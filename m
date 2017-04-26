Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8B8F207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967222AbdDZUVc (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:21:32 -0400
Received: from mout.gmx.net ([212.227.17.22]:53637 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936147AbdDZUVb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:21:31 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LsgvV-1e5F992PdZ-012K7J; Wed, 26
 Apr 2017 22:21:22 +0200
Date:   Wed, 26 Apr 2017 22:21:21 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 20/26] line-log: avoid memory leak
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <0051da81b5cffe53122c036122402418c7f8d55f.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:d1CJCtHX51dEVkjMm8KSH4scrXHkvWdgEzw3xQZ7uDVn/lavpyT
 dG5v5RAJmfGxWotmqKEqsmVtwbkrQXiE4EYSpU3z0dCJ2AxUVkGUUkIVqfHccaqnzkozivX
 jDAkCBeavvZX47nvLME3eoJWq+m7HEfI8Kv+1z8zDN17NfF76Xtr7QrGnDxRxsRPFQxxILo
 CborUds5GlRUXzo+0z1dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CYE04mlrDJ8=:eMkxd3KfpgQ5jpKjYIwoXt
 yTasX6lH23+1Jqv93tcb7UxdSHgHF61lb7hRow3+Kirkg/dYoQAmjtTvzUWrfEaCYqXMKAuHF
 fYeLTfgSHDRpjOTFqbhNpj4Ku8lJiu9kYXvlanGs/UqrSR3pRImE7W3o8ZLgUqlaavoN71FEo
 MrnUiVpfrMTzuPcm75dTFcplF6xSnm4wUDRv+8VnAyXmhx/MVPN3EisP3REZrPMT0n8RH5q60
 W4DIaketaLkKyxZ0nvDoD+LhqLz2YOuoAq+hQIk3p0dAbND9yJiYNJU8Ki1sBKiIkht/O65+q
 sPgLyD7KzpFMZdyroci9jRk4HLPcCbJki8b7ias/sTCqvlnm587j71cvylxDHeXja5IJurDvE
 G0sl3SL1BF5KdLAPy3taBpdGe/lC8E6c34lg13FDrIPS+Tr1Tc6yV3mBghM1wjSwQFfcwGmyo
 23fSGe8S8cq8xb1h0ipqudzG15cKKfm9pg/CouIPMobtgcxQhD/B4/Xh84gPpzA0J1cYwh7pw
 WvjAK1296E3mR+UgIjiOefdPrsElncLFucbnMQqx5FZWiBjKQCUO+VsgiRYgeCjH8SlQnSg2c
 zWESxfyKoKdkce6102KRjhqTE1VJBLl5eTQpqNcGiZ5bJzNvBgkrZYmr8M0qVkpQJh5eBR7z3
 KXBl+7mOhbWI3+S1OAXdtCoStEOJ5MtKN8i6dCmZJZ0otyS233MhKqA0BuPSrMyO3tlgWr7Uu
 GgpQ78ZhuA4E9dYIgEQoVYjlPuUv4s6cgbc/1XvUISJ0qswmGkPDZzqtsJPAVR5l9e1b/wmqS
 dPWQAxM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Discovered by Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 line-log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/line-log.c b/line-log.c
index a23b910471b..19d46e9ea2c 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1125,6 +1125,7 @@ static int process_ranges_ordinary_commit(struct rev_info *rev, struct commit *c
 	changed = process_all_files(&parent_range, rev, &queue, range);
 	if (parent)
 		add_line_range(rev, parent, parent_range);
+	free(parent_range);
 	return changed;
 }
 
-- 
2.12.2.windows.2.800.gede8f145e06


