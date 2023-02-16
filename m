Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94103C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 16:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBPQJ5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 11:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjBPQJw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 11:09:52 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BC14C6DC
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 08:09:51 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v23so2530927plo.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 08:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XvvaXtX22vV7BlKeTMPrW1h/oh7w0vmT7/POf4t1Eg=;
        b=S5RMjgsDP1eSkOCfeKa3g1doKCc8ICdRFYQPSCf52C/q4ox9dMnHozq/bvH8YNhDxF
         SfvyqxKs8BpXoBu6XplxNEfNxe1izWJBcxV6hSWfklywNSm6bWGVr6b2SctLnJthBAq+
         gJiWGb6xSrgoPTzKr9PeAZyPoXsY10C+EdaGKBFPJHJDBp7Sy7ijSMYU8u5XwINNAVAw
         iX3zGjrtEilRCWU7/jTvv4yonbr04NYsNdDDFHuM/NE47piXsapskqvtfdbjc/CdRcPZ
         1+N1C1uogDpfbf8TLxUgw6Jve1Qfuu3uhPMWpnOotIrKMRL1xjhC6//0g0qHOap/no5T
         PyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5XvvaXtX22vV7BlKeTMPrW1h/oh7w0vmT7/POf4t1Eg=;
        b=l9s6s7pwZx5OTiDWL/gvRyfXzvs8Vsd2n0daxl2+xo0RhP1ATDhdPyX+PS/j9Skvl1
         QVq9245A2JeDM1yHmXLoqQHzzsvrZlytWb8I/3MuHBNIlabuLaJ+VZVKGYHtl9kispye
         8jFNfJi6hBaF3/Y/0wbJ1/5vejKPe34XLDuSxb1ygSwiyO4h+o3RCQMsPUnV3UQsiEAJ
         CIEyWe/8wLbhqNvbEjI3WCOKcTj9b+omjEZghU821hoTkl9wg/XBm2gq3kzUNCfobQ4g
         bNSFP2yniOf/blhew8js/MRnZXUt6YSUuRSfXLzQsjbJLh8zerC40+kN0ye5qe/XuXuc
         pHJQ==
X-Gm-Message-State: AO0yUKXOvqtePxMHr997xm1lyt410LTvnO2ZX5pjWtYnGYtUAbeH6BGS
        1HoNlnGwVgJDqYD9Prur2Zw=
X-Google-Smtp-Source: AK7set+mKDcuBS/FoBVAQ/LeW/wL+XT8S9qYvzTVznwigEeTNzs4IvRWftPgX2LHqWnI5NTrnbASFw==
X-Received: by 2002:a05:6a20:ba9e:b0:c6:bd08:9a4d with SMTP id fb30-20020a056a20ba9e00b000c6bd089a4dmr5057872pzb.20.1676563790935;
        Thu, 16 Feb 2023 08:09:50 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id b12-20020a6567cc000000b004e28be19d1csm1399796pgs.32.2023.02.16.08.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 08:09:50 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, rsbecker@nexbridge.com
Subject: Re: [PATCH] test-genzeros: avoid raw write(2)
References: <000001d94165$3d1cf2f0$b756d8d0$@nexbridge.com>
        <Y+0eIlsIxRr+1RYp@coredump.intra.peff.net>
        <000801d9416e$4bf844b0$e3e8ce10$@nexbridge.com>
        <xmqqwn4iycbt.fsf@gitster.g>
        <Y+05tTHdj2Jzenge@coredump.intra.peff.net>
        <xmqqwn4itmb1.fsf@gitster.g> <xmqqo7putj1t.fsf_-_@gitster.g>
        <Y+2ycMAkVd8rh50q@coredump.intra.peff.net>
Date:   Thu, 16 Feb 2023 08:09:49 -0800
In-Reply-To: <Y+2ycMAkVd8rh50q@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 15 Feb 2023 23:34:56 -0500")
Message-ID: <xmqq8rgxtwvm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>     I ended up avoiding write_or_die() primarily because there is
>>     nothing "Git" about this helper, which is a poor-man's emulation
>>     of "dd if=/dev/zero".  It felt a bit too much to pull cache.h in
>>     as dependency for it.
>
> I don't find it any more "Git" than xwrite() or die_errno(), really, but
> I am quite happy with what you have here.

True.  I view "git-compat-util.h" as "projects, not limited to Git,
would benefit by its help to use POSIX api more sensibly", while
"cache.h" is "things that are about Git".  write_or_die() is certainly
in the former category, but is not available without "cache.h" X-<.
