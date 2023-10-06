Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443E9E81E1B
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 17:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjJFRF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 13:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjJFRF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 13:05:26 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7745DAD
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 10:05:23 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so29100271fa.3
        for <git@vger.kernel.org>; Fri, 06 Oct 2023 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696611921; x=1697216721; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XlOZO7T9g89D56OS6RVVmjuDN50fhrp5jkfVzHH+l48=;
        b=VSUo9ggrn4emCX5WOoGhvRZ487JnVstwY09iZLilYFEWyTJkVLJtG5n8UkfPuC0+nX
         GJiQ5uCiqdF+Y33A3uWM7hBawXh9vlLvEiPGLzUt/e4u20JDQtmilOI07Czt7lgpt+tP
         CHy7ZuIiz+y+4bbDBoBFPk5oa+kRaakjIphUteVI2r8ZpMBuprbZ8cEUSyq5gSXusC1N
         JBAzRi42o+51PDMURPc+9BB2/q+GdlIzAzR1HuLs+BOqhfATmx/eC5eX27OkGzukrVgx
         KkOaMu7A39s3YRzuQWkgX615CrEdD938QPzhYSGdmkL9Wqgw78qWiwjnGuP8FSWLbOPU
         7MJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696611921; x=1697216721;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XlOZO7T9g89D56OS6RVVmjuDN50fhrp5jkfVzHH+l48=;
        b=gO1u/gRd21geoovezj166hb+R43niQiJa4xZgd65aMQjC63CurUOIWRXCUYlwwI6yr
         /xGHyZrZFHqDgSWPbi7uoAVPi/tPmsuqBLRFB61wiajUqT/fj/2gHlnoohRnkcgk5sQM
         57OJ4Dyb1L+XSljWGQ3DOXB1JvxiJGu4GVkQWJ3kMyRv5ctrCBwrhB2e82WK6uYw47dk
         9q0gQ/ECAjhieNzKe1zJccjlpeQjCo9lX0kOaytF7s57OndhWlNjL2uUqGhVafLVpyLN
         JWqyOTmbFHfB2jbN7te4eIWNkpI6m0Vdica7FcjyUWYBP9Co+44BmBQTLPu8NVRAYBs+
         VHLQ==
X-Gm-Message-State: AOJu0YxFQvfOMyreOzSfgdvCPwP312hGeHfew8FrwrRk8qOeQ3OIPTJK
        U3ebeWqdL4tzBXXrW3EoQNADgbDmzfA=
X-Google-Smtp-Source: AGHT+IGaZk2mAkUBuGs9Sq8uLakyPdUp2vskDcOptYz0NvpB5E9nNbekENlPWEEfIic99jCjO7GZWg==
X-Received: by 2002:a05:6512:b23:b0:503:1913:ed8e with SMTP id w35-20020a0565120b2300b005031913ed8emr7724770lfu.61.1696611921102;
        Fri, 06 Oct 2023 10:05:21 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u10-20020ac248aa000000b005041a71237asm366418lfg.111.2023.10.06.10.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 10:05:20 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] diff-merges: introduce '--dd' option
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20231004214558.210339-1-sorganov@gmail.com>
        <20231004214558.210339-3-sorganov@gmail.com>
        <xmqqr0m8eoaq.fsf@gitster.g>
Date:   Fri, 06 Oct 2023 20:05:20 +0300
In-Reply-To: <xmqqr0m8eoaq.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        05 Oct 2023 14:45:33 -0700")
Message-ID: <87v8bjr8a7.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> This option provides a shortcut to request diff with respect to first
>> parent for any kind of commit, universally. It's implemented as pure
>> synonym for "--diff-merges=first-parent --patch".
>
> That explains what the patch does, but it does not tell us why it is
> useful [*].
>
>> NOTE: originally proposed as '-d', and renamed to '--dd' due to Junio
>> request to keep "short-and-sweet" '-d' reserved for other uses.
>
> The note is not grammatical, and more importantly, readers of "git
> log" 6 months down the road would not care.  I'd rather not see it
> in the proposed log message.  It is suitable material to place after
> the three-dash line, or in the cover letter for the iteration.

OK, will get rid of it.

Thanks,
-- Sergey Organov
