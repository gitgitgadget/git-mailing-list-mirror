Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E853FC61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 05:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjBNFkE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 00:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBNFkC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 00:40:02 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CB0BBBB
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 21:40:02 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id x31so9557691pgl.6
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 21:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ox7x+0fC0noEcFy3sxaDVRKrgL9g2Es0EpspkSf/erY=;
        b=ZowBT3Fwe6BXbKs4iiEJKlW/31/X7d7wzkNoQcizrrRbILsTYlrrFYxNJhbScbAPiN
         qJV/T2sbvw3XvsdeEt37paCpZsRrbPsTlXXMVcOgstqVmuYOKeO8DYBYhcZupXosDNxK
         r5Znp7rE6BIUaB/QozmKsdG2crH6oODjMe/YXoQXK5W8czP6KdFzJuM7mpjiSAyhX1MQ
         DltCXIZyYzyxIFfkRPyV6PKYEU3cJOC8cUJMZONbmEuGMxEB+zcIJiywzQR2COGqCHim
         j7liQsl6BNkZGzbrg3NW/W7hyQZEJlzfbktjubrOFqd6IdyQ+fYY3QcRGPoyYcIbzgUj
         0E2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ox7x+0fC0noEcFy3sxaDVRKrgL9g2Es0EpspkSf/erY=;
        b=YQ5ZsskvHJ+F6cPpkjc/IDjfp95649KRJm2bg4JqXePe6b3kOjy0IVIfFPAzaVLbAq
         9+p9I+A/90EEz/gfebxqgP4TGPeiirHm1vw4nlkJv6eBT/UnbdcUVVoaHB6iQulMLwaX
         lBbCW1dn7GiUv7ofC8mrbZAWCR6PtQRcXLlAwStpGudNed9J89ReHKfgD6o5dobbUwAN
         EaJZvdi6YsBW/OpIDCtGROgowTinTZCmVIL75Xp5yz30nP93G3OGrzmaW1OJktVQCluY
         nqUzl86pAC7UJDPc1CD4CRPzCZzAkB6NbX3iqaqb3LJSiwRkVZa9aI7tuzqP7zEdV6mC
         +MwA==
X-Gm-Message-State: AO0yUKWko4ePGKP7DSIgz//sSQmnNutrGfKzo/KpO9ndsXgt9LfrAGBL
        Q+Qo2MMh2zAeXNrvxHJAnln4QK8eGXw=
X-Google-Smtp-Source: AK7set8yD61dJbZWDEeYDPUBDfMjQ8ahyANdi9tuULZf9Osq+85QSZj+vr3l3K2ZYohLJK4/h8sWMQ==
X-Received: by 2002:aa7:9477:0:b0:5a8:b98a:49fb with SMTP id t23-20020aa79477000000b005a8b98a49fbmr915915pfq.17.1676353201452;
        Mon, 13 Feb 2023 21:40:01 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id j3-20020aa78dc3000000b0058d9730ede0sm8842792pfr.210.2023.02.13.21.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:40:00 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
        <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net>
        <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
        <Y+rmNvfjIA/u81em@coredump.intra.peff.net>
        <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
        <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
Date:   Mon, 13 Feb 2023 21:40:00 -0800
In-Reply-To: <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 14 Feb 2023 00:33:21 -0500")
Message-ID: <xmqq7cwk955b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> sscanf() seems to be the culprit. If I set LANG, then I get the same
> result as you get:
>
>   $ LANG=zh-CN.UTF-8 git symbolic-ref --short HEAD
>   warning: strlen(refname) = 39
>   warning: strlen(short_name) = 28
>   测试-加-增加-加-增加

Well, that's ... criminal.

I wonder if LANG=$ANY_VALID_ONE.UTF-8 would work the same way.
