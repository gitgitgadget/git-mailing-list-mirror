Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C59CC433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 21:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377870AbiATV1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 16:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377869AbiATV1K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 16:27:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EB9C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 13:27:10 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so16908274wmb.5
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 13:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hzlcao159OCA1n8K4WVG2j/83WdIvMt+wfKfoQTYmkA=;
        b=mmOuPuC2lYW8gOC99r802xA+9m8hYoiz9rFOYoGtbhPF/7Yr0x2L70cAZxukY6a24D
         Dl2rgu3VVHw1WL2pxui6B4mSQIMlAsOJKwPwYzMX4ltK99ptRqiXlNB0YsDAoJ98Umhs
         0wrijzg8zYmTC5P2jApTJXSi9xvwq7HWLLQteyQrN7kNoUwWeXefbLA5n92F1jXdwxBG
         EwR6G4N99/1uLE0+o6AwysBE3BQNB7HossPgpl6540KgESJg0doiZM5nVi+l+08lP3w3
         j9qVLnYpjVDqcOTEY8qZT79QCPB52a3D0ULvbK4ag9yY9TmKcLELMhhRxoQGUV2qlSxq
         aOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hzlcao159OCA1n8K4WVG2j/83WdIvMt+wfKfoQTYmkA=;
        b=qKsNhXMUZ2taQror7+DSqqyVVJSUwU1aryauRjIovVD8iGBYOzTR6zjBYbwA9ThWF/
         emIftrFsFxpFvRuh56ku3pfW9Jy2oJ5INaF/obKuXvbgEbIAZX0Ce7A9lrkWQD3siN8d
         0ZOgCQ4ZcZtwiX5NnAVnJfMi3x3JDyb7Ei5aoo2DTY3v+2w5E/6NEWDTIsPKHpLobrXZ
         vT3dtU4vfYjQ8lqZ2SEDCrY6bdGcgkosX03lrH63bfxWjn5voieqauJV/RVV6V94i3Iz
         r+BERZjA8hw8SV+4gZJmMnSvvmfJBSodnO8JLaoTFU/mHZWugToqdw3i5KXaEi5OEsIE
         dWnQ==
X-Gm-Message-State: AOAM532b+76+MOj7ENBMAbnRTpNl2JJlGm9/neMAckXr5XL5RP1XI30m
        /4XUcMikfhlMGt+uWZC/CJ2zgGVrrNLXXw==
X-Google-Smtp-Source: ABdhPJxDvI4IpQP3QQy+OV7Fc1hHjT1uf2qTT432mW2VqRo0qNJZL6nYPxHAZaebpdXCuZIQMf86kw==
X-Received: by 2002:a5d:4a8b:: with SMTP id o11mr891666wrq.46.1642714028217;
        Thu, 20 Jan 2022 13:27:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k12sm3761770wrd.98.2022.01.20.13.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:27:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?q?Petr=20=C5=A0pl=C3=ADchal?= <psplicha@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] checkout: fix BUG() case in 9081a421a6
