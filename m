Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EA1C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 19:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350438AbiFOTNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 15:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358219AbiFOTNa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 15:13:30 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE2525EB1
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 12:13:30 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id b15-20020a170902d50f00b00167501814edso6982383plg.8
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 12:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eebSRw4Dc0yTzFHN9L+3qkEitj3m3+X2FXyr30NSAhQ=;
        b=DkN22cX8iUObd40KHKyuH5ufyFV8IPn+9mqt4QliVo+LWAHwK3sOyeFwW0GkDs+LYI
         3yHeoLqXn3YFEUawRu2LnqRb9N9oE5KJI9NvtxGYZjmnxU9U0cvoLE33UTB1UVnJgkGM
         bRx+sakm15pXons0Ektc8FMy9gRdsZhXGgbighwRoy6gwbRlTahQ83ijL8vSDBe0PNoa
         Sx5Pv1xMZ+W836ChbDvedX1ZypbdemqIQg+jB33DGfXtqpy3axdRBsAzWj2BzmUpBNGb
         yHgze8JjkipqZIWq+xz46ULVdlKtYEorO8lB4phSNTNODBgx6ZUmpLBZ+0Yh53mpKu0L
         fJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eebSRw4Dc0yTzFHN9L+3qkEitj3m3+X2FXyr30NSAhQ=;
        b=wSTMADjL7qM+tSQESyVV3UmH7iGmqXsYz45e2W/2xpOdgL9Ux2LheEKW4jJHic4wpB
         uG8YZ6rExsPTZvgUhT7WR7uVpeGq1DFDoU8qBU99Imc2/OMQgLdE+UoGEsXpq1YOIweR
         b0LhKJrYeWUy1GHN7XD7eoli+lgqkU1UFpEKrbWBIZ1TdA38arUVLlx8Kuxw5Qf/2ROl
         OGXPD7n5no89x2otMED1sI5P9MjUo09B3wq7r2Dz9fiC3sNbgDkz4mjC6e9ufKc32aMj
         DHwMOEtcm9iGTwMUqvbRsXW+ftBWTaOtGuLIWXPo19cRQUuTU4Vx1xCyjijc7ylBe0jQ
         uxuQ==
X-Gm-Message-State: AJIora8S3RZC82j7/5LFGG2N5J3S4C66/13aUG9FB+HRDKLQKsmwAFi0
        nypXGfvbJ1yljB2BNlFKfNUi4qIeDT3k+g==
X-Google-Smtp-Source: AGRyM1tic+/LKMg1FyBcU9hbNZZuX4GE59/O39RN9HwbvYXxqqSEUf8JQ3fXnW/zguyDNsa3vylD6WsDeULd5w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:8541:0:b0:401:9c13:ffca with SMTP id
 u62-20020a638541000000b004019c13ffcamr1071210pgd.417.1655320409907; Wed, 15
 Jun 2022 12:13:29 -0700 (PDT)
Date:   Wed, 15 Jun 2022 12:13:22 -0700
In-Reply-To: <xmqq35g82f0y.fsf@gitster.g>
Message-Id: <kl6lzgid4u5p.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <xmqq35g82f0y.fsf@gitster.g>
Subject: gc/bare-repo-discovery (was Re: What's cooking in git.git (Jun 2022,
 #04; Mon, 13))
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/bare-repo-discovery (2022-06-07) 5 commits
>  - setup.c: create `discovery.bare`
>  - safe.directory: use git_protected_config()
>  - config: read protected config with `git_protected_config()`
>  - Documentation: define protected configuration
>  - Documentation/git-config.txt: add SCOPES section
>
>  Introduce a discovery.barerepository configuration variable that
>  allows users to forbid discovery of bare repositories.
>
>  Expecting a reroll.
>  source: <29053d029f8ec61095a2ad557be38b1d485a158f.1654635432.git.gitgitgadget@gmail.com>

v4 hasn't been reviewed yet. I think "Needs Review" is more accurate.
