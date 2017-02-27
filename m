Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6F61F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 19:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbdB0TSB (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 14:18:01 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33133 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbdB0TR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 14:17:59 -0500
Received: by mail-pg0-f68.google.com with SMTP id x17so1916509pgi.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cHBFawoNlR7Khv13oEaPdHippB87/2IQXw7l9QXhgPw=;
        b=PsVGungTuudDZ3N03IoNslbAC849hDLYoA6T9VCr1TMSjYKkcKFhExjYA0s9SY2UjW
         Gf6n2B/Z739mNeYTPXIhHNXvoaISyHpRDqNAaS7TCY90oRHFfZVJ30bMOyyf7TNrQDy3
         +N+74mJVq9oIUh+dksQzZuDNZvRz6OrFMVz9biFbMv+QKHBAKdf9MDj9Yc5EXzQ75BDR
         fBfg7GQHAjNd+0/C24b0bvRHrSB2HTrzkJY7iOXcufOI23euRHoEYG0dSN7qsBO7HZ9Z
         V8hTVS9TGHE0udVB1LbivAFUfcJ+0VZMjjxjh42JGh+CJS6neBrHWozAWrR7tIIwYF5Z
         Q0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cHBFawoNlR7Khv13oEaPdHippB87/2IQXw7l9QXhgPw=;
        b=Bll1XPdYkGvlzB406CjjFF9LTnb/pJTWpYQR8Zwc6Fv3g3k9H1+Uwok22TTYfUBn5Z
         2KgeyLLWCN2BJmErpWRkrpzeoVMO2EBF5NYB7Ii+MLEc04l7H9d1vJ/CdwuW14S8TIta
         3dJvFLWL4r/cdKntGY9GXJYoYmuKRALGNcZe5H6Y7q7QuKMeoaICez5AiKVMtkgzIWK/
         sXu0XmQadMx7WGOoDyrusV+0U+HLDGRMpyjLfSUCa54hOOi++NFoIAObAZTkcLJDMDwk
         76u8ClWIojyifkBXuUrQ14HfLx64ceO1xzmRgcP2QRDxUj50cnvkTwSJmYdLCCgEaNi4
         KEYA==
X-Gm-Message-State: AMke39m7s79Zmt5lYd7VyQaJOZ64ewtAOB8psbNph3XiSNbcZbzC+96WdF+gr4sdm2q+oA==
X-Received: by 10.84.247.23 with SMTP id n23mr26029683pll.39.1488222996544;
        Mon, 27 Feb 2017 11:16:36 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:c953:ec42:862e:1e81])
        by smtp.gmail.com with ESMTPSA id 85sm20411054pfz.15.2017.02.27.11.16.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 11:16:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-clone --config order & fetching extra refs during initial clone
References: <robbat2-20170225T185056-448272755Z@orbis-terrarum.net>
        <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net>
Date:   Mon, 27 Feb 2017 11:16:35 -0800
In-Reply-To: <20170225205052.j3p7obbf4onf6cbf@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 25 Feb 2017 15:50:53 -0500")
Message-ID: <xmqqd1e3xx4c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> [Re-sending, as I used an old address for Gábor on the original]
>
> On Sat, Feb 25, 2017 at 07:12:38PM +0000, Robin H. Johnson wrote:
>
>> TL;DR: git-clone ignores any fetch specs passed via --config.
>
> I agree that this is a bug. There's some previous discussion and an RFC
> patch from lat March (author cc'd):
>
>   http://public-inbox.org/git/1457313062-10073-1-git-send-email-szeder@ira.uka.de/
>
> That discussion veered off into alternatives, but I think the v2 posted
> in that thread is taking a sane approach.

Let's see how well it fares by cooking it in 'next' ;-) 

I think it was <1459349623-16443-1-git-send-email-szeder@ira.uka.de>,
which needs a bit of massaging to apply to the current codebase.

-- >8 --
From: SZEDER Gábor <szeder.dev@gmail.com>
Date: Wed, 30 Mar 2016 16:53:43 +0200
Subject: [PATCH] clone: respect configured fetch respecs during initial fetch

Conceptually 'git clone' should behave as if the following commands
were run:

  git init
  git config ... # set default configuration and origin remote
  git fetch
  git checkout   # unless '--bare' is given

However, that initial 'git fetch' behaves differently from any
subsequent fetches, because it takes only the default fetch refspec
into account and ignores all other fetch refspecs that might have
been explicitly specified on the command line (e.g. 'git -c
remote.origin.fetch=<refspec> clone' or 'git clone -c ...').

Check whether there are any fetch refspecs configured for the origin
remote and take all of them into account during the initial fetch as
well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/clone.c         | 36 ++++++++++++++++++++++++++++--------
 t/t5611-clone-config.sh | 24 ++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 3f63edbbf9..97229268b6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -516,7 +516,7 @@ static struct ref *find_remote_branch(const struct ref *refs, const char *branch
 }
 
 static struct ref *wanted_peer_refs(const struct ref *refs,
-		struct refspec *refspec)
+		struct refspec *refspec, unsigned int refspec_count)
 {
 	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
 	struct ref *local_refs = head;
@@ -537,13 +537,18 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 			warning(_("Could not find remote branch %s to clone."),
 				option_branch);
 		else {
-			get_fetch_map(remote_head, refspec, &tail, 0);
+			unsigned int i;
+			for (i = 0; i < refspec_count; i++)
+				get_fetch_map(remote_head, &refspec[i], &tail, 0);
 
 			/* if --branch=tag, pull the requested tag explicitly */
 			get_fetch_map(remote_head, tag_refspec, &tail, 0);
 		}
-	} else
-		get_fetch_map(refs, refspec, &tail, 0);
+	} else {
+		unsigned int i;
+		for (i = 0; i < refspec_count; i++)
+			get_fetch_map(refs, &refspec[i], &tail, 0);
+	}
 
 	if (!option_mirror && !option_single_branch)
 		get_fetch_map(refs, tag_refspec, &tail, 0);
