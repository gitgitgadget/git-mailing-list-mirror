From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 ] commit -v: strip diffs and submodule shortlogs from the commit message
Date: Tue, 19 Nov 2013 11:42:35 -0800
Message-ID: <xmqqk3g489g4.fsf@gitster.dls.corp.google.com>
References: <loom.20131110T222043-57@post.gmane.org> <528140F5.6090700@web.de>
	<loom.20131111T214646-550@post.gmane.org> <52814C35.6040205@web.de>
	<5281DCC5.2000209@kdbg.org> <5282A90A.4030900@web.de>
	<xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
	<5283C701.8090400@web.de>
	<xmqq7gccdq67.fsf@gitster.dls.corp.google.com>
	<5287F735.3030306@web.de>
	<20131117090935.GC17016@sigill.intra.peff.net>
	<xmqqk3g5d7gy.fsf@gitster.dls.corp.google.com>
	<528BB23D.4020001@web.de>
	<xmqqob5g89y0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Ari Pollak <ari@debian.org>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 19 20:42:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VirCL-0001bA-TT
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 20:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560Ab3KSTms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 14:42:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab3KSTmk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 14:42:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 229DE52F64;
	Tue, 19 Nov 2013 14:42:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qfg5ETNI3Vk3tu87OdQXJnwVsew=; b=Wprj1X
	/uEHO1xujdVvwqwO37WvBSdwZyArx1G87hGhMCUzDUpHRsCJve14fzucrCvQG2CC
	8F+uOjHgopIc3qWSHlDATPfVp0PMl1MmGG1cpp7cMwv1j3aF+7VrfgBAO5dj/I5D
	AL0Jy2Nt/GdjadKI/+BX7xCL8xwINik57HFgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aEH0R0ro6J06AsxDvda/hFbgZ1++fzTv
	6SEzxLGJvS4b+43qxMkEJIhWC06Qeb4UAQlUPh7o2hWhTec4eId5+7ufDc3xSmeV
	WWljOlxNSOssuZU/QphSluUN/VWNrcUJQy/caEIwuwQRqJTsgDVbBmjPGId2nNUw
	iY6o3Bem14Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1226152F60;
	Tue, 19 Nov 2013 14:42:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A76752F58;
	Tue, 19 Nov 2013 14:42:39 -0500 (EST)
In-Reply-To: <xmqqob5g89y0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 Nov 2013 11:31:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BF7E9F12-5152-11E3-89C1-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238039>

Junio C Hamano <gitster@pobox.com> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>> diff --git a/wt-status.h b/wt-status.h
>> index 6c29e6f..cd2709f 100644
>> --- a/wt-status.h
>> +++ b/wt-status.h
>> @@ -91,6 +91,8 @@ struct wt_status_state {
>>  	unsigned char cherry_pick_head_sha1[20];
>>  };
>>
>> +const char wt_status_diff_divider[];
>
> This gives me:
>
> ./wt-status.h:94:12: error: array 'wt_status_diff_divider' assumed to have one element [-Werror]
> cc1: all warnings being treated as errors
>
> which is a bit unfortunate.
>
> Regardless of that, from the API design standpoint, I think it may
> be much better not to expose this particular implementation element
> (i.e. the array) to the caller, but instead to export a helper
> function that takes a pointer to a piece of memory and let callers
> ask an "I have this line---is it the status cut mark?" question.

That is, something like this, perhaps.

 builtin/commit.c          |  9 +++------
 t/t7507-commit-verbose.sh | 15 ++++++++++++++-
 wt-status.c               | 15 +++++++++++++++
 wt-status.h               |  1 +
 4 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 6ab4605..fedb45a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1505,7 +1505,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	struct strbuf sb = STRBUF_INIT;
 	struct strbuf author_ident = STRBUF_INIT;
 	const char *index_file, *reflog_msg;
-	char *nl, *p;
+	char *nl;
 	unsigned char sha1[20];
 	struct ref_lock *ref_lock;
 	struct commit_list *parents = NULL, **pptr = &parents;
@@ -1601,11 +1601,8 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	}
 
 	/* Truncate the message just before the diff, if any. */
-	if (verbose) {
-		p = strstr(sb.buf, "\ndiff --git ");
-		if (p != NULL)
-			strbuf_setlen(&sb, p - sb.buf + 1);
-	}
+	if (verbose)
+		wt_status_truncate_message_at_cut_line(&sb);
 
 	if (cleanup_mode != CLEANUP_NONE)
 		stripspace(&sb, cleanup_mode == CLEANUP_ALL);
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index da5bd3b..09c1150 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -65,9 +65,22 @@ test_expect_success 'diff in message is retained without -v' '
 	check_message diff
 '
 
-test_expect_failure 'diff in message is retained with -v' '
+test_expect_success 'diff in message is retained with -v' '
 	git commit --amend -F diff -v &&
 	check_message diff
 '
 
+test_expect_success 'submodule log is stripped out too with -v' '
+	git config diff.submodule log &&
+	git submodule add ./. sub &&
+	git commit -m "sub added" &&
+	(
+		cd sub &&
+		echo "more" >>file &&
+		git commit -a -m "submodule commit"
+	) &&
+	GIT_EDITOR=cat test_must_fail git commit -a -v 2>err &&
+	test_i18ngrep "Aborting commit due to empty commit message." err
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index b4e44ba..492506a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -16,6 +16,9 @@
 #include "column.h"
 #include "strbuf.h"
 
+static const char wt_status_cut_line[] =
+"# ------------------------ >8 ------------------------\n";
+
 static char default_wt_status_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL, /* WT_STATUS_HEADER */
 	GIT_COLOR_GREEN,  /* WT_STATUS_UPDATED */
@@ -767,6 +770,15 @@ conclude:
 	status_printf_ln(s, GIT_COLOR_NORMAL, "");
 }
 
+void wt_status_truncate_message_at_cut_line(struct strbuf *buf)
+{
+	const char *p;
+
+	p = strstr(buf->buf, wt_status_cut_line);
+	if (p && (p == buf->buf || p[-1] == '\n'))
+		strbuf_setlen(buf, p - buf->buf);
+}
+
 static void wt_status_print_verbose(struct wt_status *s)
 {
 	struct rev_info rev;
@@ -791,6 +803,9 @@ static void wt_status_print_verbose(struct wt_status *s)
 	 */
 	if (s->fp != stdout)
 		rev.diffopt.use_color = 0;
+	fprintf(s->fp, wt_status_cut_line);
+	fprintf(s->fp, _("# Do not touch the line above.\n"));
+	fprintf(s->fp, _("# Everything below will be removed.\n"));
 	run_diff_index(&rev, 1);
 }
 
diff --git a/wt-status.h b/wt-status.h
index 6c29e6f..30a4812 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -91,6 +91,7 @@ struct wt_status_state {
 	unsigned char cherry_pick_head_sha1[20];
 };
 
+void wt_status_truncate_message_at_cut_line(struct strbuf *);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
