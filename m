Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDED1C77B60
	for <git@archiver.kernel.org>; Fri, 28 Apr 2023 18:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346341AbjD1Sst (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Apr 2023 14:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjD1Ssp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2023 14:48:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE331FDC
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:48:44 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso310361b3a.0
        for <git@vger.kernel.org>; Fri, 28 Apr 2023 11:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682707724; x=1685299724;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WQOypuvKNleO+PTszIyDb9rN9LxdaH1Fk4DGG6MrH80=;
        b=HSjy61u150A+wzEUmEJu4CZBQDLuna8KW9PmZurYtUEOIfJ0UI2WgvlFwXDRUAxQ+i
         T0xXjx7NX/Piwbk7cRSK2lRbBk5YrRxJ11jUfwyYwjA4iNQs3LKTfthVOZnebmkreKVR
         PIJ6Jt1aOtq8DEei4QfUp11uyyEy8+rkJyzyiGgZk5QGzUYgZCherUaOHtIvoTqs0Y62
         /a7RLtaTfkPEN/gstk8G4WytSEdTgyHEbpADfo/vDaKHJYfSUbAG1qVnlUHKX9Pr/6d8
         l9zq4ZEp7qrr5WD9DGIWYSvaTCi0C9yqhLaxXDZuHm43gcZg8GaVxg1B65f/nhDFtZRV
         ydPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682707724; x=1685299724;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WQOypuvKNleO+PTszIyDb9rN9LxdaH1Fk4DGG6MrH80=;
        b=NPNkWUz3SOfkWTliOjfKyfNjk7QZb6vpKT0HN+xozYYo6CtQOlA5hw+4Y3M1+moIJQ
         Nx+xLPLSgLEyqaPPkuOVIGzhxguV8AvQahhTSZslHcbTc5EQu076jGMtZ9Z22hPpty0S
         u3woZZClhv7XMD3xCGOljdcconBIUXZ1mZ5VO4bzceY2/l+JS3nioZ3jdE07TQC7K2TB
         xjjiVGfXbRH+68Aevr4tX51iHCaWtYjpWJfL6Tkwo4MW9bFP0RCEuJRZSl1+x6bSn7P9
         /Mg4n08aDpgfTVbJXCuKNaxoouXs8ZxGzl12epTsZUQvaojw3kbdI0sj44FERKdGzWkL
         CViQ==
X-Gm-Message-State: AC+VfDzzHLjIwnyS5rBgoV7/BEP+OfOXeOTofJmO9q/d+qAplwuLE996
        7nksWG6jauFoBqTk8GC8RZ6oQz0z3Bw=
X-Google-Smtp-Source: ACHHUZ7J+WtiPV80yM0P3xRiBzE0ESIRuVjQv2bQJoPIgSKO+knf2gxCWQsp4rF1kWWeqWtluJIGWg==
X-Received: by 2002:a05:6a00:248c:b0:623:c117:f20e with SMTP id c12-20020a056a00248c00b00623c117f20emr9890109pfv.19.1682707724045;
        Fri, 28 Apr 2023 11:48:44 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id n41-20020a056a000d6900b005e0699464e3sm15474542pfv.206.2023.04.28.11.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 11:48:43 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     --cc=avarab@gmail.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 0/1] push: introduce '--heads' option
References: <xmqqilippgp2.fsf@gitster.g>
        <20230428095955.66292-1-tenglong.tl@alibaba-inc.com>
Date:   Fri, 28 Apr 2023 11:48:43 -0700
In-Reply-To: <20230428095955.66292-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Fri, 28 Apr 2023 17:59:55 +0800")
Message-ID: <xmqq7ctvetbo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> ZheNing Hu mentioned me that could use "OPT_ALIAS" instead, it seems
> like could be better than OPT_BIT in this scenario. If so, are problems
> that may arise from interactions shielded? If not, I'm willing to add
> extra test about it (some relevant advice if possible).

The intent of ALIAS is to just add an extra option visible at the UI
level that behaves exactly the same as the other one at the code
level, so the codepath that is prepared to deal with one can handle
the other one without any extra effort.  In fact, after the option
parsing is finished, the rest of the code should not even be able to
tell which one, the original or the alias, was used on the command
line.

And in this case, you'd want a new "push all branches" option that
behaves exactly like existing "--all", and possibly you may over
time want to deprecate the latter.  All the code to ensure how
"--all" should interact with other options should be working fine
(or if there is a bug, that needs to be corrected whether we would
add this alias or not).

Sounds like a very good plan to me.

Thanks.

