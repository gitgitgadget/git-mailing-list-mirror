Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B498E207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967201AbdDZUTo (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:19:44 -0400
Received: from mout.gmx.net ([212.227.15.19]:65288 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967200AbdDZUTj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:19:39 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ln7wj-1dkGPX0crl-00hLvb; Wed, 26
 Apr 2017 22:19:30 +0200
Date:   Wed, 26 Apr 2017 22:19:29 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/26] add_commit_patch_id(): avoid allocating memory
 unnecessarily
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <8a33cecef46887328fb5b6fd846385e04281a1db.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GkVaQ0SrvTDTj2zH9Q0pil5c5hvPuWLGnqM7VmVwDPucFFfWZKE
 J0EmdP6TDiqzH4jwcVw9VbesI2iXgFTbqB+cSgJEF/3F0+iVVO1+e3/NgnFtPTvW3PFTSC/
 9Ik24MkoPMTWdeTY/2V4+lDq0IvGhMO27ZslzfOOWEYZ9hjN+1HHp1eeF1gqzhVj887Snun
 Wj+fsV2mpXYThUCqXsEBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b5T/yF6buXM=:5NLkyKQOKrPeGuSBQWU7Ev
 nSe5dNsAp2QSXzn8UY9avXR6o9lqaPSGTG9Q/OgLjjd581FTQ9uk8fUuLeBoPeaEJKM0Jzgkd
 JGvjwKyCaPgYqXRBGlwj+gi/C4qli5HPMzrkNQUOCHCIRc1G6bNRNyjPGZhz8PBVzWVo81l+C
 EqEP+WoYEvy/aRCue6ADCqBi6FnlwarCSVCHGw659ewI67VGryh2uGwiH4GTUBmQJEH7mG67m
 JBog8EFNhVAHIWmBjnI/Eceq2plpQF1rT3x5SwfljJj0mYnSqMyURIZq9Y8oSLOeKOseYHf1d
 DiehlwvSN/SBJBZQAIKewuPpPQauH4/Osk93zBhz+bxbGjch6NlYhXv5VCPxTRnLIntGyAPn3
 qJ8RHzmK2Ad1+Z+RqgvbYyxjKhhM81lHpf2rYBSvPi+XqmsZ91Z6eNJyWx8TIPNJQ62Tk1rtX
 IMuBXJ2PUBfLQCbSLofW7kOLJgBE18/3JPwcidRNIjJy9ITn+HastVWopCJfnKYUjJZnNIQAw
 14YOflI2SrWLJqvpxb0qu9GJQHi24B77YsXbLfUt8I0rKhUHvrilCCDji+Htfnp43m2iUkcxX
 BcLkI0Bp2AqIjc2NKerKjS85Zjc7G4iJ/fnx0yflwlZf9sGfTIqv0YukGYt1nEAoKbF7rKNtD
 23MSOQH8EK549Otjw+JoRCCvO/D8ddyqbb648ehIaPvvGhccYhyWg0oTB6izQugHnm0FcAg4A
 Wzz28zasgx4ar3+qDNyTTtO6mmZkz3W3pDM/NmxGRHxKmkmY2ogybl9kR6a2bV/K54dYHXMi5
 5t6zJVz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It would appear that we allocate (and forget to release) memory if the
patch ID is not even defined.

Reported by the Coverity tool.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 patch-ids.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/patch-ids.c b/patch-ids.c
index fa8f11de826..92eba7a059e 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -99,11 +99,12 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
 struct patch_id *add_commit_patch_id(struct commit *commit,
 				     struct patch_ids *ids)
 {
-	struct patch_id *key = xcalloc(1, sizeof(*key));
+	struct patch_id *key;
 
 	if (!patch_id_defined(commit))
 		return NULL;
 
+	key = xcalloc(1, sizeof(*key));
 	if (init_patch_id_entry(key, commit, ids)) {
 		free(key);
 		return NULL;
-- 
2.12.2.windows.2.800.gede8f145e06


