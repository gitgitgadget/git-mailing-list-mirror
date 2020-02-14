Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417BCC3B1A1
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 16:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EA2F2082F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 16:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/W15jgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393957AbgBNQt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:49:29 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:39437 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405289AbgBNQt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 11:49:28 -0500
Received: by mail-qk1-f176.google.com with SMTP id w15so9812072qkf.6
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 08:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7asV2dB4zg9aevB7POhVCtqjX9ttrQKM1URVr3w7jWo=;
        b=k/W15jgnDn2IUgSZ5Qhi2Wtwvu8pBcaQA+EytoPEVObRYvp7pcpAgMPPdwzyxL9BLe
         vXorOQQnEsT4iIkPi3MLATSarbkxHJVeeILH/J/qabcY/5Fn5iC0zXwAZScXkfMGE9d1
         2k7pXtrIB3CM1ajkKx5FoKhH6TydxF2I7IkTd9pN8i2W9pnnozdM43g8OP01ptpcV6b6
         lJfh5ErvHVkdP+4/DY6Z3IX3K6mrwuGt9j2gHRZEj4csSBo07nUF9frqD5vWcwWBcvYD
         DZQq/7f6SYjBgOnzotsy91CYcG/J9Bu/2JbOnexxVP1GtpgN3NLXzQA4JBxWDdFPmBR7
         Z5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=7asV2dB4zg9aevB7POhVCtqjX9ttrQKM1URVr3w7jWo=;
        b=DmrcJwT+vpJES8/JZqME6dVYIfQX7QJ3rRDRzs8QhXMMxBycd33O/9nNEtUh6Bew94
         hgD4fTIS5NCVgiXJjWQJIsVPmAkk3bahPUpbg6kty6JCy59cLwo9amPnC5waZDZpQUnG
         BVi22qJh+zFMtuKpvSJEwwwI8fVROl/KvGqEAH7zjy+vgOdx3McVRoFAkJkSu2a6oegt
         Cpowulf3C1WOhPtzP3RsWbP+hZMWu29fHbfy6nWgnZTtoj8QaTWpR8Znkt7eoTj2Hiyr
         OOHJ5Z90WV9dZoEhdTDf8HQQSiMEpINVV0Gdrzl1XAatiWEEgb15gHOhdXKRYzpBC4as
         beOQ==
X-Gm-Message-State: APjAAAWZWgfSVR/cB5WlZlchccHibJo2pz4i4GmOnojgi1eQFovn0ag8
        A9Fc8oAtwO13Syf+sVv9EF+yd6gZ
X-Google-Smtp-Source: APXvYqyoIVmDQLzQLP+/lzSpZAo46fzGWVYfl8vl61WTm9DI0afdFXBcglyRAdWZafbANETrsPPkfA==
X-Received: by 2002:a37:e55:: with SMTP id 82mr3537943qko.370.1581698967182;
        Fri, 14 Feb 2020 08:49:27 -0800 (PST)
Received: from [100.95.28.84] ([204.48.92.84])
        by smtp.gmail.com with ESMTPSA id x131sm190112qka.1.2020.02.14.08.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 08:49:26 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: How to force configure script to use curl ?
From:   Philippe Blain <levraiphilippeblain@gmail.com>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <20200214061714.GA605125@coredump.intra.peff.net>
Date:   Fri, 14 Feb 2020 11:49:25 -0500
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF7D86BC-9EF7-4333-A786-2EC7DCF72C74@gmail.com>
References: <A0910AA2-D24B-4DF5-8D39-8E2D8B56955B@gmail.com> <20200214061714.GA605125@coredump.intra.peff.net>
To:     Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

Thanks for a very sensible suggestion!

Philippe.=20

> Le 14 f=C3=A9vr. 2020 =C3=A0 01:17, Jeff King <peff@peff.net> a =C3=A9crit=
 :
>=20
>> On Wed, Feb 12, 2020 at 05:08:06PM -0500, Philippe Blain wrote:
>>=20
>> Is there a way to force the configure script to error out if it does
>> not find curl (or any one of the optional dependencies that I happen
>> to need for my build?)
>=20
> I don't think so. It would probably be possible for configure.ac to
> behave this way. Looking at the code, I think GIT_PARSE_WITH would have
> to record the affirmative for "--with" instead of just canceling a
> previous "--without", and then the part that does curl auto-detection
> would need to complain if it doesn't find curl at that point.
>=20
> But our use of autoconf is not very extensive, and in fact most
> developers do not use it at all. If you know you want curl, you're
> better off just overriding it explicitly with the Makefile knob:
>=20
>  make NO_CURL=3D
>=20
> or:
>=20
>  echo NO_CURL=3D >>config.mak
>  make
>=20
> Either of those will override the NO_CURL setting done by the configure
> script (you can see the full list of knobs set by configure in
> config.mak.autogen).
>=20
> -Peff
