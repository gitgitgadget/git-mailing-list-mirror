Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04BE71F463
	for <e@80x24.org>; Sun, 15 Sep 2019 12:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfIOMKf (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Sep 2019 08:10:35 -0400
Received: from mout.web.de ([212.227.15.14]:40023 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfIOMKf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Sep 2019 08:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1568549429;
        bh=Uuk1XGM3MjF62S3fCRcR5YHVivNITIyAeGoRU+lvrZc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=GnYcxpCd9Qnt5f1FUc+YxVRJf9oW6unQr0tsPgJx+6hc+3E/Gkt+6kcl0H6Oohxr7
         2/bZVMav3goVUT1GBIAxYraSonjHKdDLG9an93AfvH+/lrvK4x01N6itW2RkjZCHtF
         0I7pi4cFk+6JGSkHkqZCKRsW6YsO+rYRTN8CIq2M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MX0lw-1hdd9V0fJs-00VyBg; Sun, 15
 Sep 2019 14:10:29 +0200
Subject: [PATCH 2/2] sha1-name: check for overflow of N in "foo^N" and "foo~N"
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <c43610f2-a51f-7333-a200-a76930a0b705@web.de>
Message-ID: <2be6e3ee-209e-9cd1-eb43-284f9a8462b3@web.de>
Date:   Sun, 15 Sep 2019 14:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c43610f2-a51f-7333-a200-a76930a0b705@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8LXRZMzShaYKzIvxvak4e1y5DnmJveonTkuS4LMSz/lmy5cTvo9
 +wFCQqWVBdz7NPmzud/xe716OCnblMnOEvdINY5liLPurCsZOjJNo/NAtHb2PtWIKIEamp9
 qM9+sXql75q6sI+RJD8+1u5kjfBArUtOQlpLWU157eUd1W3ipUxiadCqX2EgCT1/pF1NxG4
 yap/aDBROmzZNkNJ04k9A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:si9nco26QqQ=:/PKy4xKZs7FsbRjFlDA4b4
 JhFVoE73GyVZ1oAa398eNCZtMdXI76ZBn8iM5Wa7lulPJdKluM1vOuzK/4iqL1dYZJdON4Ld0
 CurjUiVSBJI9udB707LdOWGYVsJrpAvIT8oh7Qc/c6wOSbAdNPo/563no3rMBriYmN63O9SX7
 OGRB5PLEkU8cPgvSd/B00+pxM0r1e4gftUc2PBrLzSUyvJEoD2yezuA7OaRuJ/FSVYaTj5U/O
 fRWQmVMKNH8ADU8E1PZBTzxodiH/nsaDkhlqCHuHe/XyKujJMdP9BAIQ4DIBP0eutvQmxBJd9
 76QzzF40kykWHTUarq9H1MdNqkSqRDXSYj5q+tvHeg+Q9UCXj1c4awcx04hzGaBt+psYg3BM1
 3MfwLUlIHvy2eN2pxQvFrRV2UFcAoylszrGluK3vqBsxkcokubCOwMSaX9zcNzHMrJnIT4w3o
 XuIjCgWQpQBwhKcTHwBfUWhb2q+qT/XbtTHwtI2NOOShQlrKnsH23vIGEl2CIkBaarbuRqUe7
 WdZZd5tGcqPIsZ0WWAUKT73zLYI7yFb2AH/wJlVeCHPp1JW8DCJF7c2vSHKf0fK88nr5CspTb
 O+BQlSqSdCYHV+qx1Esf1OUiNMGrUeK0u7JEAxPLIIWv1zgVO6f2YKM3iV7SKVE2AWNdFVbLb
 faEEdb7laQvbhob89ffh9X4vRVNo8k5oBAxIwqSjFbt7zAnfMjd4VZM2ehsR6jkoe4gJCt1nG
 PRzHj3Koc0XTio8NHHiMFYNzh/Q89qlWiADzKudvsBvClwmsTIwc1xmICFHgSGc7i7k6Rzs7V
 /eFWKaJtJkplo/9FURsqBhRh/MxJgOzVACLvXWLKtgkdrTPwKBkLonob5+9/Ow7WPGVm3js5z
 xq6/HyXxOuz+f3n7XluUq6iwD8hXZHIAiBPIj8zUOvQhF759OeM5EJFEH45u3YiY8R4L75qCc
 DyzSv/M2UNhVp+/Jv7X4hAOCG8P5caj2Z074ISv8s2gEEmuFg1XVKsVaDkIhAHWS1rynAa3r6
 iZzx+EE7B90RWvQNFWNuZKXKSJk3Z9BmScYY1suGokPI8e+jj5cL8qcJ0xjS1Z903X7stIdgY
 jsEOu0sG8xBhHZmbCo3Lh0m8yJwm+HsDX4hzILQT5IsA8j3NCYO2tb8dJkLXPvNUgLzwEajvy
 WeGYOnnLyqSQwAZv9Rns3kapauADKSL3QOFMqJPLZ00sEGyfIWJj6pPHvyYdZTbLz68rRYcou
 84wFrbPldNlg1uIfJw/CSoHgdZP/EMZ92ubW61w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reject values that don't fit into an int, as get_parent() and
get_nth_ancestor() cannot handle them.  That's better than potentially
returning a random object.

If this restriction turns out to be too tight then we can switch to a
wider data type, but we'd still have to check for overflow.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 sha1-name.c                    | 15 ++++++++++++---
 t/t1506-rev-parse-diagnosis.sh |  4 ++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/sha1-name.c b/sha1-name.c
index c665e3f96d..7a047e9e2b 100644
=2D-- a/sha1-name.c
+++ b/sha1-name.c
@@ -1160,13 +1160,22 @@ static enum get_oid_result get_oid_1(struct reposi=
tory *r,
 	}

 	if (has_suffix) {
-		int num =3D 0;
+		unsigned int num =3D 0;
 		int len1 =3D cp - name;
 		cp++;
-		while (cp < name + len)
-			num =3D num * 10 + *cp++ - '0';
+		while (cp < name + len) {
+			unsigned int digit =3D *cp++ - '0';
+			if (unsigned_mult_overflows(num, 10))
+				return MISSING_OBJECT;
+			num *=3D 10;
+			if (unsigned_add_overflows(num, digit))
+				return MISSING_OBJECT;
+			num +=3D digit;
+		}
 		if (!num && len1 =3D=3D len - 1)
 			num =3D 1;
+		else if (num > INT_MAX)
+			return MISSING_OBJECT;
 		if (has_suffix =3D=3D '^')
 			return get_parent(r, name, len1, oid, num);
 		/* else if (has_suffix =3D=3D '~') -- goes without saying */
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.=
sh
index 5c4df47401..6a938b205b 100755
=2D-- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -215,11 +215,11 @@ test_expect_success 'arg before dashdash must be a r=
evision (ambiguous)' '
 	test_cmp expect actual
 '

-test_expect_failure 'reject Nth parent if N is too high' '
+test_expect_success 'reject Nth parent if N is too high' '
 	test_must_fail git rev-parse HEAD^100000000000000000000000000000000
 '

-test_expect_failure 'reject Nth ancestor if N is too high' '
+test_expect_success 'reject Nth ancestor if N is too high' '
 	test_must_fail git rev-parse HEAD~100000000000000000000000000000000
 '

=2D-
2.23.0
