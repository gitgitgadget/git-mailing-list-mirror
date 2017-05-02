Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21371F790
	for <e@80x24.org>; Tue,  2 May 2017 16:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750961AbdEBQBY (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:01:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:57266 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbdEBQBX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:01:23 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhRUQ-1dSDhG2w1y-00MetD; Tue, 02
 May 2017 18:01:16 +0200
Date:   Tue, 2 May 2017 18:01:11 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 04/25] add_commit_patch_id(): avoid allocating memory
 unnecessarily
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <71aa1c1c90057c59dc6f549b42778a500e908acf.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZnRGG9QLwMGMaRmC5Axz04mV3TM8f2Coyyy0eNN+rinP6Ff8VPE
 BAhBEPcDSuRfDGoOeTtAuJ2QdL5ujSRPMugs/FCrrh3ydPI0dZTkWAEmC164da6pSULMpsn
 9merNx/Vxth2tcdI0NtWWRDyyn282PJ8AlRHbwl/efyvieNfN6hlEbSMKgd3pkeTkj+li8G
 NXAVVwyIPy0gwM8mHu4Qw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kLy/om0FqeI=:ZcGs1mgfTW179i9NF9NgcA
 QUcYlHwPgDqIvcJHXA31pSvSlUWACh/F5CrH1AJHKew9vzdlohkIg5t8xLJKzLXFgzR3y/Cg5
 Cvjr+c3zBkhlYg0dUPiVbWVp9IuBwmUV6lJQZsgk2kn2mBce0H8yntykQyjej+GYnNV7oDSN7
 WEHcaWLYj+vqOHrTu4y1jzEyYULND5f2w4k1DeIMzTYHYoMRT+P34itkANltPJA9BROx5e8vs
 S/z3+B8JiTlZM6f3M7NrHobkR0lCyef22PbOu7L1nzLIQw1wix9ifEGoc9EIHCQmSzf5r8a9f
 3exMgEGNbq8k0HxH8ZZwOMEM7UXFqAVWJMhdGvjhB4raVlVb6I8aZT/K1gQv+8qL0Y9xGq7BW
 G2MwwY1P6rdk11iNe5FsNWyU5TR4BfrlRtuDUyj34YDJgIuX5RJGewgdy9JK575vv+VbiS3X9
 9k6sBew/dQzG/irjA/4ySqKGS4RW5D7qQ5xNqzgUf9ALA9wR4Lt0QmibEMBP3vo18nrVD7uA4
 16bwu97hSaByCtG/jHZp+glF0RRH8HdQuZKzcY7R+K1Iaf+fMTLX2xG1X06De67l638mtfrCl
 ZVeqnEWIpwll/1AwIH1uaV+6exKAxXK84+TyOfTGHeCoucolQ7OwDZw8CYb6RN3opVfXKdj+X
 igBH25nyZhkBub9b7Pf8e83rF0MYFW/vkkbW/siwha+5+S+eegPi80t3irYRZfxwa064MzlOe
 N26nb2uMI2qh1siKmpkvmtA6kMSN3N6cSvbqa+VtPU8ZOFrgjjRJJnPGo1lI4kY7ijIBrLv0X
 /IXZ8I6
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


