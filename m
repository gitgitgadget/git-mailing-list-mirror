Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB63AC433E1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FC0206F1
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 19:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiQdvFP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbgF2TY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732132AbgF2TYu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 15:24:50 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B6BC061755
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 12:24:50 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z2so13775475qts.5
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 12:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8OgPXznbGmex8WhtwXsniISBf+e2pWATNQmL3lzp86w=;
        b=UiQdvFP4IKrGMxON1VNaCx+oqjbBUJqw+cJRhchTSOKHAJinmXElO92q+ZH6w3Gcgi
         YOgt3MaXnqpSe4xVU5eoSccxqhRB2tYvBGSK405/mNd0Q3CaZTrTH6L+57vc7kuk5Tmb
         TubFZ2k2n8nCCI+vPQ5AURgllW7fo7KGHG8SmEZdEoAW39lKFeDhL0nv2sDxiDqwh74v
         NjAv706akIeQcaocOYV8DhjReUfPYKNUt8DRlCcg0dwDt7WyRJfO35FY1u8ZuM5ibwuG
         JXHU5UejHY4u83NF9m9wDHQwNgI94sqB5J6k/Tk47alVZ31gTHTSCeE2Hx6sOayYbRn+
         T3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8OgPXznbGmex8WhtwXsniISBf+e2pWATNQmL3lzp86w=;
        b=NOcyU+yFP5ITjMYErDJCG6I9ltbR4V3LGQb35R7tgyeMcF+eBDqWy10ujpHsnmOSlr
         ZaZFaESEXAO9CZ3jVglgy8UkSyB+eIChEKf45AFu3e63GRZ9NSctlAmPUNJ8DepSJsTI
         T5HPdpWs7xBOMWqejHnQpI2M+H9azPNDbrPBIFRw98giiWwDzKtMFPIChMg9bO9QIDCu
         TRGLEuJLJXdwIXcexaVXr5kEgQAsivZ0o6RrHr3J5BT4HtGBGLGtJMBhxHLyjfGPFLYc
         Q4Lr/SzA7WoGOTBRep2ogF0GGo7QrRp55y1f67Rtd47PO29CC1k8hsBeq9l5FCQgitLX
         pb+g==
X-Gm-Message-State: AOAM5338Ba0CFooamu699HMwHbkxNYTEjHJhpjOhLvAP6rB8NGh+lEH8
        /od5ZmiwOJs6n4tLkkYvvvE40OdN
X-Google-Smtp-Source: ABdhPJz/jpL4CMzYRqgd9x927+mE18AO7aIiMsWBI/uF/A7t1fzZlaVaZ85WPWlso/v8BR5ml9Hv0Q==
X-Received: by 2002:ac8:a03:: with SMTP id b3mr16808815qti.240.1593458689898;
        Mon, 29 Jun 2020 12:24:49 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id z19sm761982qtz.81.2020.06.29.12.24.48
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 29 Jun 2020 12:24:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Listing changed identifiers with git log/diff
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <e37cdda3b73094f4f1a929dd181a64936a649c48.camel@yandex.ru>
Date:   Mon, 29 Jun 2020 15:24:47 -0400
Cc:     Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3CA60EC2-13E9-4A1A-9A89-066CFF9CA36E@gmail.com>
References: <e37cdda3b73094f4f1a929dd181a64936a649c48.camel@yandex.ru>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Konstantin,

> Le 29 juin 2020 =C3=A0 06:18, Konstantin Kharlamov =
<hi-angel@yandex.ru> a =C3=A9crit :
>=20
> Git is able to recognise functions/variables changed, and even allows =
to see the history of such identifier with `-L` option.
>=20
> But I couldn't find: how does one get a list of such identifiers in =
`git log` or `git diff`? This would be particularly useful for projects =
with odd requirements to have a list of identifiers changed in the =
commit message.
>=20
> FTR, the diff text after the "@@=E2=80=A6@@" does not cut it because =
for example if the diff is at the beginning of the function, then it =
would have a name of the previous function, i.e. not the one modified. =
As a hack, I tried passing an option `-U0`, but that didn't help, for =
one-line identifiers it still shows the name of the prev. identifier.

As far as I'm aware this is a limitation of the diff machinery.
I agree with you that it would be really nice if it could work as you =
describe...

Cheers,

Philippe.=
