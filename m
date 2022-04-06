Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B64C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 20:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiDFUEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiDFUDl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 16:03:41 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DB9AC905
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 10:46:35 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id k25so3835536iok.8
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UOhXaUCUVoF7NJinK2S9zT3FS2Ki7RfX/kZCVhQkQgY=;
        b=JowuxaHMZZdyCq7nuDmBWML/qJ4zeucyBulXpWEktd4sykciy7ACrGvFzNCQgakq5P
         9f6/sz210oGp8PbU6DjMNKj0gonuOwashSTRfSB1Dx+7+cUpZ5XAydIcl7dfiFbdwv+a
         5GTaIqNTEn1j/HIlL7JunB0PIUonc2mMfOIPAfg0Nqda/kQSSOYa0Mon47eKquYzHXt9
         ERUsLNMXyzoDTNOnFm0lpSDNFx5wK7oaPzxDxjUCIfs1Jvt1/V7ARO85vuflkVTdC0+H
         ivUj3LySDnxDSLXG/kzEcl8Hn4azjWwickAyJKSHkibzHnVg+SP4/uG34SiuM17Le8iU
         cYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UOhXaUCUVoF7NJinK2S9zT3FS2Ki7RfX/kZCVhQkQgY=;
        b=6GKFzNMC+C8eUEyBU+yOXElMJBx00fJFKs1jQvZkwKIe46B6sR2f2ZRAp4C/GRvebh
         Exz2fQ0uZa7zwWV7Iv+KzThOGnCs7gWLP76VQff425yA5UY6QQQl++d730tgdWals0Bn
         dyrITYF9I5pV/yQaZKBD7JXLdra+Z+l+xx2cOJCtZ+lYaAsM8r71uKH5TKR3Lq+ffvsH
         +nWj7yWBzcAn3KIotFV2VYbmmTb+McYf2Gg0hcp09YvfQ8Fzk1insuyIqNg8tC+1eQsT
         39M/Ur5pzVqrZhGkajtDk5UJBammzj5YZ26zzdpgON5RCun9WTS7O5irJGh6Ojld005O
         cpHQ==
X-Gm-Message-State: AOAM5302g2+kYILO2BXUmIjkc8Lhrj89B0vpBlHSWzHhYjw9mkW+RoMo
        oFQLD6qfTGDNgpq+7A5X7fzhPAi7Rkju+XNSVu2Jil76osU=
X-Google-Smtp-Source: ABdhPJw715QMsx4U1RxBqA0t3B2lyCWHXx8GvrqpOoWKktyX5BPrXV+QLtEX2TsiVjXK4yxfB4/TrQ09M4ID1ACgplA=
X-Received: by 2002:a5d:9955:0:b0:63d:a8e7:538d with SMTP id
 v21-20020a5d9955000000b0063da8e7538dmr4755057ios.207.1649267194198; Wed, 06
 Apr 2022 10:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220405165806.842520-1-eantoranz@gmail.com> <220406.86wng2eh0l.gmgdl@evledraar.gmail.com>
 <xmqq7d82yx06.fsf@gitster.g>
In-Reply-To: <xmqq7d82yx06.fsf@gitster.g>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 6 Apr 2022 19:46:22 +0200
Message-ID: <CAOc6etZkOTs-XonAxEWPt8SepUALg8yprtKA_6=H1AbjOtmwCw@mail.gmail.com>
Subject: Re: [PATCH v3] blame: report correct number of lines in progress when
 using ranges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        whydoubt@gmail.com, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 6, 2022 at 6:52 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>
> I do not think that is something we want to test, or distract the
> developers by forcing them to update the skipping hardcoded in the
> test.
>
> Is it easy to grab the last progress message from the output?  What
> we care, and have cared in the past, is that we expect that the 100%
> is paired with the number of lines in the ranges, and the progress
> actually ends at 100% (we had different bugs that did not bring the
> meter to 100% at the end), so checking that end result would be what
> matters most, e.g.
>
>     tr '\015' '\012' output | tail -n 1
>
> or something?
>

Let me send the next version of the patch that will hopefully get the best
of all the ideas we have been throwing around.
