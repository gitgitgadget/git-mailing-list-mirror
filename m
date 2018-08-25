Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14B7E1F404
	for <e@80x24.org>; Sat, 25 Aug 2018 18:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeHYWa1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 18:30:27 -0400
Received: from mout.web.de ([212.227.15.3]:56907 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbeHYWa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 18:30:27 -0400
Received: from [192.168.178.36] ([91.20.53.4]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LpwMZ-1fQ5qY2KDn-00fktX; Sat, 25
 Aug 2018 20:50:33 +0200
Subject: [PATCH v2 1/2] fsck: use strbuf_getline() to read skiplist file
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <aaf03ba2-1369-2dc3-c3ec-739a1c56606e@web.de>
Date:   Sat, 25 Aug 2018 20:50:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JIHLqYs6Bvmo8RsXnc6qt8nZnhEzH05E0nETu/MvT6UChv5mddE
 P9DVEkmYUsWiiWnr1jZ/yFhrb9MUtxO38+aqQ8NLrQXOuVT8fUmgX/U7LA40dJ49pqBCjSx
 +zGmXdZroHzVN6DAneWRJ/YuAsSi7UjTdtEzadQSMYMFwgdnlNkoL7pUS9ixjb+FgWcm4cj
 Ue2o4iGwaM4EozNkHAOSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RjUGs9oCMUw=:jqhadeGZ+5g9D/u/r+RCPN
 VSQ6CZ17ICxeJ4p5RIVWpBTT879dDPNL6UUA+RF37mnJaa47oCr/Hoq0nK5b613CxlBQwYhse
 vbuWVJvv1reP51JTvPU8Btu5i91QGk+Zq5takl1xmyxkVTTkYgHNbKHrynNnBzldV7mgMUlT2
 GarhqJSWnjPHIAseCtst7cCxabRQr2oOequU0wpE6GAvDCh+6XFbfo5qRFJLw3SktLvgzaJAH
 JEVRaA9mjHaMwZHVxafPgGeyhCYUDrSAxVL6V3VoXSVASdeIxuDYW/xAc7Uof3leCNMz+aM6F
 f5q8rPrMrQcCVGMgSocUEGCBArPwi1wPK6RqdYjAU3qhQLpL9NJGp5vvUWxjgZw0pweAwkJPK
 8L4jV7JiMJBzWunGDYvi8jaOm0i+X4NPfQkAgmlNmkSm/uRu0PWxnu8cohoXIZqMxT97RQseh
 LP8nymw8YKug258/sTQPdyI7F/oeHNPOY9+/lOW+b4JeDuK+W6ctQ95MCHuT6ZCPqyaOxlOAb
 O/RgyyI6mk4edPrUwgUn223nJUDNER1XpdBfUgS6JkhAJWV1WDkqqFl0BLREkWg/G5hhyBGhv
 l201duG+QJgdTkjb/ZhcE1dGTVsZUqp4GLP3tuaxLxcqrhdEucYwyQ43OjAQR3WqOKx5QRy+n
 fwxMkNWknCLzW+Kg2mO2r1/wt8N2Mp2fP5vj/IuAICC0cPO0GUW7JJeDTX/hZZh2eFmXYJpNT
 eZsKYqIJEEhtqHnnwDu3EIftlvZNnlbI7dkHXB7fh1weG1AGpqXlXruT/lqN+1wRoV/J6tpPW
 QUldtoR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

buffer is unlikely to contain a NUL character, so printing its contents
using %s in a die() format is unsafe (detected with ASan).

Use an idiomatic strbuf_getline() loop instead, which ensures the buffer
is always NUL-terminated, supports CRLF files as well, accepts files
without a newline after the last line, supports any hash length
automatically, and is shorter.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
Added error check.
Hopefully fixed my MUA config..

 fsck.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fsck.c b/fsck.c
index a0cee0be59..972a26b9ba 100644
--- a/fsck.c
+++ b/fsck.c
@@ -183,8 +183,9 @@ static int fsck_msg_type(enum fsck_msg_id msg_id,
 static void init_skiplist(struct fsck_options *options, const char *path)
 {
 	static struct oid_array skiplist = OID_ARRAY_INIT;
-	int sorted, fd;
-	char buffer[GIT_MAX_HEXSZ + 1];
+	int sorted;
+	FILE *fp;
+	struct strbuf sb = STRBUF_INIT;
 	struct object_id oid;
 
 	if (options->skiplist)
@@ -194,25 +195,23 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 		options->skiplist = &skiplist;
 	}
 
-	fd = open(path, O_RDONLY);
-	if (fd < 0)
+	fp = fopen(path, "r");
+	if (!fp)
 		die("Could not open skip list: %s", path);
-	for (;;) {
+	while (!strbuf_getline(&sb, fp)) {
 		const char *p;
-		int result = read_in_full(fd, buffer, sizeof(buffer));
-		if (result < 0)
-			die_errno("Could not read '%s'", path);
-		if (!result)
-			break;
-		if (parse_oid_hex(buffer, &oid, &p) || *p != '\n')
-			die("Invalid SHA-1: %s", buffer);
+		if (parse_oid_hex(sb.buf, &oid, &p) || *p != '\0')
+			die("Invalid SHA-1: %s", sb.buf);
 		oid_array_append(&skiplist, &oid);
 		if (sorted && skiplist.nr > 1 &&
 				oidcmp(&skiplist.oid[skiplist.nr - 2],
 				       &oid) > 0)
 			sorted = 0;
 	}
-	close(fd);
+	if (ferror(fp))
+		die_errno("Could not read '%s'", path);
+	fclose(fp);
+	strbuf_release(&sb);
 
 	if (sorted)
 		skiplist.sorted = 1;
-- 
2.18.0
