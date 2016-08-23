Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF451FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753784AbcHWQHi (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:07:38 -0400
Received: from mout.gmx.net ([212.227.17.21]:60111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753282AbcHWQHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:07:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MbJTE-1bseeT0fNE-00InWb; Tue, 23 Aug 2016 18:07:05
 +0200
Date:   Tue, 23 Aug 2016 18:06:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 04/15] sequencer: lib'ify prepare_revs()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <ce6a7cac9f0bd53e44129c8f72818adc4bb4a934.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:x4QKbZuZWqrECa8zHpO8g/VVhj6EnAOj++o1WnokipVn67eiTl1
 wYhoboxk6IJTyhQRaBGWO9cieKutpa+c+3CfzAPF3qPnKU8g4WZjXvcBB67/bLIAv55LwoM
 OK53RLv/FFndqNJ0bkb//ROBPmsXDgoCJWXan7qcnGnLwKB7jATCd40iQ/CPBKP3wppiXMa
 2MzbGm8d/lzoLwphx0ABg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YnhgfckVMuk=:AYEbAtsEYOOZ4CFEkwICWr
 XlVYf9yVMwP0Gc8gTQgqcvuasW3+FDvshjz32IWx5IswM3xh+MYWvzCVkCUO7PatN4JS90krB
 9JNOsXkEB+VI/KQnedqVkt+VvKnNn9eWvnx/QGYah44Z+EpwtS4fUBQeVrb4kRxkpRzlw3S+K
 di1G6o2RhYjHjApevjMrBAd2KKPDPf2VeoPaesavYCV8kV5SAVUiO4m/eO4lqyxGQtpIte3E+
 sKcJ0VI/2NIHZsHucXXJsBIRjIWxQNgklEHuy1ktg0z/XDiEOVh5gEwbg6tYDEG5vjsOBGOwu
 wIFKrVq/p12fCZFLiu73dZpbAinxpI51mjLvPRqxR7NEYX5zqrG+K+U+V8APOks3jhwB7fF00
 k10aio0jT1nYhyn42LJyWYyUq4WrCDzwdTSdBIpjfLDuE7mQR4/WoXcA1z4GvHUgoRIr/lp/p
 MUig/l3tETPfB7RDhGIDENeEaLDkPPXldu7muSc6pszjBMu7ANtvMrU6IaxH69Weg1BL799jd
 XB509jYj3UwxCkpMRpt7lwjlyUMAGmBTPtv+DdDnb/f8r5c7SeIcIbpk0ZFBtz+/gxYoy3JIP
 0u2J5qi6xV4eReP+NoOir/Xxq5s/PRznT+8IlMGnVSHaKOHeRyQS8FrZZKiGpfwk/Kbp8/4/p
 tOp2ZfF0geGoW/TIPQjIeikw1FlhB4ybFZiSmF2Kn76EpvuAk2MnC7N5SNOFFTAwWsIUPM1Ls
 Reqr3hqO6+OrZIDACNaJ39l/nV/SnN6u7NXZxvfBGzHMkiDmvI0WueJHDrGlbtejBA3YVev6i
 lanqUfu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 6ac2187..b90294f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -621,7 +621,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	return res;
 }
 
-static void prepare_revs(struct replay_opts *opts)
+static int prepare_revs(struct replay_opts *opts)
 {
 	/*
 	 * picking (but not reverting) ranges (but not individual revisions)
@@ -631,10 +631,11 @@ static void prepare_revs(struct replay_opts *opts)
 		opts->revs->reverse ^= 1;
 
 	if (prepare_revision_walk(opts->revs))
-		die(_("revision walk setup failed"));
+		return error(_("revision walk setup failed"));
 
 	if (!opts->revs->commits)
-		die(_("empty commit set passed"));
+		return error(_("empty commit set passed"));
+	return 0;
 }
 
 static void read_and_refresh_cache(struct replay_opts *opts)
-- 
2.10.0.rc1.99.gcd66998


