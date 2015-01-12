From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-log: added --none-match option
Date: Mon, 12 Jan 2015 12:51:38 -0800
Message-ID: <xmqqk30r7med.fsf@gitster.dls.corp.google.com>
References: <xmqqwq5o5e1j.fsf@gitster.dls.corp.google.com>
	<1420349268-13479-1-git-send-email-ottxor@gentoo.org>
	<xmqq61cjo6lq.fsf@gitster.dls.corp.google.com>
	<CANgp9kxXzt7x9JnnxjrcRLse4m86eDAgWyC4FwKw2U48NjV=ew@mail.gmail.com>
	<xmqqk30vbm3r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Christoph Junghans <ottxor@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 21:53:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAlzJ-00044N-VX
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 21:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbbALUxV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 15:53:21 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751896AbbALUxU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 15:53:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BB8E2F334;
	Mon, 12 Jan 2015 15:53:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OCC9D9lSzIf/bdouQpijEzxvul4=; b=Mnlm7V
	8V5jl47jw7+xeUSdDou9cy19XkDwfR1H/16rfPvvBojZaml/pbTlk6nmfDOVuh9G
	mdSXDVI2V2hgyfNV5lFpdzNs2oJ7noYhxOuJjw795yahV0rvWRnDW6hQYv0Zj2Ts
	2ZCBzmlW2j4bCsFM+PIxfZRRCm6HoUpaXQ73U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QlHi9GTNPQesjxPRaYskbiSzju1+TL5n
	wVxFB5ZfuGqLrRo5/XpyqUSv1HThGWV83kocYIvHnTqhm8aPcsISJm8OwbLcMxKZ
	Z3cvDszWpre1zY6ZGM3zjQu09AwW941LMPFst3IvJ6Da9k8NlvjhyA6l8byVhIRK
	2PgBcFoejJw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 52F1B2F333;
	Mon, 12 Jan 2015 15:53:19 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29B412F2E3;
	Mon, 12 Jan 2015 15:51:40 -0500 (EST)
In-Reply-To: <xmqqk30vbm3r.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 09 Jan 2015 14:55:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CEB98E4E-9A9C-11E4-8107-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262292>

Junio C Hamano <gitster@pobox.com> writes:

> Christoph Junghans <ottxor@gentoo.org> writes:
>
>> The only useful thing I could image is using it in conjunction with
>> --files-with-matches, but that is what --files-without-match is for.
>
> Yes, "-l" was exactly what I had in mind and I was hoping that "git
> grep -l --no-match -e WIP -e TODO -e FIXME -e NEEDSWORK" may be a
> way to find perfect files without needing any work.
>
> You can say "git grep -L -e WIP -e TODO -e FIXME -e NEEDSWORK"
> instead.  I missed that "-L" option.

Thanks for your patience.  I should have realized that this not only
can be "log-only" but _should_ be "log-only".  As you pointed out,
when we already have "-L", trying to extend it to "grep" does not
make much sense.

Continuing this line of thought, as we determined that it is
pointless to have this at "grep" level and it is needed only in the
"log" family of commands, I would very much prefer the approach
taken by your original "log --invert-grep" patch.  I would further
say that I prefer not to touch grep_opt at all.

The new "global-invert bit" is about "we'd run the usual grep thing
on the log message, and instead of filtering to only show the
commits with matching message, we only show the ones with messages
that do not match".  That logically belongs to the revision struct
that is used to interpret what the underlying grep machinery figured
out, and should not have to affect the way how underlying grep
machinery works.

We would want a few test to make sure that we do not break the
feature in the future changes.  Here is an attempt.  The patch would
apply any commit your original "--invert-grep" option would have
applied.

Thanks again.

-- >8 --
Subject: log: teach --invert-grep option

"git log --grep=<string>" shows only commits with messages that
match the given string, but sometimes it is useful to be able to
show only commits that do *not* have certain messages (e.g. "show me
ones that are not FIXUP commits").

Signed-off-by: Christoph Junghans <ottxor@gentoo.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 jc: Christoph originally had the invert-grep flag in grep_opt, but
     because "git grep --invert-grep" does not make sense except in
     conjunction with "--files-with-matches", which is already
     covered by "--files-without-matches", I moved it to revisions
     structure.  I think it expresses what the feature is about
     better to have the flag there.

     When the newly inserted two tests run, the history would have
     commits with messages "initial", "second", "third", "fourth",
     "fifth", "sixth" and Second", committed in this order.  The
     first commit that does not match either "th" or "Sec" is
     "second", and "initial" is the one that does not match either
     "th" or "Sec" case insensitively.

 Documentation/rev-list-options.txt     |  4 ++++
 contrib/completion/git-completion.bash |  2 +-
 revision.c                             |  4 +++-
 revision.h                             |  2 ++
 t/t4202-log.sh                         | 12 ++++++++++++
 5 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index deb8cca..05aa997 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -66,6 +66,10 @@ if it is part of the log message.
 	Limit the commits output to ones that match all given `--grep`,
 	instead of ones that match at least one.
 
+--invert-grep::
+	Limit the commits output to ones with log message that do not
+	match the pattern specified with `--grep=<pattern>`.
+
 -i::
 --regexp-ignore-case::
 	Match the regular expression limiting patterns without regard to letter
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 06bf262..53857f0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1428,7 +1428,7 @@ __git_log_gitk_options="
 # Options that go well for log and shortlog (not gitk)
 __git_log_shortlog_options="
 	--author= --committer= --grep=
-	--all-match
+	--all-match --invert-grep
 "
 
 __git_log_pretty_formats="oneline short medium full fuller email raw format:"
diff --git a/revision.c b/revision.c
index 615535c..84b33a3 100644
--- a/revision.c
+++ b/revision.c
@@ -1952,6 +1952,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_PCRE, &revs->grep_filter);
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
+	} else if (!strcmp(arg, "--invert-grep")) {
+		revs->invert_grep = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
 		if (strcmp(optarg, "none"))
 			git_log_output_encoding = xstrdup(optarg);
@@ -2848,7 +2850,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 				     (char *)message, strlen(message));
 	strbuf_release(&buf);
 	unuse_commit_buffer(commit, message);
-	return retval;
+	return opt->invert_grep ? !retval : retval;
 }
 
 static inline int want_ancestry(const struct rev_info *revs)
diff --git a/revision.h b/revision.h
index a620530..b0b82e7 100644
--- a/revision.h
+++ b/revision.h
@@ -168,6 +168,8 @@ struct rev_info {
 
 	/* Filter by commit log message */
 	struct grep_opt	grep_filter;
+	/* Negate the match of grep_filter */
+	int invert_grep;
 
 	/* Display history graph */
 	struct git_graph *graph;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 99ab7ca..1c9934e 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -212,6 +212,18 @@ test_expect_success 'log --grep' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --invert-grep --grep' '
+	echo second >expect &&
+	git log -1 --pretty="tformat:%s" --invert-grep --grep=th --grep=Sec >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --invert-grep --grep -i' '
+	echo initial >expect &&
+	git log -1 --pretty="tformat:%s" --invert-grep -i --grep=th --grep=Sec >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --grep option parsing' '
 	echo second >expect &&
 	git log -1 --pretty="tformat:%s" --grep sec >actual &&
