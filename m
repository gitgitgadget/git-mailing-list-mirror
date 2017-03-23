Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0324620958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965073AbdCWP3p (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:45 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34168 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964866AbdCWP3l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:41 -0400
Received: by mail-wr0-f193.google.com with SMTP id y90so7894968wrb.1
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qgd8laN+YgZNan+o94DMKJKaYBey/S00ehHUUiHfq7M=;
        b=pTn9n5SKuT755L+ojIg5kmmO9kyB7gCXB0PBkN8L5JIk312AnuoGJ5vkAfBDzDLwfh
         eb8qnzLFL8LYHXISLgS9xE5vYTZBG6U+y2BnAEm4uMNyHW6waS+9tsIslmmIsTRaMOCD
         1MBj/yoQGbTk1ZX9pE/S4f69gyPamMZTr8FWOSZd/3J3Eed3WPP9JrXUhMMBlaORkf8U
         InmdOCZYxx4QtqDUVQdMGVUmLWzV4pXwfmGaUg338WMorv5n0f50cLBd0Ur6LafGtJzn
         7vHBz+J6qW2a/XdeL1GFh8s1S7GUBjo0PvG5F8wDcicr6TWgaP3q4QMf+sQNiTQTLLZ7
         IbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qgd8laN+YgZNan+o94DMKJKaYBey/S00ehHUUiHfq7M=;
        b=VhJSztTFyrcX9cGbkGuUDkrzgGC8n/I6tpsYM3QYsJKlazyonEx6TAcZb2Dm8EunG2
         twIfwRm858K0A3gD4eeAgrLfPGP54oWmR/zgxJNMOkoJ3E5uAKVYvG8JKwJIoIG7CO5q
         fDoaTP7M52DtdsPPbNW0ByVYfKF4/EM4hwhre6iRtA8clb9XuRAcX3Ba2X3400BNgff5
         dTnngGl9XVsAnhCgM+3XjiWYroVWaV2w0hA4SBVPnirxIzj07ZUD4pCRvngjmVUgrtXG
         eJMvRs6WGJotH+rl3nRAIOWxIxLUgrU/iHuu2HIUfP39qrWffsJPlXN2HiRCxJH3LLHx
         Sntw==
X-Gm-Message-State: AFeK/H0JXts3w9NtOObAzEwZ2PVi0ACwFs/7c9m91Leoe3Fhg+V1RVz5PI+iaPtJsXdb0g==
X-Received: by 10.223.179.216 with SMTP id x24mr3161318wrd.171.1490282979544;
        Thu, 23 Mar 2017 08:29:39 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:39 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 04/14] completion: support completing fully qualified non-fast-forward refspecs
Date:   Thu, 23 Mar 2017 16:29:14 +0100
Message-Id: <20170323152924.23944-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After 'git fetch <remote> <TAB>' our completion script offers refspecs
that will fetch to a local branch with the same name as in the remote
repository, e.g. 'master:master'.  This also completes
non-fast-forward refspecs, i.e. after a '+' prefix like
'+master:master', and fully qualified refspecs, e.g.
'refs/heads/master:refs/heads/master'.  However, it does not complete
non-fast-forward fully qualified refspecs (or fully qualified refspecs
following any other prefix, e.g. '--option=', though currently no git
command supports such an option, but third party git commands might).

These refspecs are listed by the __git_refs2() function, which is just
a thin wrapper iterating over __git_refs()'s output, turning each
listed ref into a refspec.  Now, it's certainly possible to modify
__git_refs2() and its callsite to pass an extra parameter containing
only the ref part of the current word to be completed (to follow suit
of the previous commit) to deal with prefixed fully qualified refspecs
as well.  Unfortunately, keeping the current behavior unchanged in the
"no extra parameter" case brings in a bit of subtlety, which makes the
resulting code ugly and compelled me to write a 8-line long comment in
the proof of concept.  Not good.  However, since the callsite has to
be modified for proper functioning anyway, we might as well leave
__git_refs2() as is and introduce a new helper function without
backwards compatibility concerns.

