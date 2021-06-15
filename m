Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3C2C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1CB61241
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhFOVVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFOVVE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 17:21:04 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0675EC061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 14:18:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g22so165469pgk.1
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sWx/L2dCUPAO96LwS7xJNZ3uP6Ba6beAe8rJQ1Wz/Nw=;
        b=Ur76fyfljFZD26yUPCzjf+n6uL7OGBpQ1lbsPhlk2MUbY8d33qwN46NiX5gNjxJTzd
         Mhjc1U7WmjPZDeoZ9//C7wgEKkuadth6ciqQfcKc+GIkta83o7cXl3gAx+9pB77+JKkC
         tka+Dtg47RC/5FYXhABIO0BwxyRTSBbmrzt/pFju/0sVGofBNgEYf+sDL/2w7KoAezrC
         FcmS/G7Z3dD3/t/5iAMFJ+3lLdxuSRhKd58fCX7AqCSKfXGqb+1y2CcgK7AQq2yux0io
         bWBnP+AAB1ZFfCBXFZaL79WNzFdOltv9sFOafaOII3OVu72zNKlIrd1qEJdlde41EQQ3
         o0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sWx/L2dCUPAO96LwS7xJNZ3uP6Ba6beAe8rJQ1Wz/Nw=;
        b=P3fn4dnlktykPPbdDCwRl2SEWLdvddgTWA5h2MYKwKBC3/qwDtcDxIZdPozI6z6hQj
         1IXMSDJT7v3JprK0fbjFstzXyCqqkKNdayWBqjupygmw+DWBjf82YbaftFu2MrNQIHtr
         1FNC4I5t4K2H/9LsjXTCkTwmLlgw4uwJaSX/luO5lbfnnMCa74JG6Skqt3CqimELZ0yD
         16znHJRvqAp2JsNkq5kM0ONE6e+OURSR9m8GKjJFvWbXnuWab3MKUhn1bDV1Yb9U47ds
         Ga5w6whNUb6ucjDdKgw+ynHCnrigr01rwlEDgNZpCjI4zfn6zKQE0bzkonEjrj9aH0gQ
         0L5w==
X-Gm-Message-State: AOAM530/L0FeAK6TqVXc+smGBSGnWyJPTZ0cD3w5IKRtClw3PI5a2OhH
        Y4yLr09cRZAxxuyhbvivAIQXSA==
X-Google-Smtp-Source: ABdhPJww5OolRxrHgYCHMlAjXbd8H/3oTmJ8OjjqhQk9W+uph8XSaumSbHRUmiyoP//sf/wLSPQzdA==
X-Received: by 2002:aa7:8f28:0:b029:2f4:9245:4ed with SMTP id y8-20020aa78f280000b02902f4924504edmr6126083pfr.24.1623791938397;
        Tue, 15 Jun 2021 14:18:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:d4cc:f4a9:b043:ff6e])
        by smtp.gmail.com with ESMTPSA id ls17sm3198400pjb.56.2021.06.15.14.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 14:18:57 -0700 (PDT)
Date:   Tue, 15 Jun 2021 14:18:51 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [RFC PATCH 0/4] cache parent project's gitdir in submodules
Message-ID: <YMkZOxlSRnWlYRKR@google.com>
References: <20210611225428.1208973-1-emilyshaffer@google.com>
 <xmqqo8c8zz3a.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8c8zz3a.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 14, 2021 at 04:26:17PM +0900, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > It's necessary for a superproject to know which submodules it contains.
> > However, historically submodules do not know they are anything but a
> > normal single-repo Git project (or a superproject, in nested-submodules
> > cases). This decision does help prevent us from having to support
> > divergent behaviors in submodule projects vs. superprojects, which makes
> > sure Git is (somewhat) less confusing for the reader, and helps simplify
> > our code.
> 
> https://github.com/git/git/actions/runs/934803365 is the CI run of
> 'seen' that passes.  With this and another topic merged to 'seen',
> as can be seen in https://github.com/git/git/actions/runs/934680687,
> a handful of tests fail.

Thanks, I will investigate.
