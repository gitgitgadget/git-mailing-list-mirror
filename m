Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40D1C25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 10:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjAVKDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 05:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjAVKDz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 05:03:55 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7FD1CF66
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 02:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674381820; bh=8UPjDT/n2auJMBUPShtE9z3zwNw0jSMXXb5ff/hTVFM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lCaZiwlfPAoK/e7n6MyaA+5xRGKVZIphAYYFO4WX3M86MtynbWxekhgJJlfoAMGsQ
         B9NF6YiC/pK66BmHMktrPTgfm/ww6VZFRo7WFBC2mOz8cZ5zQl+27bLZ2duWCkZYJT
         1keg2d0cquAq1UWTE0qokwaD3aLL+1A/HsUuAObIwwYmnjKDfAu4CCcuhn1F49xSKE
         m8A+WqL+5YD37vUriEq/aUxK5GmD38FLagtKJ9z+kqHit7o88Uqrm8nQiaxj6ZzPXJ
         8DDO+kUI7MTLxzO32wnjgKXVrev1Cq3oorkfCKY5ov5lCKnGGTX6e2zwP1YdOKV32Z
         KwRuy2PAQVqCg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.223]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MS13n-1p8uBs3jml-00TWez; Sun, 22
 Jan 2023 11:03:39 +0100
Message-ID: <044bdc8f-fdc9-dfd2-6cbb-941513467524@web.de>
Date:   Sun, 22 Jan 2023 11:03:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] tree-walk: disallow overflowing modes
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <d673fde7-7eb2-6306-86b6-1c1a4c988ee8@web.de>
 <Y8zquGar3rLyRdTp@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Y8zquGar3rLyRdTp@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DxepNwyB+TrSJfMRiVusfDlEUPGwEADp0sEv8Dktgoh+6v7AJmg
 yFt+SZPf9e/V2KAdnPiDxes6ZzCuTaML5ZFz3JSiF4v48GA5uzw9S+hTN0KUmen3NppAFTs
 2yzjWsOjNLvkhnultQuCUfjTP7mB4RQIQYl8fjhesKJQu80RpsJjfmsQw2O7J+nbHPNcauy
 P0XPZJKJsUKY6sYzUZUBw==
UI-OutboundReport: notjunk:1;M01:P0:8qZXli1B+BI=;0feul6W+DgZCnBR53LX0OslX3/Y
 2jjUFiycyQhqIEJH6IUxrJjdwfBv9YPe+z8mF/QMKGDurwuahj4NkMpEFI4AIhKdZJF6W3Mr+
 O78hYKZ/zrXrGUIN+TW05DU3OyjB9gPPidc9IXSm9A9NcXe8Jnt5mfK1/CymAHFDpf6TqHnN1
 i4JRkKqqE0iSLxKXpsE/80iih+KaeDV/z7mEs1WG89xh0SALzCGYuidDDbm89EnwfMzMHMt+J
 1ka6T+xCM9QvaFpsjo4YESL/r+ha8MMXV7JfNtu6yjJWUnM+E8OfHWjOf62dfSJdqNIupPI28
 h7xVijqxgvzz8WhYaM2ZuMFvuTPo00ZeJe8bPvm4Ye6HHt5nLUgU6pnvhe7kUhcZNVXoIBXBt
 sux29+lI7SuKgAHOPrSIqMZCuwfffC5vCdyXJ/mYDBoyrw6rbQkJtxmUkyKjhhN09q57a9Jco
 UDgNBTxPCJOOjgO8vclcsd2WloP5RmW/0tLh+93OuBWoK4iC4PbbunCu1hEnt78voQJR9cnn9
 aVILdlT7DwqHHfV4erI3marCP2x48mQvOHZVJcxSKV4fMYFkM4n+GjXxNupzJUhdYgbnqUc18
 jId1v/bPADgzRVqkejmWjT8eaZTxrO72O8EK7wmzGztB7bz4HQBxwLPWJDsOJEKFg788AuoeA
 HSsEi6yX5nT5FnZEelCrkFgGafsmbvekCGhGAnuDZBYhyDgGY3/J63RadAO53/ziQxoUw+VAu
 Gmgav6jGQ4pB3IYNYNnyEGEsvnKOyX4eSCiUMvv0s/x37ANUrxxHJMBh/oOsckJqGzHVlfL2S
 z6c5ehX2B8XPdPhlkSzD5Z8hayxBuGTzZFZH+CAMXhxdJa5VZBq9jx/85xpc9MNEN+3578hid
 gSyk0VtXRo07PveH7we9ACZZlFbE4Vvru9gezvqLk8F2BAi+qd3fIuCom+y7x+4hGTWOgARuT
 zkirTqk+6XmsCrlUljshLtc8t1A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.01.23 um 08:50 schrieb Jeff King:
> On Sat, Jan 21, 2023 at 10:36:09AM +0100, Ren=C3=A9 Scharfe wrote:
>
>> When parsing tree entries, reject mode values that don't fit into an
>> unsigned int.
>
> Seems reasonable. I don't think you can cause any interesting mischief
> here, but it's cheap to check, and finding data problems earlier rather
> than later is always good.
>
> Should it be s/unsigned int/uint16_t/, though?

"mode" is declared as unsigned int, and I was more concerned with
overflowing that.

We could be more strict and reject everything that oversteps
S_IFMT|ALLPERMS, but the latter is not defined everywhere.  But
permission bits are well-known, so the magic number 07777 should be
recognizable enough.  Like this?

=2D-- >8 ---
Subject: [PATCH v2] tree-walk: disallow overflowing modes

When parsing tree entries, reject mode values with bits set outside file
type mask and permission bits.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tree-walk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tree-walk.c b/tree-walk.c
index 74f4d710e8..62da0e5c73 100644
=2D-- a/tree-walk.c
+++ b/tree-walk.c
@@ -18,6 +18,8 @@ static const char *get_mode(const char *str, unsigned in=
t *modep)
 		if (c < '0' || c > '7')
 			return NULL;
 		mode =3D (mode << 3) + (c - '0');
+		if (mode & ~(S_IFMT | 07777))
+			return NULL;
 	}
 	*modep =3D mode;
 	return str;
=2D-
2.39.1
