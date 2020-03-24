Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B70CC10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 05:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2AB20719
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 05:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1SMq0C9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgCXF0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:26:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41891 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXF0G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 01:26:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id z65so8712086pfz.8
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 22:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0g9S7nF4B1rxJz+G+66OHpJGytluldBXJmKLiq2/cIM=;
        b=j1SMq0C9G7Y+HY8y4lpHI/D7m7uJ908L5xZh+jR6VtzdYKS7VBeP+mrzYW9YusJCyq
         aPhcrrqIJVbCSwoUM69y55Dg53bxALQAgxpkef3cAk4k+3aDHzj3gAQbJWIs2kqZ78KX
         DxnjYM6VHeZYH9CsOUx5IbsG4moZGjeWkTx/Wr21EqrXkwteqFwO3ySuusTqB1s67mIG
         nSdoG8FZI3T415p1gHQlgAZ6jry1v8GoaYUS+hv7F5m1ey5YvpqRSU7t/6opbUwrotsk
         lI+rYfE/nZsh8ABY27SnVGvpPmg2S9AQmdKPUa9/frTbiMTl95xtj6iAbPwAZgdo2cKE
         aBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0g9S7nF4B1rxJz+G+66OHpJGytluldBXJmKLiq2/cIM=;
        b=CUESTG00QFL+Lw/6OBCZvrbpaI0MLGbd1bhybN7VSzss7DgBi5hEHuzSmWm3qSX78W
         rlueAZBN20o0C7QVCTUBLplTE1DKzWsxXR331Fer9ACxbmpIb0en8xtWI8je2tRiRG7S
         VSFU2X7hrdM0KZC6Mldcx7ZOg+/GXurUqYEfTY2oTdY1Zxdflz5u7bccmXNzPz/ZRUyY
         zWr+66ePL76itAy406XCaOEM/eVlnR7VQK0xC/wTgDbrFiXHT2bl1bgk1e4VRDxr/QIc
         /5IPIOph/vWIQNLXO2+3UqheHeVsOWREoQqF9YcSHX7ocsTPOFjESHzjw/xUMX2ED04U
         M1vw==
X-Gm-Message-State: ANhLgQ3JaaglaM6nr8mPfIR+cVU/CvOKl5IczcgXX6udJOK6G5sDVbZ8
        X8bKzDqxZb1Eem98SO+Tf6jD1PZR
X-Google-Smtp-Source: ADFU+vtGDQlCmZxJtSdeJL89tL6xYI5kBkeogdRKSaw+Xptcyjd4Fe0kXRUqEQTd/e3EmnKNoldp8g==
X-Received: by 2002:aa7:961c:: with SMTP id q28mr28981347pfg.177.1585027077671;
        Mon, 23 Mar 2020 22:17:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id w31sm13531284pgl.84.2020.03.23.22.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 22:17:56 -0700 (PDT)
Date:   Mon, 23 Mar 2020 22:17:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jonathantanmy@google.com,
        christian.couder@gmail.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2] clone: document --filter options
Message-ID: <20200324051754.GA13508@google.com>
References: <pull.586.git.1584638887.gitgitgadget@gmail.com>
 <pull.586.v2.git.1584906606469.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.586.v2.git.1584906606469.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:

> It turns out that the "--filter=<filter-spec>" option is not
> documented anywhere in the "git clone" page, and instead is
> detailed carefully in "git rev-list" where it serves a
> different purpose.
>
> Add a small bit about this option in the documentation.
[...]
>  Documentation/git-clone.txt | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

>                                                         It
> would be worth some time to create a subsection in the "git clone"
> documentation about partial clone as a concept and how it can be
> a surprising experience. For example, "git checkout" will likely
> trigger a pack download.

I think that belongs in its own git-partial-clone(7) page.

Thanks,
Jonathan
