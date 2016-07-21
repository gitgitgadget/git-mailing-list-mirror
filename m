Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02595203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 16:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbcGUQrK (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 12:47:10 -0400
Received: from mout.web.de ([212.227.15.4]:58351 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286AbcGUQrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 12:47:09 -0400
Received: from [192.168.178.36] ([79.213.113.124]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MgOQQ-1bf2HQ1s6I-00NghD; Thu, 21 Jul 2016 18:46:54
 +0200
Subject: Re: [PATCH] use strbuf_addbuf() for appending a strbuf to another
To:	Jeff King <peff@peff.net>
References: <578E732D.2090803@web.de>
 <20160720132025.GD17469@sigill.intra.peff.net>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5790FC74.6000602@web.de>
Date:	Thu, 21 Jul 2016 18:46:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20160720132025.GD17469@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:uH8xClSUNhNryHtmFGvMNT6HD6W7NLcjEAPV4BiRz4sre49KNJO
 130bu3HOan4zbJtnpRzQ5QPQeDeMaKr5oVTyULXkQz7LGhWIWNyGT5hJDasdI/sPOyKiR92
 m6U6GR5NO9dCyBAV4Lrpz+Xy/jFkoxc/grYNfOuIDDutspXowQK3jZBRJcm6UU6agCAe6we
 7omdQI9p28ODeU+L4EDbw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:/UhpbOsmOCU=:6DWm3UUGdn3ykygiQxhPff
 NV/lZH7w3CvA7AbGj/DXHWlGEaULMC6BQEIPPY21lyyQGesgrW4b/skjPQ2n7q3ShO1+BayNM
 PKTmyKlFolTPzrpltmBHtWB6y3Iv3woU6qicZ0RM9gpbxksGKx62uU0wB1MSnshCfTYzqt8Co
 QGdWsjHQiw1KRkTKZXOOt2Zg2CG+G6edhSOnLsCsqeR4uT6Xa4fFTW7RPfIh6NAB9eqMWwvzo
 GJSlVJODHuA86FJJHlWt9sMSIkgOmBy72Rnx3t3Xco4odykJqY+hJcjpi1v+ZFiZ1UZ1UVdQc
 G2khdFMWlkZGaIcAKXXE7a0OBXKkWtWxdOQa+vAA5ApXJZL5riL/mP96kHanHicxwEQ/XWKo/
 V4Ppj3Z4qQhkVkboYpxHCCdENy7Nn9vV8j0VOViPJc6BCFmhAi+nLFP9wC7+Po3OkYtiriH8P
 e3SMp7ZyxKo7HqLbAR84biJi70y7q8aZDJLkXHMkexl1CuL16agAu/1n5YV7JrdOHZ53c0rLE
 UUyXSAwKr8eO/CZXj52u5Zidyl64FJZhGP99b4m7W1/uO8MjGZprBjApMsUgmtK4MM3gnpUVk
 BgRsW0WHziU5eC1mj4K2CEHXW1PQPootgym0nygC7AgM016YBazQlHFf12dN5dGApuVtQfD7b
 bdmPMVFtTZhP2C7WcAxw363/rkgZNbxjbOZJcJH2935W9KOLC8R7ufkGzFQKEK92BD09SqH0S
 kA1TYE2Q9Zm9t+htaqSlQ9o29Xd/jFeYN7DmeIZPJrMxNc6o/JNGt+/KeXowNVHgO0b7tURm4
 FThT/yT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 20.07.2016 um 15:20 schrieb Jeff King:
> On Tue, Jul 19, 2016 at 08:36:29PM +0200, René Scharfe wrote:
> 
>> Use strbuf_addbuf() where possible; it's shorter and more efficient.
> 
> After seeing "efficient", I was momentarily surprised by the first hunk:
> 
>> diff --git a/dir.c b/dir.c
>> index 6172b34..0ea235f 100644
>> --- a/dir.c
>> +++ b/dir.c
>> @@ -2364,7 +2364,7 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
>>   
>>   	varint_len = encode_varint(untracked->ident.len, varbuf);
>>   	strbuf_add(out, varbuf, varint_len);
>> -	strbuf_add(out, untracked->ident.buf, untracked->ident.len);
>> +	strbuf_addbuf(out, &untracked->ident);
> 
> This is actually slightly _less_ efficient, because we already are using
> the precomputed len, and the new code will call an extra strbuf_grow()
> to cover the case where the two arguments are the same.  See 81d2cae
> (strbuf_addbuf(): allow passing the same buf to dst and src,
> 2010-01-12).

Ah, I wasn't aware of that.  Calling strbuf_grow() twice shouldn't be
thaaat bad.  However, I wonder where we duplicate strbufs, or why we
would ever want to do so.  Anyway, here's a patch for that:

-- >8 --
Subject: strbuf: avoid calling strbuf_grow() twice in strbuf_addbuf()

Implement strbuf_addbuf() as a normal function in order to avoid calling
strbuf_grow() twice, with the second callinside strbud_add() being a
no-op.  This is slightly faster and also reduces the text size a bit.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 strbuf.c | 7 +++++++
 strbuf.h | 6 +-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 1ba600b..f3bd571 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -197,6 +197,13 @@ void strbuf_add(struct strbuf *sb, const void *data, size_t len)
 	strbuf_setlen(sb, sb->len + len);
 }
 
+void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
+{
+	strbuf_grow(sb, sb2->len);
+	memcpy(sb->buf + sb->len, sb2->buf, sb2->len);
+	strbuf_setlen(sb, sb->len + sb2->len);
+}
+
 void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len)
 {
 	strbuf_grow(sb, len);
diff --git a/strbuf.h b/strbuf.h
index 83c5c98..ba8d5f1 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -263,11 +263,7 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s)
 /**
  * Copy the contents of another buffer at the end of the current one.
  */
-static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
-{
-	strbuf_grow(sb, sb2->len);
-	strbuf_add(sb, sb2->buf, sb2->len);
-}
+extern void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2);
 
 /**
  * Copy part of the buffer from a given position till a given length to the
-- 
2.9.2

