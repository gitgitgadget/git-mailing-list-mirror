Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E18B1F461
	for <e@80x24.org>; Thu, 16 May 2019 01:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfEPBqX (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:23 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:35700 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbfEPAhk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 20:37:40 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1hR4Ou-0006em-4r; Thu, 16 May 2019 09:37:36 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH 2/2] Use xmmap_gently instead of xmmap in use_pack
Date:   Thu, 16 May 2019 09:37:36 +0900
Message-Id: <20190516003736.25544-2-mh@glandium.org>
X-Mailer: git-send-email 2.21.0.dirty
In-Reply-To: <20190516003736.25544-1-mh@glandium.org>
References: <20190516003130.racexnofe7cxra3t@glandium.org>
 <20190516003736.25544-1-mh@glandium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

use_pack has its own error message on mmap error, but it can't be
reached when using xmmap, which dies with its own error.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 16bcb75262..6a66b605e9 100644
--- a/packfile.c
+++ b/packfile.c
@@ -630,7 +630,7 @@ unsigned char *use_pack(struct packed_git *p,
 			while (packed_git_limit < pack_mapped
 				&& unuse_one_window(p))
 				; /* nothing */
-			win->base = xmmap(NULL, win->len,
+			win->base = xmmap_gently(NULL, win->len,
 				PROT_READ, MAP_PRIVATE,
 				p->pack_fd, win->offset);
 			if (win->base == MAP_FAILED)
-- 
2.21.0.dirty

