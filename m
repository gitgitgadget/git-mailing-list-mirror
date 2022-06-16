Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E08C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 22:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378589AbiFPWIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiFPWIq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 18:08:46 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA9D5EDE1
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 15:08:45 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id x9so2448321vsg.13
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 15:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gChw1KbgNzC5bJE31IVJlwSxSLr2fePwXwu5d/5YgsA=;
        b=nMm21djOk5CNYAqVGMJnQMnPVNUEr5piHEkkG7+v9k3HdXH2I1pH/uACfTQ3IQL29z
         ienb99hnS7E/xFOQcKv+ZAPPiE7loO0UqDTRdis3hotSGGdWmr1Iykznrp4SytOYaoQz
         hf+cw+Dy1sCjNTOyugAttHqI3ppD0uKJrtJx6Fn+mqPfqYNvFIm6mBdjo0+XPeQRrCVn
         txmEBfgzHJSsyAnmCKjk61d8BhzHiwMtEogEZPJ4/ffLE3TXy/Ymw8QsxdQemRCIuP5g
         airSgDmxZO1YIDmIxvrb91GXluaVTAHUCIIcaJ1hBywoBQP2m7eyPukA3waMUGoTA9ys
         Ni0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gChw1KbgNzC5bJE31IVJlwSxSLr2fePwXwu5d/5YgsA=;
        b=TvuUG1z2gf59HKjJXza1GfoGAvLmmBQGEcoZZ5vuOTST+Ou8/3n4rxS+o8Wbiqj+Kp
         viQDswWcvlJupx6RVTgT/FO37QqfkCLWjzafMWrMjdp5VnvSx2dyxV4G3UYI9YwJwVfM
         jU1EX1HToSEiknxOo9C+TwzyIqNmqFvcTTyUgKPLxHfnqnC81VoFpnzciGac/yhizkI9
         uJ+1i7JSIu4loTdyyJqyEkFD8haGl2sDTR9lWd0+XkJxaSjGUIH7ogrQQswYSxlSfDiL
         tWLJBt3LsuPdZF0D8XfbNhcuT0O4FuAIjoZnYSTn/SKmAyJ7AVcb0KKJhAg2TU8EAnjM
         EQrw==
X-Gm-Message-State: AJIora+6cR+Ogrclm2jE8qPwZchagbUZ/zeR7L/jwrgWnkVvmj3irnXn
        w60ZKgEEqRB2+rvCZRpznYJAIYcIM68R35PWZukwRFzr
X-Google-Smtp-Source: AGRyM1sHDNigiY9YwEo67gKvEPO5ddhyc9XnP8ihyPyygeHpp59k915KreZLIhV7ARtVivs2vObmswOiANvZa8s/VMA=
X-Received: by 2002:a67:3c1:0:b0:34c:62e3:e5b1 with SMTP id
 184-20020a6703c1000000b0034c62e3e5b1mr3512078vsd.8.1655417324919; Thu, 16 Jun
 2022 15:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
 <20220616205456.19081-3-jacob.e.keller@intel.com> <xmqqpmj8qomp.fsf@gitster.g>
In-Reply-To: <xmqqpmj8qomp.fsf@gitster.g>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 16 Jun 2022 15:08:35 -0700
Message-ID: <CA+P7+xp3FRya7HMR4DVwOQ_WSsFoKbv3z=++YOP0M0hV4Cnwmw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] tests: handle --global directly in test_config/test_unconfig
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 16, 2022 at 2:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
>
> > +             --global)
> > +                     global=yes
>
>                         global=--global
>
> > ...
> > +     git ${config_dir:+-C "$config_dir"} config ${global:+--global} --unset-all "$1"
>
>         git ${config_dir:+-C "$config_dir"} config $global --unset-all "$1"
>
> The other one can use the same trick to make it more concise.
>

Ah, yep, makes sense!

> Thanks.
