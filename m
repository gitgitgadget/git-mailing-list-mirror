Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD14207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755755AbcIKKxE (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:53:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:54812 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755741AbcIKKxD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:53:03 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MLA45-1bilGV12GX-000KMg; Sun, 11 Sep 2016 12:52:58
 +0200
Date:   Sun, 11 Sep 2016 12:52:57 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 03/25] sequencer: avoid unnecessary indirection
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <2587881a45d5a81cda4b2eb40e2d7d8d55b7931c.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:aXTy1Xr8zudV0FeC0PSRcQRr5DDGv0yM8uq92njWJKEyuvFxOYK
 q44QRf1kOsm2YETcDNVCAz445txRD5zaI0a+rsdScOuFrgaSxxwcKEf+rctIJ1FTnZvpc/v
 x1P11JncRYtvt1S2wTWYOLc9fDDSBsiRogenJMpcOkQjYsitPnsGiqyl6KCe5WOnERGUrLy
 y6eyIlfovI+e/NoiqiuUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:spZ3CwEbCuE=:VELcczULkvjSCzJ7MwgSuG
 9naXRvQNeGsjwY7GNjVR6utXhyXBWHoxvQbbkiqM98AgGclCANI7Hej04gcQF1Poa+F8avn3L
 9VlDGQyZmALUOH3MsbczG5HY87UOaa+YLL6/QBtcuyJza2yo5qJzPxy8UlqDbfdPCEFofb43R
 e0k6ChjLAtWKE3TozZUFPGtqc33BAKodXSDUz0EbcyTpR8hd6WEtzyAP2NhkpXlm9qettW+oa
 w0RgO7ppR5Rg+Qzosee2a3086lJ+nJEvryFQ2fOUoHKi+S1h3GMCsKlRKuKB2Yu8tinJmXmj8
 HtfUt+pcrXxWTFwvC5fbhvL+C1P53ssLOovoIZFNh0VJ1Nc94cvjmPtsICKD8Tx3DmvyzcT/L
 SRuS89iXwIIMovyEX0PdXnEzpquX25a35CB0t/VeRPM4jaCK6c8/HAZLEo7Ofm5pvBYRUw4jV
 bQ8/OZra0SEPgocBkLoEu4lzo22PfUsgwW9nwPgy4cLp34BLs+CbWtpbBLNT6y2YOxCEmpGEJ
 a4/ngLfwCfrr5GTdNxK+SNVvN7D/hOd1nf4EO1dAzA/6IeZ4pRt064pDeCaRYQw/aDSu3wnzH
 A7q1WniYwGi2aaNeMIDQkjdGKtf3rYwtB36161M6PpbKfkau7c/qzH/kvRVrkf6DI2kyyzEVe
 56WbqKJUcCjJcMjg7Fbu8+cWKOVga7HEDCR9bTpmJldPPk2U2oUM+m/mXyHXaWzD8zmkcE/MF
 Piodlav/YAbUEs5txSfkDfx/qNxSuYn97wOfVS5rxU9WsqjkeAmFYORCSith+LrELiR4eX1N1
 lVK4TnP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We really do not need the *pointer to a* pointer to the options in
the read_populate_opts() function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index cb16cbd..c2fbf6f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -813,7 +813,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	return 0;
 }
 
-static int read_populate_opts(struct replay_opts **opts)
+static int read_populate_opts(struct replay_opts *opts)
 {
 	if (!file_exists(git_path_opts_file()))
 		return 0;
@@ -823,7 +823,7 @@ static int read_populate_opts(struct replay_opts **opts)
 	 * about this case, though, because we wrote that file ourselves, so we
 	 * are pretty certain that it is syntactically correct.
 	 */
-	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
+	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) < 0)
 		return error(_("Malformed options sheet: %s"),
 			git_path_opts_file());
 	return 0;
@@ -1054,7 +1054,7 @@ static int sequencer_continue(struct replay_opts *opts)
 
 	if (!file_exists(git_path_todo_file()))
 		return continue_single_pick();
-	if (read_populate_opts(&opts) ||
+	if (read_populate_opts(opts) ||
 			read_populate_todo(&todo_list, opts))
 		return -1;
 
-- 
2.10.0.windows.1.10.g803177d


