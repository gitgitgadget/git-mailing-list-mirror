Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C18BC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022CF20656
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 15:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ScjF7WkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfKZPXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 10:23:38 -0500
Received: from mout.web.de ([212.227.15.14]:60931 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbfKZPXh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 10:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574781811;
        bh=oxA8sKU9R1Hd0XlY0hocnuYLehbgMFiJjTe+MWnxmLI=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=ScjF7WkCoS8P0tz136xGp7smu1F3UcCZOPIZSKpl7dkQ5MVnYluXb4jSppcO/cs+L
         qzSkqSS6mje8jW6JX24zlgtcq3QfYK5++y55oADcY9EwFzqasByZNbDSBZiTkcE464
         v55f0SjjAQDvWsHMGQi+80ZT4B8IZLljf3eKNm5w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.146.29]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMqbf-1iSE1s2KvH-008dhF; Tue, 26
 Nov 2019 16:23:31 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] name-rev: use skip_prefix() instead of starts_with()
Message-ID: <23925fba-9413-0596-b21a-f49aac922f88@web.de>
Date:   Tue, 26 Nov 2019 16:23:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aDzbvT89LBducjOB91U4ivqAYuXILjsyGEcfje0tbZG17oSzNih
 PoRSI8+P0iTnjs6LPk/gWkNzghJPKa7eW6Q2soe90dUX7uos3HhBHzuJlWPt55g+i4q2ohf
 ZX5IKXXAr1PHpuTB9V966aD3Jb4aYNFRyOJuj2H7QZrgz1UitoWRKoNHr2dLvHoSVbgUvX+
 DRBxQFdreSyLeuwljS2hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FjiAXEm+hNQ=:8oRVl2ZwasVENqfczZDzUz
 0sPAJMCt2XoHXqmNp+FN1U/HyJucCEJe2QcstI5GJ0kux8xxGAZJIMfzjS6kOu8iLgZ/Ovsvr
 z3Oeq0+EBc8vzyKB6bM4LjdysK14xZo++lNjs+zwuFRUhAHK2zuaCLTwRCaRqIyivQoV2HIgH
 7QbTZbTqIn3lN2B7IwyL7uiOqqN2dXvHI5SejOX2KwGS6esEhsIbG+lpK5tTzmTeVbkLkP0Z9
 mxLkZqeVj0Hl18OdLm6ikoj9IPx4GymXOuGh3qoC06NEvLV9pHHcXN0tJ8lidU9PQWl+1KULz
 /BK2A1sQtZMSijN6wc+HAxAYd79sZpFlpNxlanWbxWSTi8Y+0L3c/g/6UQfgVkAmnKtNaIE8P
 lez2NZ9RHanTl5TP8FOJDLsxBOOAOthlCbrvwn0eK5wKjIfJN4n5b/VI/p+Wdum3+n0dvRbOr
 An4EDH4D1e8cT2hS/Y7ZUtE+9r7BLKRffYYU5bA4YzK/VfeUeGnQdAStH2ZehrZrU7ISCdyG0
 Jk+4AKs7nyS8yekraIV4NOWQMm77kKBOJ4AD1p0B5q+eJfjgqVTFjHsLFh55hnHLG+U2isT/S
 TcozxFkw8ZkgxgvS4xOMx5xq1C4tmitu0N3l9OX93cDlIgE/4TnNpIdIcj5AfxPzwQbNZOvMj
 hfgi6bphbFbPs6JX+IEYveUdh+01lyRG5Hh2j1XQu7+GAvPrheXQSsWz7K80FTWI29zeJoEbi
 MoHPbcHeYy63iVczZw7OeEltUdszXOr7Wzm0voKSxzfpluv0gHvLPZne0sFtb7kvQElBZx+ix
 hSO/hDW+ICB09idZmyM4dQREX5VnLX9EC59n5U8oU6NCdD741cdxq1GMvP1zg841WXDXHotr1
 l+a44aznSuY5Jan49uHCZ8UmOCzLkVl4mXR9aDb6j6e1faAhsA8dUSR6rhGruKT/UU0F7l2F+
 ATyRoVbAvcWwdOI+FrRme2WHag5gjxQxArDb9mNfvUk1lUmYjRyWTNRNc2/UCIaoAWPq7fijb
 hEJY3pZpHm/2VrddHi+OYg3RKZZH6dv3tsMJ3lY7/oMjWk9FIThgRnoSiADZhDjuqYqkrev1+
 euwx+D3AsiuvBBtFeejKo1PqAsyzw4+m7m2zmuxLOpdOjSmSID8qFD3OoO/MpBaKgP90vuwEo
 chE/8WyO2+hQo7sWQszbRPI3lTECtAjL/m4qw3LSrQ1K7dxTWAFfBr/3PseoXigkPvbCg6WxJ
 YmU1fW0N9u/a9JP08mAgrqdS8ptZAs43tO1uRpQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let skip_prefix() advance refname to get rid of two magic numbers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/name-rev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index b0f0776947..c261d661d7 100644
=2D-- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -161,10 +161,8 @@ static const char *name_ref_abbrev(const char *refnam=
e, int shorten_unambiguous)
 {
 	if (shorten_unambiguous)
 		refname =3D shorten_unambiguous_ref(refname, 0);
-	else if (starts_with(refname, "refs/heads/"))
-		refname =3D refname + 11;
-	else if (starts_with(refname, "refs/"))
-		refname =3D refname + 5;
+	else if (!skip_prefix(refname, "refs/heads/", &refname))
+		skip_prefix(refname, "refs/", &refname);
 	return refname;
 }

=2D-
2.24.0
