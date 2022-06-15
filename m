Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5102DC43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 00:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbiFOAfV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 20:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiFOAfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 20:35:20 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D71F369C4
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:35:19 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a184so7671306qkg.5
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 17:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TeSHaFSNqXpyCpg5AgGOFWb0TIfp1QsGesyvYl2MjWo=;
        b=wU3Oto2DGrtEtpowCA7oRzWdb4nnwMi0ViBfBQjuQKBQ0u0EdE1rFVU3divDEmhV+R
         st7FnI3K6QzsqXnkP74UQ0mJQopo+MjAuR4T7xWeQDuce79xoK2eNRdP88I64S8M2i4q
         3FOTTUk9MoodxcKVZZaDThT59P1S9E+XccNQ2WXV5kaJz8brNDKHpmqtHbk5RfsN/JDc
         J/BOYMJbPmGUEayj4lXhZ3WXWLvQ+kZvsc9q3Hpa37FO1xB4at5u+11C5JMQ2945rWmq
         C09vWc7QF5gyaIBrw13JbdMLcfpuhK8Nvk8akBVZ48YrnXaxGcUOF65M6P6fGWEEcbK3
         PuMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TeSHaFSNqXpyCpg5AgGOFWb0TIfp1QsGesyvYl2MjWo=;
        b=QnCfj+MwSC3CKsiDnlcjOz5xi4a0T3ODiokiu/qAPZQjwMW9Euz9Cl/Z7iL/eaaudd
         lvVuXIlqjJvq+QHVAm56E3e7EXNjQcfL7BgkUFRfy5u8TtGBD9bRSUc8jr16cap4sVLt
         O8ypkFeCuOIn86WmmNlOx5zpG8MfzyxGeDLYa33Tt1B6TcnfEx49zyVs7uOlLbbJ4aDY
         OHopby020TAb29F7dGlTCl4Lh6uAb2XmsITKEE6900MB466sk5be7av1/1Q1GY8PSWDx
         vh4yBPS5Ok9zZQdpryXPWH4aaRMnQb26CWMbK83DrkISdIOqGLgJvnJqdL8CDCFUK7uo
         jTzA==
X-Gm-Message-State: AOAM532RkJw6IO4cinuqFK6Y4Wb+k6aKywZblyZdu0gYcqumY1t8IY+f
        JMyNpnI+8iDZcPoT2UeVKGnGKA==
X-Google-Smtp-Source: ABdhPJyiAfbS6Zq0it3LiipUysy0tdG3RsH/9OQam7Ue9mTxJZUI9kAaeOAD9KYQhZZDBCBDogvTQw==
X-Received: by 2002:a05:620a:170e:b0:6a7:3ff1:baf4 with SMTP id az14-20020a05620a170e00b006a73ff1baf4mr6233170qkb.471.1655253318593;
        Tue, 14 Jun 2022 17:35:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z17-20020ae9c111000000b006a6f68c8a87sm9850406qki.126.2022.06.14.17.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 17:35:18 -0700 (PDT)
Date:   Tue, 14 Jun 2022 20:35:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Richard Oliver <roliver@roku.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] mktree: learn about promised objects
Message-ID: <YqkpRE8nykqVv8cn@nand.local>
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
 <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 14, 2022 at 01:27:18PM -0400, Derrick Stolee wrote:
> > Did you have any other sort of performance test in mind? The remotes we
> > typically deal with are geographically far away and deal with a high volume
> > of traffic so we're keen to move behaviour to the client where it makes sense
> > to do so.
>
> I guess I wonder how large your promisor pack-files are in this test,
> since your implementation depends on for_each_packed_object(), which
> should be really inefficient if you're actually dealing with a large
> partial clone.

I had the same thought. Storing data available in the promisor packs
into an oid_map is going to be expensive if there are many such objects.

Is there a reason that we can't introduce a variant of
find_kept_pack_entry() that deals only with .promisor packs and look
these things up as-needed?

Thanks,
Taylor
