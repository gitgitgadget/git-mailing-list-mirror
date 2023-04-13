Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13C7C77B6F
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjDML6Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjDML6J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:58:09 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BF09ED9
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:58:02 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-187878a90e6so3527399fac.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681387081; x=1683979081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T65ucdKm+tRgnG4pL9NczmK9GKxC4f5iCXDxKYvxP1Y=;
        b=PILO6tzkfAwcuBeqKcaWIPacTdo7SFnuMT9AHZqWK+VAvCLKVInxwXALbyV2j7ApRq
         WLSxT9g76geEjWDfwmccBQbIjUX4zy4NFdj+miQsz7lpyvylyTH0A1qdN1G493JnyQ8f
         RSevGJgE2q6TjHTE/CKkZPNtz5wjvWeBZRW2ICuFF2VNW+F7RQYiadHVvzVj0i9bt/XW
         sv1RFMLeyAEQITLdJKGD1sSrCjtLK43ARIwXNqY/PL7A57LrAl6xIUyWnz6Gc64q+qPC
         HOKxZWGtDyYfX8YL2f6DeavknNLSFUadirvm692qtS5usZhNnODpzJt1p0SzoVz4rNMF
         PFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681387081; x=1683979081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T65ucdKm+tRgnG4pL9NczmK9GKxC4f5iCXDxKYvxP1Y=;
        b=BS9Vt15KtnqN1Wr0876x6tM0yD+5uFG9oy+ICbr3MH044eXbB3MItXhS/ozAufyuaX
         5USsJXpCwcC/S9VPY7heNwshPUcQ7oouAbSWTeX5r0DCfT3y9ftuL4If35TriTp3phGf
         0IZ6Xija9rHdr39I36WPC97AJW0x0YG7ATYZftJlkJ2GIOm0hJGc8dMVxsCZwxk1OVpB
         Pfpk+wD2V95Hs+GVISUcZWSYHPITt+1vwMdjjYspOH1AA7dqcKviNkwWsI4TNaB3JQaK
         tj7/81jkQOtHKjX+yVYnt7a03Oo2GxvSHDMmeXOuvcCsig/N2QFU8FzlD7opfi9hUdTg
         Qxiw==
X-Gm-Message-State: AAQBX9epucgxTDCN0pie25Sm+Ot5bu+921jlkLDDkB1rXTjQbqDCmjCY
        72cf80BYHaszNS8T2uHfk1N9pcvClkg=
X-Google-Smtp-Source: AKy350ajMvc3iQqRVGt6XfzU453Zeq+uzc7v+/oyVbOiEZFLDod49+fowKNRlMVxctDvT5Od2afqtg==
X-Received: by 2002:a05:6870:8286:b0:17e:13e9:1e4a with SMTP id q6-20020a056870828600b0017e13e91e4amr1591545oae.17.1681387081709;
        Thu, 13 Apr 2023 04:58:01 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id eb8-20020a056870a88800b001777244e3f9sm622728oab.8.2023.04.13.04.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 04:58:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Johnsen <chris_johnsen@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 11/12] test: doc: add check for callouts
Date:   Thu, 13 Apr 2023 05:57:44 -0600
Message-Id: <20230413115745.116063-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230413115745.116063-1-felipe.contreras@gmail.com>
References: <20230413115745.116063-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t0600-doc-tools.sh | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/t/t0600-doc-tools.sh b/t/t0600-doc-tools.sh
index cd88027514..545fb0e199 100755
--- a/t/t0600-doc-tools.sh
+++ b/t/t0600-doc-tools.sh
@@ -26,6 +26,17 @@ DESCRIPTION
 -----------
 description
 
+CALLOUTS
+--------
+----
+$ git diff <1>
+$ git diff --cached <2>
+$ git diff @ <3>
+----
+<1> Callout 1
+<2> Callout 2
+<3> Callout 3
+
 GIT
 ---
 Part of the linkgit:git[1] suite
@@ -49,6 +60,27 @@ git-foo \- Test command
 .SH "DESCRIPTION"
 .sp
 description
+.SH "CALLOUTS"
+.sp
+.if n \{\\
+.RS 4
+.\}
+.nf
+$ git diff \fB(1)\fR
+$ git diff \-\-cached \fB(2)\fR
+$ git diff @ \fB(3)\fR
+.fi
+.if n \{\\
+.RE
+.\}
+.sp
+.sp
+\fB1. \fRCallout 1
+.br
+\fB2. \fRCallout 2
+.br
+\fB3. \fRCallout 3
+.br
 .SH "GIT"
 .sp
 Part of the \fBgit\fR(1) suite
@@ -84,12 +116,12 @@ test_expect_success ASCIIDOC 'legacy asciidoc.py' '
 	check_manpage "git-foo"
 '
 
-test_expect_success ASCIIDOC 'legacy asciidoc.py (docbook5)' '
+test_expect_failure ASCIIDOC 'legacy asciidoc.py (docbook5)' '
 	build_asciidoc_py "git-foo" docbook5 &&
 	check_manpage "git-foo"
 '
 
-test_expect_success ASCIIDOCTOR 'modern asciidoctor (docbook5)' '
+test_expect_failure ASCIIDOCTOR 'modern asciidoctor (docbook5)' '
 	build_asciidoctor "git-foo" &&
 	check_manpage "git-foo"
 '
-- 
2.40.0+fc1

