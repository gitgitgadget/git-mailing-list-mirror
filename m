Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C597DC433FE
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 00:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345758AbhLAAcd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 19:32:33 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:38616 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbhLAAcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 19:32:32 -0500
Received: from localhost.localdomain ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id sDUkmByoui2JdsDUkmSxS6; Wed, 01 Dec 2021 00:29:10 +0000
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=f5U2+96M c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=wwJ6zcVpBE7CKp6EtbsA:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 1/3] repack.c: LLP64 compatibility, upcast unity for left shift
Date:   Wed,  1 Dec 2021 00:29:00 +0000
Message-Id: <20211201002902.1042-2-philipoakley@iee.email>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20211201002902.1042-1-philipoakley@iee.email>
References: <20211201002902.1042-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfEaCEXODdAkI0kcc5LNC2z/QWVLDuuX2vKgCILN0bpd0MtlMpmt1ePqWrWG+NjNbNCln/+xCfGJJ3Xcb6Yh2QYSN4a0MH/oJDai/j7Ghf/+H2tClhHU0
 PeZOc8LIiwzxI+0udrIZQwNLknA56N8On/mJ+B4WRKyMrMZcAKc5YfCm92OsQcNAkpNPJAD0JFLlY9YtCSt7RDFsNE/JkHWEupkiCdWoqelJ6Ru3UQVs0rKT
 hBAsLWD5DjPJ5cb+z+NsmgGurACLl3h6f9zG+0lwM5asGQMfB+tfF0+dk2HwksJ96pIl0ssAytwey5/mfvIkwF6oWQo4b45BJUJZTDhcNPOM9W32AQGPs5Ys
 j9DMMfer
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Visual Studio reports C4334 "was 64-bit shift intended" warning
because of size mismatch.

Promote unity to the matching type to fit with the `&` operator.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 builtin/repack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0b2d1e5d82..6da66474fd 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -842,7 +842,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			fname_old = mkpathdup("%s-%s%s",
 					packtmp, item->string, exts[ext].name);
 
-			if (((uintptr_t)item->util) & (1 << ext)) {
+			if (((uintptr_t)item->util) & ((uintptr_t)1 << ext)) {
 				struct stat statbuffer;
 				if (!stat(fname_old, &statbuffer)) {
 					statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
-- 
2.34.0.rc1.windows.1.4.ga126985b17

