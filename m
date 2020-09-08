Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1B6C43461
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 21:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA2C320659
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 21:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="igDJMDeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbgIHVHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:07:06 -0400
Received: from mout.web.de ([212.227.15.3]:50339 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728197AbgIHVHG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 17:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599599215;
        bh=S6Nig/dViOJGYiExR4asAxalESmEjt7BWsUBSnShPrc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=igDJMDeO3GQiu40k7iK5+kfoV5rRcnchewxSnStZi0xo4hZ33u3AbkL8tdneeF31K
         kwkgBxG4lX6iYkU5tOTckRgs5/H0zjfsYHe2VQu6G2dM1ZbdLHktvNk47b8BuSqHA3
         hKGy5hGZHlZd9yS6vvfWb5O5l5p0j0m2sFqdpeiA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MX0q4-1k1L4M3TL2-00W09W; Tue, 08
 Sep 2020 23:06:54 +0200
Subject: Re: [Bug report] git status doesn't escape paths of untracked files
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Patrick Fong <patrickf3139@gmail.com>, git@vger.kernel.org
References: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
 <20200908011756.GG241078@camp.crustytoothpaste.net>
 <xmqq5z8p12ds.fsf@gitster.c.googlers.com>
 <xmqq4ko8yxp9.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3a72c5f2-35cc-a865-d5f2-02706c48d8ec@web.de>
Date:   Tue, 8 Sep 2020 23:06:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ko8yxp9.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ux7qQiUVGANo1fC3Lu5ktppLdQJQNnbQie3o3sX+x8Hmjj2zSwp
 N+8WLrfZaEdhr0SYlYgQqzYOrtX2n5qoerXWm9W508w6GopFDaQbGSFgMixa2iQ9T9KB5Vp
 tw7KOotj3QLWmSmy/xVuFpJyi82/kY2GRxukZ1WalirEeWxBt2GWj8ZmEMZeI7H8JkQ3EqK
 xH+FT152dJ3jbeBcNHh0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uc4d9cN8pis=:YVGOC+B2xxWC1xNLUrQEVo
 oUybE1kuxcERICxOilRk1VNWDlgRDaAs7758Hlt8bqFb0LKYVyXK1UeyRRPEyMNsBqS15H0pq
 MLkCYzyjBGGJfUtlJAFnZtAV60/eZo3U0AdpUPN9/LE84XxSWqwVo/fB1RQxbEuODkmfQKPq1
 0wkVR3hZscPT00vdjBpOSopbhzyi7l99ha6c1bg+ogjUx8JIzYnW55GUuP+RvyOdMMOxS9O3Q
 bdA1+UOqM5rqIy4JIkH15gnfipGnFqC/MpJ2WdXenXEOLSOmXYcsJLhFr5jwux8lZJ0HadhJ6
 B9SNsndgpl4BMitFHdT5w9m/3RWlq2ArXSkZFWRbVlLwKswfwS3L0LEXOGAcuhdpmatiuluOt
 D1NW7dEgV6wlK5PgXKhPrGUk3U5bDGcpzn7Bt0tyT9oRir1L5I2JwBXUz9VHIXid6WuzgsHd9
 78/GjkEzmdDLcwSka+1gYRnyJINlf1haWmzsB1L9G7a01UBAXO/FTBMOO1fPSD0c7tbFsasdW
 49kCU/Yqx0yT9kXL/w2qyqQEjvG/l8yhKjUpcXcAh3igCAzBuY+hS69tBfNTrc22j+sONJv4+
 85UNin0q2e3A6Y0PSEDc/bqMvSJzyTNuAN75m032LUnHsEm+/MgUXFv7nCbrcFzyxbojCaPip
 YHdJv6fDgS+ilMQLeP11EXaefMmfqGJGSbP66RDMNVP0O6jC4et16M6L98irxrsuF+jdmMR2a
 Yu9hbEuc1pxlvIugWda0TnMP0Xlz0W/UVyVAs/LpC0tuYheEHnZmCmen8msrD7V0ku1GRuHl5
 eJqZ3ID8hqT9Us0fQA1N1BQhcscjzIM8hP8gQEIQV7HOeE+5QSLHfhoCTq+jNpQvPn2CVTUJf
 RIpfZBhhHEzLhn49IJerFBxTVlqMb1+zAhzb/fsiZ78dtaF44oTnhNzlvqdH2g7tQZ8ilgj/B
 +/Fw0XnSHU2L1C3T4Gxzyd8KFJc7vEVl9SSRH69oND7to9zrFXAUnwO9tP94fcO9XHcec1SXv
 IMSgxyOHzqf5IdFm63yWqfuuGkCdMOgeoBP1NPwjI4yylnDPlYaJdRi5Sqn3FcWY++xiTg2q8
 CxALkVil/rV4g4avOaVRJl4uWedyb9qX8uJviRPwh6G7OKNXE7Al4FqvmAziVaisshCcI71SB
 oTgjQUOb4+pd4RMP5bNuZji6QPVX/HxCVW0OTTYScfsDpAUKS1QTgKCsgvjTECmVhdK3u34lz
 sk7b/qXga5PNgdS4x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.09.20 um 19:39 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> I agree with your "the special case handling needs to be taught to
>> the wt_shortstatus_other()"; a refactored helper function called
>> by both places would help.
>
> I came up with this.
>
>  - I very much like the fact that I got rid of the "directly print
>    dq and then feed the remainder of (un)quoted path plus trailing
>    dq to the normal printing logic" from print_cquoted(), even
>    though strbuf_insertstr() a single byte to the beginning of the
>    buffer feels a bit wasteful.

I don't particularly like how this print* function takes a printf
format, but doesn't interpret its remaining arguments like printf does.

>  - I think the short status output for unmerged paths deserve the
>    same quoting treatment, so an extra helper function pays off even
>    better than our plan to fix "untracked/ignored".
>
>  - I am undecided if I like that the helper formats and also prints;
>    I was hoping I can come up with a pure formatting helper that
>    does not do I/O but it seems to be hard to arrange for the
>    current callers.

How about something like this then?

diff --git a/wt-status.c b/wt-status.c
index ff43932402..e0711aff04 100644
=2D-- a/wt-status.c
+++ b/wt-status.c
@@ -1829,19 +1829,19 @@ static void wt_longstatus_print(struct wt_status *=
s)
 		wt_longstatus_print_stash_summary(s);
 }

