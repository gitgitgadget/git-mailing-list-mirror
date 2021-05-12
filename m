Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1042EC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69776192A
	for <git@archiver.kernel.org>; Wed, 12 May 2021 01:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhELBKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 21:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhELBKA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 21:10:00 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB31C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 18:08:52 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso19140521otb.13
        for <git@vger.kernel.org>; Tue, 11 May 2021 18:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Uzg6/m/iG2lqXDKp2hP0B6YkpN3RAZMdjK8Sa5kB0Xo=;
        b=k5wMkZWn3RuexQmGKmJYZjXa113fmlz2py/4eRoo9CeWB1vcX6fm/aDUa+6WXdDQ0v
         ni7jDIAt56k3PHaySz02ITnFl6v/sUJQcCY0SRC3GBP7BcRimE7KhGyoyM7mJUZhM1je
         oFT71IhgGMrBYeMge73enhtY2eSDesHNuCgFL04oKinhqpyieeqdT7y91/hCL5xcf3AU
         fBbZOhVKQ8nBQADMeXEE6FoFyKhIGOFMlUEUca9f1VuiE4iiEGlrdB+cPG3OkWq7QKmK
         eBQzLGQmfWoeIvraTqjv+mp8r6yIRMjlEqulWYLFur7aAkZo80vanm6FHQgsGGOaAnfM
         CLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Uzg6/m/iG2lqXDKp2hP0B6YkpN3RAZMdjK8Sa5kB0Xo=;
        b=Q/1/7mGDGYjs+dqYwqBCecOgjBijgT8EeMqgWcmnfVaOWfcDQAnJP7eTegKZCgegSr
         ZieGaygMLgmLJCO+tUIkm5C+QDO1Zy2wa+MqtbMldKalZrebJuzplIWeep94K4XvIXY4
         O5sOXvcQ1h2ooc6T6sA5dpPifHc3WvtO8Vpy8aZjpwR6T1oEMeusXm8mrh/XWwLyM5t3
         SdlN4Fb9xsTFoq4GLmgLHyms59xSbmT2w+I1EIkm486+2LpBiX6Bn2Rdj50GTKFEyT79
         d7kRkbvPRW1U+PA6SdAUa/PFq93Yd9QlnfHQ6eNpD/3OowR/BJh3QZw2l5xKnAXFMf2A
         8GBw==
X-Gm-Message-State: AOAM531Keutc5xGD3g5qqN1witM3pUWV3DZldd7Mi+kHBF27GVDw2zqx
        7vBUI1YFCDEfgIULJnQSGls=
X-Google-Smtp-Source: ABdhPJxFvFShJmKVRS6BnoEFy4SfU7c3KE4OWRCGfb8Jogwa/R/+6AmY3cjccjlxpxHno+5fTnTY9Q==
X-Received: by 2002:a9d:5a5:: with SMTP id 34mr29080613otd.353.1620781732370;
        Tue, 11 May 2021 18:08:52 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id s24sm3694747ooh.28.2021.05.11.18.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 18:08:51 -0700 (PDT)
Date:   Tue, 11 May 2021 20:08:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Gregory Anders <greg@gpanders.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <609b2aa26aa5b_678ff20893@natae.notmuch>
In-Reply-To: <YJslulEQFvPkyo/R@coredump.intra.peff.net>
References: <20210511191510.25888-1-greg@gpanders.com>
 <609ae32e3b9f_60649208e0@natae.notmuch>
 <YJrsTu5YtGNpQvZh@gpanders.com>
 <609b0017a323b_6064920888@natae.notmuch>
 <YJsDAnHcnro6Gfk4@gpanders.com>
 <YJslulEQFvPkyo/R@coredump.intra.peff.net>
Subject: Re: [PATCH v3] git-send-email: use ! to indicate relative path to
 command
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, May 11, 2021 at 04:19:46PM -0600, Gregory Anders wrote:
> > Frankly I agree. Should I modify my patch to add this new option instead of
> > modifying the behavior of smtpServer? Obviously the smtpServer option would
> > need to preserve its current behavior for backward compatibility.
> 
> Yeah, that was mentioned in the thread I linked earlier. I think it
> would be a fine solution, too. It would probably make sense for it to
> use the shell, as suggested elsewhere, and to call it "smtp-command" for
> consistency with other parts of Git (I'm thinking particularly of
> GIT_SSH versus GIT_SSH_COMMAND, where the latter was introduced to fix
> the defect that the former could not provide any arguments).

But it would be "smtpserver-command", and I don't think that the best
naming, because it doesn't necessarily have anything to do with SMTP, or
a server.

I think simply sendemail.command is perfectly fine.

-- 
Felipe Contreras
