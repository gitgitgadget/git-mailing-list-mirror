Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E78C636D7
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 16:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBIQo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 11:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBIQoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 11:44:25 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EF65EA34
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 08:44:24 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id pj3so2653750pjb.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 08:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wrrnHsYB4GhBD5UIypYvdukQd2NNn6YUPs58+QMfik=;
        b=GdpDfaJcYeGRpG0lfH2Shrs5N2etikE0aadwNJ9u0K24hpf0846+NOmiO0VN1ZwJm+
         1xJPGVeNJk941JTvz/fK9MLfBMA2nTUNsAdo++bEi3QLkhzOBIxZXrwNXUkBAeNfq3gR
         vBjY6Y1ukbrX/Nn8+NxPIUdpIR+Q8/7t7zmUYLHiJfhttbQ0XSr+YCkGPzVp8HyGnNbv
         +Zwt8H3Fgz6m/BheIukRNOkV15rGW3pOKZmuIduffUKbLgmN5QphVkJI0KUAZMuPw8CT
         SKmKIYNXsI8kkPEBZGtUReCIwSYJEJHHw+cUICubQCzW6b9ONkGiICDVDusSNr8hH5W/
         Z2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+wrrnHsYB4GhBD5UIypYvdukQd2NNn6YUPs58+QMfik=;
        b=F6mVG2mwrgmdpia/F1WC3KKGxkYGFZMoS66j1NBgnajB9iSvUvj0dLoNojxgEkW6a6
         9v5X94IEunTP96dkYifTEXO03KJIDw0XlJ0iLjNv+ldmPzvenLYxnZNCwvslPkvuVDIN
         KLSIt2ty+MqDUaetY03O0xlDK1J6PdaBIQ/SZi0Jh/WXMoZyUwnxuzhjpR6vB2sNhA70
         8dtMRVYeB7QBYUSUY59mavhI9RZ2CKYwtH4UZN0vFcoYAJl3t75b7cBazK7P9qhGdmhq
         jTPV5wmJ7EHPKhW1sXhMu89gyNbG5jDN+l7MhlBdUXlFlYOzGBMkmbcZDh9d1zExzTVI
         cjZw==
X-Gm-Message-State: AO0yUKVuvXlbZlRTYwXvTurRlCyqpjEDP9eP8bSNDGiABfj2uuG55Gzh
        zQ94w6r25NyESOql6/+3Tnc=
X-Google-Smtp-Source: AK7set8tAPdMPwJRyDJJf4/YBNXDk8bl3SkvtzY1/gHGzCZKGsD63WSyxiI1EjAnZSPVTbbHb1+eFQ==
X-Received: by 2002:a05:6a20:4287:b0:bc:71f2:c998 with SMTP id o7-20020a056a20428700b000bc71f2c998mr15881744pzj.22.1675961063962;
        Thu, 09 Feb 2023 08:44:23 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id jd2-20020a170903260200b0019324fbec59sm1740476plb.41.2023.02.09.08.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 08:44:23 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Max Gautier <max.gautier@redhat.com>, git@vger.kernel.org
Subject: Re: git rev-list fails to verify ssh-signed commits (but git log
 works)
References: <Y+TqEM21o+3TGx6D@coredump.intra.peff.net>
Date:   Thu, 09 Feb 2023 08:44:23 -0800
In-Reply-To: <Y+TqEM21o+3TGx6D@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 9 Feb 2023 07:41:52 -0500")
Message-ID: <xmqqpmaiokk8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'd be more worried about correctness (command "foo" must not parse
> option "bar" because it is plumbing and must use the default). But
> looking over the options, I really don't see anything like that. The one
> I'd expect (or worry most about) is "we do/do not bother to enable
> signatures at all based on config" but I don't think that is the case.
> We default use_format to &gpg_format[0], so there is always a signature
> format defined, even if the config is skipped.

I arrived at the same conclusion after seeing what these
configuration affected.  If some plumbing codepaths should avoid
certain gpg-interface features, I didn't see a good reason for them
to be calling into gpg-interface.c functions (e.g. that would have
meant that "rev-list '--format=%G'" should have errored out with a
"%G is only available in log but not in rev-list which is a
plumbing" error message) and at that point reading configuration
is much lessor problem.

> If the gpg code used git_config_get_string(), etc, then they could just
> access each key on demand (efficiently, from an internal hash table),
> which reduces the risk of "oops, we forgot to initialize the config
> here". It does probably mean restructuring the code a little, though
> (since you'd often have an accessor function to get "foo.bar" rather
> than assuming "foo.bar" was parsed into an enum already, etc). That may
> not be worth the effort (and risk of regression) to convert.

Yup.  Care must be taken not to break "-u <keyid>" that is set via
calling set_signing_key() directly, which assumes that the default
key is already set from the config earlier, but the resulting code
may make it clearer that our rule is "command line first, and then
peek into configuration as a fallback value", if we did such a
conversion.

Thanks.