@@ -856,7 +861,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int submodule_progress;
 
 	struct refspec *refspec;
-	const char *fetch_pattern;
+	unsigned int refspec_count = 1;
+	const char **fetch_patterns;
+	const struct string_list *config_fetch_patterns;
 
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
@@ -1002,9 +1009,21 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
-	fetch_pattern = value.buf;
-	refspec = parse_fetch_refspec(1, &fetch_pattern);
+	strbuf_addf(&key, "remote.%s.fetch", option_origin);
+	config_fetch_patterns = git_config_get_value_multi(key.buf);
+	if (config_fetch_patterns)
+		refspec_count = 1 + config_fetch_patterns->nr;
+	fetch_patterns = xcalloc(refspec_count, sizeof(*fetch_patterns));
+	fetch_patterns[0] = value.buf;
+	if (config_fetch_patterns) {
+		struct string_list_item *fp;
+		unsigned int i = 1;
+		for_each_string_list_item(fp, config_fetch_patterns)
+			fetch_patterns[i++] = fp->string;
+	}
+	refspec = parse_fetch_refspec(refspec_count, fetch_patterns);
 
+	strbuf_reset(&key);
 	strbuf_reset(&value);
 
 	remote = remote_get(option_origin);
@@ -1058,7 +1077,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	refs = transport_get_remote_refs(transport);
 
 	if (refs) {
-		mapped_refs = wanted_peer_refs(refs, refspec);
+		mapped_refs = wanted_peer_refs(refs, refspec, refspec_count);
 		/*
 		 * transport_get_remote_refs() may return refs with null sha-1
 		 * in mapped_refs (see struct transport->get_refs_list
@@ -1147,6 +1166,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&value);
 	junk_mode = JUNK_LEAVE_ALL;
 
+	free(fetch_patterns);
 	free(refspec);
 	return err;
 }
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index e4850b778c..3bed17783b 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -37,6 +37,30 @@ test_expect_success 'clone -c config is available during clone' '
 	test_cmp expect child/file
 '
 
+test_expect_success 'clone -c remote.origin.fetch=<refspec> works' '
+	rm -rf child &&
+	git update-ref refs/grab/it refs/heads/master &&
+	git update-ref refs/keep/out refs/heads/master &&
+	git clone -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" . child &&
+	(
+		cd child &&
+		git for-each-ref --format="%(refname)" refs/grab/ >../actual
+	) &&
+	echo refs/grab/it >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git -c remote.origin.fetch=<refspec> clone works' '
+	rm -rf child &&
+	git -c "remote.origin.fetch=+refs/grab/*:refs/grab/*" clone . child &&
+	(
+		cd child &&
+		git for-each-ref --format="%(refname)" refs/grab/ >../actual
+	) &&
+	echo refs/grab/it >expect &&
+	test_cmp expect actual
+'
+
 # Tests for the hidden file attribute on windows
 is_hidden () {
 	# Use the output of `attrib`, ignore the absolute path

