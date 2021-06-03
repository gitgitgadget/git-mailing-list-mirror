Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EECC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 21:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0E3613F9
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 21:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhFCVjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 17:39:02 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51736 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhFCVjC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 17:39:02 -0400
Received: by mail-pf1-f202.google.com with SMTP id 197-20020a6218ce0000b02902e9c6393facso4128011pfy.18
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 14:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WeKlNNdtQRAHfqfW6Z794dz1nLIBa86B8Jnd13h736Q=;
        b=dgODogpFCoM7S7GCR1BeuHfRWRQ54EIo/1usqLd3whCqGfTEK7fd7GWIlj41N20fLy
         +o6u3du1DPxFwO9gAreCFZznlkqYhc9FAI6ckAndcAHoQwh2aWDFVgpXQ8x+yxIAlsaC
         oIjdcw46nXsxUDJlOJ6Bu/6GsE1cSCwghmcq9Wy6aGMXWNKVcS8BXc2Dx9Hnje9lLzpy
         c9JYXDDzlTpgMp7LZgTnrKOMwinvXbhIKqR8qT9DkYnjbT98pm6APUIT+DCdPLG+XNVt
         7UrJxNSd+BRUCo2j5tjJ5lfH3N+BXYIx5Q6yx7CXIbnWaJ/kSTEIf/mu+My3uKUWG6LH
         92aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WeKlNNdtQRAHfqfW6Z794dz1nLIBa86B8Jnd13h736Q=;
        b=PHti8g2oGnhUJyqyQ559ssmgnqzR8Xl9tR/OJrVz8Tjn3VAi/IB3S9FvRTUkxlGe5Z
         LRyQWnyNL+5+/viffgLjblpsEX7f3wTzg+VqC4aIM2rj+OfT/ZyfbNx0LJeBrzFWkm7p
         eAo5jDQItulvPtxlpmrsCwpdNs+1oPWxdWKr0L/bv8lszhBML+HSXrBkXSS3Ean0AGNf
         rlm7l37KgDLtahIJrtuSy+fCv0o9wYwhAa+dEspTeiCcsVoDv10C91Q9Xlr8kxOoXUiF
         jaH7/UlBwLLPxriIjGZrZfNhnhQ2BLwvg5drkaMbYLeCBl+BXtx0ACBGKuMTd9Jo5t16
         mnJw==
X-Gm-Message-State: AOAM533BL4z1d2wpQwKAp6NgUZF4x0PicMdnxH8ik9oI7l74Vlhyk4fW
        xnkKzKJLPIh0PG7cANpfwfvhFE789c3NBjerYTtz
X-Google-Smtp-Source: ABdhPJzadaMvBBTzlj88HqBpDEUSYszKKdDOk7SFQTNAUc0Yx5doL5fvXrjZyUDidQJ1zCFjsD2/492gS43az3UXVYuI
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a62:541:0:b029:2dc:9e95:95cc with
 SMTP id 62-20020a6205410000b02902dc9e9595ccmr1287371pff.79.1622756161632;
 Thu, 03 Jun 2021 14:36:01 -0700 (PDT)
Date:   Thu,  3 Jun 2021 14:35:58 -0700
In-Reply-To: <YLffyI3rp9hSZZdy@nand.local>
Message-Id: <20210603213558.453725-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YLffyI3rp9hSZZdy@nand.local>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: Re: [PATCH] Remove warning that repack only works on non-promisor packfiles
From:   Jonathan Tan <jonathantanmy@google.com>
To:     me@ttaylorr.com
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org, tao@klerks.biz,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On Wed, Jun 02, 2021 at 11:47:26AM +0000, Tao Klerks via GitGitGadget wrote:
> > From: Tao Klerks <tao@klerks.biz>
> >
> > The git-repack doc clearly states that it *does* operate on promisor
> > packfiles (in a separate partition), with "-a" specified. Presumably
> > the statements here are outdated, as they feature from the first doc
> > in 2017 (and the repack support was added in 2018)
> 
> Yeah, this all originally comes from Jeff H.'s design document in
> 637fc4467e (partial-clone: design doc, 2017-12-14), but probably should
> have been updated in 5d19e8138d (repack: repack promisor objects if -a
> or -A is set, 2018-08-08).
> 
> This looks good to me, but I'll add Jonathan Tan to the CC list to
> double check.
> 
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks, Taylor. Yes, the patch is correct.
