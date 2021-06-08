Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD4C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108BE613AB
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 17:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhFHRfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhFHRfp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 13:35:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A548BC061787
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 10:33:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id z26so16246086pfj.5
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OBR/fXp5ipTaDi6RkbtiRDEQtboCobeZ9XxDtmuBZ0s=;
        b=UdYP7zIHQ9pw+3nQbgwmghJXiYjcIpwHaIQhZuGzs+8wr9DaYTa/glv1xNgV4Z5CzG
         wbtPkbQKDY6vjCLRybJ56WVeGMsPiNvLXjEP5bOrYFP4tz9VIt2yl95OcM+uXSWPr/Hs
         9jkAdP5rq6lCa/sg65gHZr09YOTo8pyxG3Kc/J5WNeGUh+DSRgI1ELl+PLI4rtaSTXFA
         QGMlGuUIUDmt8/waLSg7jvIgADqEkqY1anyhHFteHSrmGhuyr0c4NJYwVi9z6mSFjDjw
         2bMQqX/+eqooK0HP/TmMnsz4OtZZChHm3qkB7wBySD76w6+29Hqg02+NJulIV2sayCbY
         FKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OBR/fXp5ipTaDi6RkbtiRDEQtboCobeZ9XxDtmuBZ0s=;
        b=Wb7JSQcrLPoTbMTtYtiwBTYiBN4zlXuOTqiFou863e45D3QSavR2SswQ45dvWHKxpp
         l9HRT+WBD2pEm+YNTdrF/9ZSsFPzoMaMhl2QVH8zcEoG/bbsXHHgmssuhZXzJpFYIFu/
         l69opeVSHUIWpEnK4qGg/H7lKUZlpn6ZSX/XslQImWIpABQjnODQFIixFh81iH93Al+v
         GEfNwRi8buQIAzzw+dPh8E7TxDpMug7X554oW3KpthIJPUIaYC8El1m9gioHGgJe7UVo
         6o4c08hmUPIpktxj6y8OLFCGiEB9zr2rDVVW7zPDgBJrsiY7nC4T4XlgTkh70nkhR6Hq
         A+HA==
X-Gm-Message-State: AOAM532V0jWQtiGwaHgGC2fd4XHXCRCFREzt62Okmk2YWyKoV5zY2uxV
        P6IP9JEMmx1FstKxULJ56Yt+4A==
X-Google-Smtp-Source: ABdhPJx0B3mn6gwAyqGDoiBISTbxPX5rhIQKQ9qlzblQn1gaU1marNpTB8Pfgec+KxeorEtIQUrnOg==
X-Received: by 2002:a62:2901:0:b029:28e:ef3d:10d2 with SMTP id p1-20020a6229010000b029028eef3d10d2mr818835pfp.45.1623173632079;
        Tue, 08 Jun 2021 10:33:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:f819:e238:f61a:a961])
        by smtp.gmail.com with ESMTPSA id l8sm12026138pgq.49.2021.06.08.10.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 10:33:51 -0700 (PDT)
Date:   Tue, 8 Jun 2021 10:33:44 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
Message-ID: <YL+p+MlgJ754YoqB@google.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 07, 2021 at 04:57:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> 
> 
> There are several instances in our documentation where we refer to an
> anonymous user as "a contributor" or "an integrator" or similar. To
> avoid repeating this role, pronouns are used. Previous examples
> chose a gender for this user, using "he/him" or "she/her" arbitrarily.

(I am not disagreeing with the series.)

There is value in intentionally defaulting to "she/her", especially in
settings where women are underrepresented. It can be a nice way to
shake the foundations of unconscious bias in the reader's head. See
https://www.askamanager.org/2011/07/why-i-refer-to-everyone-as-she.html
as an example.

> Replace these uses with "they/them" to ensure that these documentation
> examples apply to all potential users without exception.

However, in this case, I think "they/them" is appropriate as a default.
As you say, this documentation is intended as a guide to potential users
and contributors, and should apply to them. Thanks for writing the
change.

Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
