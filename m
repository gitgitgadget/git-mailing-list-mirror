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
	by dcvr.yhbt.net (Postfix) with ESMTP id 641351F461
	for <e@80x24.org>; Sat, 22 Jun 2019 10:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFVKDl (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 06:03:41 -0400
Received: from mout.web.de ([212.227.17.11]:43003 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfFVKDk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 06:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1561197817;
        bh=G69plghB/lRsTRVOca7w69WcB+FnzDSEVJ5IwQuYXk0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mSqY9DsRjiVl+g1maSlor8ZqLgsOqePDDiuWuBRd9PyVs1PlsVtucoeSx8mNxvLtb
         b3iuma1apk4Zarti8/CWGbH4QAikWsmkZg98JgwwCoNia5vL841N310SI5pBOhTsX3
         wQfSEtF172djrwIg9wxQHa03tAj3K1fzPCZ1/ZrM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.26.169]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWRzK-1i7eAF1BxC-00XfbE; Sat, 22
 Jun 2019 12:03:37 +0200
Subject: [PATCH v2 2/3] config: don't multiply in parse_unit_factor()
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
Message-ID: <20bc9ec5-6e69-57aa-7347-4b7eaa8c8c1f@web.de>
Date:   Sat, 22 Jun 2019 12:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <xmqq7e9ltbe2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pFMxU9s/60p/P12g3vRf414CPTUtWcqfpFNnHW5TN2ocJC/sK6b
 0xnRNMDGeiIAlAleEudMojzQHo982IKudWemieJfEMhZKyB/nhmJq/DDj0WlHhkguTjj+vK
 bl1PyLzVY5k/w1sNrnx18itIY2rGlfHjoHDTzRA0hilBcDCwa73sWJkX627ARjYKZ9V8UCx
 a7qU8ekB/cm8wce40Amsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xy/twpCJokY=:QTYFjjyc9nZnZl0HwdMdAD
 PLOESo19tEbbs5NIEmpXmatrfbJw+D/GnIjadUru2/MMW/AT5dDR8QOAdgXSJQB10Y5KYJKj0
 t5fDxpZt01+IKC1gf650NaJ/hkLcZOxlGrAAzuGy5k0IG5qgPyxizb68T4ZsGdb2wlW7jjxsE
 flV3+kLfNXVhi9feBGr80gKknhYPMz8+zKJ8uOlygU+0n6qa2UYKHJTXhwdiIN63jQtgvuX3I
 VBKbyJJxayTLDKTR4/hbkARcjpq3WYJ4kU1dKGlw7Y3IeDWsm6dXzFEWYu69b+6M/3wuILfJc
 aEjai6Evl4Tpaji7LP5GzX7Yw7TtbGj/D2XMH4xj4tX90IppJzLgr/cnth84Oo6raqKROP/cU
 ec9S4ZDxw4cn1Hkzqj24x78/xMBF6L7bEH2uw9zaHcVEVfTjMZvwTBLr72xbpUFKBSgm/EQ1f
 mJH1TL8oktOHMRS4JFexzd82xPW48tpiz88VJJyZz0N/zQcxhtYyWtHZNiT/nLvB578aCLXZq
 YobkWwescEtHY/AP9ViFJXLYv3npICVaqhDifegAvovNK1C9nVSusQil2vwjehnPSyaU0BNG7
 q2zZsBcIZdVwttBb2gxikEeyqsTrIJyhKrRgkrT+3NMIcJrmXOW3friwZRuk2A+5DaCyHlS7H
 cgADjpFnm9JfMW8iZLYACJ5jAlY74X81MJOxEJ2dGR4s8n0SI1tHXf2dfWgiXM6q0U2A1fNrA
 oYh05AcDBYhgRLiipR3y1PYQy5xeDt4GSqtii6845nQ20evZ06J9MI6KkpjPN5Y4wXGza1qr+
 2G80UI8CSo3ub/MiR/Zv+koA36Ggi93sb6u+BQQZiQMo/7KURWx0ifDnJq4NgxuzWKhDlNzWX
 tgR3rd8QJyWV0zI8Xl/h8RKbm6E3ScD03zdfEEotsXR/xMYc//pSCLhtuz8egNCxQ68FUZE55
 Lm0lLNz805ht89JQUA8MOOJI08pxe/SQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

parse_unit_factor() multiplies the number that is passed to it with the
value of a recognized unit factor (K, M or G for 2^10, 2^20 and 2^30,
respectively).  All callers pass in 1 as a number, though, which allows
them to check the actual multiplication for overflow before they are
doing it themselves.

Ignore the passed in number and don't multiply, as this feature of
parse_unit_factor() is not used anymore.  Rename the output parameter to
reflect that it's not about the end result anymore, but just about the
unit factor.

Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
=2D--
 config.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/config.c b/config.c
index 3c00369ba8..a8bd1d821e 100644
=2D-- a/config.c
+++ b/config.c
@@ -834,20 +834,22 @@ static int git_parse_source(config_fn_t fn, void *da=
ta,
 	return error_return;
 }

-static int parse_unit_factor(const char *end, uintmax_t *val)
+static int parse_unit_factor(const char *end, uintmax_t *factor)
 {
-	if (!*end)
+	if (!*end) {
+		*factor =3D 1;
 		return 1;
+	}
 	else if (!strcasecmp(end, "k")) {
-		*val *=3D 1024;
+		*factor =3D 1024;
 		return 1;
 	}
 	else if (!strcasecmp(end, "m")) {
-		*val *=3D 1024 * 1024;
+		*factor =3D 1024 * 1024;
 		return 1;
 	}
 	else if (!strcasecmp(end, "g")) {
-		*val *=3D 1024 * 1024 * 1024;
+		*factor =3D 1024 * 1024 * 1024;
 		return 1;
 	}
 	return 0;
@@ -859,7 +861,7 @@ static int git_parse_signed(const char *value, intmax_=
t *ret, intmax_t max)
 		char *end;
 		intmax_t val;
 		uintmax_t uval;
-		uintmax_t factor =3D 1;
+		uintmax_t factor;

 		errno =3D 0;
 		val =3D strtoimax(value, &end, 0);
@@ -888,7 +890,7 @@ static int git_parse_unsigned(const char *value, uintm=
ax_t *ret, uintmax_t max)
 	if (value && *value) {
 		char *end;
 		uintmax_t val;
-		uintmax_t factor =3D 1;
+		uintmax_t factor;

 		errno =3D 0;
 		val =3D strtoumax(value, &end, 0);
=2D-
2.22.0
