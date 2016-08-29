Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FF21F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756638AbcH2IEa (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:04:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:49817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756425AbcH2IEV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:04:21 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lqi70-1b8occ1O9C-00eNUW; Mon, 29 Aug 2016 10:04:16
 +0200
Date:   Mon, 29 Aug 2016 10:04:15 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/22] sequencer: avoid unnecessary indirection
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <e5e6c27038c7db226a787da6b7ee343b2b310654.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rTlKUCTkz3P8s16NaFZKUQDDy/ka+5JRswlmMZD8e4cvdIOsSQP
 H2e/jQ/m9XGLklGoVW87ymGwS+Qg6xwuHAR65sRBq6NcAr7H7LdcVpk4QiWKqbDEzWhOk6P
 H5OtAL1F5MRv8LsA2MNpzNd9qi0cRG43SWa6VunTbWz2RkpJmLK3c8AhhM8N9/4WtUnhFGG
 z1HQTDrclVzgOxPVR3y2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bYVz4nx8PQ8=:M/ker9uf1htO/htTDTyxqO
 oS1JpcDhg4Z54avZVnhTcBTcI3WsQxPaeWmWMzA7KlTIzblTZdfBs+W8sEySzxtreNNRlDdW0
 idH298JvRym0bYhw5OTR7ZfohZJachKUa/gZ5V1CDZUOJlwPHri+Gx++Fonjr9ITBOXEUyPaS
 fEb7uYpfJZftnt4FUWNVb04RApQ0hiOgsnEV5olTAqsO2BdTmARXa/U1tcqXVdgYKdx4zs/Vy
 9DXKyUIDhpL+pbQnrzwYMdvr6hfUDTBp1mZ6B9wQkBZoKSBWDIlVOUwA80otcXDqDVEaALR1b
 mBtPOErIJ6LHWig2aOx6BsMbJ46DcappFBDEqcRtFI4MciaEMCUxKTpERPhbPnoisVfz3vIOr
 8Dvib7Nr6lPws1UHHnGkzLW4DvTqUyhtS8HCg0b835Cf++YrX7iWBa6DA/amMSoZjXjWNiqJB
 2sVifvoAX9PN2NIqRqIYAnTpGgm7zXfs/ZhOIJ8tAMnOuFeIxZ9+CxIFN8xT3F4A5j97vwbbh
 LkFmynavyr9o+1wyRfXgh6waIiTZfj5MCXHTlFnzXumuQOqui/Mp8NmO3nU2IMhyBEmoKaHUI
 ZFScjThlwxb8s04+rz1qsxUDibD0GzhEPEAm1ytcGP+K4xgmHa6Uj5Ma0hx+9pPQqu0bkfFtx
 6uSIvCg15u0gLD4vdWTZMnQvgqFlExSnbHnqQYYHranBRuhjLLwH0Kdiq+3j21cPbZlGKEyaM
 tLg7ehqoMG+pbcrUbTT116ukI5PixjNh20vS1hWsIRjrzxFk0GfVduApHNJBgsF1CqVazqEKm
 /Ya7UdW
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
index 4d2b4e3..14ef79b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -809,11 +809,11 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 	return 0;
 }
 
-static int read_populate_opts(struct replay_opts **opts)
+static int read_populate_opts(struct replay_opts *opts)
 {
 	if (!file_exists(git_path_opts_file()))
 		return 0;
-	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), *opts) < 0)
+	if (git_config_from_file(populate_opts_cb, git_path_opts_file(), opts) < 0)
 		return error(_("Malformed options sheet: %s"),
 			git_path_opts_file());
 	return 0;
@@ -1038,7 +1038,7 @@ static int sequencer_continue(struct replay_opts *opts)
 
 	if (!file_exists(git_path_todo_file()))
 		return continue_single_pick();
-	if (read_populate_opts(&opts) ||
+	if (read_populate_opts(opts) ||
 			read_populate_todo(&todo_list, opts))
 		return -1;
 
-- 
2.10.0.rc1.114.g2bd6b38


