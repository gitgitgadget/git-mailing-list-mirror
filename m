Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C958C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A049422255
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 15:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="aBOLfJHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389806AbgJOPxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 11:53:03 -0400
Received: from mout.web.de ([217.72.192.78]:56413 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389762AbgJOPxD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 11:53:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1602777161;
        bh=56LNUYI6wlvZ5QQtqYsDMZCrSj/QcMKXsK//N0njUuI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aBOLfJHEGU5Y42iEEtCdfFHkhA1HYrr9OLvSgZ7vnhKCLMSFH5wJI/oZi0vUXE3pz
         ydPNIWbYG5j5iGr+WCu7cGR7rL37gnnnHDtWl8TOAZw+hnqwTwNM7NOCO0L9GeP0FF
         AJyTYbty4mwsso/cv1hCKHcOCLopYKB0lNFo1DNk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.28.94]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmho4-1k4RzT3ag2-00jpTe; Thu, 15
 Oct 2020 17:52:41 +0200
Subject: Re: git fast-import leaks memory drastically, so crashes with out of
 memory by attempt to import 22MB export dump
To:     "Dipl. Ing. Sergey Brester" <serg.brester@sebres.de>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <1eeb49305cb7c712e141dcae2c434d96@sebres.de>
 <20201015012636.GA387901@coredump.intra.peff.net>
 <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <79cbeb4c-5840-d5b7-a2b9-d72cf47968df@web.de>
Date:   Thu, 15 Oct 2020 17:52:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <72a4d4d8dff95351122bd192976dd6b1@sebres.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2MdV1BkkQeOzEDy41+R6DFpVzTwd18WAmv6K6RyEr2dNJMPm35M
 hnivbPPyfSJPLwulvcHxbLueDWSQladWTV1i1NbRsuYnLfqdnuyJKlFcQfOGoZlQYS4mJAF
 p92OWy0HGE3e+edLT1CuTUD7gBz9/SjQy6zAsb9lrgfAF5RwOtA7cbRs4kvVeowo2N/lIez
 odz+uZrI/gjKE5rO1pBlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wp9NkcUcvuo=:pzVUOTENU74qozjnIAf3RY
 H6gesEq5HAVD0SiARRn1w0LCfDevF4Cg67qAc9M+0IOtw5p7+W2vH9LPz5OpGmRdOtw9g69au
 ooMTQSaf6hrFmn/m/AZ0ym414RV4MbpRPC3EGwOxmzqoACDO67+qc0R6QK4q/4ULjSaHFvUHm
 wqK+YJyZnJuB42jPHzIquXhVyKA74XQtB4JRecAsVRB8bo56MWmnRC/qPhpG1EjAlbQOKr+rl
 j8l3nC6Bi2QRVREEu13Txgo3xPJLLGxu6ZFL9oqeqdCv664Bc3nHxog+1zn0Q84fdyhGJ1HoH
 wKDLyfJrhGCoSpT6XQlEzjdWLpIILqZVzC+7k7i2B128qjryc55OXJHMz01jpC03dbbtrUOjB
 g+0zTggKDz670opvwKxALcqP9ubFxQv++GFkMXtlxhLsxEthj9B7ZbenvV6Zcvw2pZDW5nbR3
 RVJKWlLvXFuaucd9JIbWgIfuiL4FV0z+4/AMrsFK9ajtRtUn+ULqV9VN4GD25zn5484do8a14
 RuwED6RwGWAUQjhArlkV0AAuLpsj/coPcrdLKa7gHWPmWdpRsA6W8XhpGOPqrq9Bvd2yVDyll
 fddPvJVfGMOfKtvmoyi1vMB7UTZVz3KIBD+Ub3HV3mNXi2s5j85/ek6VZ3cqZeITZnUhNX7rO
 EXYIc26Ubrolt8BnoFXpbB5vRWdN3XIviORuJWP8Au+p26y9B59cD/NLh+Tr6MKIHWiatxExH
 AZG/Jyo+i8gcmajwZC5zfCleoArU386wR9p/HkPr8WfotsZDYPlgBeupmtCrWD7Weuez96BYT
 lywlG4YJFuUH8Kv32JGj2afXMhlvhvEtE0hJKkAuPMpyP8giAfgg4MmMC0YutG3waX2MNsAnR
 GPcvex03Is05jOv6fKXQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.10.20 um 13:50 schrieb Dipl. Ing. Sergey Brester:
> ```
> # clone or copy git repository (we'll use it for export and import):
> git clone https://github.com/git/git.git
> cd git
>
> # make 1st fast-export in order to generate marks (don't need the dump, =
only marks are needed):
> git fast-export --reencode=3Dyes --export-marks=3D.tmp.exp-1.tmp e83c516=
3316f89bfbde7d9ab23ca2e25604af290..dc04167d378fb29d30e1647ff6ff51dd182bc9a=
3 > /dev/null
>
> # make 2nd fast-export in order to generate partial export dump (file ".=
tmp.dump" will be ca. 87MB):
> git fast-export --reencode=3Dyes --import-marks=3D.tmp.exp-1.tmp --expor=
t-marks=3D.tmp.exp-2.tmp 61addb841f2a6d74a1737a01e03df1f773e04944..master =
> .tmp.dump

In case someone else is wondering about the meaning of those hashes,
here are their reference strings:

e83c516331 (Initial revision of "git", the information manager from hell, =
2005-04-07)
dc04167d37 (Fourth batch, 2020-08-04)
61addb841f (Merge branch 'jk/strvec' into next, 2020-08-04)

> # now try to import this dump, using first marks as import marks (we hav=
e all revs in git-repo):
> git fast-import --import-marks=3D.tmp.exp-1.tmp --export-marks=3D.tmp.im=
p.tmp < .tmp.dump
>
> ```

So you use the marks generated by the first export to import the second
export.  I wonder if that's relevant to trigger the memory allocation
issue.

> And see how git-fast-import eating your whole memory and enjoy the crash=
 :)
>
> ```
> fatal: Out of memory, malloc failed (tried to allocate 2097152 bytes)
> fast-import: dumping crash report to .git/fast_import_crash_6684
> ```

I can reproduce this on Debian -- but don't get a crash report, just a
notice from the OOM killer.  It bisects to ddddf8d7e2 (fast-import:
permit reading multiple marks files, 2020-02-22).

Ren=C3=A9
