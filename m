Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A48C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 518A52076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 18:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="GNUxUJar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDVSus (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgDVSus (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 14:50:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B1CC03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 11:50:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so3699680wmh.3
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bVXH8jedk6J2l5TUFBQwFEzBdGBtMHusOMHjJt4K11E=;
        b=GNUxUJarNV7zHEoAKXfNWSNsKNxlf2Rbk1Bjj1Tr7WUwj2AL7YbgmmUe2NyUfXzYZi
         6FXyorkAuBHmyypDgPmBMvuqX6hAWv8fVxKR5T8AwZpwi7i8qQ6jkky3YRNI716C560z
         HxoXN5sYKloNLRSuUxBGWYq2OodMghn+jcXWxNy/0ssfxkNB/SkHSTtkgiqyYll8JjTF
         hokOfjKc9j8EafqISkQwdpd8QasJtyAFccNYgtyuYH5vkQ1Ia3PwINTzQ2VDT8pdDg2t
         8094aiehM2XNCh7Qha3xhBx32nKm2pHDWajFvXhpkMUglb8Evkvad+cRxQgFn2GZiXME
         ABaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bVXH8jedk6J2l5TUFBQwFEzBdGBtMHusOMHjJt4K11E=;
        b=M8Cr+Uvl/JcdOD3JRQUZyJa/bybLuEhFUFZyQR6C5+MXPC5TepJu1iC7zCn83abu+F
         SjALTJSLcr1FbHDHcRGusq+Le75HzQoh8QljSI+Y7ZWreS1ocII6BLzl1btV5Z3harQp
         ALmLK9Gu1/LxJzaB5q98ztQEajjgaaDa5kDqNOicGL6aE8zvTH2wXNBz3bt8snUOoz+W
         paDJoXZ89iKADZ7UW1HTmKmwFWDOemykLuXinhV6S+KdTX6NkE8C0l5TbxYjbbcvqSGW
         /kv+vazNTEBu/nQHa/DDVAaMCfuJ/PFjwDIzTy+N5EADK0Ysr2IFfdgHnWQIW4AtlXtC
         eL0g==
X-Gm-Message-State: AGi0PuZlk08m2M4GvXWOuIKveRuY7p5xph8VhpYuvb9YPruwZHd+y4xw
        V16L638jHPMV7R5pL5gyRn8dKFfg2cqZvg==
X-Google-Smtp-Source: APiQypID/rucfgO/WDqfJ7yOssizHdaHKG/G36dZelgIqaE5j90GRUsXHjL/2k7H94rH4Sx7/TITcA==
X-Received: by 2002:a05:600c:210:: with SMTP id 16mr11525883wmi.57.1587581446134;
        Wed, 22 Apr 2020 11:50:46 -0700 (PDT)
Received: from [192.168.149.251] (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id s6sm240484wmh.17.2020.04.22.11.50.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 11:50:44 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for
 GNU/Hurd
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CA+sFfMfre6W5GcPh1pWcroFD9S9OPj_uLp5CK11yh-UhqgDs2w@mail.gmail.com>
Date:   Wed, 22 Apr 2020 19:50:44 +0100
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <452EC7D1-BE96-4172-8F70-3E7384C87280@jrtc27.com>
References: <20200422153347.40018-1-jrtc27@jrtc27.com>
 <20200422164150.GA140314@google.com>
 <CA+sFfMfre6W5GcPh1pWcroFD9S9OPj_uLp5CK11yh-UhqgDs2w@mail.gmail.com>
To:     Brandon Casey <drafnel@gmail.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 Apr 2020, at 19:48, Brandon Casey <drafnel@gmail.com> wrote:
> On Wed, Apr 22, 2020 at 9:41 AM Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>>=20
>> Jessica Clarke wrote:
>>=20
>>> GNU/Hurd is another platform that behaves like this. Set it to
>>> UnfortunatelyYes so that config directory files are correctly =
processed.
>>> This fixes the corresponding 'proper error on directory "files"' =
test in
>>> t1308-config-set.sh.
>>>=20
>>> Thanks-to: Jeff King <peff@peff.net>
>>> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
>>> ---
>>> config.mak.uname | 1 +
>>> 1 file changed, 1 insertion(+)
>>=20
>> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>> Thanks.
>>=20
>>> diff --git a/config.mak.uname b/config.mak.uname
>>> index 0ab8e00938..3e526f6b9f 100644
>>> --- a/config.mak.uname
>>> +++ b/config.mak.uname
>>> @@ -308,6 +308,7 @@ ifeq ($(uname_S),GNU)
>>>      NO_STRLCPY =3D YesPlease
>>>      HAVE_PATHS_H =3D YesPlease
>>>      LIBC_CONTAINS_LIBINTL =3D YesPlease
>>> +     FREAD_READS_DIRECTORIES =3D UnfortunatelyYes
>>> endif
>>=20
>> I wonder why we set up this knob this way.  A lot of operating =
systems
>> support fopen(..., "r") of a directory --- wouldn't it make sense for
>> FREAD_READS_DIRECTORIES to be the default and for users on stricter
>> platforms to be able to set FREAD_DOES_NOT_READ_DIRECTORIES if they
>> want to speed Git up by taking advantage of their saner fread?
>=20
> At the time it was written, the assumption in the code was that an
> fread() on a directory would produce a failure, and that that was the
> sane and common behavior. fopen(..., "r") on a directory was expected
> to be successful on most platforms, but does fail on some. I don't
> recall if it failed on any of the platforms I had access to at the
> time (Solaris, IRIX), but it does fail on Windows. So I introduced
> this feature that would make fopen() fail when opening a directory for
> use on the platforms where fread() of a directory did not fail,
> instead of trying to wrap fread().
>=20
> I just looked in config.mak.uname, and I'm surprised to see
> FREAD_READS_DIRECTORIES set for so many platforms. And it's set for
> Linux and Darwin?!?!? Junio added it for Darwin
> (8e178ec4d072da4cd8f4449e17aef3aff5b57f6a) and Nguy=E1=BB=85n Th=C3=A1i =
Ng=E1=BB=8Dc Duy
> added it for Linux (e2d90fd1c33ae57e4a6da5729ae53876107b3463), but
> also seemed to mistake the intention of FREAD_FREADS_DIRECTORIES as
> being about the fopen(..., "r") of a directory rather than about an
> fread() of a directory.
>=20
> I just wrote a test program and tested on Linux, Darwin, and Windows.
> Linux and Darwin both succeed to fopen() a directory and fail to
> fread() it, as expected. Windows fails to fopen() a directory.
>=20
> I notice this earlier commit mentions a failure of t1308
> (4e3ecbd43958b1400d6cb85fe5529beda1630e3a). I wonder if this is the
> reason FREAD_READS_DIRECTORIES was added to so many platforms?

Then the current autoconf test is wrong and likely causing confusion:

> AC_RUN_IFELSE(
>         [AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
>                 [[
>                 FILE *f =3D fopen(".", "r");
>                 return f !=3D NULL;]])],
>         [ac_cv_fread_reads_directories=3Dno],
>         [ac_cv_fread_reads_directories=3Dyes])
> ])

Jess

