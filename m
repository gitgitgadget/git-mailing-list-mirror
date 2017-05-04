Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB77C207D6
	for <e@80x24.org>; Thu,  4 May 2017 13:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755443AbdEDN5U (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 09:57:20 -0400
Received: from mout.gmx.net ([212.227.17.20]:52646 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755407AbdEDN47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 09:56:59 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtmK9-1e6sFR3Fa9-011D9R; Thu, 04
 May 2017 15:56:48 +0200
Date:   Thu, 4 May 2017 15:56:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH v4 13/25] setup_bare_git_dir(): help static analysis
In-Reply-To: <cover.1493906084.git.johannes.schindelin@gmx.de>
Message-ID: <fc054bdc7754045b01655feee88a74203bdf128c.1493906085.git.johannes.schindelin@gmx.de>
References: <cover.1493740497.git.johannes.schindelin@gmx.de> <cover.1493906084.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EfOzC0VNbCj1RjXZljFDvyrav01A2BkVbajLb3dzM26lD02Ha3V
 8qvtEcaNftInrSHlz7P+jXtkyu/1SflZHK5Y8nOV50NIPKFPF8Cmnda37vwF/UZnML//J6w
 m1Xv98vRfHpfIYxi2xe9Gbfq6CgkcxU8tuMZxjkaQP1kbpPvBXRjMM6sFVr19MgM3drQIQ0
 WFms44+wPNzT7h9Wq6Crg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OWFhcdGJAss=:gh03SNdJ/qmDxYZTe2R1py
 wMA8e3x8Y901PdmmQcd8w3D25/l3gJUZm48rGvzpMKbjKO3szZBwtxMbQ/fdR4h/5a3cLzbhy
 QqM72ShEnPUsL4hMYbZC+4glzGmRVq/FPB3UAVEI2go69CVT9sRztdC1lZ3EYz9klfSRLPDjC
 V+NYAoH8AGuCEEXTGOGxuGft02HghJQL0+EHpp/TP6VbcZ/wA3lo8Y+6VCWD3pBZ58P5KZPNK
 ND/Dbdj9ZRB1qnoLDZ6oqayT6b/irzT4VSKxirmKRi2q9507eL88iSUe+c2CIamHXwoKvDV2U
 E5Db0KvS2Id3Vtcf86xZO/oRqPgD48K3aFVAyq0qObKL6F0BH9m56VsoIv5+rQI/REhqLaUG4
 NTNlZdv5FP89vb+75pB+dG0LV/ACEJieDK9UaDyE1+PenNWTZtLVA9mCVR4e6bdiptow+TfC1
 ufcc228TSYBgCXskgbKdZJz7qCkqnldMrYEaVuKjOBIbQp3261TR+sjD7NYpiurPuRIfV2y8W
 +mIG1k2uLyn5hdRAZfAswFl3V6pQ9xKz5pV8gck7dK8Cn5Wutemeg9RYyd/sG+bKvNq528j2X
 oQzyvsV70XGmBKcQ0MnPFDBOpzUxX9lH1i8CyjPpUVqKu5YB7wpUipedg5kwutQ/YW8bKSjZv
 KW7xeOuMvUVVij3UPTeMoF/3YyRRQB6J2Wv7KUK7JYFn1sUbUepvJPIAEpPXc6rak6eTk2Rco
 KBquu4wXrUsoOVwZqTpj7J1Cr+ejqBDotRN1C3Ik2bvPSHm0augYQe9e5rbPGwrt4zPs3r6u7
 y7OJr5r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coverity reported a memory leak in this function. However, it can only
be called once, as setup_git_directory() changes global state and hence
is not reentrant.

Mark the variable as static to indicate that this is a singleton.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 0309c278218..0320a9ad14c 100644
--- a/setup.c
+++ b/setup.c
@@ -748,7 +748,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
-		const char *gitdir;
+		static const char *gitdir;
 
 		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
 		if (chdir(cwd->buf))
-- 
2.12.2.windows.2.800.gede8f145e06


