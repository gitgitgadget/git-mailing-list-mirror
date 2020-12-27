Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF2DC433DB
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 18:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A072242A
	for <git@archiver.kernel.org>; Sun, 27 Dec 2020 18:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgL0SsK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Dec 2020 13:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgL0SsK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Dec 2020 13:48:10 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F193CC061794
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 10:47:29 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id l200so9546528oig.9
        for <git@vger.kernel.org>; Sun, 27 Dec 2020 10:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=q7YmqOm2Zpf2TqRWDlp79xgRbxeuecpyB0nIqjNIdUk=;
        b=rWfNYgwLFBp0LaUud0JFVaSemI1gxWwaEXGRS8e9b2qf2oRNOz7zThBR1cePql+jhB
         qeBzAN2h0xg9b0kaPYE62rkLub9aRwQMBBk7yOHTcCtqlID3+6xnQyFwCKzrBio6KIds
         HhwvPWDtImE8X/vJsS9/7y583tdKAQazdiO+YnS2TMP4tDpSr6kkv54Qody9vVlYEEIO
         XvsQ4ev/Zo9g0c43q5p74GBwRJBz8Ctkr9MDISrEZJHYjLP93mrq5FxRZXGazGYCwrP4
         OBBkEDyLtXLEe/fAgEk2XALgcs/KQIHtlRx1N1r5o9jJe69JOn7iW/NPqi9V8dN/u02V
         5UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=q7YmqOm2Zpf2TqRWDlp79xgRbxeuecpyB0nIqjNIdUk=;
        b=VEQNdoP3+wLie+KQQP9Bpr9KVZyMDbhBFvVA6Jt5Zs7A7uxW2v76rjLze/JYknSqMt
         tKqSo0cCsSCU+bqUWGoe8Q37FRXwOIi2a3f+R1vvhi4yCpicRoXPlLf0gcSWDfnyhwWP
         SJrAvTPAAUEoJNEcAktKLwT/zOt3ofWmNK5fAwgKsCgQ9Bdz+1QvNjDzDltkcyQimMGX
         vKXnIvd2YQX8o8rpXtKZ/qZ5Fi8lP61qoRV38MB1Jeqr9oPYubRQ7HhI6o3MJmkHWNLv
         j5JkbVtpTgj8KyF6nLgL9P3Z5xN4sZlbDzMs3qUhKunBE9diPaJjkxbHZ1vIqRTbqtXm
         qCLQ==
X-Gm-Message-State: AOAM530RzI3Ingcuu+EiZDWSjiiKhf64b+SfOOs7+S7A3r+Sf3DJIFD6
        XKi5bOPeO04AxXETU+8TcRBl4qFbx3BwOw==
X-Google-Smtp-Source: ABdhPJzUHjGuHwK7SGfaSB4xSG8XwT60uEpMHF2DmXdtdEOso6XotmUOh1DXFn3ZLaUunFbPkjOJxQ==
X-Received: by 2002:aca:3192:: with SMTP id x140mr10235981oix.172.1609094849129;
        Sun, 27 Dec 2020 10:47:29 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id w4sm8721564otj.3.2020.12.27.10.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 10:47:28 -0800 (PST)
Date:   Sun, 27 Dec 2020 12:47:27 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        David Aguilar <davvid@gmail.com>, Seth House <seth@eseth.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        git@sfconservancy.org
Message-ID: <5fe8d6bf1a1a3_f1c220893@natae.notmuch>
In-Reply-To: <xmqq5z4nqey1.fsf@gitster.c.googlers.com>
References: <5fdc18a91c402_f2faf20837@natae.notmuch>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
 <CAJDDKr6LrBMyfdp5Tutp29W9OqhbW4ffcP5e6PD8ruyxk3rQxA@mail.gmail.com>
 <5fe134eeaec71_11498208f9@natae.notmuch>
 <20201222150124.mnfcyofm4qyvvj4n@yadavpratyush.com>
 <5fe2c64bd3790_17f6720897@natae.notmuch>
 <xmqq5z4tdsiz.fsf@gitster.c.googlers.com>
 <5fe2d89c212e8_18dc12083e@natae.notmuch>
 <xmqqzh248sy0.fsf@gitster.c.googlers.com>
 <5fe36790793ae_2354120839@natae.notmuch>
 <87r1ngufmf.fsf@evledraar.gmail.com>
 <5fe424d0528a2_7855a208d3@natae.notmuch>
 <87o8ijv124.fsf@evledraar.gmail.com>
 <5fe4b33dbc028_19c920834@natae.notmuch>
 <xmqqtusa24oa.fsf@gitster.c.googlers.com>
 <5fe8c464bc190_e22d2086a@natae.notmuch>
 <xmqq5z4nqey1.fsf@gitster.c.googlers.com>
Subject: Re: Nobody is THE one making contribution
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> But if you are arguing that when you write "Signed-off-by:" your
> >> sign-off can mean something other than what DCO says it means,
> >
> > The DCO has clause (d), which clearly states the developer must agree
> > that a record of his/her contribution is maintained indefinitely (and
> > that includes his/her sign off).
> 
> Yes.  Are you saying that you are OK with (a)-(c) but not (d)?

I'm saying if the author of the patch states "I don't agree with a
record of my contribution being maintained indefinitely with my sign
off", then clause (d) isn't met.

-- 
Felipe Contreras
