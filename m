Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960FDC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FFA5613F9
	for <git@archiver.kernel.org>; Wed, 12 May 2021 12:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhELMZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 08:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhELMZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 08:25:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958ACC0613ED
        for <git@vger.kernel.org>; Wed, 12 May 2021 05:24:17 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id z4so773643pgb.9
        for <git@vger.kernel.org>; Wed, 12 May 2021 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iLBiGh5WbY1hrYRO2Ij2EV3jdB7+mWcw2VUT8tCvfz8=;
        b=r/edBSkjhMYrrXaHles2CxyzBLA3xllktKOG1v0qj6S71XElFfKP9fG1YrJEhwfLI5
         ZSFvXHorxvIKBa0bdBtSSQNnR0EPVjxSFXiUw06dD5T+xKrK2aKgDTUUvt0rdEmEOZUP
         ER1Ym5DqlANtR5mooG7kNKNGtrwn0inDbFpVKm2QDZBZteqrgn7QuYLzJpxcttleR0wF
         wTgrFzNBubFEJvA5zN70XiyvI/UAN6eZkEpeDb25Z2/kRRRU6nnTIBC/sK4xg/o391cP
         w28TSxzb20ziG3M/QqTdkwCqLqvD4xrDT8I5JiucPMlRGaYPw7i8rjzGx02Po4zDReVf
         xIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iLBiGh5WbY1hrYRO2Ij2EV3jdB7+mWcw2VUT8tCvfz8=;
        b=bh5PBSbhxOwowccFygQDJK5K8SGRSxrEruOw4TTBCuraxkb+r2653pSbWKYhu5WEmK
         bG/m7ZBmZlRgwBcRqgSBW24JgdnJynpcXZKq+ANy7j40Cjw6R4LfG7CYo9WOQseylZ9P
         RK+7MLnbi5XrDWQI+km9OIW1oX6SfatjMrNyPIkXrh+vraNfSh92f5KQueijWOLQm6FT
         BRNXwaHoU2mtbxqpb8D1V+MKjwiRGfSwK/6bUeZOsd4XFCc+oB7DyXAvlmMa4TXvEZLs
         CPJ0+zVlprtSdIepc8okuYSZ2SxEN28gnZgYd2/tWUoDJMYVXtfNX42koPEaTgWICC2L
         FWTw==
X-Gm-Message-State: AOAM533MyuhVck0U0JCcVh95Jjv1zxPJ5Js6yBLWedpl0Ac3r8UiblAW
        y/v63dJbQq8d1rJCQWptty0=
X-Google-Smtp-Source: ABdhPJxsmOzKoCEadW13/q+26gDHlaMo5bXPfxYnAhqjAKw1FYG4DU8LcZvv+WLX+k34uvQzg/q59w==
X-Received: by 2002:a63:ed4d:: with SMTP id m13mr35862007pgk.433.1620822257111;
        Wed, 12 May 2021 05:24:17 -0700 (PDT)
Received: from localhost ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id 3sm11451451pfn.11.2021.05.12.05.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 05:24:16 -0700 (PDT)
Date:   Wed, 12 May 2021 19:24:14 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Dave Huseby <dwh@linuxprogrammer.org>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 2/3] SubmittingPatches: replace discussion of Travis with
 GitHub Actions
Message-ID: <YJvI7hCoaIXkkDyl@danh.dev>
References: <cover-0.3-0000000000-20210512T084137Z-avarab@gmail.com>
 <patch-2.3-7add00cc87-20210512T084137Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-2.3-7add00cc87-20210512T084137Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-05-12 10:45:01+0200, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>  If a branch did not pass all test cases then it is marked with a red
> -cross.  In that case you can click on the failing Travis CI job and
> -scroll all the way down in the log.  Find the line "<-- Click here to see
> -detailed test output!" and click on the triangle next to the log line
> -number to expand the detailed test output.  Here is such a failing
> -example: https://travis-ci.org/git/git/jobs/122676187
> -
> -Fix the problem and push your fix to your Git fork.  This will trigger
> -a new Travis CI build to ensure all tests pass.
> +cross. In that case you can click on the failing job and navigate to
> +"ci/run-build-and-tests.sh" and/or "ci/print-test-failures.sh". You
> +can also download "Artifacts" which are tarred (or zipped) archives
> +with test data relevant for debugging.
> +
> +Then fix the problem and push your fix to your Github fork. This will

Nit: s/Github/GitHub/

It's the brand.

-- 
Danh
