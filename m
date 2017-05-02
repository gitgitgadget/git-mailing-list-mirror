Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F0D71F790
	for <e@80x24.org>; Tue,  2 May 2017 16:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbdEBQCi (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 12:02:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:58121 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751199AbdEBQCh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 12:02:37 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ln8Tl-1diDn93d8f-00hLLA; Tue, 02
 May 2017 18:02:30 +0200
Date:   Tue, 2 May 2017 18:02:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 17/25] fast-export: avoid leaking memory in handle_tag()
In-Reply-To: <cover.1493740497.git.johannes.schindelin@gmx.de>
Message-ID: <06098b382225d6a8ef40b30717d86f1c750ab1ef.1493740497.git.johannes.schindelin@gmx.de>
References: <cover.1493387231.git.johannes.schindelin@gmx.de> <cover.1493740497.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:55ovpIQ5opKexKgYRtMJnu2SrR9fgM1wf90ZwVAsZkNsBKdHDCL
 yobkUbmz/zkrCtOVBAsXbRXZ7S2ifZ63I67ktV3cKwe8LzO7paXxNk+ypV6gNBktTIcsqp2
 tXm4TQBkqXPOXDRI5O8BDiHTihkaNcT6DPqfKb/ZV4ECliCoctw1ytPi70imTp3tWKs5RXh
 DoDgMxwdwAGbqvxpBZQ1A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/ak8SPcah7U=:97mRSNj/ih8ac0eVd/H3A/
 ZO0sEZrSiorItaSO4TLAizvmXOhMOKTV4C5sUipL5b9quyjSMlUG053r6fKQQhlYQ7qvhM9FI
 j56FAnWF/h1e9FVqZjteFzXwazhuoeebUX6GonKMWwGECt6YwNYFMFx5rk/IRl/OI6ipJ57Re
 x3JE3J/OslXsZEx4+lEZ21GGckEHZBx+0UgWMrmEk7CdJE4VThAJBdxfgx6YKfBQEycgrY4c8
 +pvZ3wECj0zQqfElp5JRt4/Q73gAmdIim6xT3j9F9PI9xD330BF9BEOFx5x65LZ19v39OYJgw
 fsBimq/ZMUQ29o1WhksA8b1bGmcSPjXd5Z+CLHRoCz7ECzDpnjyMeLk74qrRHPsM52x9kqvfS
 5ZLZc3aQGp3t46ygN5SdR1abN7gC30VizKGNMRAENOL6Se3G+BXRqyNxPfMSwHUDyYphAf46j
 TO4LcXSRGhYuKGa0Wu6iSiS+A2nBw2MIKHUcq5BAzPSFBpOCf8+L+Jb0qZeoFpJaqiLvhBaXH
 vIdWZ/M0RLW/nUi4QB70Ry47FAQKp8oedhOhzaLNi0Yo1BqEZTkKrukP95ORAirhzO66WaEdP
 k5URiNMyKbmhPa3c0u3+b9miqT++xtRUzS2DICP2Tr8/LUQsjMyviZ751ibfnuP0bQQdeAloU
 8fD3Rjr0AuT9GW2CBy1wqtX5W7FBdDOG5YZHj56x57FPc3RvlmpXNb0cFxqq34cBvDfqsQqyu
 LAksTchpVnpIdrnNWfeAwL0ulzosc6e20pN7X7yixLUGmN7O6S0FUFKscork88EqVuC3rlald
 9er94rg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported by, you guessed it, Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fast-export.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index e0220630d00..64617ad8e36 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -734,6 +734,7 @@ static void handle_tag(const char *name, struct tag *tag)
 			     oid_to_hex(&tag->object.oid));
 		case DROP:
 			/* Ignore this tag altogether */
+			free(buf);
 			return;
 		case REWRITE:
 			if (tagged->type != OBJ_COMMIT) {
@@ -765,6 +766,7 @@ static void handle_tag(const char *name, struct tag *tag)
 	       (int)(tagger_end - tagger), tagger,
 	       tagger == tagger_end ? "" : "\n",
 	       (int)message_size, (int)message_size, message ? message : "");
+	free(buf);
 }
 
 static struct commit *get_commit(struct rev_cmdline_entry *e, char *full_name)
-- 
2.12.2.windows.2.800.gede8f145e06


