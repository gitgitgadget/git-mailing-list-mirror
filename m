Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CCFC433ED
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 18:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44182613F6
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 18:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbhDVSK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 14:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236829AbhDVSK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 14:10:27 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA98EC06174A
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 11:09:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso20520954otl.0
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=AUxxds8LIF41FwgOfQZBYrc/1FKkk2VX330jpjCHqJY=;
        b=bPmS0oVx2EdYOT1307VaQqeiXeY4bxFDg17j7xUVWOWzFx23mOnW26BnJXC0HQUoBm
         8f+g27cEZDw8AiVPlHDEXGz5DNan4+lqMq/x6oEOpA5LVxpfu1s4Kc8sj+DQjDK5gm9D
         3v1dFvOWQ2ATaa0Jq/8RzWtYfYbDHMq+zNlNBcjYnzrQGW9TJUCUq2obz6G1aDZG9Ien
         lxAmcb18z2nV6Y/CvpZ7oHyC6xw+iVSugeMZ4vrKteMymEFS40+t1YB4/s8sMsbPgfDp
         5vDKsDTJp0vPj7B6/UXjb/Ud/zQv0CCNQHRJdb9JeYyqoVbCy0FV7dmNJrIqySz6Najo
         luig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=AUxxds8LIF41FwgOfQZBYrc/1FKkk2VX330jpjCHqJY=;
        b=jqmbxOxgiCWZOzHXdd7yOFmou+soCKvnQx+eD6Xg9/HF5bR4oMEq05rB9y4N02dTgc
         /1LVGWlpRJxT7TmUwIT65opd7arhfPzhvIiQQAa7qiWZDODFgFGndCGyVlj+7zJLdCbO
         iGZS8z1/cU5VdsgnBYY9PXUGdpelIy63TpZ13tTpB8sJmBUAoJfpJDBYjcNpArx9/zwi
         wGDG4CT0nGtGFcihrH5BeI+SV2cmMoj4XSPgDYTFgida25//eCD2hRgYCflT1i25AhbE
         VShbAYGwzLvd9xZqpySyR0Y4pnjM7kGex8A9LyO43rHkCQE6gXSplHDVLpSi653h8E/z
         65Sw==
X-Gm-Message-State: AOAM5330+GlhY9iK7B1RTYvIfm7DKjidbTq7+fRDZZUz6jX9XreYBbYw
        0nF9UtLWQ6BOVQJJDUuKUf0=
X-Google-Smtp-Source: ABdhPJyRfeRfkvjjhxEtlrKfqpvk0yXLSsb/8nZmbESzG5AhWheUUF5a75Q+FBO7eV1ZpMalPGs8jg==
X-Received: by 2002:a05:6830:30b6:: with SMTP id g22mr3813654ots.196.1619114990359;
        Thu, 22 Apr 2021 11:09:50 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id t6sm702044ood.41.2021.04.22.11.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 11:09:49 -0700 (PDT)
Date:   Thu, 22 Apr 2021 13:09:48 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <6081bbec7760c_11019208f5@natae.notmuch>
In-Reply-To: <xmqq8s67m8zi.fsf@gitster.g>
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <patch-01.11-e51c860a65d-20210328T021238Z-avarab@gmail.com>
 <xmqqy2e7on7d.fsf@gitster.g>
 <87zgynmgbk.fsf@evledraar.gmail.com>
 <xmqq8s67m8zi.fsf@gitster.g>
Subject: Re: [PATCH v2 01/10] object.c: stop supporting len == -1 in
 type_from_string_gently()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> I am reasonably sure I and a few others on the list are net
> suppliers of the reviewer bandwidth.  I do not expect all the
> prolific contributors to become net suppliers; after all, designing
> and writing their own stuff is always fun.  But I wish that the most
> prominent contributors in the community to be reviewing others'
> topics and ushering these topics to completion from time to time,
> and I am hoping to see that happen more.

The problem is that the suppliers are a club who often agree on what
code is not ready to be merged, which is most of it, and also agree it's
better to apply the reject hammer.

This club is by definition small.

There's a spectrum of perfectness, and the suppliers are on the far left
side: code has to be perfect, while most of the consumers are on the
right side, or even on the sensible middle side: do not let the perfect
be the enemy of the good.

For the suppliers club good is usually not good enough.

I'm fairly confident most of the consumers would agree the bar on what
constitutes "good enough" is too damn high, so why would they spend time
raising it any higher? They won't.

If anything they are more often going to dissagree with the suppliers
club, in order to increase the likelihood of perfectly good patches to
be merged.

As long as you keep insisting on making the perfect being the enemy of
the good, you are going to ensure the supply is *always* going to be
low.

Cheers.

-- 
Felipe Contreras
