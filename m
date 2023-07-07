Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036E7EB64D9
	for <git@archiver.kernel.org>; Fri,  7 Jul 2023 21:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjGGVsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 17:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjGGVsG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 17:48:06 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEBA12A
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1688766476; x=1689371276; i=l.s.r@web.de;
 bh=Ytc20SmxsekVWoE4f94HJUMf5XAeHs2JxDeOloGoUBU=;
 h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
 b=Cy/3cGdscE11dlxRCXfiaDk24pFtRX9O8rHtynG0IKfRjBXFScYr51PDYo7XYhgUYAUku5V
 ErcavgWTYJ1H7k9xfzFzVvufAj1WCSd7SyT9bg4NQM2qsMuXoX0f2l8CDkaSKvlem2bykc2tk
 pGQOn8yc7qoMtTV/aS9DKUa2TQZdhsnWjQtD+IrsaPUy53ADtH5s+V9DRNrhgwlgnL5yY4Et+
 gVbZvq5viE72ROgos0wgvLMLrBX2CYI7kpEiRH+HrQrBa0rzRYO1BQBfoNIfF1IdcFqQBFbjU
 ZPzltUtZd4bHENJVApxJSh9pl/KlF7m8h22jhrFVq/9qncV8xTwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.158.134]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mav6t-1phAyV1IDb-00cC8g; Fri, 07
 Jul 2023 23:47:56 +0200
Message-ID: <4d2bb49b-9c3c-ea58-274b-d9e9586620c1@web.de>
Date:   Fri, 7 Jul 2023 23:47:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: [PATCH v2] pkt-line: add size parameter to packet_length()
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
References: <89d58db7-6a01-b3fa-54f0-19d5a3819eb3@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>
In-Reply-To: <89d58db7-6a01-b3fa-54f0-19d5a3819eb3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sDp2w7t4ihgaGBvXgQ9xf/DUjZVuHgF32GMdGX59F0Y0dkNN0P2
 7roWjw4yQd50IZZly9XXU8juaGlWBEcvNWhWl+ZcV/gIoNHk8UaRSTYN89ZBGimrnuv0fKC
 7hWm8mzuueegBvCYpFYPzw7YbCCQSSMUpQhksYbWB4SshJgXXsRm3ZMC4rJTOjHytCcN/f6
 iOSYlzDiwJqwR0ht5eciQ==
UI-OutboundReport: notjunk:1;M01:P0:ymz6hl1ZFSc=;eG5OG9HFcYCYQva5TECQHshxHH4
 uFNzLJZ7ZdG6O/V9C1aW5EsyrCBAu3yoOO8ulrGTEL0P9zSe9QKRW7vrKmyQM+QA0m2uprXBD
 VYsDBWoUkkyKjOqjEn/ZdKPvdfLAEQxbH31YX9yzFh3D4AGKBGV7hm0DIIwAqiz1h0W2GJsw3
 pT+Ne2wOJ5RXW6v6PUAYZgJCy0g9ib/ZSj6QUK9P6R6CJKXL44R9b4gzT7QHp5NBPwSzmn8bu
 N6kVP1+AkmlzkAhVWxVMuQR+DtcI9+K9WZCdHNeU1nYm3Ou/WSAQb4GM6fsNWllOH4ucvQB4Z
 LCIv8DEmX7oKRpDaYEm3WZfkDMTimqaIlssHRCSMVhwpzNlx/4IjlSUD2ySg57no+PTO5P5Hc
 NUMo2EAF0LHuBrkoTYuKsigpzGt1V8fKz0myINni0uwgvi+q6JTR1mTN7K/GQmC1ff9QxvdvD
 UNp6BzX/K5gc2f9/wg7us2b5P1ESHwwXy0Lut10Kycze58IETyDPTwkujr4qgSL8mj5j4A56q
 66WQie9DTwuvNK++goeuxvZCW2TD2mfxZqrX/j+Vv55z0c7O+845txND53eaNwXv6OQJGY0KD
 4GE9UFteuTVXtmBfB5U4pns+i6YwXTKhWiqSDw2QgoZhEifHRv+x4cJ/lkxhyVdME5VSPtqRV
 0MS8Fv+X1LrxDRaju184hlJ7/TiTDH2vMqXSXggji9kyHfYqvrygZk9PlXIQ2qw/NlLS7Jndr
 KEDUtwNrxUmRjCkXBWj6q+GoncV4G9SdvtQUfMKuBzcUZk+3HrvPUQxJkDEVkiXRWc/tPKZf+
 UoD2t9sai5k7Hr1jyAKtqfo4C/IeDqoV/X5fZxYPeY4w08776bSLA4+cZPVBjPb1JMh5a/D3A
 SnpRXtF6dbs1WH7nC7KOxO14FOyh+N7n+WlnYBmbY6aRXdLMvmYYpiZv0I+X6ajoFKFCPb7T2
 Zp1GsQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hex2chr() takes care not to run over the end of a NUL-terminated string.