Date:   Thu, 20 Jan 2022 22:26:57 +0100
Message-Id: <patch-1.1-21ddf7c628d-20220120T212233Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <YemTGQZ97vAPUPY0@pobox.com>
References: <YemTGQZ97vAPUPY0@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in my 9081a421a6d (checkout: fix "branch info" memory
leaks, 2021-11-16) where I'd assumed that the old_branch_info.path
would have to start with refs/heads/*, but as has been reported[1]
that's not the case.

As a test case[2] to reproduce this shows the second "git checkout"
here runs into the BUG() in the pre-image. The test being added is
amended from[2] and will pass both with this change, and before
9081a421a6. I.e. our behavior now is again the same as before that
commit.

1. https://bugzilla.redhat.com/show_bug.cgi?id=2042920
2. https://lore.kernel.org/git/YemTGQZ97vAPUPY0@pobox.com/

Reported-by: Petr Šplíchal <psplicha@redhat.com>
Reported-by: Todd Zullinger <tmz@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Thu, Jan 20 2022, Todd Zullinger wrote:

> Hi,
>
> A bug was filed in the Fedora/Red Hat bugzilla today for the
> git 2.35.0 rc (rc1, but it's the same in rc2).  Petr (Cc'd),
> ran the following
>
>     git clone https://github.com/psss/fmf /tmp/fmf
>     cd /tmp/fmf
>     cp .git/refs/remotes/origin/HEAD .git/refs/heads/__DEFAULT__
>     git checkout -f __DEFAULT__
>     git checkout -f __DEFAULT__
>
> The second git checkout call runs into the BUG() call added
> in 9081a421a6 (checkout: fix "branch info" memory leaks,
> 2021-11-16):
>
>     BUG: builtin/checkout.c:1098: should be able to skip
>     past 'refs/heads/' in 'refs/remotes/origin/master'!
>     Aborted (core dumped)
>
> This worked in 2.34.1, so it's new to 2.35.0.  Should this
> work or does the manual copy to setup a branch fall into a
> new category of "don't do that"?
>
> (It's novel to get a bug report from rc testing of a distro
> build -- that doesn't happen often.)

Thanks to both you and Petr for the report and easy to reproduce case,
and sorry about causing it.

In retrospec it's a rather obvious thinko. Here's a minimal fix for
it, along with a derived test case that I made more exhaustive to
check the state of the repo before, after, and in-between the two "git
checkout" commands. As noted it'll also pass with 9081a421a6d
reverted, showing that our behavior is the same as before that commit.

 builtin/checkout.c         | 11 ++++-------
 t/t2018-checkout-branch.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6a5dd2a2a22..52a47ef40e1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1090,13 +1090,10 @@ static int switch_branches(const struct checkout_opts *opts,
 		FREE_AND_NULL(old_branch_info.path);
 
 	if (old_branch_info.path) {
-		const char *const prefix = "refs/heads/";
-		const char *p;
-		if (skip_prefix(old_branch_info.path, prefix, &p))
-			old_branch_info.name = xstrdup(p);
-		else
-			BUG("should be able to skip past '%s' in '%s'!",
-			    prefix, old_branch_info.path);
+		const char *p = old_branch_info.path;
+
+		skip_prefix(old_branch_info.path, "refs/heads/", &p);
+		old_branch_info.name = xstrdup(p);
 	}
 
 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index 3e93506c045..82df9b8bf64 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -85,6 +85,39 @@ test_expect_success 'setup' '
 	git branch -m branch1
 '
 
+test_expect_success REFFILES 'checkout a branch without refs/heads/* prefix' '
+	git clone --no-tags . repo-odd-prefix &&
+	(
+		cd repo-odd-prefix &&
+
+		cp .git/refs/remotes/origin/HEAD .git/refs/heads/a-branch &&
+
+		echo branch1 >expect.ref &&
+		git rev-parse --abbrev-ref HEAD >actual.ref &&
+		test_cmp expect.ref actual.ref &&
+
+		git checkout -f a-branch &&
+
+		echo origin/branch1 >expect.ref &&
+		git rev-parse --abbrev-ref HEAD >actual.ref &&
+		test_cmp expect.ref actual.ref &&
+
+		git checkout -f a-branch &&
+
+		cat >expect <<-EOF &&
+		$(git rev-parse HEAD) commit	refs/heads/a-branch
+		$(git rev-parse HEAD) commit	refs/heads/branch1
+		$(git rev-parse HEAD) commit	refs/remotes/origin/HEAD
+		$(git rev-parse HEAD) commit	refs/remotes/origin/branch1
+		EOF
+		git for-each-ref >actual &&
+		test_cmp expect actual &&
+
+		git rev-parse --abbrev-ref HEAD >actual &&
+		test_cmp expect.ref actual.ref
+	)
+'
+
 test_expect_success 'checkout -b to a new branch, set to HEAD' '
 	test_when_finished "
 		git checkout branch1 &&
-- 
2.35.0.rc1.864.g57621b115b6

