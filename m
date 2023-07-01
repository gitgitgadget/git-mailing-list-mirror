Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39F2EB64DC
	for <git@archiver.kernel.org>; Sat,  1 Jul 2023 07:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjGAHLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jul 2023 03:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGAHLQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2023 03:11:16 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6771BD0
        for <git@vger.kernel.org>; Sat,  1 Jul 2023 00:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688195115; x=1688799915; i=l.s.r@web.de;
 bh=0BgHthwvMKeZVkPEdOlVrMF1H6sBF3YZQY+szk0PRIk=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=VBdYRZ4sULbjKDDYO5XpF2jlxvKLD52ItctvL5Wo9GfmHsJWGsOCLq13iIEKp1k9wbrSWmZ
 HdWBZC6gpJyrkVFzCQJ1TMRQEcoptcDZZ0n9/ylQ8lsOH7schpBm3eD4OWCtAq3nkcLf9yS+t
 Ff+XRca5mVgK4Zbb6FJYFxrLaS9fb1EokHzsI/RJG0jQ8QZlE9Z7PT0rwDSqJjxt6hjP1y1Qr
 xZnOex4VOypiAh2wPXo7gzThPGYVKZxRzZi4CVXE3BokHjoPbUwBuCBBrHBH2YiWKgXD8hSjE
 bHJVzQHpEqdUbYLDo89Nq+Ya3kJ2ufRyC8Jm0sd5ST6mnf3MPdHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.31.43]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMAE-1pa6BB30Vi-00fV3r for
 <git@vger.kernel.org>; Sat, 01 Jul 2023 09:05:15 +0200
Message-ID: <89d58db7-6a01-b3fa-54f0-19d5a3819eb3@web.de>
Date:   Sat, 1 Jul 2023 09:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] pkt-line: don't check string length in packet_length()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pkrEUSxrDuOGil+FziYpQzkgLjUEX9j3ALW5IqW4JW24v6GXt6C
 gfzDOachxPTG2cED1XYUPGmk64vOGCyZjZvoGSAMUNfNCFq21vZEbZ3jvFS0uHAs2/+Jv5D
 QIXVjPLB3AmVcX229aHzziJMbhAjNaWq1PWQs5w9lN9hY180iGSIp/wBXpvyQbOnZpkd/Xo
 XLP8jzjBLxU+5fwHw41gA==
UI-OutboundReport: notjunk:1;M01:P0:g14nFcYtYIs=;jnC82Ez8phwHOsrSCoFRvBYBdWU
 uYQvYUrZsp4S/tY2Lu+rlofy7oqKRTOkK7friGN+fGZwtK/whdngCYVLk9fty1mt1xuaeZDy8
 va1tuOfJbvT4WnD5Fn8vGDu9BVwcqucqvAMCkvGvZwX1U4Iz6w6ycwQMNz9CuutPP+s1OzzNz
 74xxaCSr4HoogZRfWbc4QV+Ik9e2SGU9TVaT55cO23udJcq5JCM4NR8fAxhDUNASr5s2gFk/B
 eJqVLpDXq1MPv0201VgQH6X6KzIns/pB/7h+gx8kjsrk1ky3IOd8ZedFgAGwJbgAiDqmB6aiz
 G0k0U3B4h9G8xpyh67OTm/3112SjKszMWD1hZLDbADoADQk1mD/eH5q4IniFrabUzw+NpezRH
 rVLMjsmn3Gk+shyvp87sPtxxtcM5KChCsqo07LtQnZoeymAIcT6lkWZCiiHRDenyz263Fhd/O
 LG/gWhTJ+uwQUZyiHVFcH2cGa1e0Tm5qGVgkSIl24yIU3bADfonwVcfE2Zk/ToEWrNImyv06G
 gIcGZqfq0QSms1b1YbXAb9S4GQO8ZG0CNGo0Bvx03xeboKeQIY0pBI9VR2Mak2hShuSW7Lz3c
 kaUUIwBh04W2Wz4mfqKdJMXlbOMvTcievCB4HsktKxPf5nRhAKR3ues9roPkG+6q8UEfMlbAX
 RZAYGAQdoCPFN8+BW30JKuwKvjUOOQc7kwfujQTpiyRWTXhTdorEqWubzAouw81UDg2KEW/6M
 zP8k56TOnb6pLp6jipZ/6wx3BeX+Sa90Q+l6KLyQEW6elbGxVqq8AS6LeT5k2Vgdy2VJOKhpe
 HyNrejMnMfJwCuqcwgXGhrDCscK5A2b/be9/J2JrsSjxP6Gd+RHwucwC9dSEkLsgCfLF0pa7A
 4Cv1ZPy9AmA70lq5QaTvBedLgoa392E89KQ4k8JG7NA0LiFFx3vZyq5EH2aiSOpTpRZyjZAlR
 JbUqGA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hex2chr() takes care not to run over the end of a short string.
101736a14c (pkt-line: extern packet_length(), 2020-05-19) turned the
input parameter of packet_length() from a string pointer into an array
of known length, making string length checks unnecessary.  Get rid of
them by using hexval() directly.

The resulting branchless code is simpler and it becomes easier to see
that the function mirrors set_packet_header().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 pkt-line.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 62b4208b66..6e022029ca 100644
=2D-- a/pkt-line.c
+++ b/pkt-line.c
@@ -375,8 +375,10 @@ static int get_packet_data(int fd, char **src_buf, si=
ze_t *src_size,

 int packet_length(const char lenbuf_hex[4])
 {
-	int val =3D hex2chr(lenbuf_hex);
-	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
+	return	hexval(lenbuf_hex[0]) << 12 |
+		hexval(lenbuf_hex[1]) <<  8 |
+		hexval(lenbuf_hex[2]) <<  4 |
+		hexval(lenbuf_hex[3]);
 }

 static char *find_packfile_uri_path(const char *buffer)
=2D-
2.41.0