-static void print_cquoted(const char *fmt, const char *path, const char *=
prefix)
+static const char *cquote(const char *in, const char *prefix, struct strb=
uf *out)
 {
-	struct strbuf onebuf =3D STRBUF_INIT;
-	const char *one;
-
-	one =3D quote_path(path, prefix, &onebuf);
-	if (*one !=3D '"' && strchr(one, ' ')) {
-		strbuf_insertstr(&onebuf, 0, "\"");
-		strbuf_addch(&onebuf, '"');
-		one =3D onebuf.buf;
-	}
-	printf(fmt, one);
-	strbuf_release(&onebuf);
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *rel =3D relative_path(in, prefix, &sb);
+	int need_quotes =3D *rel !=3D '"' && strchr(rel, ' ');
+	strbuf_reset(out);
+	if (need_quotes)
+		strbuf_addch(out, '"');
+	quote_c_style(rel, out, NULL, 0);
+	if (need_quotes)
+		strbuf_addch(out, '"');
+	strbuf_release(&sb);
+	return out->buf;
 }

 static void wt_shortstatus_unmerged(struct string_list_item *it,
@@ -1849,6 +1849,7 @@ static void wt_shortstatus_unmerged(struct string_li=
st_item *it,
 {
 	struct wt_status_change_data *d =3D it->util;
 	const char *how =3D "??";
+	struct strbuf sb =3D STRBUF_INIT;

 	switch (d->stagemask) {
 	case 1: how =3D "DD"; break; /* both deleted */
@@ -1863,13 +1864,15 @@ static void wt_shortstatus_unmerged(struct string_=
list_item *it,
 	if (s->null_termination)
 		fprintf(stdout, " %s%c", it->string, 0);
 	else
-		print_cquoted(" %s\n", it->string, s->prefix);
+		printf(" %s\n", cquote(it->string, s->prefix, &sb));
+	strbuf_release(&sb);
 }

 static void wt_shortstatus_status(struct string_list_item *it,
 			 struct wt_status *s)
 {
 	struct wt_status_change_data *d =3D it->util;
+	struct strbuf sb =3D STRBUF_INIT;

 	if (d->index_status)
 		color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%c", d->index_status=
);
@@ -1886,20 +1889,24 @@ static void wt_shortstatus_status(struct string_li=
st_item *it,
 			fprintf(stdout, "%s%c", d->rename_source, 0);
 	} else {
 		if (d->rename_source)
-			print_cquoted("%s -> ", d->rename_source, s->prefix);
-		print_cquoted("%s\n", it->string, s->prefix);
+			printf("%s -> ", cquote(d->rename_source, s->prefix, &sb));
+		printf("%s\n", cquote(it->string, s->prefix, &sb));
 	}
+	strbuf_release(&sb);
 }

 static void wt_shortstatus_other(struct string_list_item *it,
 				 struct wt_status *s, const char *sign)
 {
+	struct strbuf sb =3D STRBUF_INIT;
+
 	if (s->null_termination) {
 		fprintf(stdout, "%s %s%c", sign, it->string, 0);
 	} else {
 		color_fprintf(s->fp, color(WT_STATUS_UNTRACKED, s), "%s", sign);
-		print_cquoted(" %s\n", it->string, s->prefix);
+		printf(" %s\n", cquote(it->string, s->prefix, &sb));
 	}
+	strbuf_release(&sb);
 }

 static void wt_shortstatus_print_tracking(struct wt_status *s)

