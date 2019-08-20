Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12541F461
	for <e@80x24.org>; Tue, 20 Aug 2019 18:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfHTStW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 14:49:22 -0400
Received: from mout.web.de ([212.227.17.11]:52157 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbfHTStV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 14:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566326952;
        bh=VDxNP66OkpaiBX617k1GeUGINoex4iBsbw/+MHR8KLQ=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=aV4QBu2O67ulb3g6Tp6IjKiDIA2kIBW/XjRf1B5u9AZ7zv3gSCMhsq4xpKsLPN/H1
         t03WFyBfxndK5iUkWLLARVttcwlDYpk3c7qz7/hjNVu4PVfR7OngOSBF8F/QW8vXCx
         d/ys8wZhLCdJ8e47Z6mSk1/ccui/S9GNGoP6CA5E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M57Vi-1iAhIU2XpG-00zE3s; Tue, 20
 Aug 2019 20:49:12 +0200
X-Mozilla-News-Host: news://nntp.public-inbox.org:119
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] sha1-name: make sort_ambiguous_oid_array() thread-safe
Message-ID: <a08751c7-170d-7faf-272e-79c589ec3eab@web.de>
Date:   Tue, 20 Aug 2019 20:49:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T/A1aYDsWzXZX/jNcsFan+tkdYRrLs2mrOQhpb2DkckbiPjX7ab
 1oyP4QV4GXnUz7JrZ/w2oNGOOY2FkuHdn6UyQ40DGJ/vbaQ29STHPg2E98vEtHz/wH6T9n5
 DIq8o7hb1go9vHHs26Hx6MpNbvqokbN2gakJF8LzasoHl6VmpZ94FH2EZtyEeyUD/vM3ukh
 e044u9h9js3vMmZ1kRRgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NXvUI1pVspU=:2pJ0cXywToM7/Y7WeoL9tS
 GyFIkS5E0wDl6Kt+tb1kuAhH5HbTUjJZfFzQ3qmaT3TlzA22Ihr+Fw0Suvv3/kcxUUdE4xqe5
 r0t6FAD1dQZTinbPQDNm0GVMstB5Jx9Z0FwhHvW1GueASS92b9+CjBc0UHKteqJPAEnEkw9Rw
 rNru2bMuZDgz471rTj+p4XhDCm1iaImAiDH2OKbAW27by7aGJlB8p/EFdFQ7KbREcuBfkLeVt
 GM7o6UcvbStIk0KhZDKVGvk68hyY84manOCf3UnVn1keMcckaY0oh0OBO+O4vIlkIpddP2qCc
 v06q8iX+uDMmUFlwKoGrnZvqCiYKXxDRjFju9DsE99I3pf1Ckrms+bGivVwnYYWzeRGDPMl8o
 YCB//QtEb6sKiygKJO9iKoEYMEWOKYUuqo+JDLu7+SCPZ5DwJ8RWWOYMKJiSidFuH9Y5MPZet
 wj0Rn6u5iNr7y82qm8x5njlQQ0N6m4hZObi3Tfo8p4cyfrb1+bxpYER4Pn4D/HPUUYDz6il2n
 fwe1AMszDCO1c7zv+h0cF/XSkcKrFjFIWvTBLoaRcuZkrW5kr4NOfhIAnA038Cz/OtPs+URpC
 DMQRy/Rl/Bi0qC340pUv9syhvQl01GuQ9sO4Le01+Ph7WjpMRHeid+woWI9C0phU6g6AGIBh9
 cclT5eXRbWavCbS74sR9caYRLzM2EgV0OVTQduYE88rd1m3IpvjdtRuNQOcBg5Rt2J+OgayXw
 +p3DCKIwHBnj+esVUAVOPjVmXe3a3CK7O1AxwjBAJB4DZvyJ89GCK9a3vnxZqFz4UKgZPqYAj
 9rOf1vTfSU9uRmZJ3OMDN4ib2pRkQ5XcwUkwmkrFp6zhhexqvYderKzy9eTfV0IArCwhSthls
 f3xsBi568ZDCYhLuVDbEFtSVyESaMUE8ag66XfmUnIT7GJa0KdcLiaxb+5rqssyu1bbDqHDAn
 O7ynOWSS7i6LG5CSvwzeq0qkdPxSYRJFfVUP0dVKSirAreNrnDd+Bad48xN9PPVpwiKWiUiB1
 /QGGbj66ryF9lQM9WThEFTvxKns5eK5B4cNsq/COn/yymmoBupY9821SyxgZmpeVN8hClRqTr
 horXacmkMbAwd0jlK1ZAPNwEqUD+j5yiv8GAJRaE7MoRQyk4j3dzt6VyQlZyCCSG+fsLsxyd5
 aGt7Wbcqkx9to9yP6l77L4s93mXUj2vLkzDsMezOY1oP2eYw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use QSORT_S instead of QSORT, which allows passing the repository
pointer to the comparison function without using a static variable.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 sha1-name.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index 2989e27b71..c665e3f96d 100644
=2D-- a/sha1-name.c
+++ b/sha1-name.c
@@ -403,9 +403,9 @@ static int repo_collect_ambiguous(struct repository *r=
,
 	return collect_ambiguous(oid, data);
 }

-static struct repository *sort_ambiguous_repo;
-static int sort_ambiguous(const void *a, const void *b)
+static int sort_ambiguous(const void *a, const void *b, void *ctx)
 {
+	struct repository *sort_ambiguous_repo =3D ctx;
 	int a_type =3D oid_object_info(sort_ambiguous_repo, a, NULL);
 	int b_type =3D oid_object_info(sort_ambiguous_repo, b, NULL);
 	int a_type_sort;
@@ -434,10 +434,7 @@ static int sort_ambiguous(const void *a, const void *=
b)

 static void sort_ambiguous_oid_array(struct repository *r, struct oid_arr=
ay *a)
 {
-	/* mutex will be needed if this code is to be made thread safe */
-	sort_ambiguous_repo =3D r;
-	QSORT(a->oid, a->nr, sort_ambiguous);
-	sort_ambiguous_repo =3D NULL;
+	QSORT_S(a->oid, a->nr, sort_ambiguous, r);
 }

 static enum get_oid_result get_short_oid(struct repository *r,
=2D-
2.23.0
