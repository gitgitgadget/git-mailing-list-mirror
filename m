Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CEAC34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 09:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CB824671
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 09:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=loskot-net.20150623.gappssmtp.com header.i=@loskot-net.20150623.gappssmtp.com header.b="CHDz11Y8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgBSJKX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:10:23 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49]:38019 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgBSJKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 04:10:22 -0500
Received: by mail-ed1-f49.google.com with SMTP id p23so28266136edr.5
        for <git@vger.kernel.org>; Wed, 19 Feb 2020 01:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=loskot-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IC2ioDQuWcd4XU95pXitGdOV9VMrPEiLalG2cvCCUUc=;
        b=CHDz11Y89t0mLjCRnLZAkjiQfXm1hpMxoUeR0ZkTkkCkxULsHiuwJRa+UrlqST0AKi
         o0Evvjq8PwW//D//6UNzzTVaK35Ulx+Aku0wYYUHZF1KLc+sF8G/CXfsP/AZPp2uJgtA
         ye/LjTOeyqh2yDHHLpDWbTuwVS4pAvfhkGpvT1IXzt9WxRp8GQL0LQgDd7gcTKY0PTbn
         +eaLIJ1t5xIgoVp3XIkz2SIKXFpfd7V+b2/4OSpMnruxCHGw163/kF1dHpyLsx1OcLjJ
         q3YvmZGJRmqDEWWa83iqc72iIoEFmTs4BqlrEmQU+Tik9SKdswxS4QzM6Mh+Fe32wFoc
         pUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IC2ioDQuWcd4XU95pXitGdOV9VMrPEiLalG2cvCCUUc=;
        b=aSNiPrePlqM10Yf/kFDZvheKOjLilfXZzJajr9TY9bSc48BYnp/ZUwh7iEweJUdwkA
         ZrGlXpA+Hd+QGIeF3YurdMfHJFXti3JRYiveKbzAKWCe3jbU/gTpnJSIxvxl4qwpmV/8
         3tI9tG50emFKzHSEXCxyQ48LIj7QoaCDP0ehKoPeHPZaB0aRu6kLYRQNpeX7wpm9loaF
         ZYsEE6g0FENcEMoaWU/SqYeSSYAlR75WW6T0Paudo8/UmLbWx/L+SaqMtTwNpxFzpqaw
         7zo8J/PRnDaiHmqDQ/xnIpVvqklOQQt7UU8hB0AMRcBM/TwGFRvzuuIAPH7t9S/QwlRp
         ou6Q==
X-Gm-Message-State: APjAAAUPjLwP0Y0FKuzU0nk3Yw8an/TMbWc2c/V3Zg+hUlson3n/h/jO
        Wpv7vbwGoTbmrrj8gdiyk4uJqBt6KHz2IHahI9ddui5jBek1mw==
X-Google-Smtp-Source: APXvYqwUOYp3ZcPYU+P/QJD1ba5JEGmtXBbWaYROXYlflGuY+rRrGWt2DfFSK5IymUVlSCufqTvmxqn0KN08UiHWg7c=
X-Received: by 2002:a17:906:ce3c:: with SMTP id sd28mr23416045ejb.251.1582103420807;
 Wed, 19 Feb 2020 01:10:20 -0800 (PST)
MIME-Version: 1.0
References: <e773b01e-8fcf-8b8f-50d7-4b0f922895f7@gmail.com> <547b53e1-f3e1-5f12-5ffc-f35b95e25867@gmail.com>
In-Reply-To: <547b53e1-f3e1-5f12-5ffc-f35b95e25867@gmail.com>
From:   Mateusz Loskot <mateusz@loskot.net>
Date:   Wed, 19 Feb 2020 10:11:10 +0100
Message-ID: <CABUeae-hC+Q_giRDpOmSQJP0Ty9iWQwGVC3kb7FqMdUeGA2AcQ@mail.gmail.com>
Subject: Re: Committing with one single option
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Feb 2020 at 09:57, Alberto Salvia Novella
<es20490446e@gmail.com> wrote:
>
> Doing:
> git add --all; git commit -m ${summary}; git push
>
> is so common that it would likely benefit from being composed into a
> single option,

That's what aliases are for, no?

http://blog.vogella.com/2010/12/25/git-alias-add-commit/

> something like:
> git set ${summary}

IMO, set makes an unclear and ambiguous name.

Best regards,
-- 
Mateusz Loskot, http://mateusz.loskot.net
