Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88A4C77B73
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 00:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjDUAKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Apr 2023 20:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjDUAKq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2023 20:10:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A354233
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 17:10:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-506c04dd879so1698346a12.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2023 17:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682035843; x=1684627843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t46qAudvVPVIOiOaPyfvc1CaSjnePh1BChkLnKUKbXY=;
        b=WEQFZjE3rAhRxe7WJxcuUxLGKvn3uXrFFPRt9x9fb97RmlKsDfLE7dU/Rp0q2qV/WS
         w7u7CcffUocNcxYj0M6+LzmsKGXB7brjHvR6mIM/Ia7y1MeimfEi6vQFk5GyGZ3SgWXZ
         xHB7XNRruUDiG1AM7nsw8wDDzrZf5sPWCkpSJfX8SQNlnlf6JO7b03Q0clOAv/PZpwJO
         h4QKEF4qBjWZtpTVGNuww/3vfM003eJ3e1cMCqrmqRU4PGAmVdL5wTjwtGZoOp4cfi9v
         zs0TkagMLAyq/hHxh9zOyCPbNc7GxcmLsMyoAHX3v2/HeiM8lnvJpQVONALyMszfIbeX
         MDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682035843; x=1684627843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t46qAudvVPVIOiOaPyfvc1CaSjnePh1BChkLnKUKbXY=;
        b=jA99JjOK4f7Ybi0xbnLFlTNfql3+dcbPArliS3RX6i+F1Hbl94ZoB98xDRl1nhMLb6
         OQ8sPrSJRWFV0oHDnzuwnhpRXK611Yrpvd36d5kXfmmyRkJepQdCMkEXjuHbOVWS2SAK
         uDust7sFoVSiiWvZTTwIGDI/1QJX2vf8X/PvLx0r1TQ3ld/Z82Gutmf2tOW7OlB47+rR
         lkGeceBPuAm/9GMQHxEYpdohlZrWXKTW6jCiKzH1kRKt0KTiskHY87RcJSjPduMmk2eE
         EDvo1vOgEpLLB8Ghsh//14VkAopZTbQug8l+dAy4oqMxX7is67os1MI7Vrd9FjmZ1H4h
         6+4w==
X-Gm-Message-State: AAQBX9eHYoAn7Ku21mCa3xUkSh+CqmLBgfH0b6NN0SZiAqO9CGRhhELl
        /1kcL+uqF/r4565VE88OYipwLaRMEI9OUZDYtm+Pfq6ksNQ=
X-Google-Smtp-Source: AKy350b2Ks1CI1zWF/RZJqq0iUcbSR3tkSkJAtPsoZfXrO1SNcOYPDbkVCoQP9JlAz4Y1/7wqLIL44ioh/HJPPdmoF4=
X-Received: by 2002:aa7:da81:0:b0:506:905b:816d with SMTP id
 q1-20020aa7da81000000b00506905b816dmr3135812eds.6.1682035842724; Thu, 20 Apr
 2023 17:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
In-Reply-To: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 20 Apr 2023 17:10:31 -0700
Message-ID: <CAPx1GvdmzDVbiZGeguVVjWe+eAhj6=yG18Rd6wLhZVrnd4jiBg@mail.gmail.com>
Subject: Re: [PATCH] builtin/pack-objects.c: introduce `pack.extraCruftTips`
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 10:35=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
> +Output must contain exactly one hex object ID per line, and nothing
> +else. Objects which cannot be found in the repository are ignored.

The first part sounds good, as a rigid output format can always be
relaxed later if necessary. The second I'm less sure about: should
there perhaps be a --{no-,}missing-objects option to control it?

In particular I'd be a bit concerned if I always wanted to keep object
$H and ran a command that is supposed to keep $H, but it was
silently dropped (accidentally or not) and is then gone.

One could always run `gitt rev-parse` or `git cat-file -t` on the hash
afterward to double check, I suppose...

Chris
