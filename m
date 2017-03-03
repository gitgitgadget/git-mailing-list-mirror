Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B437120133
	for <e@80x24.org>; Fri,  3 Mar 2017 17:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752117AbdCCRdD (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 12:33:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:55758 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbdCCRdC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 12:33:02 -0500
Received: from virtualbox ([89.204.154.17]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgvEY-1byxXy10qc-00oJUK; Fri, 03
 Mar 2017 18:32:48 +0100
Date:   Fri, 3 Mar 2017 18:32:45 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v3 3/9] Prepare setup_discovered_git_directory() the root
 directory
In-Reply-To: <cover.1488562287.git.johannes.schindelin@gmx.de>
Message-ID: <11d7318604fe3d5d6b30cf51101a57555011880e.1488562287.git.johannes.schindelin@gmx.de>
References: <cover.1488506615.git.johannes.schindelin@gmx.de> <cover.1488562287.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:M8SQ0CB8cOz+DNIzaKlUicBRMS7Hs7V+hbeN79wPsf4qW3lAXtF
 E5tkvw9arJq4uxzpiyZCHxFWyfDKCxLC39ORs5wHytBshE2SA97MSOTLI8WpRrY+mbJz/EM
 kceyd2CoyGTep6CoKHOyDFZ70IPfkr30Fq1rwTLRmSG+2j01gKP/HAWPD6BHrhyIkP0srln
 sRcG3tMKqKGhmcpgz4A3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ncTKcqp8cks=:btpoBIbRwk1JLaqQP+tL95
 wwgQ+jPDcZaH8kSe9ZqFNFC9G/6qEHJ858GXfce1Mki3NrOUuJbzFwj6wld2a49gVZ7hDC36q
 2CsnD6ylX6nfYZexSdtNAbr7hTuUeGDWQzROARhrwHRWc893UZTZeDRKuO5LU5qMKxCTbDh2X
 GmWCoo/u8lkcYF+g8BuCtdL6rzDS9X2R2YuBH4AS/eMf2uyJL6Vmaj/6ZNV0vlLyXnwyUGh74
 MLmMfhWRIN4S66iUAHt+BDTO0cLDTGRoYg4MiXMUiDRXcn9jH1q4Bh5Zx8e97pzPBwiUXRt6W
 af3NAT0kwA9sGNCo1LuvG5qwEzDQ9i6yXdWEDTAmNWucUjGhzfU3APpCOcCWxclquRSKlhUlW
 oWHM3CRqRxo/omQ+CebnZQFqcTdXHWuSiexG1k1NWkmSKwjZFN4sDdS9lSwqdkUq64HIOusDw
 f1Hoj9KJ0t6RAVsMPT/J9ddnNxsSjycbZloa0ugJqwBm2vRo4hIW3a+qs6qpD7+rLnAS+fNLk
 vKuQ+mitiIp+r6l9MVKSPMVIYOKadOCQSjeSkFwJezuworjKAqyQYINth+UaXZ5Ogqct/WrKy
 e/wAWMiUp9JaiDE2WKxwW3b4xUYBEjwz36jzIsSIgyStplfHv21QBGKj26X+DnFXOBN98/HaW
 /+ip2xoADO5y9uzIEsZ7RlMvs4Gm613bNXYQiOAzStDf73xWioP5WDcB3qqO/1D5qcjz7TWA5
 tmeGGijOl5CckfAKh/ujF3mG7tztdebYG+ZGbHDa8N+BSq0v2nFAxPyQb1B2CknfOlK7snXHS
 EFMYUoZ
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
index c47619605fb..91d884b6746 100644
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


