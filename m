Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3866D1FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 14:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752723AbcF2OOw (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 10:14:52 -0400
Received: from mout.gmx.net ([212.227.15.15]:49303 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752677AbcF2OOu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 10:14:50 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LvEZe-1bQKtp0pP8-010P2W; Wed, 29 Jun 2016 16:14:47
 +0200
Date:	Wed, 29 Jun 2016 16:14:46 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] sequencer: use skip_blank_lines() to find the commit
 subject
In-Reply-To: <cover.1467209576.git.johannes.schindelin@gmx.de>
Message-ID: <69bc831064331117141c7153dc72e9e658691155.1467209576.git.johannes.schindelin@gmx.de>
References: <cover.1467209576.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tM7dDFm2cMXA6w1IX7XgKuOkmGAmeK46uAdWzHINTGjjYULwm3q
 JBe80+NbdI+2zUJsDdJfjYxrv+g5kpBH02XaDNKa2G9hR52AIlLbPcNp35296LBPGekj6w+
 w/miIVDriTTBqC985EpButn5YGp/4WYcnCQ+7bTx8V7P7VHsUkwAkasCwJ6sNM8eFVimpnB
 wSkyKo5MnL+n6vNMr6eBw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fTfF1J4uIg4=:fuVnOQPexVqAC6FQwqEsoM
 R3Xu2B0uztRqoSP4vPLNce47j9d04mSKTmv7FxYpJGPmSGlLOkHV/nJ6ZxkHMR4bSuPR1auNI
 eSu6ftF7nC9ThMizfNkpPRwKfFrNIzWUp31t2Q8eizCFUF4CFbkCCsbdB5wQwsmK3C3znycBN
 7/JTJfcL8hPKE+dXbmsELoG7XxYINrrp+BAaH2FpVmHMtiRf+VHyyKVe/itGv9xFkroPxXv2q
 EhutFjMYzCbdQMto5sx+ViGBZ5zk48H3W8EwUWPE5Z1yyul14B27P4bR7yLAka01YP5aWSXex
 G7SxTmqNmYMI3vsQSy30TFCmBzTNgU0kO/rlKkSPq8Oum3eONZpg8V7CQEG6jFd8RAiU/KTXO
 BvAFXbQJgJLEnft+CbMhNO35HNNtr+Ty2fs9G61ZdxJMTejD6Q/jicD4ucdxYydlFV0OmcT0V
 itZeTuaOUyviR08L036PF8gz9AGoMSvSd77Y1gqQiXxaYxRP4/cCH0QHsK2NshPjuyXtYFN14
 7tZVEn/FHyPShG9gmFLfNvwnl7fK7yLFImMj2OD4tgCKOCjOPZ2lBBuKufLr//M98Xsy3rzbQ
 pNeA5P80azGepe0/m8N954OcqRZ6M66fhXLJdcOwPnvEkzoDxKlNrJ61vqzJ8FyBInoza2KnN
 jTIrg9PLNUsd466o8I82YigiuC80Ax1dXz7aueZxqrrGmtjWAMck6afxik13WpZCgA36GNDpo
 HU7XJenEq3qJf1E0ecrDSCO/w2NS8t/RGpynBSNtu2HKz7wwYVf/5kQTC2YzIOHU1qcUUbpOg
 m4gKAUi
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Just like we already taught the find_commit_subject() function (to make
it consistent with the code in pretty.c), we now simply skip leading
blank lines of the commit message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7d7add6..cdfac82 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -544,10 +544,8 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		 * information followed by "\n\n".
 		 */
 		p = strstr(msg.message, "\n\n");
-		if (p) {
-			p += 2;
-			strbuf_addstr(&msgbuf, p);
-		}
+		if (p)
+			strbuf_addstr(&msgbuf, skip_blank_lines(p + 2));
 
 		if (opts->record_origin) {
 			if (!has_conforming_footer(&msgbuf, NULL, 0))
-- 
2.9.0.270.g810e421


