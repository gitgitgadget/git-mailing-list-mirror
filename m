Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B29C202DA
	for <e@80x24.org>; Tue,  7 Mar 2017 14:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755652AbdCGOdY (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 09:33:24 -0500
Received: from mout.gmx.net ([212.227.15.15]:57648 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755615AbdCGOdS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 09:33:18 -0500
Received: from virtualbox ([37.201.194.72]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX1hk-1coXRf0O8a-00VzRV; Tue, 07
 Mar 2017 15:32:52 +0100
Date:   Tue, 7 Mar 2017 15:32:40 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v4 03/10] Prepare setup_discovered_git_directory() the root
 directory
In-Reply-To: <cover.1488897111.git.johannes.schindelin@gmx.de>
Message-ID: <44b547dd1e7cc57c8612ca12771cca75d5f6c4a0.1488897111.git.johannes.schindelin@gmx.de>
References: <cover.1488562287.git.johannes.schindelin@gmx.de> <cover.1488897111.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7ViDDJ3jujBqelu3yf2PiM3cuhz1INXqo6yZaOCNMcg+QL10yRh
 FkZn9+QmUGWAEmRiZubIdldxIz0teqeFYT7nCuOFR4ZinEgkjOkguWULTOHrNe868CX7lnF
 fKMl1xvVWkz7zgoBGh5Y+F+sQpTAByAeC93cu0OS3bL7PEx8jCuzEg7MXWBOY4vbap/JJzk
 jXBjLszYRNMzD0v/25gMw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HMnqKW14nMQ=:cED3Cvh79LV7OAy3eaarfl
 VRmCNB47Hycp5t8h0TTPoXdqkPk35NWmD87PmyrMUOgxD8EVpe+z2u0K2+kW/A/9ZxXTTYKMf
 vykDWVWIfz5vFw3RfqGcbKSBhLiWt64BtoE7qVsxTKTfyv+v2vAB80bcQqbQnabEwRcRI7kFt
 qeWdjzNnHCzyQvWr2jXHplj3jlzIxbYFiIMHA3zRgLLq6sYDJ6tfigjxMVpyXuyNIRX2ORANu
 57o+I7hDcWHKS+ZLwwx344/MMBg1iQXOWPr8S32H++MqOxSvt4LiiYu9/58b1YlibsRQiMwQ7
 aNYBwHCsNiTMWkQzcoAWLGv7+01YhPObhH4acFpYA3jOOX45hnVU/5L7sfxr0gaXyoy2C/FsC
 qEWqVyXeDJb6bGsn9jepUalnZjSa94apAfjp4QixUzjyvMFAYTeezvKO8kZ1vO/H9KdBcp753
 mlIeke4gxYfqm+Lg5vc69TERifaUFwDkb/h7olzjLAP4ZuZoM99FiUd3MmpT3gOzJip49Z3Mf
 a0tOoP+0dCxCzvW2nloDWaB57p9oRhmX2Y2C7tykQpDdW4vy/Ghsth9sCSuDnSWLsBk7/oObb
 ro3r8qm4UH8ZCSVWfjHsZXqPUiJAPuUVRkYT6hqOU55N+DZ6ayvx6x0PQTe/MGmx5H0qWDlmL
 fVZ5fVqKfwnpAa4tLnebVRA6rPiNMHVBmQHxsArTbYSKGSevCSj9Jc2dH15ANpvWWvfY7t/l4
 KB9ZHGGMKzvqXlmcNEQhKPO92xBCSQZuZAiEXS4l89yZ/vwwVdPhud28ntQcO7nN4Dy0jRRdn
 dqFFr5x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the offset parameter (indicating what part of the cwd
parameter corresponds to the current directory after discovering the
.git/ directory) is set to 0 when we are running in the root directory.

However, in the next patches we will avoid changing the current working
directory while searching for the .git/ directory, meaning that the
offset corresponding to the root directory will have to be 1 to reflect
that this directory is characterized by the path "/" (and not "").

So let's make sure that setup_discovered_git_directory() only tries to
append the trailing slash to non-root directories.

Note: the setup_bare_git_directory() does not need a corresponding
change, as it does not want to return a prefix.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 4a15b105676..20a1f0f870e 100644
--- a/setup.c
+++ b/setup.c
@@ -721,8 +721,10 @@ static const char *setup_discovered_git_dir(const char *gitdir,
 	if (offset == cwd->len)
 		return NULL;
 
-	/* Make "offset" point to past the '/', and add a '/' at the end */
-	offset++;
+	/* Make "offset" point past the '/' (already the case for root dirs) */
+	if (offset != offset_1st_component(cwd->buf))
+		offset++;
+	/* Add a '/' at the end */
 	strbuf_addch(cwd, '/');
 	return cwd->buf + offset;
 }
-- 
2.12.0.windows.1.7.g94dafc3b124


