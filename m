Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F4C43334
	for <git@archiver.kernel.org>; Sat, 16 Jul 2022 06:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiGPGbe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jul 2022 02:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiGPGbL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jul 2022 02:31:11 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5158A23BF9
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 23:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657953049;
        bh=Z+8O6YOV5eCWOBinzh8XpLVudVs4WsfxQMyj8KHJJ2E=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=m8EeEztI2bYCwsJma3M8YPH6uDpXmRdu75Efy4JgTR9VKOzx8zwiUEOZ5ci8wTEuz
         oTC2L5FjkYBQjdfi6Z2gWVHOIblgfy9EgJzUB0Y4KXlDUdYTKeot2Jlj9NU3j2VIpX
         QBxppAqz67B7Wou0RI7nmJv1sVFuHfmCSmbrLQ44=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2ggX-1oFcOc0oPv-003uMW; Sat, 16
 Jul 2022 08:30:49 +0200
Message-ID: <7da25e7e-e3c6-77a9-2b8f-7407e92605b9@web.de>
Date:   Sat, 16 Jul 2022 08:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.0.2
Subject: Re: [RFC][PATCH] mingw: avoid mktemp() in mkstemp() implementation
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <7265e37f-fd29-3579-b840-19a1df52a59f@web.de>
 <b7fffe99-63fb-3899-6a6d-882b72b9512f@kdbg.org> <xmqq1qum2uvy.fsf@gitster.g>
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq1qum2uvy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6aqJn6qWX5r6VNE24VR/yPc2nAvD7lv5xMrmoyrWxKjKTnV5IoI
 W+UuwOlXRn+G5g6kW/LEfB4ouoJahDyl/HzYf88IHDjNfQL88twtmKoac66Oe/ykcX0W32o
 kLUBUIHGO7GAfCm5mI3dltQWGlECZbzHTVYJ2DzK0cJNclHEyRCA3GL6cyK2ZngQQtcJE3h
 RyR/py6R7CMzLHid7fXfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ug/8lrmrb78=:aDQqJFbNoWqKFZHBVc9hn+
 uLzIHBqOmR3I6t0fzrRdZt2TA5LdVOgZ1fonBI8HswETu0ByUixhOsLdSqKcfvkZyRmmY+iw0
 ssUlLZ2QWtPtivXfqRaQF+b+xJVU2F/o4eT+frldBAKklUZlxDLbIdAxFKpVDknYIKsjeQda3
 kn36iTj2TtIdL4C2egwcayGYJmLX7YwEm45u9Q4sPPatBiismdCSpJ7f/f/eLBkUjqKOyloHM
 hog8I4aCDEDXuWbWxY/iZeTrPq58Ibt8O6bOcw7v1RYAbtPC7YwATIeYaoCdCLwSqOSqQ+EdM
 0dI8dhCen652bKHd1t88BRSHf38+V0lXDe1ChQEKvSZJ9Df15MbPgf7Z2QZzw83RPAzZns7RL
 y54ML2UHXsUIFrW8p1CLGVvATydF+JZOxNk1VXxIllLE+nRQqenQWPbuxx0jPFbhljnPU4FtH
 tYH/IGH8bz/A00b3C71bGZ0JLB81SDaFrCS4CvF1qzXGVwYSAe5jTaPp3LCrtmbPSofo4Pl/W
 mAa1idJ/rg3XTB+GvZ9OZJhVQQJ+bS7+1IWK0SRdz0f010J4QeEZW9laRbutffd38xWZEQf2N
 AxadMjK4VeuYOU39eHXpSmjsndNynV3AMzJSLzDlPZqh/If+EERlUD0NEV9SerJ3hYruhSZ8K
 tLgfEAbG5ZIjIMb7WRkpp1gOKSVRmeEL09dtBYwLkgmWW4Z+kgzzXG/Lw0C+PapLOdQl+UhKA
 1oe1tI6385b3zsJdN1iHxL3aeJA7cfhpk8HwHKaScXIMgHNXCpZjuNuwWup020S947w/ldLFR
 WSkZovNsNkPty4zl2G6vVeTjx66HSd9tMv0yDN6jc7+sfS/rFJg4P6U2YXDHBt1LocPUSkOam
 eirKB9u4o6ianKzfh02B+oHt3IbdF5I+GwFhrjg58dcvgWLriaQ1LnsjV5O4Fg1IxcIAT9QNB
 SKCIU6R9Sy2Sj0+4rXB73o9sCWRnOxLjG5XLDTr+S0gx1sES29Nu+Uzq8jGkj957TeCpWfTja
 uHTukAA+J7GxOrn0pWeNEtURFHOE4COHLYkhyifNmWrtE2KlkAA0XaW49Q8nejFBH6aDsVReC
 0Ca/WseZHe1U0zyr9SX0P3z0NsrhrKmszh1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.07.22 um 18:38 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>>> diff --git a/compat/mingw.c b/compat/mingw.c
