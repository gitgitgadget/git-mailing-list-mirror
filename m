Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3060C432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 14:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832AF206BF
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 14:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Y99WUkys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfKZOXR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:23:17 -0500
Received: from mout.web.de ([212.227.15.3]:50517 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbfKZOXR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 09:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574778191;
        bh=guZp9rZIsVpulS+7F6U/6ECnIzTwZs6ipEUpdauw+NA=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Y99WUkysSB1I8W1YEUwyxBxyonRoVe0yCcrz/CoSH+ZlK1I6xT+hW7vdAL68ma/P2
         Dx0/7oNEFwNFPAfrtxfNphUG80hSzlRneveoEEt+XefOmI9+/J7cQ5QpAoSEAsrkko
         nS9zh2cEJhJu0lPm/TT0JFKPFyPTkaS2l0+OQFWQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M4I79-1hjIGy1Blz-00rqWr; Tue, 26
 Nov 2019 15:23:11 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] fmt-merge-msg: use skip_prefix() instead of starts_with()
Message-ID: <8fa33928-3cbc-beba-524b-55bca143fd80@web.de>
Date:   Tue, 26 Nov 2019 15:22:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fM+ye7OqfIHu5jkLhmT1MCpFAa0oxBuy57JyqIO9u/eZ3L2CAsc
 VbHuu8hQeogXXtpLAyQAUtF+hS98vHW9Hsury7b/hjIV+uJYruXxY/HCulKt9WQtMX8bc3q
 0OyaehtkVSWwSVnuI4WyKGgS/ZulElhXrLxnYN44YYsl30LxHwBQkGxugyY4Ke4yJO09jvS
 J4dqz4lAPlceAzvJ1GG7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XsR/Svf8SfQ=:e0rz7UtKglDH0WbFUGPXV4
 aG5p+YhXAVk3p1LZMRuFoL8AUc1lYxYc3V0ajG83SM7POs4ENptKApDB9ILjFUnaAX2W5qvrj
 axVMg7i6k60cXr8IFXQiZdOUTV04D9kCRn0V1bEUzn7sEyc+j+x5uFXOMMtLFOi/OnP2moj8Q
 wE4UATHmDzcLvXfzIIcYDp1al4dnfKOZEBpl478HEuB3y08tg9awVCREXiu9hSThX8xBTKZfK
 c4PAShPH+0fJadqsWGiHry0O0DtNr4OgPmzKT6Y6GdxYWYHlfdwawf2ehpExkBECciKgU5C1p
 ep2JxCMI2Tan7zUT7wu0LEmfBG1WnsYxRRPAx2gCT8DN8viIooHAuHKTPVccJd6HUX/TjH22Q
 hYBtEN7iwynMd7kxcYQyDg8mcZqEpx50ZEPrpY0tqxuAScIgi0Fgv/wcMZFJGeBXDhqR2CkaD
 aWSP5am0juQx9SyivT0Jo1i1y751rZhllUfUXeIaOYnjolTOIu3MUwSRQWfwuU4va1dkVQLRt
 gnmhE9RW/ejSyUDxjBxtgCs5hCdJRX7sz0zdfnMZCx1zOC1BxKYIyvhvbiqx3YQGOW6MJJ6vh
 u/ilWzZURfs+aM3hzdeosIeX9hw3MCy3BdbLJ+DMHGn9sBFi2L0cloLxRRVEkNIBa7T6SwW6z
 JI+RaqD1b10c0NeytGuI39zQxKXYVX51TiRkHcTIe9SYeVaS1VXrwynLPsL1NauyfGVJzMaEs
 qz3AAmGDaXnckmOXNmmgdcNa73Fclnk3FjaQ5OtbyHllZwji/lDrsUTqcdQRMPTfKkTXLDlxm
 kobVSVrPEHXPI/lp7np10sffbpSGlJF12311EAuNuERw/szftZbuLu5PT9mRUr5VIGYbxV2/a
 XHbQQaSlpLaJEirZ/23XgdNVB8r0V/1fAL2f3kyXaIjpsS2AlTwQvAN5dYsXcBpxHmP1cMacM
 hSsh2Yaz8DYbhXyPEbRqK3Di7dXNAy9VaNnJVf095Ler3MHRyOoq7ofsMjKylJgASIT2DyMfO
 FGVluSE3kHlspdaeQigT0DmBwR5MajeAJk4+9SGyFB+PV0Opa3E/2ZsEvq775pge3lKJn5KNr
 NuVOQ4qSaPoYkacT//Ox8gPPAIFyPKSFS6QuRPmSQ/juYp+WtbjYseXmBvXv0ZYqlWW2xkBLb
 m5cGd3eeewMIo7y1PfTQa5y7NMBFG+GZBADzNaE+8DvroIAioP+/p1WPh2U67XPxKY8xjs5JE
 q5dUOUmx7VpzOlfSs/QTQQhzYWZPPg0wBqWYVbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Get rid of two magic numbers by using skip_prefix().

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/fmt-merge-msg.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index a4615587fd..736f666f64 100644
=2D-- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -106,7 +106,7 @@ static int handle_line(char *line, struct merge_parent=
s *merge_parents)
 	int i, len =3D strlen(line);
 	struct origin_data *origin_data;
 	char *src;
-	const char *origin;
+	const char *origin, *tag_name;
 	struct src_data *src_data;
 	struct string_list_item *item;
 	int pulling_head =3D 0;
@@ -162,14 +162,13 @@ static int handle_line(char *line, struct merge_pare=
nts *merge_parents)
 	if (pulling_head) {
 		origin =3D src;
 		src_data->head_status |=3D 1;
-	} else if (starts_with(line, "branch ")) {
+	} else if (skip_prefix(line, "branch ", &origin)) {
 		origin_data->is_local_branch =3D 1;
-		origin =3D line + 7;
 		string_list_append(&src_data->branch, origin);
 		src_data->head_status |=3D 2;
-	} else if (starts_with(line, "tag ")) {
+	} else if (skip_prefix(line, "tag ", &tag_name)) {
 		origin =3D line;
-		string_list_append(&src_data->tag, origin + 4);
+		string_list_append(&src_data->tag, tag_name);
 		src_data->head_status |=3D 2;
 	} else if (skip_prefix(line, "remote-tracking branch ", &origin)) {
 		string_list_append(&src_data->r_branch, origin);
=2D-
2.24.0
