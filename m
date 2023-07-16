Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012ECEB64DA
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 08:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGPIwi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jul 2023 04:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPIwg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2023 04:52:36 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498C9D1
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 01:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689497553; x=1690102353; i=l.s.r@web.de;
 bh=5E7N/x+lVn9ViUxp9vDlHqLW6J30F4qIVLVkabxyGqo=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=mD5a38QyubTTHJa0xH6K6xdc/77KGQ0WirrnqmAC5FvQpmw/GnQVmn4+Qu0YcJndBLVM+Qx
 iiTk7BaHKiwb8qpCcU4xh/KVSW8lpzE9cMJfcU3PnKcyOXwLN8hYphxkvtbHj+dLbkPYN6VW+
 NsaWIch2HKQS5TNUxUuS6dtkKAou24VukXVbIc9foax8h5oSPKM6MqyUD/pm+V9xbJ7UnC8vr
 v1BLT5OYBFIpM7HxYAndc6zQndI3BXlt4BSBsXIn3PdH6hFHK9MUDpVYZDTC2NBykQ9hAPMk7
 8fDDDss7QR7Dl1cL43kvDxYUjmnkA17q/PUZQ349DLMBi1HUoHBg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.247]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M76bV-1qJ2DO2jZ1-008TPJ for
 <git@vger.kernel.org>; Sun, 16 Jul 2023 10:52:33 +0200
Message-ID: <fccba24c-584d-6329-69a7-75cf0458af7d@web.de>
Date:   Sun, 16 Jul 2023 10:52:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] strbuf: use skip_prefix() in strbuf_addftime()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kks8ZK2m9NAa7JTUJyqMaIujZOMGAu+SJIabK8PnfsJZn0H1fE5
 xiOj1b3MgYjpuF3cEXRES4i7YpXzqx5Y/1sSDnbOJLijMrNeHGS9q4b939bf8ODPjFc4vTB
 EzBcbnpBV6iXYxTgd6WZ9vbssDkWKpTPleB2DlGz2yMkS2rXlM/rBPFC+K1aBYMNnpdJYz3
 nFEjzn0y90YGy3OmYI5xA==
UI-OutboundReport: notjunk:1;M01:P0:wOutsKBj/xk=;+pGTvohKbnDwD6HfYab9axY4IAa
 pRsDArcW4+H2mfSF/w8HiSQNd2xBTgoglaImCfA8mp5zQf6C608n5zFFIIlnSZx5l8MsiMvFm
 618El22zWxJPSmqFXrkR6U0QzRRy2zznIjxYy8Z8ybHMTmydbZxFrPotqZScZiM3somR7qogC
 clQx2sEwB/2W9I1Lho7o8XNX4NbQlljji7FhQlvZUtiDTspwFOLZEdh8CTFd7dC3M3/qSuK+P
 GFdfYEvTyRJhx8nJqQX1dJBfdwP3CXzgtvffMNjva1Ux/EXBbrAoyQ5ulwOJ3o7CQMZuugqbJ
 hB6ZI42mx1gCSgTVMasIImy2QFcIVQ58rRoPdLZ1SPcT5yDH4OAJTBgINAfdiPQNYCtFP5UKI
 pODMYtGY4S8gIDfxRAeJbOM4ujAOzrQU6ZlOjrZ3BsfZgMjZDg7j/0ivSe+WZlElmfuEaTqyq
 5OiW5oVjSUiEZVCZbNbLvDr9x+Gb3P64ObTJKjcSiQ4BCEhIsKZJBTYZ/PUtIz4IVXpcRB/FE
 VDaNmxBuQ9PF721njLs06Qg24rGEtr1QHvfCD4ckfiGDyS+nuzflik8RMbKuDZVSQbociH19a
 ZkNH5Jp+aRahqkDIeFSuBEZ4FmrYJ6iLi2ceXLRlKPMY+zxXUuI/z7932MpMKa1kUKucccc04
 2ijUaXnTScYWcyKZyAJX0x73iF00rBN5nVTJiAGmkE1aqolnZZQWqXCeu2omrtm7GURLjx8XG
 HQoMhlqkQgAz2BJ0L6BmEVQqjIhOaAcYQRjJdsXk8Oqa0do7wrVWFUe4VfkwUkmpr3AEuEodZ
 RsP/cJzrl+GkQzoWp0OrXvMLBFwX6Z3WU3+IQhVllAFeG/Xh2BaeN/siYHU91nYPKU/eQl781
 9LAdcmbKyrxJVzn7rMZ1CmVsElRQhQxe8WmSOYOPThYXAgFlJtKldddVArdjColvzjdK+7iBc
 NPr+7FegU/TdALSVhu699l1NodQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the now common skip_prefix() cascade instead of a case statement to
parse the strftime(3) format in strbuf_addftime().  skip_prefix() parses
the "fmt" pointer and advances it appropriately, making additional
pointer arithmetic unnecessary.  The resulting code is more compact and
consistent with most other strbuf_expand_step() loops.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 strbuf.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 399242684b..837975ef9c 100644
=2D-- a/strbuf.c
+++ b/strbuf.c
@@ -935,31 +935,19 @@ void strbuf_addftime(struct strbuf *sb, const char *=
fmt, const struct tm *tm,
 	 * of seconds.
 	 */
 	while (strbuf_expand_step(&munged_fmt, &fmt)) {
-		switch (*fmt) {
-		case '%':
+		if (skip_prefix(fmt, "%", &fmt))
 			strbuf_addstr(&munged_fmt, "%%");
-			fmt++;
-			break;
-		case 's':
+		else if (skip_prefix(fmt, "s", &fmt))
 			strbuf_addf(&munged_fmt, "%"PRItime,
 				    (timestamp_t)tm_to_time_t(tm) -
 				    3600 * (tz_offset / 100) -
 				    60 * (tz_offset % 100));
-			fmt++;
-			break;
-		case 'z':
+		else if (skip_prefix(fmt, "z", &fmt))
 			strbuf_addf(&munged_fmt, "%+05d", tz_offset);
-			fmt++;
-			break;
-		case 'Z':
-			if (suppress_tz_name) {
-				fmt++;
-				break;
-			}
-			/* FALLTHROUGH */
-		default:
+		else if (suppress_tz_name && skip_prefix(fmt, "Z", &fmt))
+			; /* nothing */
+		else
 			strbuf_addch(&munged_fmt, '%');
-		}
 	}
 	fmt =3D munged_fmt.buf;

=2D-
2.41.0