>>> index 2607de93af..b5502997e2 100644
>>> --- a/compat/mingw.c
>>> +++ b/compat/mingw.c
>>> @@ -1059,10 +1059,7 @@ char *mingw_mktemp(char *template)
>>>
>>>  int mkstemp(char *template)
>>>  {
>>> -	char *filename =3D mktemp(template);
>>> -	if (!filename)
>>> -		return -1;
>>> -	return open(filename, O_RDWR | O_CREAT, 0600);
>>> +	return git_mkstemp_mode(template, 0600);
>>>  }
>>>
>>>  int gettimeofday(struct timeval *tv, void *tz)
>>
>> I hate such an obvious layering violation. But we have already a ton of
>> them elsewhere (calling xmalloc from compat/, for example), so this is
>> just a rant, not an objection.
>
> There is intended behaviour difference between xmalloc() and
> malloc() that justifies your "layering violation" observation.  A
> low level library replacement implemented in compat/ should not call
> die() when it fails to obtain memory and instead report an error.
>
> But it is unclear git_mkstemp_mode() and some others in wrapper.c
> fall into the same category.  With the posted implementation above,
> the end result is how the platform that lack working mkstemp() would
> implement it.

We'd have a problem if git_mkstemp_mode() depended on mkstemp().  It
doesn't now, but if it is ever turned into a mkstemp() wrapper then it
would fall flat on its face, but only on Windows.

> If we were to do something to make it "cleaner", I suspect that the
> above implementatoin of mkstemp() can be moved out of compat/mingw.c
> and made reusable by _anybody_ who lack mkstemp(), just like we ship
> memmem() emulation for anybody who lack it in contrib/memmem.c

All other platforms seem to have a native mkstemp().  There may still
be interest in using our own if the native implementation is inferior,
e.g. uses a weak RNG and/or doesn't retry.

We could also convert the handful of mkstemp() callers (two if we
ignore reftable/) to use git_mkstemp_mode().  One of them is quite
tempting for the code deduplication aspect alone (see below)..

Ren=C3=A9


=2D--
 wrapper.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index 1c3c970080..77ca923040 100644
=2D-- a/wrapper.c
+++ b/wrapper.c
@@ -439,24 +439,7 @@ FILE *fopen_or_warn(const char *path, const char *mod=
e)

 int xmkstemp(char *filename_template)
 {
-	int fd;
-	char origtemplate[PATH_MAX];
-	strlcpy(origtemplate, filename_template, sizeof(origtemplate));
-
-	fd =3D mkstemp(filename_template);
-	if (fd < 0) {
-		int saved_errno =3D errno;
-		const char *nonrelative_template;
-
-		if (strlen(filename_template) !=3D strlen(origtemplate))
-			filename_template =3D origtemplate;
-
-		nonrelative_template =3D absolute_path(filename_template);
-		errno =3D saved_errno;
-		die_errno("Unable to create temporary file '%s'",
-			nonrelative_template);
-	}
-	return fd;
+	return xmkstemp_mode(filename_template, 0600);
 }

 /* Adapted from libiberty's mkstemp.c. */
=2D-
2.37.0