Add the new function __git_complete_fetch_refspecs() that has all the
necessary parameters to do the right thing in all cases mentioned
above, including non-fast-forward fully qualified refspecs.  This new
function can also easier benefit from optimizations coming later in
this patch series.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 21 ++++++++++-
 t/t9902-completion.sh                  | 68 ++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b897cba4b..067dff823 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -486,6 +486,7 @@ __git_complete_refs ()
 }
 
 # __git_refs2 requires 1 argument (to pass to __git_refs)
+# Deprecated: use __git_complete_fetch_refspecs() instead.
 __git_refs2 ()
 {
 	local i
@@ -494,6 +495,24 @@ __git_refs2 ()
 	done
 }
 
+# Completes refspecs for fetching from a remote repository.
+# 1: The remote repository.
+# 2: A prefix to be added to each listed refspec (optional).
+# 3: The ref to be completed as a refspec instead of the current word to be
+#    completed (optional)
+# 4: A suffix to be appended to each listed refspec instead of the default
+#    space (optional).
+__git_complete_fetch_refspecs ()
+{
+	local i remote="$1" pfx="${2-}" cur_="${3-$cur}" sfx="${4- }"
+
+	__gitcomp_nl "$(
+		for i in $(__git_refs "$remote" "" "" "$cur_") ; do
+			echo "$i:$i"
+		done
+		)" "$pfx" "$cur_" "$sfx"
+}
+
 # __git_refs_remotes requires 1 argument (to pass to ls-remote)
 __git_refs_remotes ()
 {
@@ -686,7 +705,7 @@ __git_complete_remote_or_refspec ()
 	case "$cmd" in
 	fetch)
 		if [ $lhs = 1 ]; then
-			__gitcomp_nl "$(__git_refs2 "$remote")" "$pfx" "$cur_"
+			__git_complete_fetch_refspecs "$remote" "$pfx" "$cur_"
 		else
 			__git_complete_refs --pfx="$pfx" --cur="$cur_"
 		fi
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 0a41ee1ea..f641d99ec 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -912,6 +912,74 @@ test_expect_success '__git_complete_refs - suffix' '
 	test_cmp expected out
 '
 
+test_expect_success '__git_complete_fetch_refspecs - simple' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	HEAD:HEAD Z
+	branch-in-other:branch-in-other Z
+	master-in-other:master-in-other Z
+	EOF
+	(
+		cur= &&
+		__git_complete_fetch_refspecs other &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_fetch_refspecs - matching' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	branch-in-other:branch-in-other Z
+	EOF
+	(
+		cur=br &&
+		__git_complete_fetch_refspecs other "" br &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_fetch_refspecs - prefix' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	+HEAD:HEAD Z
+	+branch-in-other:branch-in-other Z
+	+master-in-other:master-in-other Z
+	EOF
+	(
+		cur="+" &&
+		__git_complete_fetch_refspecs other "+" ""  &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_fetch_refspecs - fully qualified' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	refs/heads/branch-in-other:refs/heads/branch-in-other Z
+	refs/heads/master-in-other:refs/heads/master-in-other Z
+	refs/tags/tag-in-other:refs/tags/tag-in-other Z
+	EOF
+	(
+		cur=refs/ &&
+		__git_complete_fetch_refspecs other "" refs/ &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
+test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
+	sed -e "s/Z$//" >expected <<-EOF &&
+	+refs/heads/branch-in-other:refs/heads/branch-in-other Z
+	+refs/heads/master-in-other:refs/heads/master-in-other Z
+	+refs/tags/tag-in-other:refs/tags/tag-in-other Z
+	EOF
+	(
+		cur=+refs/ &&
+		__git_complete_fetch_refspecs other + refs/ &&
+		print_comp
+	) &&
+	test_cmp expected out
+'
+
 test_expect_success 'teardown after ref completion' '
 	git branch -d matching-branch &&
 	git tag -d matching-tag &&
-- 
2.12.1.485.g1616aa492