It's used in packet_length(), but both callers of that function pass a
four-byte buffer, making NUL-checks unnecessary.  packet_length() could
accidentally be used with a pointer to a buffer of unknown size at new
call-sites, though, and the compiler wouldn't complain.

Add a size parameter plus check, and remove the NUL-checks by calling
hexval() directly.  This trades three NUL checks against one size check
and the ability to report the use of a short buffer at runtime.

If any of the four bytes is NUL or -- more generally -- not a
hexadecimal digit, then packet_length() still returns a negative value.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 pkt-line.c    | 12 ++++++++----
 pkt-line.h    |  2 +-
 remote-curl.c |  3 ++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 62b4208b66..fcfa357ccd 100644
=2D-- a/pkt-line.c
+++ b/pkt-line.c
@@ -373,10 +373,14 @@ static int get_packet_data(int fd, char **src_buf, s=
ize_t *src_size,
 	return ret;
 }

-int packet_length(const char lenbuf_hex[4])
+int packet_length(const char lenbuf_hex[4], size_t size)
 {
-	int val =3D hex2chr(lenbuf_hex);
-	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
+	if (size < 4)
+		BUG("buffer too small");
+	return	hexval(lenbuf_hex[0]) << 12 |
+		hexval(lenbuf_hex[1]) <<  8 |
+		hexval(lenbuf_hex[2]) <<  4 |
+		hexval(lenbuf_hex[3]);
 }

 static char *find_packfile_uri_path(const char *buffer)
@@ -419,7 +423,7 @@ enum packet_read_status packet_read_with_status(int fd=
, char **src_buffer,
 		return PACKET_READ_EOF;
 	}

-	len =3D packet_length(linelen);
+	len =3D packet_length(linelen, sizeof(linelen));

 	if (len < 0) {
 		if (options & PACKET_READ_GENTLE_ON_READ_ERROR)
diff --git a/pkt-line.h b/pkt-line.h
index 7c23a4bfaf..954eec8719 100644
=2D-- a/pkt-line.h
+++ b/pkt-line.h
@@ -94,7 +94,7 @@ int packet_read(int fd, char *buffer, unsigned size, int=
 options);
  * If lenbuf_hex contains non-hex characters, return -1. Otherwise, retur=
n the
  * numeric value of the length header.
  */
-int packet_length(const char lenbuf_hex[4]);
+int packet_length(const char lenbuf_hex[4], size_t size);

 /*
  * Read a packetized line into a buffer like the 'packet_read()' function=
 but
diff --git a/remote-curl.c b/remote-curl.c
index acf7b2bb40..143318658e 100644
=2D-- a/remote-curl.c
+++ b/remote-curl.c
@@ -763,7 +763,8 @@ static void check_pktline(struct check_pktline_state *=
state, const char *ptr, si
 			size -=3D digits_remaining;

 			if (state->len_filled =3D=3D 4) {
-				state->remaining =3D packet_length(state->len_buf);
+				state->remaining =3D packet_length(state->len_buf,
+								 sizeof(state->len_buf));
 				if (state->remaining < 0) {
 					die(_("remote-curl: bad line length character: %.4s"), state->len_bu=
f);
 				} else if (state->remaining =3D=3D 2) {
=2D-
2.41.0
