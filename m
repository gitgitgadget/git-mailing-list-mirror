Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07C8C432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F09960FF2
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 22:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbhHZWjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 18:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243753AbhHZWjx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 18:39:53 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABA4C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:39:05 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e15so2685707plh.8
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uT2fMe2XO5YGt4VaIJC6fDyuA15lpByleMMYkkDeoN4=;
        b=vha9daC9qeDhFD+2111NFn6Us4sZNRtGOV08LkNJxO5h0wLWQaXN+6dg8AUbq8PQbb
         PGbWH/vKb8zn3gbfg4mVzaATs+jdcJzifoDrDnWwPWUJFhLwprp+nO/TLEA+dLNpdnSJ
         5MK5XMkG8AC9c9iejifCFL67W52GuZ5dk9JU3FsSnH8KDZzRqme6rw3P3KNdGqUaCVUQ
         6A87CFpVvt5fxFOSsQXaMwmqUEKgMQmDhdPoMs/exUyLGA87QJ6aVNitmBZRirAKYncn
         Sye504j8HQnR9pTVbzKqvguSNbSGmQ8G0P2VOWBR8svziERly/s8DT65jHHLsIKW5llh
         0pTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uT2fMe2XO5YGt4VaIJC6fDyuA15lpByleMMYkkDeoN4=;
        b=D9kYtAfDe2awhyANSX2GEJvVnoZKNk8iehOftlZl7m4P8zjGhWeT96X/BwDW7JDQRq
         50quRVqUNSl7PdS5vRdD4lswwLrl8doo4KP9RaR3fYRsS7KLhOHTpFK4vTrwqIIIylIF
         dAHHIAN3Fp7XZTfJDj6/4C8yIg02LDP8gAQdcSDnuzMptpObBWJ1IGqtGU2lkW7sz7zt
         VQU1gHHbbXdNUZMpKIXpJ7OLQP2CHBsN+Ed8CjsqEfVifVTvvafkT4yWtZmEihUc1Eqq
         bI2i2gxmll389+utn0xaN/FgtwTXJh3Fcb9C+t977K1N+Eyiypt45YnVuLfGUiz3+pnF
         kLPQ==
X-Gm-Message-State: AOAM5323CzYCCxuglEZHvWS7YRu0ptdQXIN95cXKY/BiiUnHzNjVARUZ
        8NzuXZdCqxYPC+nH7mbK/aalbp6rYBcIxg==
X-Google-Smtp-Source: ABdhPJy266TRgf4FQ+6fw5B8oSZDf84u2tiv5OLFc8j2BsEnkZrJIDQz4D6qcw7Whr48rPHK9tV32w==
X-Received: by 2002:a17:90a:b38b:: with SMTP id e11mr6873669pjr.1.1630017544596;
        Thu, 26 Aug 2021 15:39:04 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c1d9:3a1d:fe59:b07a])
        by smtp.gmail.com with ESMTPSA id x4sm3913205pfu.65.2021.08.26.15.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:39:03 -0700 (PDT)
Date:   Thu, 26 Aug 2021 15:38:59 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/6] hook: introduce "git hook list"
Message-ID: <YSgYA44krEdk6VFD@google.com>
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-4-emilyshaffer@google.com>
 <87r1eiet3o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87r1eiet3o.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 05:53:48PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Wed, Aug 18 2021, Emily Shaffer wrote:
> 
> > +	head = hook_list(hookname);
> 
> This doesn't compile, as hook_list() is added in a later
> commit. Something something earlier suggestion of "git rebase -i --exec
> 'make test'" :)


Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaargh. Thanks.
