Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D65B20285
	for <e@80x24.org>; Wed, 30 Aug 2017 18:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752711AbdH3SUu (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 14:20:50 -0400
Received: from mout.web.de ([212.227.15.3]:53497 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752549AbdH3SUR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 14:20:17 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MVtqS-1e2eJT1rNQ-00X1Pn for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 20:20:15 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 29/34] transport-helper: release strbuf after use in process_connect_service()
Date:   Wed, 30 Aug 2017 20:20:15 +0200
Message-Id: <20170830182015.21188-1-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:eDBn5K/1oHA+xADWI9R59YwEZnkt8dyOgM6u73LoCqvNoYsM2WO
 FjRb+al8dUL/H2+jYiqBrXBaVNfJLyCdwRWXs3diMelEWPGo8jVginVdp91nw5QkDyyZr1y
 /fx3v6Kr56VOw5J4MhxTRL+MEUjwr0iZJbw+Z9MUZJatTHrNZcH2/1kEyIX4UZgGKFPyP9D
 hrBtLlRO1fxTkMDY86i1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BM0qKnA0jw0=:5ArQHfDns/uklJi/pfB4h4
 18uhDct0SwqjW+6SV1C/OyLgIJtEoAtmZ+KSjUnQ7PYBtXANUbeeutiAl04+eOvZL3Y9A54u3
 Fndcp7Bhf+YCH17Pj1tzXlPVnk9pFDkscKnVzmOVJPJkWwlrdSiopoZrZeRT6QbQFKLd9OnYt
 XzWgqsBDlylU5SKDL2aVD3MPqKBsOM1JOrbEZXZlmRgfP/YRXFic40xslfYYXYHjAWyPF59Zf
 yaOuVwSn8+lSUC28xDUrX5zF8xxxzpiEGh+fYOSuNIuHdQFOkBW0/pjXWoUErzdQ7WC9GW7iA
 fmc7qb+vYlmDOOND7BCsZO4F0SEQ8GCBYBVFRPN4kQkAZmiiFU6JhtCc9Lhj1AhrCSc100HUw
 1p3NLUpNsFDmFqev8MNRA9tQJVc+/PZymXLN+fkh+T8GaKKNbXZF0VNSJxw8FF/x1ohTZnllJ
 G2ysdBBvlfVnAXWth3QmlU6OFow26EpzVTceYShds3ESLhmypsyyq+1iJwUF/IHS4VP6TBeOw
 41rbQqjQuJOFMl22AXOv/A2fSBEDwtKkFIcGuJUAM1i6zvYF+tO201+X9wdu2X0Q78wUd/jiX
 8aBk3Y+2BURZG/LC11yKr+rO/oeiBo5uasdnhwHVaQh36qrQYG3asdk/Oqc52CW3bCLQimNuK
 8O9vM1HWfi0E5USXHdlBPBYiFC74A0o0m3RLA0G1eRsXp5SvqBstF1x92wiVj4gIK8iVO1iS+
 KjViZkwJJO2vIL+md7lQMreA69KcgGclm6Q782ZH5ARyKOpAjgAzJZjV3bJC431uPQbQAiukW
 1Uqx1q/OX4NhYp0WlEo9R6X+ZuiGg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 transport-helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/transport-helper.c b/transport-helper.c
index 8f68d69a86..519a244583 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -548,62 +548,63 @@ static int fetch_with_import(struct transport *transport,
 static int process_connect_service(struct transport *transport,
 				   const char *name, const char *exec)
 {
 	struct helper_data *data = transport->data;
 	struct strbuf cmdbuf = STRBUF_INIT;
 	struct child_process *helper;
 	int r, duped, ret = 0;
 	FILE *input;
 
 	helper = get_helper(transport);
 
 	/*
 	 * Yes, dup the pipe another time, as we need unbuffered version
 	 * of input pipe as FILE*. fclose() closes the underlying fd and
 	 * stream buffering only can be changed before first I/O operation
 	 * on it.
 	 */
 	duped = dup(helper->out);
 	if (duped < 0)
 		die_errno("Can't dup helper output fd");
 	input = xfdopen(duped, "r");
 	setvbuf(input, NULL, _IONBF, 0);
 
 	/*
 	 * Handle --upload-pack and friends. This is fire and forget...
 	 * just warn if it fails.
 	 */
 	if (strcmp(name, exec)) {
 		r = set_helper_option(transport, "servpath", exec);
 		if (r > 0)
 			warning("Setting remote service path not supported by protocol.");
 		else if (r < 0)
 			warning("Invalid remote service path.");
 	}
 
 	if (data->connect)
 		strbuf_addf(&cmdbuf, "connect %s\n", name);
 	else
 		goto exit;
 
 	sendline(data, &cmdbuf);
 	if (recvline_fh(input, &cmdbuf, name))
 		exit(128);
 
 	if (!strcmp(cmdbuf.buf, "")) {
 		data->no_disconnect_req = 1;
 		if (debug)
 			fprintf(stderr, "Debug: Smart transport connection "
 				"ready.\n");
 		ret = 1;
 	} else if (!strcmp(cmdbuf.buf, "fallback")) {
 		if (debug)
 			fprintf(stderr, "Debug: Falling back to dumb "
 				"transport.\n");
 	} else
 		die("Unknown response to connect: %s",
 			cmdbuf.buf);
 
 exit:
+	strbuf_release(&cmdbuf);
 	fclose(input);
 	return ret;
 }
-- 
2.14.1

