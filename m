Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43049C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125A36162A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhEKWIb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 18:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKWIa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 18:08:30 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA67EC061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 15:07:22 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id k25so20481896oic.4
        for <git@vger.kernel.org>; Tue, 11 May 2021 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=eJsczQ/r8z6bVlfOCSYcQM+/7WF3LbpPFxTa73V7Qkc=;
        b=nW29I+SksT7Q2iOaV8X65xssL6Gb6cIjsQ37RHeDjU5lCSxs8YWqVZC17H0FAOO4Un
         DUFDKUv21tSq6Fi1CrPd9Wbvxo1a168N6aj8voJU/BD2pkmPsGP7aHwGS2Rko+1dIbfE
         QLMEvbF6bBpn8rr6y5/P7z1/pe+P1PP+vMA4a3e5c5Aj9HzA/zqD4d0QQ6U//OUlMk+y
         2JJk0BuxvVK7Q1bzOSkIpXjafgUKyigKg6a35u2bRYd4aMTIngtQnkbqLoRB/SSM5HDm
         zQziyL0J4cFT+tWhsNTmh+YjKAlpJE8gOi27odWLIAPUXE9J7prNrDESSPIKEK878sF/
         wrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=eJsczQ/r8z6bVlfOCSYcQM+/7WF3LbpPFxTa73V7Qkc=;
        b=KewHUHlG0gHe7LXJ4jnn6PFtqLMDGbgq7uycKBRU7mtPo/EgQOhgRzNuit9bIoBG17
         Oogfe1zINhgxENaggXvPnlY9VKL7F9lNgTHN711T3L7Q8yTTMluRHcA9YfEkfQ2F9ij6
         ixTWURDqjYZbNfvRKdA9UA8lObJRyOJQMlBZzsYu6wz3BUjvv3cKFIJt7MORX+DXlFA1
         LRoxm+nqYXvAWvZfGJ7xH0gAZKFXVpKV8HCLPRmBJuzmLMT8AS9DztOzu809V4d+CqGR
         ilr/rrhVKUyQ23et+CPqA/amfu3Xp06eJMFHcYLd+fqJ+8GSNkxuT8EkTWlX1jiMQtsF
         vfYw==
X-Gm-Message-State: AOAM53322NJ2eJYJZaMFnr5lz5kX7vhHb7OZ00Lo2eRZmccFPQzNystQ
        2vLUrX94UssNcyGA9dGmdpTa/haVyJutrw==
X-Google-Smtp-Source: ABdhPJwCbxSWSNaWSRLN6tKxeS7QP06IGN2VLx/eFu33ihxpRKESD8S1ZgXZU3l962HXrOsh0XK9NA==
X-Received: by 2002:aca:3b88:: with SMTP id i130mr23398716oia.26.1620770842232;
        Tue, 11 May 2021 15:07:22 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id y191sm2586835oia.50.2021.05.11.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 15:07:21 -0700 (PDT)
Date:   Tue, 11 May 2021 17:07:19 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Gregory Anders <greg@gpanders.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <609b0017a323b_6064920888@natae.notmuch>
In-Reply-To: <YJrsTu5YtGNpQvZh@gpanders.com>
References: <20210511191510.25888-1-greg@gpanders.com>
 <609ae32e3b9f_60649208e0@natae.notmuch>
 <YJrsTu5YtGNpQvZh@gpanders.com>
Subject: Re: [PATCH v3] git-send-email: use ! to indicate relative path to
 command
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gregory Anders wrote:
> On Tue, 11 May 2021 15:03 -0500, Felipe Contreras wrote:
> >Is there any particular reason why we are checking for an absolute 
> >path?
> 
> The existing behavior is that the value of smtpServer is a hostname of a 
> server, *unless* it is an absolute path in which case it is interpreted 
> as a program to use to send the mail (e.g. a sendmail alternative or 
> msmtp).

I see. That's unfortunate.

It would be much better to have sendemail.program, and then we wouldn't
needto deal with these workarounds.

-- 
Felipe Contreras
