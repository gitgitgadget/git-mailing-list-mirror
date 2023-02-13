Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D845C636CC
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 21:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjBMVKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 16:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBMVKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 16:10:09 -0500
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E32F76C
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 13:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676322599; bh=zMin3KHULZT7qzyTMP6HegCQeHJ4kzRGt88VkudGSTk=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=UyO/uAMSMIbvCGN6ObfYmXQxV15B/7PYmB8t/rvsse7vZRWzxxUQaHlEnTBmawjGC
         Kx1KGCNzjrkDopNchg4OR66WKMJOQfWBAnpJL04kdk5yuX62neEsW+pDML5yVEmiJH
         oJRbaH7aT5spyPOWtW3qn+uvcK38YiljW0L2eFYRHuKsp0pm9fHE0B/Rf3xvBD7l6i
         2NXWBBLSPhPScfmEmzeso/hckV7DemMpxstevJWQs+8rSHQU/tn917sgFf2+Jnzznv
         1uPhGr/fyYe3o1KuxkGYPbMeiU1Oc1tktOJwlRHER0Jc2SwaeDOFDL2fH+N0ltXYAK
         iZFIvDIFwEvnQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFJjZ-1pLLME08Cn-00FjSZ; Mon, 13
 Feb 2023 22:09:59 +0100
Message-ID: <c740cbc6-d9db-88df-b10f-904bdd5e2e06@web.de>
Date:   Mon, 13 Feb 2023 22:09:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: [PATCH v2 1/3] test-ctype: test isascii
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
 <81eee04b-598e-dfe1-f954-3105bcbcb2f2@web.de>
In-Reply-To: <81eee04b-598e-dfe1-f954-3105bcbcb2f2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ibm0WEnIMb9ABymj/144aiD625RLUqdcxNbnZw04G0Rp0NUJnGz
 0YoFt3HDBlnRQhaBEGzuK1n6lFymD9c2g6aavA8v4g51r0VcD9DFF13gMz79P0QuZRsVwkU
 BYrrBYmgO8p8WYzBt70y8WaZBG2xdHMcmShaNEnGIYHwUgpIAspzf0r6+tff266fozoxude
 Gip59MNyewjB2CmPzDffQ==
UI-OutboundReport: notjunk:1;M01:P0:gfVh0ZaGH/Q=;j701dWx8KowSpUCLDMeHLn1rxDk
 FbDF67c7QVe4G9gdWMl6nwroQC0BMM4KgwgrBPgTvd7DvssB6H1BsjHPOO+MB9FXl2nQe0Auo
 HxxAik24pe+hGLTT+EESf2O9gEbqdluC2rQKWrF3Ao21BeWgRmCu1u5H6DMn3dr0dIivNzaEw
 7bc+k70XVx6bIvlWEX/m5/RhsORLk31NybXhRfXVd5vpYEPozZVk8db14oSB7RUMTOT1/4g4w
 le2lYZsb5vberBf0mALC1RK8ZDUeLlEF+COEcGA6fBjW92TM4IJt02y0NYP0Ht6xyDKREelQs
 s+BBTd1/nPFYuw/BltdRRm+iS4USyiz9Ygw459B5JjqOxYyWdzY/XAy4EI8gF6XLiOdmNjGE5
 5cgIzDYkzCKJ8oQWDcJcZB4JhWkAYxbjt6XKBENY1dADQh5V5sjIPX7kr8jT1eRmPrGdtINA7
 zV2MgiLODgPdu14sntb0BBftB87wYV3EnFycTMqQfLOJAzcz9YO1idoRDBzKLkpyquf7oy8u3
 Sr7j9VbCnPBZmIIQUrzyR8nIllXVQ30ZgEAcMPMB8YAjxmJzIiPbc50Li/kT+VXlObBmNbyp+
 l+5Zext72y6lJpXqkuuzs9CEWOONVJF0uaImlIFxUchO+PLLc6kgE17P04JMyLJEgEx2BWhqE
 W4/F7HfvdLJaWV6ibTdl5N2KMgd9lHOTnMY8TRiblap5atm6fy+ubSPuPgMjU6dP3CjHXgXjt
 AW1RBu0IT+oKeAM6x8GKwis2PHwVf6Ee+8WmY9iw9oFt2bFjOTYwX85z/PzgTUu7owHeybLfU
 bmRR8Rzj04v0jZG1EjmfeedyBALM5PLd5mhNG+c+n+62xVVsXqy6Y/tgHUArDvqNwNpsI380B
 ScIqetL3/1aRVLRBVxYEOISaWQz0AJ4xLHpeE5swyF2kpmZSgOMP4DuOAjiq30x4RxaEtNmNH
 KRiwvw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the character classifier added by c2e9364a06 (cleanup: add
isascii(), 2009-03-07).  It returns 1 for NUL as well, which requires
special treatment, as our string-based tester can't find it with
strcmp(3).  Allow NUL to be given as the first character in a class
specification string.  This has the downside of no longer supporting
the empty string, but that's OK since we are not interested in testing
character classes with no members.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/helper/test-ctype.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-ctype.c b/t/helper/test-ctype.c
index 92c4c2313e..caf586649f 100644
=2D-- a/t/helper/test-ctype.c
+++ b/t/helper/test-ctype.c
@@ -11,9 +11,14 @@ static void report_error(const char *class, int ch)

 static int is_in(const char *s, int ch)
 {
-	/* We can't find NUL using strchr.  It's classless anyway. */
+	/*
+	 * We can't find NUL using strchr. Accept it as the first
+	 * character in the spec -- there are no empty classes.
+	 */
 	if (ch =3D=3D '\0')
-		return 0;
+		return ch =3D=3D *s;
+	if (*s =3D=3D '\0')
+		s++;
 	return !!strchr(s, ch);
 }

@@ -28,6 +33,15 @@ static int is_in(const char *s, int ch)
 #define DIGIT "0123456789"
 #define LOWER "abcdefghijklmnopqrstuvwxyz"
 #define UPPER "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+#define ASCII \
+	"\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f" \
+	"\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x1a\x1b\x1c\x1d\x1e\x1f" \
+	"\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f" \
+	"\x30\x31\x32\x33\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x3e\x3f" \
+	"\x40\x41\x42\x43\x44\x45\x46\x47\x48\x49\x4a\x4b\x4c\x4d\x4e\x4f" \
+	"\x50\x51\x52\x53\x54\x55\x56\x57\x58\x59\x5a\x5b\x5c\x5d\x5e\x5f" \
+	"\x60\x61\x62\x63\x64\x65\x66\x67\x68\x69\x6a\x6b\x6c\x6d\x6e\x6f" \
+	"\x70\x71\x72\x73\x74\x75\x76\x77\x78\x79\x7a\x7b\x7c\x7d\x7e\x7f"

 int cmd__ctype(int argc, const char **argv)
 {
@@ -38,6 +52,7 @@ int cmd__ctype(int argc, const char **argv)
 	TEST_CLASS(is_glob_special, "*?[\\");
 	TEST_CLASS(is_regex_special, "$()*+.?[\\^{|");
 	TEST_CLASS(is_pathspec_magic, "!\"#%&',-/:;<=3D>@_`~");
+	TEST_CLASS(isascii, ASCII);

 	return rc;
 }
=2D-
2.39.1
