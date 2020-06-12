Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4947C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 16:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F5120835
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 16:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTTOHXZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgFLQvT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLQvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 12:51:19 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129DBC03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 09:51:18 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id b10so3451974uaf.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bWzZT8ukEJGWr4msZlU+xUcgrEBLuKx+CPVy6kScDNY=;
        b=KTTOHXZjpxb8Km1wvkZP0GSyxrRUuEZ0NFSmt24Fs+JX9zg7pMBqgy6YQ5znUy4T8C
         UF3bzXkF15y08q8bSEig0G2lNz6AIaeCyMcy8p6JfC2nVxqBzCzXepgFi4CGQ/9Eut5x
         jOQmQF38SCZsf1+nod+uTHHmmwGIAwUV4iGWpFeE0j08SV61b/hZiZSQersWsC17eQkH
         SYDz7j/yquTSCXKReRi3nvROImYgkyZA3BUed6Zxhxw2kOXxcgB47b58feimiLY02run
         te/+QNjEW8mOS+oOyxEcbZ0m13UqYfl24tc5nSRpQfEjLslCP0qFMWkkMh04ho+q5ILp
         tIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bWzZT8ukEJGWr4msZlU+xUcgrEBLuKx+CPVy6kScDNY=;
        b=JDyTFUDPJgKL7vUFI5q7728BGDNfsUEL0vJ3A8oYRX5ZCOMm4tplYh2B39poo0P6D8
         EgUpPNDKOHuTF/iigjy9NYHIyOdn1lhXRkI/y4QiQJDyhznuS4jHCrWT/fVDVtcgiOAG
         WWwsbWohzMjqk8xCp+1rp7gKO1RiWx3ydDoqVZFZHa4V8VimgDHkiGE8drWA7lY/Jxqf
         INwqGBmKzrSsAD5uoSzPB1RSHttkqrVMl/nmEkAkC2xst42QOxgI7KKh3avVBKSiZYOj
         bb80fzR3DVFhfHoScxHpbQdi+GT/B4j4BVoaaMzjinatj3OoQKy2F+auj9Q5QCqEjy6F
         Hh6g==
X-Gm-Message-State: AOAM531qoZ6j/dxuQ2nauQi18m/VOVOcM79YtO8yYtecC2Epeo8A8jdn
        ob+oU16T07XQ/zSr0o/TjxI=
X-Google-Smtp-Source: ABdhPJwG0XcLkw+StnEOOSOQbKh4sbCdw94wLnHsOP02oALd2006XgI91oW5I63mCNPfqhgGNT7Zcw==
X-Received: by 2002:ab0:b0d:: with SMTP id b13mr10917989uak.70.1591980676201;
        Fri, 12 Jun 2020 09:51:16 -0700 (PDT)
Received: from localhost (25.173.196.35.bc.googleusercontent.com. [35.196.173.25])
        by smtp.gmail.com with ESMTPSA id b7sm898373vsc.13.2020.06.12.09.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 09:51:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for new repositories
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
        <be09ffbb-4e38-5b67-54da-0b60d5e2d8c3@gmail.com>
        <nycvar.QRO.7.76.6.2006121308030.56@tvgsbejvaqbjf.bet>
Date:   Fri, 12 Jun 2020 09:51:14 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2006121308030.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 12 Jun 2020 13:55:50 +0200 (CEST)")
Message-ID: <xmqqlfks2pod.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I added a _brief_ extension to the context to the first commit's commit
> message. However, I do not want to go into details here because _this_
> patch series is only about empowering users to change their default main
> branch name.

Sensible.

And I do not think the planned follow-up work to rename 'master' to
something else needs to be defended with lengthy history lessons.

Sufficiently large part of the user population are unhappy with the
use of the word 'master' as the default name of the primary branch
in a newly created repository, and the mere fact that we are aware
of that is good enough justification to move _away_ from 'master'.
In other words, we do not have to explain why 'master' was bad, as
it does not have to be bad for everybody to be replaced.

But you need to defend that the new word you picked is something
everybody is happy with.  That is much harder ;-).
