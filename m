Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC4EC433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 00:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbhLAAcf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 19:32:35 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:50952 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345744AbhLAAcc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 19:32:32 -0500
Received: from localhost.localdomain ([84.13.154.214])
        by smtp.talktalk.net with SMTP
        id sDUkmByoui2JdsDUlmSxSL; Wed, 01 Dec 2021 00:29:11 +0000
X-Originating-IP: [84.13.154.214]
X-Spam: 0
X-OAuthority: v=2.3 cv=f5U2+96M c=1 sm=1 tr=0 a=nZAgPUNe/8GoCGAv1ndepQ==:117
 a=nZAgPUNe/8GoCGAv1ndepQ==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=ldyaYNNxDcoA:10 a=ZZnuYtJkoWoA:10 a=gIu6M3af8k3AuybQZX8A:9
From:   Philip Oakley <philipoakley@iee.email>
To:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 3/3] object-file.c: LLP64 compatibility, upcast unity for left shift
Date:   Wed,  1 Dec 2021 00:29:02 +0000
Message-Id: <20211201002902.1042-4-philipoakley@iee.email>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20211201002902.1042-1-philipoakley@iee.email>
References: <20211201002902.1042-1-philipoakley@iee.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJv0mkEJH6WFtvipohfcVGaGRmyJraCNt0OKuvydpXvsJeDQEsNJGXEdCZxqIqaqoJjbB/2MSVD4Dx+UN17yqf72W//fDTGLFBZ/5W1eiA839JbI+2s/
 y2P+SALAGxBL6TlC4IyHCW58xNDuzxelp2IUHp1Eb/qV/45pDaxPQLEj03iH1zYWlUVBrqVMvt2ZgAjHwrHeKmiOE0qtmdlGhnb2jJqQx0bHPrm48HnmVeMJ
 U6EXWJ2jZ4SzFLf1uKrxjI9YyYWtssucOKszfrBzSbrzD5Yn98XBY5kt2Z6XqzAVWLWiaZKerZetRQo5aEoOpZTheItUqRT4qAWuaaljRz5XU1E9MEBobLLi
 H5C6M19t
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Visual Studio reports C4334 "was 64-bit shift intended" warning because
of size miss-match.

Promote unity to the matching type to fit with the assignment.

Signed-off-by: Philip Oakley <philipoakley@iee.email>
---
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index c3d866a287..da8821cb91 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2425,7 +2425,7 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 	struct strbuf buf = STRBUF_INIT;
 	size_t word_bits = bitsizeof(odb->loose_objects_subdir_seen[0]);
 	size_t word_index = subdir_nr / word_bits;
-	size_t mask = 1u << (subdir_nr % word_bits);
+	size_t mask = (size_t)1u << (subdir_nr % word_bits);
 	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
-- 
2.34.0.rc1.windows.1.4.ga126985b17

