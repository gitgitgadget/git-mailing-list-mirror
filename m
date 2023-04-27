Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560C7C77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 18:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbjD0SYJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 14:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjD0SYH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 14:24:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F8BEA
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:24:06 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso6810748b3a.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682619846; x=1685211846;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8KicV8hMkSEnn0AxSUL4pEweL1ShhLNPiAJCT7ekAE=;
        b=ZJHUJF19BMeSUwtPNb5GNTlJ2+th0AHCQsVqkmIooBEv7i3ze7PhVBUZO64kyym0aN
         VWGvjcNUjQ+T3Z8EpFpPKcE6dJBfQDQe6RbrQW8LwhhFqQY3BGBD3yrFyGJP82LXnrDc
         zxryucXLm3cDBmBn12ioia+ZfJqK1yE1OscVPUNCHuZzxts0uwLqR8G9JAwkRJJj9vHA
         v4RC0SrK9Kytn7rkIXrsbOlD6MDwVCCz/XNyKmfv9zPFZCPIxEp6D+dz9VAjwhJC0AZR
         Jv+2FQjEco0CHzWx9w29olnT9ujJ/4WwiY5tibuNi3H9zWU+6rTeqN31FRfitJJXe2I0
         YHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682619846; x=1685211846;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q8KicV8hMkSEnn0AxSUL4pEweL1ShhLNPiAJCT7ekAE=;
        b=NVpdOUe1EgCH25P3vnlYfCwrhwNUk4WBSEBVoSnN82ivIvdyTMdQRiAUX6jXZt+dqE
         /jJQxVJ2KpTnDrzKR5tzVfhkCgvHsL0BqJA48CsVF68VlJlwUo3ZSR3V9PLktMjiKrnm
         zbKDBwyB5TnN1EbKgcm6iQKiF/NwFK/F5G3+rwnucQ2zkVzt/mLzDBEyEyPNXX833b6M
         iZ9g94sAK6tsDTjGShl30UQ5DRbj2CvB5uL21Mz0yS30w/bZ1Zo0w7nrULYP9v8GNyB4
         2P5fc8ZU7GPT2lCqbprjh8VEs0WZlq0VRNxa30Cg2MsdgCwXU1YuqgIHCXnC7/ruf6Aq
         Y7kw==
X-Gm-Message-State: AC+VfDx9Y5c7H5wsCxnKvUa/WkwMYmr5Jft9Ephoug2v2fuIi5muqUwX
        X9ZxgUpJN44Mdf+y8/vnOVA=
X-Google-Smtp-Source: ACHHUZ4GBt9u4S8rKbJ7wNq8kArBhAWAYO2oBSqtzuxzRVFxvYaLEo0ADZTSYIEjLxbRngUhBRuXzA==
X-Received: by 2002:a05:6a00:234b:b0:63d:254a:3918 with SMTP id j11-20020a056a00234b00b0063d254a3918mr4336298pfj.29.1682619846334;
        Thu, 27 Apr 2023 11:24:06 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id fe5-20020a056a002f0500b0062de9ef6915sm13364073pfb.216.2023.04.27.11.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 11:24:05 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Javier Mora <cousteaulecommandant@gmail.com>, git@vger.kernel.org
Subject: Re: Commit graph not using minimal number of columns
References: <CAH1-q0hReZoDWmXo7St10Dk6uc+6ZUQSxqvu1cJ7w3r7ftR9PQ@mail.gmail.com>
        <xmqq8refy114.fsf@gitster.g>
        <86188f31-f492-d195-d4d5-b0582906621a@github.com>
        <xmqq1qk6vd3v.fsf@gitster.g>
        <eb1c6c62-1081-a9d2-8504-db8bffc6c870@github.com>
        <xmqqwn1ysfo4.fsf@gitster.g>
        <7ec7f7b2-3e7a-afb9-7042-a4375970e8d8@github.com>
Date:   Thu, 27 Apr 2023 11:24:05 -0700
In-Reply-To: <7ec7f7b2-3e7a-afb9-7042-a4375970e8d8@github.com> (Derrick
        Stolee's message of "Thu, 27 Apr 2023 09:02:43 -0400")
Message-ID: <xmqq4jp1kwu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Corrected commit date should be equal to commit date unless there
> is clock skew causing a commit to be older than its parent, (or
> we have a path of commits with equal commit date) so I don't
> anticipate that being helpful in general.

Yes, exactly.  For normal cases it should not matter.

I was wondering if the current --date-order shows commits in an
order that end-users find unnatural in a branchy history with many
commits that have wrong commit dates, and if so, tweaking the
date-order to instead use the corrected commit date may help and if
so how much.

Thanks.


