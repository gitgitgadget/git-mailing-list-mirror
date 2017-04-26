Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15CBB207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967214AbdDZUVT (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:21:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:59018 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966731AbdDZUVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:21:16 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MWwp6-1dZUq51Kbs-00W1L4; Wed, 26
 Apr 2017 22:21:13 +0200
Date:   Wed, 26 Apr 2017 22:21:12 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 17/26] mktree: plug memory leaks reported by Coverity
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <517446aaef6742d546afeab2a5270f72992c2742.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:scXqi0vBAOsEbVwYv74Aw6IZgHLVflQ2pjLxQ2OAmZyLpHROOxi
 grxdeimtIOr/M2g1cEa3eYth/IZRLgXpuk8+C+ze+bvksZfGoewlHGmV4oqx02HuRLZ7tBj
 Wems03bDrzV1EvGLGyTpDuOiWu9I4HxLkzk+dTFL54dAXpVi5VEC8PY5O6wUDM5PYZwimaE
 MEROBocXXrpDEchRGREmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7JveT5OWS3Q=:OcSGqzz9zbUMS9smKs6Wzv
 Hrkjbx4Wgb2jG908XNaSsUVjEoIw3gH+p+PrC/U1k+ejAm/tI7D4v7rbRsO69+uLiV+5zLBl5
 pLb4zjN4D4hHsITbWR+vcK9n7ELhIVKXAPoRlw2BT36CachO59/TW4ZrsHbJRjHOo2RgwuFgC
 hjJ+0EnSLce6YRHH4Fq9bmlcK0uMhCCkp7+gtueCZN0fVCZuBB4ZBh6Ti0bxvwFtAAoSi0o/C
 N+Kn7tp9keIoYKzwGdJoVAuCTWPs+gg6caO8GzCX+w8LbOjf05Ka7HTMNZWIyltVvfdKbMoWK
 URFKdBDtgv5ym+bVjHiPoDr8A7KoWPrdzRrBH0Fk+nVimXC3feFab0PbooRDeZ7FN5+RIDaZj
 uaqGZVXaUmjta4ZNuIkR6TqN3GlDtwb57nou8WzhdfefBwtKDJ6veh3du5wB10KBXnvNvgKim
 HZg0oKSUgS7+s0hAvZCmwhB6XQTLFtqX3Ajt0s05X6fx6Bqtlfq/qcLKDVU0pz2V4QipvO/3N
 aF3LpHQOjOJisnVgM42bRq69l2HzVRj7hvYVfTOL1ugTC07gjx5O8GhUu3p1/J+X9zTKhq+im
 8VjaGZxn6b+RMEyvu2r3vQcR41cse8RJw96SeqRB3+q9BCirUFEE2LSld3WsffZVHkmTg0ckq
 P9irxS7rSZDcI+xoqaPxKeyPB7wzdOBL3DT4FnFGeiOcWG1oP2PqpPUZwxps0I7LoBB6mb5rT
 HAjjEuNZdFrLl3KilcXgaS8yifUY5m2neuYP/vVeg/iahbxlIlPQHVnYuygFWCh6CKSHoO7H4
 KW87U2v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/mktree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index de9b40fc63b..f0354bc9718 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -72,7 +72,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	unsigned mode;
 	enum object_type mode_type; /* object type derived from mode */
 	enum object_type obj_type; /* object type derived from sha */
-	char *path;
+	char *path, *p = NULL;
 	unsigned char sha1[20];
 
 	ptr = buf;
@@ -102,7 +102,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 		struct strbuf p_uq = STRBUF_INIT;
 		if (unquote_c_style(&p_uq, path, NULL))
 			die("invalid quoting");
-		path = strbuf_detach(&p_uq, NULL);
+		path = p = strbuf_detach(&p_uq, NULL);
 	}
 
 	/*
@@ -136,6 +136,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
 	}
 
 	append_to_tree(mode, sha1, path);
+	free(p);
 }
 
 int cmd_mktree(int ac, const char **av, const char *prefix)
-- 
2.12.2.windows.2.800.gede8f145e06


