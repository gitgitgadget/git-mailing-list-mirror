Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F3AC433DF
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D6520671
	for <git@archiver.kernel.org>; Mon, 18 May 2020 14:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="soFNPho3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgEROaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 10:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROaA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 10:30:00 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4DEC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:29:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 63so8175563oto.8
        for <git@vger.kernel.org>; Mon, 18 May 2020 07:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7FmEzSBZgMwFAdz3VEaHTxhcIiMQspjJoYD2WgnK3Ps=;
        b=soFNPho3LYOG2rRYA5GGaNz7owlmaZM6L2wK1tAxSbRx8ebC8tiPTfnPlr3zpSGNnU
         +7hPC7Bc9T7kqZPJRdrhbN4BCXGf+yyzaX/m5bGQSsoymt6r0hvip7YZrzlTHufYWPdl
         u/z/JmHy7CVK+G9CX8X6Y6zuPD4BPcwSkXyGJsvnREhh/+O/ZgGAPXw5BZH6uxn/Y8/d
         PMfenR5rSDuzb/9WnkZFjCnUXWjoVEiqg22AN5BgMv4XXbOV7xenu0+xdq0XWUcTkj1G
         opsrUpxt/EwR7k85LMmmiYysYXRSApp1SqTK++I7XnG5sO52l8NrD2mK+Zehu99YTnUu
         JLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7FmEzSBZgMwFAdz3VEaHTxhcIiMQspjJoYD2WgnK3Ps=;
        b=EZIc3Q7z40UcZMmN517P5/SrlmR3JrmyWQyXtJXAXrdeDfePuzA/9WczcmqFBqnxGq
         q6e4XLDaZ28VhtmVusVZ4qoBZR3zjCMcPqXKHASSL1mS7oQJzyjDijd9VFWUCNopZfdj
         ngbPzcSVgGMWaIecYRXHoJkcpTbCB+GJNrqLw3qzbIKqoO499aX0I1H6wBRNDcQTkGGH
         NnmXy72zHldNFPzPD7AeySk+VTT4VORPd+sdrHNYC94+AjS3xqe/G8yXESCUKkP21a5b
         INB85Mc04u78F80pXRbE9c35WkIuMLDVCTdkzoRbv/kphH+E4d72HTCJvSbdPoyrgaFt
         LQ8A==
X-Gm-Message-State: AOAM533IN521Jaz4h+FyrunVe5dPybmzf8z5zmq/ml1f7ra16P+Envr7
        bNQ/4smhk3PH4KP0awWgAJFOh71OhDB/x6o9pAzMkA==
X-Google-Smtp-Source: ABdhPJxIkQ45hDDqJgkBMftLKb1fn45sl9gEFa2wKqw7KWR7rueI92M2HjOBBa+UKmzt3Wm1V7qRotSueDA2uWVTdng=
X-Received: by 2002:a05:6830:1d99:: with SMTP id y25mr11113425oti.235.1589812198632;
 Mon, 18 May 2020 07:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200518100356.29292-1-dtucker@dtucker.net> <20200518141311.GC1980@danh.dev>
In-Reply-To: <20200518141311.GC1980@danh.dev>
From:   Darren Tucker <dtucker@dtucker.net>
Date:   Tue, 19 May 2020 00:29:47 +1000
Message-ID: <CALDDTe13_utn7E+QF1AgndX_6nPph=Gr1hesLwfV8e9LwgUPOQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] Redirect grep's stderr top null too.
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 19 May 2020 at 00:13, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <c=
ongdanhqx@gmail.com> wrote:
>
> Hi Darren,
>
> On 2020-05-18 20:03:50+1000, Darren Tucker <dtucker@dtucker.net> wrote:
> > Prevents pollution of configure output on platforms that don't have
> > grep -a.
>
> From your other's patch, I think you're in HP-UX,

Yes (it's not my usual platform but I had occasion to test something
on it so revived an old system).

> would you mind also run the test.
>
> Since t5703 also uses "grep -a"

It fails with:
$ ./t5703-upload-pack-ref-in-want.sh
sed: There are too many commands for the s/\n// function.
ok 1 - setup repository
sed: There are too many commands for the s/\n// function.
not ok 2 - config controls ref-in-want advertisement
#
#               test-tool serve-v2 --advertise-capabilities >out &&
#               ! grep -a ref-in-want out &&
#
#               git config uploadpack.allowRefInWant false &&
#               test-tool serve-v2 --advertise-capabilities >out &&
#               ! grep -a ref-in-want out &&
#
#               git config uploadpack.allowRefInWant true &&
#               test-tool serve-v2 --advertise-capabilities >out &&
#               grep -a ref-in-want out
#
sed: There are too many commands for the s/\n// function.
ok 3 - invalid want-ref line
sed: There are too many commands for the s/\n// function.
ok 4 - basic want-ref
sed: There are too many commands for the s/\n// function.
ok 5 - multiple want-ref lines
sed: There are too many commands for the s/\n// function.
ok 6 - mix want and want-ref
sed: There are too many commands for the s/\n// function.
ok 7 - want-ref with ref we already have commit for
sed: There are too many commands for the s/\n// function.
FATAL: Unexpected exit with code 0

If I use gnu sed and native grep, only #2 fails as above.  If I use
gnu grep and gnu sed it passes with a warning from (gnu) printf:
$ ./t5703-upload-pack-ref-in-want.sh
printf: \3: invalid escape
ok 1 - setup repository
ok 2 - config controls ref-in-want advertisement
ok 3 - invalid want-ref line
ok 4 - basic want-ref
ok 5 - multiple want-ref lines
ok 6 - mix want and want-ref
ok 7 - want-ref with ref we already have commit for
ok 8 - setup repos for fetching with ref-in-want tests
ok 9 - fetching with exact OID
ok 10 - fetching multiple refs
ok 11 - fetching ref and exact OID
ok 12 - fetching with wildcard that does not match any refs
ok 13 - fetching with wildcard that matches multiple refs
# passed all 13 test(s)
# SKIP skipping test, git built without http support
1..13

Maybe you want AC_PROG_GREP?  That picks the gnu grep in /usr/local,
but plumbing it in is more involved.

--=20
Darren Tucker (dtucker at dtucker.net)
GPG key 11EAA6FA / A86E 3E07 5B19 5880 E860  37F4 9357 ECEF 11EA A6FA (new)
    Good judgement comes with experience. Unfortunately, the experience
usually comes from bad judgement.
