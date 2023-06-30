Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B260DEB64DA
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 22:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjF3WSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjF3WSo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 18:18:44 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAB3199E
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 15:18:43 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b6824141b4so14565165ad.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 15:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688163523; x=1690755523;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uf5V51eiaJkpN8ynUspOMtloc0afaXU6wTvxegToN7Q=;
        b=2tqALEz+O5boKieKgaPnHKtjNyKSDn2zc9qJWfUOFvnTKfjY4k2ercVoTL0sty6/Q+
         NzvqZwwD1PMM3aqPh6j5Cb8RTxHLqLDLNYFcbwPvvRh7+DV+eRDbWiYSACB3166v4trX
         uA1ryCei6GENOrxrCPoEmDGpvSsDB8z6Bb+xWfhEQHhQOP6NyYinEtI0pYZlJfNwqwbH
         zHQrywbO7jiPv4n6Tcui5dmTlOK/nyIjuVMrJkToTnob1xtDlRWhErkuCCwN//eOY6of
         brx+uGYau943DPol1BvceW2LFBKsgn8uekYqtwcD6X9qiP0Wnh4U7QqIKgC8saWMpFfV
         iksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688163523; x=1690755523;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uf5V51eiaJkpN8ynUspOMtloc0afaXU6wTvxegToN7Q=;
        b=aJFOb0NccAB7gKa6fRwUxHkqkltxzpkWKSy+MC9G7w/QpzOiA6oU8p3guqMIV9T0h0
         tdU+raJZE/gpElWfdvvUVUrCAjywY0Ue7BvK7dcTF4A0mZDxtWIhnXr02TXhWl++y7XG
         S6sUIXAqHEFFZ56Y8NqYSITciSLl/rUf/QvFFLuxUczGVQPcifCdrn1xABRpNTgwSLxn
         oGQephd4vhk2wCunasrgjH6cz3HFWVHB8NTBQ4jYu0Cy5srYHcadvr7BtE5xa0cIEpM4
         Kpv8JaMJyuptMo7qiw01boyYhBaEPi0oQslT58EY8w+Un7gwhgF3yzCTO/fSAnzxhbgI
         C36w==
X-Gm-Message-State: AC+VfDyxeM6mG9znJQVSav5ID+J5Acgj6cvoBZ7/sdU483D8TgpW8HmD
        BHYgLqUR0BjYkz7TuJRPZz/1pQ==
X-Google-Smtp-Source: ACHHUZ4BQjUP8jFUSKfWcToOCklowmx7bknPRXUWOEBctqvXRW+823e5aKi8AQwvu1T2ZzLfXp7/8Q==
X-Received: by 2002:a17:903:40c6:b0:1b7:c09d:3f7a with SMTP id t6-20020a17090340c600b001b7c09d3f7amr9329608pld.11.1688163522581;
        Fri, 30 Jun 2023 15:18:42 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:1498:3821:7231:6e96])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001b86c526feasm1826266plf.28.2023.06.30.15.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:18:42 -0700 (PDT)
Date:   Fri, 30 Jun 2023 15:18:37 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, calvinwan@google.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
Message-ID: <ZJ9UvXsZKQh+PFoV@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        calvinwan@google.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
 <xmqq7cs73sic.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7cs73sic.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.06.13 15:30, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > In our current testing environment, we spend a significant amount of
> > effort crafting end-to-end tests for error conditions that could easily
> > be captured by unit tests (or we simply forgo some hard-to-setup and
> > rare error conditions).Describe what we hope to accomplish by
> > implementing unit tests, and explain some open questions and milestones.
> > Discuss desired features for test frameworks/harnesses, and provide a
> > preliminary comparison of several different frameworks.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > Coauthored-by: Calvin Wan <calvinwan@google.com>
> > ---
> 
> The co-author should also signal his acceptance of the D-C-O with
> his own S-o-b.  [*1*] gives a good example.

Fixed in V4. Thanks.
