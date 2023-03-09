Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907CFC678D5
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 00:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjCIAFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 19:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCIAF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 19:05:28 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1E7C8883
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 16:03:55 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id fr5-20020a17090ae2c500b0023af8a036d2so3445308pjb.5
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 16:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678320178;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IT9DipPbYucQXIkTz4m0iTESm81P9H229mus9qFDrAM=;
        b=oOUGxvgDt+LgCeAzFZpWT8SAVpQ7HeSfDDsh2k/Xwjd7z6csaTDm5FrqCtwGLl8xLH
         QT7nRURHzxvTXzSi5FlQOdel5ZJWQ7oGn2o6gC+Ws3IAsfV6DPD7Vu59tyvqNQIVmV5A
         CgRoj2PZizTMvZhdwlUiW7vLd8NsR807Wi4d7pL/gv5dqYcO92yxBuAdcc4qHdDjgbnU
         V3lXrcY/2+60sSmfSV1pufZ1e2gS6iKvq8y6w2HCt4dHLCllevFJD3fC/Dc5qiTAm+Q0
         WOTwCHQKXBmoB134yZABEMVkDryTrX+ZW0BHIYX4iCQ+WJYae+8S3qYQ+5ICIQVqSWpz
         oStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678320178;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IT9DipPbYucQXIkTz4m0iTESm81P9H229mus9qFDrAM=;
        b=Z6UgvJqh8YW8y9jpAT5uCdt3MXueNw/Ex6jhuZL7xM+UltteZafoG5lgqKxJK52W+S
         tyXcD9OAJchTd+4VCPQbFw8Plhd5d6q2ytINQT/ozsb9BriRVGVYQFJMPM1+WlRN9Sjx
         LBJSz/5z2EtvDi3uOxW82vP9AVcEQzZ0esTq96cBXpm4fOrtNyANpk0DSaTxoULeZDMD
         SWj6ugmlK4qy5PVcGYT7aLbrfgMhxE2LDo+GcTduLgqXSogYNF/pVUXjmvR/Uml52pq5
         T/IHTpprLpqIkr4yjUpD5CTlcrwdeW91Ez0si0ycrEqYQ8QS+rnYDmGGhqF1BM9KHMTn
         lpzg==
X-Gm-Message-State: AO0yUKVoT61rQfqytu/tMoYc80Y9dZHyUTxE82Wu/Z+ksLvfd7/V6H0A
        0/zmAu5uvaj14ximk2Syc4c=
X-Google-Smtp-Source: AK7set/83k62w61EGYUGi6TI2JX6JLjXMWlikI7OODDU3v7wrlCbvOCAJXO/fD62DyHDfonaGFQd8w==
X-Received: by 2002:a17:902:f54b:b0:19c:f16c:5cb4 with SMTP id h11-20020a170902f54b00b0019cf16c5cb4mr26023266plf.1.1678320178265;
        Wed, 08 Mar 2023 16:02:58 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x1-20020a63db41000000b00502f9fba637sm9506300pgi.68.2023.03.08.16.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 16:02:57 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jay Asbury <vbjay.net@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Writing to err vs std
References: <CAH74SFS3hFzYzJ6eb2YenJh4-Pf_VBzVTo8axnEtHDyaJUB-jw@mail.gmail.com>
Date:   Wed, 08 Mar 2023 16:02:57 -0800
In-Reply-To: <CAH74SFS3hFzYzJ6eb2YenJh4-Pf_VBzVTo8axnEtHDyaJUB-jw@mail.gmail.com>
        (Jay Asbury's message of "Wed, 8 Mar 2023 18:53:51 -0500")
Message-ID: <xmqq7cvqrdu6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jay Asbury <vbjay.net@gmail.com> writes:

> I see things like git fetch and other processing writing details to
> stderr and not std.

I assume you meant "not to standard output".  

As a rule of thumb, the core of the output, the information the
end-user asked for, is sent to the standard output, whether it is
machine parseable or otherwise.  And other stuff like progress
meter, warning and advice messages, are sent to the standard error.

This should be documented already in Documentation/CodingGuidelines
for our developers.  Do you think it needs to be documented for
end-users?  I suspect that rather than such "principle", they are
more interested in seeing what message can be squelched with --quiet
and what can be piped to downstream with "git foo |" on case-by-case
basis individually.



