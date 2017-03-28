Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EBA1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 21:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932576AbdC1VZC (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 17:25:02 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33119 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932394AbdC1VZB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 17:25:01 -0400
Received: by mail-pg0-f42.google.com with SMTP id n5so76524849pgh.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kUubMOJR7rr37TczfsSDT2y+int24vg3IMIcItG0YDI=;
        b=dhbvOh2dhEypK1S9/o8guOkTcpe3jaUsw5L87f2oIJQmdmt8DMxeKCj/AuiRozelmo
         RuKeEmENT0rtg2lcjSdu5tLKZ9X8DVr2uhJoNLQ65ktqc5O/yArspoVGr+fwFNSaXUBH
         K3j+Vc47Mxv56Y7PN973w27ueCUWH0zVsVk+4URKqAXPBdF+oi9KUeJ7owDi/iPj0F8b
         FephKWUw3j8CBhUkSU9V24xxAM5YxOR6mpn9z6bmn6s/2lVP4xbbGWy13a08+qwQXEZM
         nqBPLf+uCpzOAysOUpo9UVECJ2vhHWZNeb5bgyC0pFhVPmWRuRGU4orSBTtsUkF45GMa
         nB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kUubMOJR7rr37TczfsSDT2y+int24vg3IMIcItG0YDI=;
        b=KxjbFzMgKQyJYq96ZabYjcAsTWMP8D/22gfmoVSKEbsPySoEqwX6IChIclBv6vTZTw
         KKi+idPyWoyDsrPMu9086ESGwZ8AN6TMeH3If8w3vBHUavuP2cbLRE92fvOO6gSTObmh
         UpNr1jq5Nm8JR/LNSL94tbROIXWasxql7FX0z4QcTeObORue9fsam1j9pAFLzxe7914d
         LKpGQKwhY1NcELKxZCe2cEzmrHt/2Lol5OVwYzyim5unU8q3qX8lMaHxl5ehbxLDDL/U
         ul3IHTdVOd/iojCQJ2qC6n0t7Cr4j0TrLjv0vdCOeEi0yHyRCdYqKTTH+iSq4vXXHvAX
         zWag==
X-Gm-Message-State: AFeK/H3kSNx24tZ2lGAxgBUqtyRBkGljz9707u0/eXUGDZBsl/IIM26bcC5TssFC6oD3bUTr9S2IQekYNCr9H2+1
X-Received: by 10.98.48.196 with SMTP id w187mr34006618pfw.179.1490736262352;
 Tue, 28 Mar 2017 14:24:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 28 Mar 2017 14:24:21 -0700 (PDT)
In-Reply-To: <CAP8UFD3pXSf+RhysULQyd2kdKSkBWdoKs+L6GPQ4jwpoeP+yOA@mail.gmail.com>
References: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de> <CAP8UFD3pXSf+RhysULQyd2kdKSkBWdoKs+L6GPQ4jwpoeP+yOA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Mar 2017 14:24:21 -0700
Message-ID: <CAGZ79kaFhrEFFfmBUUM7rc9RftS3cKLcvJe5M8jkwKL=bdemgQ@mail.gmail.com>
Subject: Re: [PATCH] strbuf: support long paths w/o read rights in
 strbuf_getcwd() on FreeBSD
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 2:15 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Sun, Mar 26, 2017 at 3:43 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> FreeBSD implements getcwd(3) as a syscall, but falls back to a version
>> based on readdir(3) if it fails for some reason.  The latter requires
>> permissions to read and execute path components, while the former does
>> not.  That means that if our buffer is too small and we're missing
>> rights we could get EACCES, but we may succeed with a bigger buffer.
>>
>> Keep retrying if getcwd(3) indicates lack of permissions until our
>> buffer can fit PATH_MAX bytes, as that's the maximum supported by the
>> syscall on FreeBSD anyway.  This way we do what we can to be able to
>> benefit from the syscall, but we also won't loop forever if there is a
>> real permission issue.
>
> Sorry to be late and maybe I missed something obvious, but the above
> and the patch seem complex to me compared with something like:
>
> diff --git a/strbuf.c b/strbuf.c
> index ace58e7367..25eadcbedc 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -441,7 +441,7 @@ int strbuf_readlink(struct strbuf *sb, const char
> *path, size_t hint)
>  int strbuf_getcwd(struct strbuf *sb)
>  {
>         size_t oldalloc =3D sb->alloc;
> -       size_t guessed_len =3D 128;
> +       size_t guessed_len =3D PATH_MAX > 128 ? PATH_MAX : 128;
>
>         for (;; guessed_len *=3D 2) {
>                 strbuf_grow(sb, guessed_len);

From f22a76e911 (strbuf: add strbuf_getcwd(), 2014-07-28):
    Because it doesn't use a fixed-size buffer it supports
    arbitrarily long paths, provided the platform's getcwd() does as well.
    At least on Linux and FreeBSD it handles paths longer than PATH_MAX
    just fine.

So with your patch, we'd still see the original issue for paths > PATH_MAX
IIUC.

Thanks,
Stefan
