Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06F3E1F453
	for <e@80x24.org>; Sat, 26 Jan 2019 10:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfAZKlP (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Jan 2019 05:41:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46710 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfAZKlP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 05:41:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id f5so8649529lfc.13
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 02:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=p406RstVqcDEjwvA33RU+0B9xHRMNez/MzcVDeLelYU=;
        b=ENMhTPrIlr2juX2qgPXnnXwr5wT2zIR5jyoYonp4PlQqrG7g1WTu8LgrqyY4jAN8F2
         +qi5oo+qs07E255btxHeramIzf1ooevFmKC6gKuHf5i1YkqkHqBYfm/jWvk05WVUc81f
         Pg19Uqzh4gsTxtAY9ptWKdKOes6Y30G16CwHmd2Fdkrkgg9uOjs3rY8XLn0Y4NbFT1X2
         YWjgu7QrfkrxcJdmYW44MU0nJuLVRSu7+OvjSgOkdok9ApZ22Rn8NmyyBGLQdt2yamEw
         paq5KjxFmXGHi4LsnGHM0IIJsMS2alMyLFtouPOWhz2GeusHPfVcMYZkQdp/aLz+EoE6
         ki3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=p406RstVqcDEjwvA33RU+0B9xHRMNez/MzcVDeLelYU=;
        b=DpzEUVzNKLgk0P9rYdWcMzEUYeSpL/O/jx9J1opmsa3lJrgZ/u/6GUp/YTbCD+te5a
         NeW2y5/VmbZxDHqEK9vIpeDQT3x05ICgzi8ojaSOkxm/p+C80w0PWCt7140g1etNtJqY
         7ifMzR4g1dzgW6gb80A0gh0HZKt/zqDhJXaeJDfXRN0wG1nR5pPL/Vccdblpc/F0vuLc
         RyxpNFbSVhyQ/QxeN1qX2Yu23+wmY+NuFIpLYjovxWNlQ4DX7ycx8GKwW93b+uqwISfP
         zYZi0M6Bvq/DXg2YGUgbL3lJKnZ60Xd9BVX6vzWKyOBRjboYWXBM80kCaPgwho3uDIkv
         7ZSg==
X-Gm-Message-State: AJcUukcj7JSEWQe7uUEehZNrACjarWt07LeBDPmbvRzW4iTckYBI/wcH
        e688pcs/UjImG1Im1Eib0vp20ORy3ClKsM1yuMhO0w==
X-Google-Smtp-Source: ALg8bN49HhVUiqdkB+F9ajuqTvfosSxuca9y+pxbOly0uQ3WvBXfo/H5v0qS18J9XrhbiTPRpiXzvmgVP8R3eawNh2w=
X-Received: by 2002:a19:c115:: with SMTP id r21mr11086292lff.144.1548499272815;
 Sat, 26 Jan 2019 02:41:12 -0800 (PST)
MIME-Version: 1.0
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Sat, 26 Jan 2019 11:40:35 +0100
Message-ID: <CA+xP2SZ6RJj3Eii-=D6eSfkqHFtyskSvUFU=Qg358eTd+-SeNQ@mail.gmail.com>
Subject: [PATCH 1/2] Add tests for describe with --work-tree
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The dirty ones are already passing, but just because describe is comparing
with the wrong working tree.

Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
---
 t/t6120-describe.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index d639d94696..9a6bd1541f 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -28,6 +28,24 @@ check_describe () {
     '
 }

+check_describe_worktree () {
+  cd "$TEST_DIRECTORY"
+    expect="$1"
+    shift
+    R=$(git --git-dir "$TRASH_DIRECTORY/.git" --work-tree
"$TRASH_DIRECTORY" describe "$@" 2>err.actual)
+    S=$?
+    cat err.actual >&3
+    test_expect_success "describe with --work-tree $*" '
+    test $S = 0 &&
+    case "$R" in
+    $expect)    echo happy ;;
+    *)    echo "Oops - $R is not $expect";
+        false ;;
+    esac
+    '
+  cd "$TRASH_DIRECTORY"
+}
+
 test_expect_success setup '

     test_tick &&
@@ -145,14 +163,20 @@ check_describe A-* HEAD

 check_describe "A-*[0-9a-f]" --dirty

+check_describe_worktree "A-*[0-9a-f]" --dirty
+
 test_expect_success 'set-up dirty work tree' '
     echo >>file
 '

 check_describe "A-*[0-9a-f]-dirty" --dirty

+check_describe_worktree "A-*[0-9a-f]-dirty" --dirty
+
 check_describe "A-*[0-9a-f].mod" --dirty=.mod

+check_describe_worktree "A-*[0-9a-f].mod" --dirty=.mod
+
 test_expect_success 'describe --dirty HEAD' '
     test_must_fail git describe --dirty HEAD
 '
--
2.20.1
