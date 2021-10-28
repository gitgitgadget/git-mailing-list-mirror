Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35330C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 13:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F4D60EBD
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 13:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJ1NTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 09:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhJ1NTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 09:19:44 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EC4C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 06:17:17 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id e64so2958385vke.4
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 06:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=J33uG3mtuQDbjsh570Xwxxr2lCeert9LU4H6DTZDq5U=;
        b=Jq31N2qVS2WZvBivCYDEurJlLA9DA9WpZUT2TxKn5Ye7nqbE7zWkNGBFNnSV/8CL+r
         +R1HgwT/4LO7wiL+dvGrpISaWwwxfJ21paEXREcQng44ds73BuHaOnaA5n1DCTB13gO4
         7QWyyM8b73Wvt39G2Q0M050+GJIXKliBCZtn4WnNaU8QDePwjLm/ZAGYDzN5s3AnQcPY
         QFz186mEq6kN4GtQkp7Z39YFRaYjYQUrAXNMfnNcpigkjTPyZdS67y+Qs8fitkCHYauU
         O2RwBs71adddaosocOnXX7GMi3sbrKfbKlrcTeAZuTqEWpl/VWDlB/wj6VgxVqdfXIci
         z3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=J33uG3mtuQDbjsh570Xwxxr2lCeert9LU4H6DTZDq5U=;
        b=oEx9Gc2vtwRFuRgG/RmlhipjLaGkYBmZtnb4JBBfdn1hRV1jodEgwe6fePMmend9iI
         Ek/dDbNFWRlDE60+vbknclia59LEqzRMVQxOwlbEa1gyXXk3j8+KH14v56HazHTbHVgN
         aYi07hZ0mteJw8LkWxHdf6lZewAza/w+/5D2bEA5Ape3Xmc+S5xrThCI6r+vF3ibVbHU
         L3DHT5cczI7wN2sX1/weneizvzxlHUFbjvQ1+QT0BnrjYnsjtlPtIM1xSvDUQbUMu9Aq
         v8OpqJ5tAQf+WAxuwUfjS/m2JO2JZZL6/SgRH1DmgAulzNPMrBxXfoJmYqe3NFfU65DP
         xsqw==
X-Gm-Message-State: AOAM530ZQHzw7+FD0+Z+zUm+iyRFg2WBop5QTZx8ofWr2wnP1VP+IAKC
        kwY8ickAIFBhG0xGWuNRguccqwWjD4/6o/uKI5FQl/m1Kuh36Q==
X-Google-Smtp-Source: ABdhPJwbatPpJbYF0twYZdgaUS/WAI1cbkTU5Oct/PBJ7TIomfeNqCcOBXPD+xfM6d3sTn6wTp7j9UrYk5PfX/STfLQ=
X-Received: by 2002:a1f:3a47:: with SMTP id h68mr4196239vka.9.1635427036439;
 Thu, 28 Oct 2021 06:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com> <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
In-Reply-To: <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 28 Oct 2021 15:17:04 +0200
Message-ID: <CAFQ2z_P8y_zze6sBz4OQzEuEEC7ygGNk2UqHhu+8QkF=Cqv1xA@mail.gmail.com>
Subject: Re: why git is so slow for a tiny git push?
To:     =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 9, 2021 at 8:06 PM =E7=A8=8B=E6=B4=8B <chengyang@xiaomi.com> wr=
ote:
>
> I have a really big repository which has 9m objects and maybe 300k refs.
> I noticed that git push is really slow for a tiny change. An example show=
s below
>
> 3 objects which is only 7 kb takes 36 seconds to pack-objects (it's the t=
ime after i enable pack.usesparse)
> However if I manually call =E2=80=9Cpack-objects=E2=80=9D with the exactl=
y same objects SHA1. It only take less than 0.005 second
> What is really pass to =E2=80=9Cpack-objects=E2=80=9D when I call =E2=80=
=9Cgit push=E2=80=9D?
>
> I read an article says git will enumerate all "uninteresting objects" to =
determine what to send. but i don't understand, in my case git should only =
enumerate objects between "1a2d494b1b71469eebbd42aeabe1736bfa4b51fa..ddf3b8=
4dca1aa4fe209a218380df1482af0d6b48". It's insane. I have a master server an=
d a slave server serve this repository to my users. And i have a cron job t=
o push every change from master to slave. And i found my master server CPU =
is full all the time because of the push jobs
>
> Is there any solution?

not sure if this is your problem , but we heard reports of bitmaps
slowing down push replication for Gerrit (it looks like you're working
with Android repositories.). See
https://groups.google.com/g/repo-discuss/c/Xb8TbBXUYxw/m/jv5hqZ2PCQAJ
for background and suggestions.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
