Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DED41F859
	for <e@80x24.org>; Thu, 25 Aug 2016 15:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759353AbcHYPPB (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 11:15:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:51281 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758952AbcHYPNw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 11:13:52 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ll0tl-1b2VQy3BMT-00ap5c; Thu, 25 Aug 2016 17:07:13
 +0200
Date:   Thu, 25 Aug 2016 17:06:59 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/6] require_clean_work_tree: ensure that the index was
 read
In-Reply-To: <cover.1472137582.git.johannes.schindelin@gmx.de>
Message-ID: <4122fc996a0076c2426d5e1325f2ce2810ef4f9b.1472137582.git.johannes.schindelin@gmx.de>
References: <cover.1472137582.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EJS7ov3WfARMFM7xVAdb6B4DZLqIEjluXMoT6PhZtRosfz19PZC
 dQ2l2ZjauVKmF+MDT2eKb7XZ1zH9h/Jaf3zN3FpbT1aI4sQNSbFNmC72vHvPCHpiWsXHrhj
 N8Tpkju9AI19NFpX+dg8LxX7QYeZrl4nn1H6MWEEepfUyao3M5wESp0LBUvOxW/HoqvZjBh
 p78eXsuP6QzPMFsWah1bw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RyC2+1c11cc=:51AnD3vpBKHYDZOEnDwUpE
 /flvkOfA2tOpLNzWgCMwVDxAcvhW0VelEHmMGwKWKeCGG5gY5ofN0nKXAz3NP446fWAxx/6c3
 CZ1endl7PRDBg0MCiRgLdcuONE+UsrOFV7FtzQDrKcWaf9lJfquNOieq53vl6acCJ2t+OH1qb
 63sCeMly9BEaD4qtHWv1TUf2UpNradoh9QAKWvuiWWMLlFSoc/pIC5dLpEKBIdBx0cqXqVwQj
 eIdvY7jM7aCFBsaRSP1B5anoB39wmxH1f9O3yPDJ2nlWvNjiuE90hx8PtSaGWheI21hVBDmYI
 OgNzy4fNoJ61PapoSPXz69okUW5PhAxxJwMQzo1EhKXvRKdtAktIWnq8dO5ePaZZCX/aN04hO
 69+HmjCUljShBY3tFIxTuWcgySwieRrkTPEvvbBNHC0XtAK87MOQ+uPLy4yKSeqm7Ht72s8lo
 hfSyhiKsj83B0ApE4Boj3420QVYUPl+jKN8gf55P2AiLeGSkkD3DWYdTbHftTL+whRDHLplsS
 ldopywSOhqRRH4Mj/VpVqh2gqx3ZPNUK+tWDj4u3QqLjEvVTnIbi/Gj59CWsSnKH5+9PowhwL
 RRydj7CHHduxXGp9ODsteJvfA+vML3lVrVDUOfLsX6zSX/mnyISTIGzi6yBuuUHeJSU9/dxE1
 pIulxNONFDDoq2jY72KIdaQapHjSKLNVvgEoi11SDUsaPb4K5IT3pi+qWj0rhdM5AEpv684Iu
 gjWzLhNyGVhOda4PlOzfZqZhKRQ4GcfnO0ITULiUaGuryZi5eBNb9RvjUum9g9IoWp5VZLXne
 dFFRy7c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function would otherwise pretend to work fine, but totally ignore
the working directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 wt-status.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index 792dda9..33dd76f 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1804,6 +1804,13 @@ int require_clean_work_tree(const char *action, const char *hint, int gently)
 	struct lock_file *lock_file = xcalloc(1, sizeof(*lock_file));
 	int err = 0;
 
+	if (read_cache() < 0) {
+		error(_("Could not read index"));
+		if (gently)
+			return -1;
+		exit(1);
+	}
+
 	hold_locked_index(lock_file, 0);
 	refresh_cache(REFRESH_QUIET);
 	update_index_if_able(&the_index, lock_file);
-- 
2.10.0.rc1.99.gcd66998


