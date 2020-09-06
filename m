Return-Path: <SRS0=Ralj=CP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62356C43461
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 08:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BDA2074D
	for <git@archiver.kernel.org>; Sun,  6 Sep 2020 08:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FwE9aMLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgIFIjk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Sep 2020 04:39:40 -0400
Received: from mout.web.de ([212.227.15.3]:49631 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgIFIjj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Sep 2020 04:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599381575;
        bh=hhU+wNU9+seJSUUF7ZNfa9I4PhOoSfBPXs0WkWaRi1U=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=FwE9aMLV0azhKhXI3J9LRs5L4yi0AAyBHdr11ImApsipi5gXaue8JpBRiv6JL/Gpg
         PzuEW7QDirsd+tC6rHuo5r4vRe4IOYtWBEExbe2oEIuMGi5kxcUACLcd0dgv7t9Vhf
         5Yvt/ggNT0XYKgVh+PTtMiMnsLLfXD8BdvptoKzY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZB01-1k1yAZ3rFJ-00V6tF; Sun, 06
 Sep 2020 10:39:34 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] fast-import: use write_pack_header()
Message-ID: <7613ef32-f39c-ea4b-1cfc-88d255307186@web.de>
Date:   Sun, 6 Sep 2020 10:39:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AxwhgIdCP0y63MqJLEBSmZa1Npg70MrxrK0jjXRALws1WXiIZ9L
 I1V3zR/P+tlpxiM/D5jd4clXQ7lzBqDk8V6cdYj1M41fa4uA6ycjocDpaemiJE+JdxWT64e
 k1WHXbtmyAUlDGlbouVJCcVIyHIfNZ4BFFDO5rXwM4J+qKJwvPrpJxeoHoBTOtpM7zxctC7
 n4NUv/s9X7n+/luXFLo6g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qr/EP5/pwIU=:Dh2A6ZikpzippXc0YudBLM
 jorAhsDPcDKTyQNj+wKaFFXrc3ZsMPN255UeIaqlQWLP//gZv4vaRcgi/jbMuWcsLfsglbOOz
 Ua7N+QqioOEDH5iKjts7GOgh7nMrqOTAx6AHb5gfdDzUN3zW8JMRhqzo60/SfKHs8gUt1C2bs
 Ckjsvd9oYIYIkPV0r732Z7c6eiWhn78q+wqyu2GTxDw6qjIIxFLbv9WWSX1HnNWiEws0UsKF5
 63JMWp0I3HqCRoeUjYiQdOVdY2oW50gVoUYjcAU9BH6TjGFjwIYesWYMXmHqz96f8jEXzhOPy
 0HmN6ebUsI7yDdl2Q3epN9yzrYwVSTrplazW+C4J0IhWGxEy7CZnHFn9h+FdPu1OVx/2+2X9r
 mjhXIaMCVn081ztkKrH+ZBRhhADZXLzk3Py5XFfRXVyR8FeG0NMPJWUHSJjwGP60wjl2II1xH
 U9tMnCtM/sRe0l7uCzKvbJJYBo3no3wOqpDA5YLNsOuPEEzI7Je2h6tVynMGrrST6a1sCkgnu
 gmVUQIg7YhvgcUIlq/pkU3pXJWPPW0B9XG+7iO/Hawf4K3gRINWjNv5dzjs+DhsFJVBGYAMRu
 o6Cpm/WiK9sYuPrXjbcudwpHB2wKQH/9Ezj95yPkCgwZqv6N/PavQBGBVeNpPhBTYgtnOibwm
 SQTXb4SFsMLMl0npdhQIwAJgDUUNRPQhtIsNcUkgWtDKnz/uZG2h+3uaWFDxHBjoY8HVqwQr3
 6O2BqTn66U+DuIVE5tg/WMr2dUiLvJFp/6Z2TkK+5CbMcGtHn3WbiYKXl5B/4mT+wv1jRPUZS
 y/8E3AamGYCw2Y8+IwGypl+PcjXE1DCJhf/7KkwWdkWyOwME2wXA1EWiU9jQiLAIz9EPDPgPM
 bOdxIDSiEs2ISI+uBmdXcM2liMDLoOj4YT0bEZ4SK1o+L5twdYt+MD5HGPKA5AVPcXX5wwg84
 hcnRPIo9fk7u+LkxCNcHx2SEVOeNM9BIKHZlMFnnQLxhFPJ/zHkbYgaqH+Ukr2jiHn4rxM1WO
 90zymIB1Kvj5tn8tyISES4t5jrdGHcNn25tycW7+weaQV1tOdZnTTn1N4eIrL9fauFnm2/Hpo
 BBcUdzCwScQkIoJLHi3IdK/yps18Y0ThRBCijYeM1sCdYRS+Pp71h6qO+9ldQrFHAfjC9kCht
 Xwe0sB0RQIh2t518wkhjx+hmfmdEp4P8mpWpfqLjWvrHS0zE03PFDvJoEiwo0rNEkgsttr0Vv
 n7SHJIHBQYfARcCi7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call write_pack_header() to hash and write a pack header instead of
open-coding this function.  This gets rid of duplicate code and of the
magic version number 2 -- which has been used here since c90be46abd
(Changed fast-import's pack header creation to use pack.h, 2006-08-16)
and in pack.h (again) since 29f049a0c2 (Revert "move pack creation to
version 3", 2006-10-14).

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/fast-import.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 1c85eafe43..1bf50a73dc 100644
=2D-- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -739,7 +739,6 @@ static void start_packfile(void)
 {
 	struct strbuf tmp_file =3D STRBUF_INIT;
 	struct packed_git *p;
-	struct pack_header hdr;
 	int pack_fd;

 	pack_fd =3D odb_mkstemp(&tmp_file, "pack/tmp_pack_XXXXXX");
@@ -750,13 +749,8 @@ static void start_packfile(void)
 	p->do_not_close =3D 1;
 	pack_file =3D hashfd(pack_fd, p->pack_name);

-	hdr.hdr_signature =3D htonl(PACK_SIGNATURE);
-	hdr.hdr_version =3D htonl(2);
-	hdr.hdr_entries =3D 0;
-	hashwrite(pack_file, &hdr, sizeof(hdr));
-
 	pack_data =3D p;
-	pack_size =3D sizeof(hdr);
+	pack_size =3D write_pack_header(pack_file, 0);
 	object_count =3D 0;

 	REALLOC_ARRAY(all_packs, pack_id + 1);
=2D-
2.28.0
