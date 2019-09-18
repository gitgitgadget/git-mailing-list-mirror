Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 619741F463
	for <e@80x24.org>; Wed, 18 Sep 2019 16:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387609AbfIRQfp (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 12:35:45 -0400
Received: from mout.web.de ([212.227.15.3]:55109 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbfIRQfp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 12:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568824540;
        bh=oKR8d/KdqPj/MV5ajntqehjrAVICAzYwnPIB86WqT1c=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=kcPUIH5pp47mn8V0bL2amv7SvUBCWVzDwRjeQgkU8KOazS4Z8pxCgmaEfzAAG2jDq
         d2e4jn7ttma+O+RGvpWB+IO+QjdSFsbaOUjfkHa+mqE9hbPf++l3Moi7Fb7ftpT1uD
         MqJ9wt0joceaLa2OKx+p6B0hE6d/aX+Y4dNvPt3s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lo0M4-1hi8jE39Im-00fxDS; Wed, 18
 Sep 2019 18:35:40 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sha1_name: simplify strbuf handling in
 interpret_nth_prior_checkout()
Message-ID: <582d8659-dd5e-440e-6f00-a59c7017dff6@web.de>
Date:   Wed, 18 Sep 2019 18:35:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aSqgxJUsLgjM7RKn1fWVGuXwzZf5LCPyZgUCBrY073/cXgZARBs
 u8+l4OnbqNyEkRdPPqGvpPEWn9NXM4chK3oiSAtwi9VyUjLie/ArSXN3C9MJ6gI7Zh+7WW7
 8ViedUd6HHfqCjGqKhaGIWJQXhy7DVGByECnwS/orN0L18Wt0ooBt83R/tgvvUj1CVxjHJy
 1n2aOXy4SA8//9gRjBPQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EtfX413FD4o=:Hgosdb4UgXKHgINx4quYm8
 irfJ9gcmHIAJWnoerWdyRLM4CBhQRyk01QJdH68b1EDk7p6oCiSe+SPksdlsa6LZOM8GbI8M0
 SRJUPCVxMj8c902Ur17+InQW3LG9t+d0RN3FPm2/v0Rfq4YG/aYPBqobqpM1Q+94zeFu1m5eb
 6wQqloozC5bO3NfPJ0oC4aRtojkLwCEm2rtTsADtVPP62TmNy7MkycUF3Crlgot1QdwF4SQI0
 pgJ9gWcrfgiy3a0g+CoWifS6DaYYm6IKphziwQNHsZZ1sMOFfGNf3fLMM2RMstn4rQU4miLzQ
 CUs8j2op7/K9iFnBCqq55PKadDGk1MIwRTCyxR1XaDNCquYOjX0OKplbWJ3f1hPZjWLTD16G+
 fUF5seruUQlJbnJow2H1Ed05tjACDsV2zm7I5MRnILedEiiNzem4eFFy5X6Uker6FZNMWviSa
 Fe3xgurmDm/HwZdieud15JnB14NiyHmJmqGy1263t1WLYfUiflkS8Xu4VF2Hg5QLOy8GolGDi
 B0F9l2VF+VtoKgy7qd+bxXjWVqLKEr8hmucD4zYvjrbWm7dzXhFcjEnfrfZ10/TnuWhyXxr/d
 lgSsoydDNym/msphZiCc9r3w5kzSoeKMp7PW+zfhSOVDcXOO/YdmvWwXXdoBZCWTr5NNNnyYD
 qdRHFishzN7b+u6DzsTGveYQ1pIZYbmRr1/KC58RR1RnxPvyImW5k43aaxlrVaydW5ybyMoI9
 Cvquj0RZ4p4/GYc22wjrxfxyAaxulfIcMx4qmIxzEWx2ba2eljQvZu78f3/0wEscveGrBcGru
 KbevygP1c+sRw/zk3NZ5FHX4H6k7hHYZkHkpPKsEVWzemq/i160ls2agigEBt9TJwyDwKZkN4
 /8ao60T0ha697UqFQ7XxGnpzPxh8jm8wwu7apMZocMX7YFP7aXYtQwnSw9m07+YxTNgb2pdaP
 NJCtSDVSe5XDBo7KbUCA1vbPljAMjq76u6eWN6bJEvessNcPEGzq3hh9KJedBlPVkq+B8Ew//
 QbuBLAw4uzYGYk90MXpNStK332iQuTMkZEUs5tO5/o8gUYj3WIXNe5IVZSuz3eU0h1YT81zpx
 GuU51TyHvSCS/WXEjqnTZAYhuLLUOQig9skEBHYrn9dG8R2zoHsu0uUxs13oDYBuuMQZHFU02
 LQPWMDXwYVqx/0IkA4Bb5drXFUHN9NerhJVxX86tRKuHyOEMe0/NsReRlb3tzxM6riDECeO1i
 A1yOMRMHXOA3f9sJv9WUldwkyhnIkcscsWc30iA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the target strbuf to the callback function grab_nth_branch_switch()
by reference so that it can add the result string directly instead of
having it put the string into a temporary strbuf first.  This gets rid
of an extra allocation and a string copy.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Patch formatted with --function-context for easier reviewing.

 sha1-name.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index c665e3f96d..85196929c7 100644
=2D-- a/sha1-name.c
+++ b/sha1-name.c
@@ -1286,70 +1286,67 @@ static int get_oid_oneline(struct repository *r,

 struct grab_nth_branch_switch_cbdata {
 	int remaining;
-	struct strbuf buf;
+	struct strbuf *sb;
 };

 static int grab_nth_branch_switch(struct object_id *ooid, struct object_i=
d *noid,
 				  const char *email, timestamp_t timestamp, int tz,
 				  const char *message, void *cb_data)
 {
 	struct grab_nth_branch_switch_cbdata *cb =3D cb_data;
 	const char *match =3D NULL, *target =3D NULL;
 	size_t len;

 	if (skip_prefix(message, "checkout: moving from ", &match))
 		target =3D strstr(match, " to ");

 	if (!match || !target)
 		return 0;
 	if (--(cb->remaining) =3D=3D 0) {
 		len =3D target - match;
-		strbuf_reset(&cb->buf);
-		strbuf_add(&cb->buf, match, len);
+		strbuf_reset(cb->sb);
+		strbuf_add(cb->sb, match, len);
 		return 1; /* we are done */
 	}
 	return 0;
 }

 /*
  * Parse @{-N} syntax, return the number of characters parsed
  * if successful; otherwise signal an error with negative value.
  */
 static int interpret_nth_prior_checkout(struct repository *r,
 					const char *name, int namelen,
 					struct strbuf *buf)
 {
 	long nth;
 	int retval;
 	struct grab_nth_branch_switch_cbdata cb;
 	const char *brace;
 	char *num_end;

 	if (namelen < 4)
 		return -1;
 	if (name[0] !=3D '@' || name[1] !=3D '{' || name[2] !=3D '-')
 		return -1;
 	brace =3D memchr(name, '}', namelen);
 	if (!brace)
 		return -1;
 	nth =3D strtol(name + 3, &num_end, 10);
 	if (num_end !=3D brace)
 		return -1;
 	if (nth <=3D 0)
 		return -1;
 	cb.remaining =3D nth;
-	strbuf_init(&cb.buf, 20);
+	cb.sb =3D buf;

 	retval =3D refs_for_each_reflog_ent_reverse(get_main_ref_store(r),
 			"HEAD", grab_nth_branch_switch, &cb);
 	if (0 < retval) {
-		strbuf_reset(buf);
-		strbuf_addbuf(buf, &cb.buf);
 		retval =3D brace - name + 1;
 	} else
 		retval =3D 0;

-	strbuf_release(&cb.buf);
 	return retval;
 }

=2D-
2.23.0
