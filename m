Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CCAC43215
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF602080D
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 20:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK1cISdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKXUZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 15:25:54 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38445 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfKXUZx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 15:25:53 -0500
Received: by mail-wr1-f52.google.com with SMTP id i12so15030808wro.5
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 12:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=psXjmZYn5YIaBsFauoGc8CUYWqATSfRzVkf80k1v5Zc=;
        b=ZK1cISdlFx/vvxH/2it4GrwNz2kINnX4A9xPPbcbIOHsla6UwF3GBE6GnbqApilo8h
         twTQV724aTCnXXzE4YnsMlGGWjQV6uy4ED90pWQa+O0rO77oSz5CYTVdyU6YIJlJF4UI
         awlu1fgfI78vRp/8U9VlQ9z+G4w6rDQffNRhq/vB2Q3D97xwPiR0V6/5d1cqiogqiH1e
         vilItL/GO9foaU/vm1sMRwJrjmlmifBum6mp8VYDK0DZDXkwXL3PqsmvMi35SgWovkwI
         xplJXd1j8llUzVrNXlRlCu1DwKGYZxvtgZW+ooWJ3x53XJI/No4gaw1dSoesPVKF9CVW
         slBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=psXjmZYn5YIaBsFauoGc8CUYWqATSfRzVkf80k1v5Zc=;
        b=ZmrUDEvviAYz24QKfDTJQmkD6yAcEtkP2Alu6Zifnl6Nu9J08QFVQzGf24vrEPaLDS
         srllfjUxTL3IWGcx4YBuchhxGj8kFnrw6CG2LU2Tnc9q7HKpLOLz34PuVvnOg+kQtOyP
         lfGXryaBPsT5AkS8ww1U6BcdLndFXKKIvgl5oFx0U3S2wc1vdc9GXpRihOU/r+85sbGp
         oGIBbyll0WuAGd6hwA0bQPgASX6Vni8aysG+QeoeUwEGnlf87uQP9sS8HZPqjTwZB8Zj
         dz5nA2xLa01crVbcfR7A+x3ddMyJrPOH6gfTrrMsr1zK6UiDdhrhoj2qjZ2pjCowfKnp
         42kg==
X-Gm-Message-State: APjAAAXnV71rrYT/71dpvapc1SctmokPStoTmnOscTu9/p+uAyMfF/pZ
        vdRqeC6Ka1MGMcLdXu3jL5Ql9DF6
X-Google-Smtp-Source: APXvYqzbTFCOSLeqHo4TJ9z5rNQtpK4ZzOAMqAExOM66v89CCHXq6f5kPDT2pXpjfP88UQdczdaKbw==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr27648598wrj.102.1574627151833;
        Sun, 24 Nov 2019 12:25:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d202sm5971008wmd.47.2019.11.24.12.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 12:25:51 -0800 (PST)
Message-Id: <a608dc8368c6fc738393dac46618f12e25d40eaf.1574627149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.474.v2.git.1574627149.gitgitgadget@gmail.com>
References: <pull.474.git.1574538937.gitgitgadget@gmail.com>
        <pull.474.v2.git.1574627149.gitgitgadget@gmail.com>
From:   "Nika Layzell via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 20:25:49 +0000
Subject: [PATCH v2 1/1] reset: parse rev as tree-ish in patch mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nika Layzell <nika@thelayzells.com>,
        Junio C Hamano <gitster@pobox.com>,
        Nika Layzell <nika@thelayzells.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nika Layzell <nika@thelayzells.com>

Since 2f328c3d ("reset $sha1 $pathspec: require $sha1 only to be
treeish", 2013-01-14), we allowed "git reset $object -- $path" to reset
individual paths that match the pathspec to take the blob from a tree
object, not necessarily a commit, while the form to reset the tip of the
current branch to some other commit still must be given a commit.

Like resetting with paths, "git reset --patch" does not update HEAD, and
need not require a commit. The path-filtered form, "git reset --patch
$object -- $pathspec", has accepted a tree-ish since 2f328c3d.

"git reset --patch" is documented as accepting a <tree-ish> since
bf44142f ("reset: update documentation to require only tree-ish with
paths", 2013-01-16). Documentation changes are not required.

Loosen the restriction that requires a commit for the unfiltered "git
reset --patch $object".

Signed-off-by: Nika Layzell <nika@thelayzells.com>
---
 builtin/reset.c        |  2 +-
 t/t7105-reset-patch.sh | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index fdd572168b..5cbfb21ec4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -320,7 +320,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
 		oidcpy(&oid, the_hash_algo->empty_tree);
-	} else if (!pathspec.nr) {
+	} else if (!pathspec.nr && !patch_mode) {
 		struct commit *commit;
 		if (get_oid_committish(rev, &oid))
 			die(_("Failed to resolve '%s' as a valid revision."), rev);
diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index bd10a96727..fc2a6cf5c7 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -38,6 +38,27 @@ test_expect_success PERL 'git reset -p HEAD^' '
 	test_i18ngrep "Apply" output
 '
 
+test_expect_success PERL 'git reset -p HEAD^^{tree}' '
+	test_write_lines n y | git reset -p HEAD^^{tree} >output &&
+	verify_state dir/foo work parent &&
+	verify_saved_state bar &&
+	test_i18ngrep "Apply" output
+'
+
+test_expect_success PERL 'git reset -p HEAD^:dir/foo (blob fails)' '
+	set_and_save_state dir/foo work work &&
+	test_must_fail git reset -p HEAD^:dir/foo &&
+	verify_saved_state dir/foo &&
+	verify_saved_state bar
+'
+
+test_expect_success PERL 'git reset -p aaaaaaaa (unknown fails)' '
+	set_and_save_state dir/foo work work &&
+	test_must_fail git reset -p aaaaaaaa &&
+	verify_saved_state dir/foo &&
+	verify_saved_state bar
+'
+
 # The idea in the rest is that bar sorts first, so we always say 'y'
 # first and if the path limiter fails it'll apply to bar instead of
 # dir/foo.  There's always an extra 'n' to reject edits to dir/foo in
-- 
gitgitgadget
