Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BB13207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 20:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754269AbdDZUUL (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 16:20:11 -0400
Received: from mout.gmx.net ([212.227.15.15]:64861 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754262AbdDZUUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 16:20:09 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKHMk-1d586c1OJK-001iFN; Wed, 26
 Apr 2017 22:19:48 +0200
Date:   Wed, 26 Apr 2017 22:19:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 07/26] http-backend: avoid memory leaks
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
Message-ID: <366e4d805da9b4b610fe216537de5e4a4c3941ed.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:SZueVflSL7uCV8F4IUOsLFR3T9M1381m3NfX//tNUd8807ZyCUn
 +HQPddY//FhHBgc1iiA+nRy8vzkFF/PdKq9QYIHL3W6EstE6chJw+HkvwQSs/1NKnUCDX29
 1bKcaQnAhZ+unJO0ZADZlsd6LGjoT2u+KlbVnTpIc/JIFHd6Eyb4r/kaYZOmWHtqL5eVcwi
 zLMlGp6tsG6bHpPu/tOJw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h+uaPS4W5lA=:xX/u2mw01h6AC3bkCbHqrC
 KSH9ivIRFPjLVCtvkWjc10+MrcHSOrZdmyRXd7Xmt5sxMzoCgETLebDplys3kJqA40arnI55b
 xEu6xanp0kyI5jrwTUL4kvh1QhdEPGS2wvNvHd7HWrtz9Lef4y6D1/BIg8MBTJZhuWnhHIFS4
 Zl4VDSPHqHxn0wpovnZtGenletSQ+70jKKF57lOY0fnKvcmRJRBuTWzGBC7NI/QDJyBSczIPu
 n0ueky0RVXvYd+uSwIGdKniQ2Ioaw41MKahw8PlmQjgbRpQDV1HkzyHDaeO1iJ48lQ9Zzrqo8
 qBS4VPRimukzZ9tt6Y928GPAVRsq1hFF1dVLNfMYZ7nBRMDLkl+EFdHWRiYh5dHVMmZm7T3LM
 dUkO17qs6L+UeCQZ5lj+aoWQQKWWBKyfUVJW8XFgDLkStvj8jC6yoQnE01CjBcichJAOJIDRS
 7OfDw2XENJ+rc217qL2U2fzK+8eFtUgov79A1/ADX/xZa0FyhsThmfkUMbrl6Mdsjb9poGNSC
 RzFv1TBDKhpi700aL9AEi24y1XgQ/Bywr9KWzkEsLVuk/88VP+dq+1yrQhUtTIB8nF4v3lbm4
 n53WMTI9tY0M0pxIlOzW2OHAbTEEmd2txYN1JfA/gVxVu5mmQfjPURrjWZ1U2ig+v8PwJE1+D
 R2FwnWmkAl7dzwzpgDNSvMISOOk//EFIDn9IZ8dLYccUNlR8dXfYmAVq4PyMMnNSG2DiFvQee
 iKJ76PEMXC62s9VpgKI1W+oQSv32TFrhIbu97T4HEjZ9zkCjbFVDHL59tmwvoeip5Yt7kt+Wm
 XRt833r
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reported via Coverity.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http-backend.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/http-backend.c b/http-backend.c
index eef0a361f4f..d12572fda10 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -681,8 +681,10 @@ int cmd_main(int argc, const char **argv)
 		if (!regexec(&re, dir, 1, out, 0)) {
 			size_t n;
 
-			if (strcmp(method, c->method))
+			if (strcmp(method, c->method)) {
+				free(dir);
 				return bad_request(&hdr, c);
+			}
 
 			cmd = c;
 			n = out[0].rm_eo - out[0].rm_so;
@@ -708,5 +710,7 @@ int cmd_main(int argc, const char **argv)
 					   max_request_buffer);
 
 	cmd->imp(&hdr, cmd_arg);
+	free(dir);
+	free(cmd_arg);
 	return 0;
 }
-- 
2.12.2.windows.2.800.gede8f145e06


