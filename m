Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96273C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 01:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D5E611AD
	for <git@archiver.kernel.org>; Thu, 20 May 2021 01:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhETBUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 21:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhETBUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 21:20:41 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B43C061574
        for <git@vger.kernel.org>; Wed, 19 May 2021 18:19:21 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso13472033otn.3
        for <git@vger.kernel.org>; Wed, 19 May 2021 18:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KsCvEmWT8GvxoFyE52UqgWQqn2vGrp3s/PRgcNeUybI=;
        b=DDglEt2KCEpTRleQ8mtoFqDmuIvV7tb18HbboS7ZQKLH1Pws6ajwPHUQKMyZik7N/E
         EMW1Rb/eOuVKqTMKvaC0gUJHPCLtaNFFTta1NsR1BsUDm9q2EnHuUwOoR1v/J8yU9voE
         1T6HVkl15fQBfrR8Oar/I3k22tD36cRn8Rc3k/nXnK9n25s5jMcHwHh1hmyWVKfCecfn
         6umXOCqz7YxCbX6GtALWz9nxiDaqThtn2+Cmap/FfUKLboC0I33/afhVTfOErKUMY53L
         kVJqAm8Y/eJPNF9gYakcnHwUYqdh+Hb1rQnMI4WnVKWlF0EqJJ5m7NPIzzTqKr2AwY/N
         o6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KsCvEmWT8GvxoFyE52UqgWQqn2vGrp3s/PRgcNeUybI=;
        b=j2ACUd+ygW0ZpZsL06KmdghClB8m2HBmk8O1eRNYR2PRDGIw8+Atd4YpLQCe9kyrJB
         wQ3MzYMXI2KjmQu0S+pAJzM+P9bT1/9YNvEHjLVYO4kohzOC50xZjSJljp2fKsgajCnD
         1SbttR/0NVjdCzHikKJTCMjnANRAwBHn4i6vU00Om1TVMspVfB1tSrRH4IpYGw3j1TTk
         sU/od3tqjWpFmkre7QB9PyVDckc94Oz32U2ufkvUfMuCgk0WV520bZPmK0xB9IdNP6Jg
         8wHJsK0zIj6bp4vQCzpXFCVbs/13TCgM1s5CDgUIDx6k/PfFBO5vtV9tP1iinHuJ5QNa
         vnGQ==
X-Gm-Message-State: AOAM531+YJC1ryiClxfrQTCB3UrMZHiG93nXNO06zY8yIhRTbe8ysvDV
        YSnj2O5V7Eb2rp7Ouk1BQag=
X-Google-Smtp-Source: ABdhPJxUpk0q67JaiyC2t+bQYezSPOSxNCTR1JshlXAgB0lm5CUn9YsbN91l1AyIqX5ebrh5ZStMYg==
X-Received: by 2002:a9d:7997:: with SMTP id h23mr1967326otm.366.1621473560387;
        Wed, 19 May 2021 18:19:20 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id y44sm245732ooi.0.2021.05.19.18.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 18:19:19 -0700 (PDT)
Date:   Wed, 19 May 2021 20:19:18 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Message-ID: <60a5b9165fd5b_1e27520848@natae.notmuch>
In-Reply-To: <xmqqeee2w7ov.fsf@gitster.g>
References: <YKWggLGDhTOY+lcy@google.com>
 <xmqqeee2w7ov.fsf@gitster.g>
Subject: Re: RFC: error codes on exit
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

> > In order to do this, I would like to annotate "exit" events with a
> > classification of the error.
> 
> We already have BUG() for e. and die() for everything else, and
> "everything else" may be overly broad for your purpose.

BUG() and die() can call fatal().

> I am sympathetic to the cause and I agree that introducing a
> finer-grained classification might be a solution.  I however am not
> sure how we can enforce developers to apply such a manually assigned
> "error code" cosistently.

You don't enforce developers to do this--just like you don't enforce
developers to use advice() instead of fprintf(stderr, )... You nudge
them in that direction, and eventually it becomes a habit.

Developers in other languages and stacks have no problem with this
granularity. They do this in languages like JavaScript, C++, Ruby and
Python regularlly. And developers dealing with HTTP have no trouble with
error codes (like 200, 400, and 404).

-- 
Felipe Contreras
