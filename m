Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DFBC4167B
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 15:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiK2PaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 10:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbiK2PaE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 10:30:04 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7C913CED
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 07:30:03 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q71so13327141pgq.8
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8N6v5u62AinvVCqHfASnyhWrEsJPbTy2v2dHWH41P8=;
        b=ReLJxHKX3CaINUf/5E1N/AOxiAUM+mPf7Ejig2vIcxlgt4Gvt4AR1Tx7EvXiOjOYYO
         /UyQqrObXO9jbaEclVwaN1tNGkpejMV/7zuhrmYcsMjD0nU/dMZABe4F8soWi2fx8VUU
         13f6WG4b6oWq6hyUlPMsKQ2C/jL+/bbB7DmwjcOzehNFOk7PaM6chdm0B4Sm4Tbh6/LF
         9gEZEzlCRaWNyasda15fYttL59rU8vZI9/08XfTbdZk48xMoo6LiZALqHvVtahSMFFHO
         YNj9CYExLSeo0TeFZUnrZxr9/1xdaT5nFuABQjBgGiSAiFKTPNO18Q4dgw+vf2uiY9hs
         Gv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z8N6v5u62AinvVCqHfASnyhWrEsJPbTy2v2dHWH41P8=;
        b=tbfXgLZylj86UqtRXkn2Ds4BrJKR0/N65tvzIlZeQadP+swaay15uClsK8JlFmbMEY
         yHBM0SkMdsOOCSPW9U1+ud4EMoLu+g/y21iv4VATO2cpFEzbdPPANI10txalXniuJRwm
         yYKSZAugKF3/5lHHEFtukfZ/grSi/8KQFhERQkJ2xOzdYKqprfBEC+Sc8VybSvovYKvY
         QlHfzSGNheBk4+11j7B7lww+9si+3aqgcgnH51f+CqELnKCTJKFkdQtpn0tHu1j7JFi9
         MxcpopVH+0nToIO9xZqlrQqUBCPUH+pEehvHh7QvHXF/slBPBN26bWRODcyI5nz6k6cu
         GVqg==
X-Gm-Message-State: ANoB5pm+OlXyO9yeELzXXsBFV1rw+klHGQkEpBAkux8G+DOx1tTvbNvk
        x6w/IhkJJFBLXW4O2wFa4cY=
X-Google-Smtp-Source: AA0mqf4QlAcWuFTZfPgnRtG5nM3TrhFQtJtb3/1WXRidh2MmesiJMDL4jELU/51pxGPoPEvX/T3i3w==
X-Received: by 2002:a63:1a55:0:b0:477:4ba4:c278 with SMTP id a21-20020a631a55000000b004774ba4c278mr33181922pgm.482.1669735803046;
        Tue, 29 Nov 2022 07:30:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id t24-20020a170902b21800b0017f7628cbddsm11055289plr.30.2022.11.29.07.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:30:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] diff-merges: implement log.diffMergesForce config
References: <20221127093721.31012-1-sorganov@gmail.com>
        <20221127093721.31012-4-sorganov@gmail.com>
        <xmqqedtn957j.fsf@gitster.g> <8735a3gmuq.fsf@osv.gnss.ru>
Date:   Wed, 30 Nov 2022 00:30:00 +0900
Message-ID: <xmqqbkop3hjb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> +	if (set_func != NULL) {
>>
>> Please write it like so:
>>
>> 	if (set_func) {
>
> OK, will do.
>
>>
>> I am not reviewing any new feature topic during -rc period (yet),
>> but this triggered CI failure at the tip of 'seen', so.
>
> Thanks! Do we now have tool for auto-check for these issues? I still use
> one from Linux kernel, and it didn't object to this form.

I noticed it when I pushed to GitHub, which ran the CI ;-)

If you have your own fork at GitHub of https://github.com/git/git/, I
think preparing a pull request against it triggers the CI.
