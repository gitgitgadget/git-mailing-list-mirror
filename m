Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667F8C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 09:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D37207D3
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 09:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUZFQMls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgFEJKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgFEJKx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 05:10:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1877C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 02:10:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z16so3687344ybg.13
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=GgnZIqnc0j0zOaRGGAp+SnPKe/CRcuuaf1OuwwNu+Eo=;
        b=ZUZFQMlsmp58hkpJHi9a7Cq/j4jX7B1FYUqcbkKj0+vGOJs2e2G4SeAcEc0cfWVSIf
         m/yciSSE2ppT5yXBGxTM41xHPpCSQHRf3gt9rAA/oyBYmNZ0oHobVsWX3lxDtCn8qy1U
         k2D9Sz40ZypAyjCDrlzzKpO+DinZqwOM4Vjt81STeBiRsYbQnviVRAY7dElovJp7jzGR
         xyNAI1nJWqRIcJ2wyC7+I5byoUumufhoaiA9Fbf0J/hoYvtu+gS6iXxDR89joDpDkHar
         bs6DeyXTD4arvzR1+mBmflAcOl8bMfrcgs5bZ0ZMLUc+PtXuM0m2Tasmu7owDC/PPCnD
         qMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=GgnZIqnc0j0zOaRGGAp+SnPKe/CRcuuaf1OuwwNu+Eo=;
        b=NjSLR//bDh3CmCYw/t/z/Yg4sksvzHoCeKCG/GXpXcpC69U15uxvMFFFCYA+uCzPHF
         IKDb9AFHUMRvOQuch1S9p2+B98Z/8HnKlBzUnz9Z06V64dURl76LYgtKcnfp/lE7ZXnU
         PFcpIB40oxnhxk3EkUSiSNMfq/+krYVI7+mfVQTMB3oIzPMHl5Na77Ihj4Ep5kENYyn/
         y+q3plGsS3VUb6oR4yXngaZuReEBbdLXPSE+HPx9EcfjA9lDDhs9zqvSBRZBIfmfm1Pu
         +H24f7X4gUgCR0ElW+L5Z0OkEFIN56BURALLQkdIGZKADiYUUOWSOHkQPxpuaq6CWEkG
         Mo6w==
X-Gm-Message-State: AOAM531Ow7ezuBFsMLRo4TM70KDkCcewInEp8fr8qgZAArItK8GX7WxQ
        cX29K4pkVSusF9BlbxF/EKcXPVIm8gE9mJlqu7UpBx1Ypk/vp58Dl+kHx/CFwIZ9TT5rpl3Oj0w
        tYlRj0UkdsoDDYibomek9gyt0uXXtwzALcPAuhPkseEn9nKa2xBIdHtqwiw5r
X-Google-Smtp-Source: ABdhPJxNe+L6ddRrTdP7M4fSW3rd5CC7CetwYjHsPsIc/67eAlZX+6ZCEIbwyIQh+iRcjgZO9RsSftPh4u6d
X-Received: by 2002:a25:6d0a:: with SMTP id i10mr15340099ybc.193.1591348250934;
 Fri, 05 Jun 2020 02:10:50 -0700 (PDT)
Date:   Fri,  5 Jun 2020 02:10:04 -0700
In-Reply-To: <20200605091004.208668-1-delphij@google.com>
Message-Id: <20200605091004.208668-5-delphij@google.com>
Mime-Version: 1.0
References: <20200528025359.20931-2-delphij@google.com> <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
 <20200528171924.GC58643@google.com> <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
 <20200528191739.GA114915@google.com> <20200529000432.146618-1-delphij@google.com>
 <20200529010119.GE114915@google.com> <xmqqk10uzkcd.fsf@gitster.c.googlers.com>
 <20200605091004.208668-1-delphij@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v6 4/4] check_repository_format_gently(): refuse extensions
 for old repositories
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, extensions were recognized regardless of repository format
version. =C2=A0If the user sets an undefined "extensions" value on a
repository of version 0 and that value is used by a future git version,
they might get an undesired result.

Because all extensions now also upgrade repository versions, tightening
the check would help avoid this for future extensions.

Signed-off-by: Xin Li <delphij@google.com>
---
 setup.c                  | 12 +++++++++---
 t/t0410-partial-clone.sh | 11 +++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 597b41b822..eb066db6d8 100644
--- a/setup.c
+++ b/setup.c
@@ -507,9 +507,15 @@ static int check_repository_format_gently(const char *=
gitdir, struct repository_
 		die("%s", err.buf);
 	}
=20
-	repository_format_precious_objects =3D candidate->precious_objects;
-	set_repository_format_partial_clone(candidate->partial_clone);
-	repository_format_worktree_config =3D candidate->worktree_config;
+	if (candidate->version >=3D 1) {
+		repository_format_precious_objects =3D candidate->precious_objects;
+		set_repository_format_partial_clone(candidate->partial_clone);
+		repository_format_worktree_config =3D candidate->worktree_config;
+	} else {
+		repository_format_precious_objects =3D 0;
+		set_repository_format_partial_clone(NULL);
+		repository_format_worktree_config =3D 0;
+	}
 	string_list_clear(&candidate->unknown_extensions, 0);
=20
 	if (repository_format_worktree_config) {
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 16ad000382..463dc3a8be 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -42,6 +42,17 @@ test_expect_success 'convert shallow clone to partial cl=
one' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
=20
+test_expect_success 'convert shallow clone to partial clone must fail with=
 any extension' '
+	rm -fr server client &&
+	test_create_repo server &&
+	test_commit -C server my_commit 1 &&
+	test_commit -C server my_commit2 1 &&
+	git clone --depth=3D1 "file://$(pwd)/server" client &&
+	test_cmp_config -C client 0 core.repositoryformatversion &&
+	git -C client config extensions.partialclone origin &&
+	test_must_fail git -C client fetch --unshallow --filter=3D"blob:none"
+'
+
 test_expect_success 'missing reflog object, but promised by a commit, pass=
es fsck' '
 	rm -rf repo &&
 	test_create_repo repo &&
--=20
2.27.0.278.ge193c7cf3a9-goog

