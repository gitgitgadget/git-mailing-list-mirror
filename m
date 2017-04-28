Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32257207EB
	for <e@80x24.org>; Fri, 28 Apr 2017 13:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2998154AbdD1Nuc (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 09:50:32 -0400
Received: from mout.gmx.net ([212.227.15.19]:49693 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2998139AbdD1Nub (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 09:50:31 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5cMq-1e1Zci0fHM-00xf6E; Fri, 28
 Apr 2017 15:50:20 +0200
Date:   Fri, 28 Apr 2017 15:50:18 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 05/25] git_config_rename_section_in_file(): avoid resource
 leak
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <aed88de3501817b6d3586a1a27cbd2006b1407cf.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:h8aLkp/T88YF4pIiXe+Yap7r/cBEzmtMiqSwPavLJJqKjuRDRFJ
 9bleZmfneRt3h38YNVoRtBWCBOj/oY3lsejdGL9qngjXRwKaFG6v++okMuztJuQfkmRJ3Gl
 xlLrVNT4fd49KLLwV8M1HvJ2nFw7J4tHn1adp//Dk5C2oSZzjZTFG7ciZb7JI1EyQuWUPZt
 4x40wWnL58yRYeIRljIpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T19CAChQRmQ=:kvkICt2ZPq5B9wUy9DCByb
 Knl1rrj+FWgbgZC/dlA4eY9Q4FHyvwhlezK1pKDS5cXB4nCVjPC46M4xw8H+cgqUMzbWyhSEa
 SQuFWW2hqyzbcV8927/t2uPCRVZGw3kLKn/cmuav2g1TlXRifpGPymnY89+sApC07SmbDDhoH
 kP+IleQgTiZywWp7AUJBY0qufo7WQcdQWrbHuihk/yBFpCfupAkEeKrSAvXboMbAsWqWZmA9e
 7YGbQak60x+y95ef3EBnqMU7dmAPyRgOJYRyc7nFqrOrFMMWfyIbs91eyKo88r2fZDlYtSIWq
 qoRBguEq9h0fEvbSp8sJx7UQ03P8viFygs+h08mG8TwOQrAyqmY+XoVdPINcDyyrgfM3BKmQA
 ZoeLa9b/V9LiXkN/WnBabilX27sOkw62jT9rCarOe3KJiAtQLIs4jAnR9XPg5sGKNRuv80qJA
 utv3eUfT4NVWPzx4NCxHIWVDlGUl7XfUAL9kA8RCrdL/kG+K8d9HUzl12NLIQbBdcH5W8E7rx
 HR3GlWGtaT+EPJ/BHM/D7trcW+6qvQiffpDiNn4Em6PO2fFR3aDSJltXi1TuURKOvswrStJuj
 zh0afvKDtiBPBeL9x4MCZQfEtAGKr7PbRnxkOXvthTzn9bP61lnvWHLAln+wb1tiuQsGqeaBn
 1XrUDa6WvHYug3Dsg1l/q+2Sn7MY5H4BSXcAaHZcW3Q/1OjnpUdZVgm+so9YwJ1Por2BRhwp+
 tTpoftOPFMbreIeDAPwpFvSXUFdiJOn5qznX+ybSKx7gHNe7x9gPEfyHz6ea0jtPNCZN8OvsT
 pOuT+Dr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case of errors, we really want the file descriptor to be closed.

Discovered by a Coverity scan.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index b4a3205da32..a30056ec7e9 100644
--- a/config.c
+++ b/config.c
@@ -2621,7 +2621,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 	struct lock_file *lock;
 	int out_fd;
 	char buf[1024];
-	FILE *config_file;
+	FILE *config_file = NULL;
 	struct stat st;
 
 	if (new_name && !section_name_is_ok(new_name)) {
@@ -2703,11 +2703,14 @@ int git_config_rename_section_in_file(const char *config_filename,
 		}
 	}
 	fclose(config_file);
+	config_file = NULL;
 commit_and_out:
 	if (commit_lock_file(lock) < 0)
 		ret = error_errno("could not write config file %s",
 				  config_filename);
 out:
+	if (config_file)
+		fclose(config_file);
 	rollback_lock_file(lock);
 out_no_rollback:
 	free(filename_buf);
-- 
2.12.2.windows.2.800.gede8f145e06


