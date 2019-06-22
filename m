Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B1471F461
	for <e@80x24.org>; Sat, 22 Jun 2019 10:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfFVKDj (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 06:03:39 -0400
Received: from mout.web.de ([217.72.192.78]:53285 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKDj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 06:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561197811;
        bh=7X4HbrMkKGgcLrziqQKrS5CImUzlzOdTAfAcBIVgh80=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UZbUuCTN0VO27YjEG2hzb++9TxUCNMm/oMQUjJGOaQ6sa313xq9a4wjovmYo2ybqL
         QA665C41p0VbYqMAhFrLfRavyFpKLFCtODhkf56Rcp3ngbu/DWHEeXwr1uXgo3MoGD
         wLPvf5LNMtfdgeWoDPrchwqClwaTJbnrAw9j6ANw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LtFYd-1ic3Am0wvr-012rfu; Sat, 22
 Jun 2019 12:03:31 +0200
Subject: [PATCH v2 1/3] config: use unsigned_mult_overflows to check for
 overflows
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.265.git.gitgitgadget@gmail.com>
 <9613c88849e53e00e1f7ade49c6c9056309ef0b9.1560426581.git.gitgitgadget@gmail.com>
 <03a68560-8058-7436-6edb-38e276a37190@web.de>
 <f22599d4-148f-212c-282c-790f5bde1706@web.de>
 <90ef3797-78a6-f6d9-443b-387c0ab7cbe7@web.de>
 <xmqq7e9ltbe2.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7a580777-2ccc-6097-477a-e66eb28d5f9b@web.de>
Date:   Sat, 22 Jun 2019 12:03:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq7e9ltbe2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yy174peznYIIttcQKbfAFSfCbbvkew/9StB2Iy2J+GjaxoVC5wW
 DQYGzcg7Qv2zbO98RxrbVhATU3M/dWVxYRVSszXTz5eGTfjYJyoPcy+Dpa/Ulofrs5RqiS4
 wd0qxNkPkCu2ssfFga6TmEn0f+hUIuYxe+0/Vruzdihc/TK4T4oHtpelRY9nqriYwgsCHqC
 7/CCCAarR+HrcqaE6E7cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7RgEzeDvZaQ=:BdxMRriDL8rcdvlUqJbHfX
 iGrr3THvoOmIv6Ls80agdP4IZPHwcyAcr7PyTpYFIYMbFAJvDffAxyDRh8lcLreFINHd4Nj9H
 smDQmEzZmcWjn+rsS7fpYmCjDzyRm/rBuBEctIxzv6gAAd/+Vi000J1izFBDrKwSf3/zrgMec
 393uG7674ruoEKkHk3runoDHMP1RgerhSVPBtRgckBrRj9FzfmS6+E+jzsibtHuO/+3ZgVpep
 reFh0sr6Sc3Nh58kZ82rSfLt3Jip8+kUkHnNmO9KAvZ02kIDkw4vo7tt7XbyxUoyMGxrc9Kf7
 HKxs+IY3Wn12gsmcRq1sAahTP+jsB0EmdqC9ER18+9pbYZJCrVRwgkU3kpAqbN4Ov9Hmy+3py
 xsd21Pr/D5HICKviKJteElXqeaIxq4SIfChKxua6g9Y/NO7yNoaRbdWDLyydkNAJcEmIGtYbL
 pMSvhSy6a0PTe3xA8/81ffr76EOnP4lHp3KgMb/pyFhnO4C50XHp61UOKbPo8cSgyrKfcVq7M
 YaQw6FVKHf4vhwouUO28IKH9kh0gwOWUgEFRYKyPnlzazF192/vxBQ9NfgZylm+RAS3d0cbCI
 Xc8CjpR0XiksCxfcMQdSFEzPsACj95vwWuZNg0eq9We3ZUTy69nLbUxTXyjZIYWBLtPObGRz4
 4hUlXYM8PztnYcE3S3HYphrtD9uu10p3lDShft1Tk4qPX1b4OcY6OXAX5y5epM9aT5B5W3df6
 FECUcR/kETMQl6T4KPllWJd9paGzqTWv+GmnuVCNHDz7xOBZtuqPD6cIyY9p51AdLHcafamOg
 qGM1YQxTMbIRJBn0vWbAE9konOk32xX4GB8MIzETNMnRY9MOarHgv1vqU4w6Jp6UQciWstCL2
 FPl+E210jhtV6RNef7GJGiF+oBxjTPvXXC9MoTnn1F+JLQIfeu2Jd6LAkVqzqHYwDJQoiaNLk
 InWckgYsQfvKMIIA+HfxRXcHMAu9b4rA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse_unit_factor() checks if a K, M or G is present after a number and
multiplies it by 2^10, 2^20 or 2^30, respectively.  One of its callers
checks if the result is smaller than the number alone to detect
overflows.  The other one passes 1 as the number and does multiplication
and overflow check itself in a similar manner.

This works, but is inconsistent, and it would break if we added support
for a bigger unit factor.  E.g. 16777217T is 2^64 + 2^40, i.e. too big
for a 64-bit number.  Modulo 2^64 we get 2^40 =3D=3D 1TB, which is bigger
than the raw number 16777217 =3D=3D 2^24 + 1, so the overflow would go
undetected by that method.

Let both callers pass 1 and handle overflow check and multiplication
themselves.  Do the check before the multiplication, using
unsigned_mult_overflows, which is simpler and can deal with larger unit
factors.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
=2D--
Patch generated with --function-context for easier review (e.g. to see
why we can stop updating uval in place).

 config.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/config.c b/config.c
index 01c6e9df23..3c00369ba8 100644
=2D-- a/config.c
+++ b/config.c
@@ -856,29 +856,29 @@ static int parse_unit_factor(const char *end, uintma=
x_t *val)
 static int git_parse_signed(const char *value, intmax_t *ret, intmax_t ma=
x)
 {
 	if (value && *value) {
 		char *end;
 		intmax_t val;
 		uintmax_t uval;
 		uintmax_t factor =3D 1;

 		errno =3D 0;
 		val =3D strtoimax(value, &end, 0);
 		if (errno =3D=3D ERANGE)
 			return 0;
 		if (!parse_unit_factor(end, &factor)) {
 			errno =3D EINVAL;
 			return 0;
 		}
 		uval =3D val < 0 ? -val : val;
-		uval *=3D factor;
-		if (uval > max || (val < 0 ? -val : val) > uval) {
+		if (unsigned_mult_overflows(factor, uval) ||
+		    factor * uval > max) {
 			errno =3D ERANGE;
 			return 0;
 		}
 		val *=3D factor;
 		*ret =3D val;
 		return 1;
 	}
 	errno =3D EINVAL;
 	return 0;
 }
@@ -886,26 +886,27 @@ static int git_parse_signed(const char *value, intma=
x_t *ret, intmax_t max)
 static int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_=
t max)
 {
 	if (value && *value) {
 		char *end;
 		uintmax_t val;
-		uintmax_t oldval;
+		uintmax_t factor =3D 1;

 		errno =3D 0;
 		val =3D strtoumax(value, &end, 0);
 		if (errno =3D=3D ERANGE)
 			return 0;
-		oldval =3D val;
-		if (!parse_unit_factor(end, &val)) {
+		if (!parse_unit_factor(end, &factor)) {
 			errno =3D EINVAL;
 			return 0;
 		}
-		if (val > max || oldval > val) {
+		if (unsigned_mult_overflows(factor, val) ||
+		    factor * val > max) {
 			errno =3D ERANGE;
 			return 0;
 		}
+		val *=3D factor;
 		*ret =3D val;
 		return 1;
 	}
 	errno =3D EINVAL;
 	return 0;
 }
=2D-
2.22.0
