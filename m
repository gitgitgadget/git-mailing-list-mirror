Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94F3C433DF
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 16:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778E22173E
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 16:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="VKLesMKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgJNQ4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 12:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgJNQ4L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 12:56:11 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B114DC061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 09:56:11 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g7so6011495iov.13
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SKuuowu65ntkUW+SgwOnRVN2Na7MpxvGfnawSxxv+bE=;
        b=VKLesMKjf26tMLZbmbFoqHiCdMlEKbDkJs7NUEqAwwVDx/HoFDPYJWlRK6QIXNbOtS
         mM3RrM1eGtGWh90ARxjbDyXkagmLvqsvBKMvPwOT9IuOzDkyJNo0EO0xlMsAmFZTMxAX
         LhVgTp3i8YsDsi7hatgt6R5e5Z5CjwpNtSJ4fJvFaLpfRup/dofc9GIWaFjAPS/fwxSN
         moiSNhms0RhOvplTDvJ0RhSr1rT/Ajfq5pEqy1cBHUZx/wn83udg0nLD9dT2q93twrle
         DLdpuzCvT9kaMuXYfLs2KA/9+jOrBLU4b/Ww0j2D/8Whjn4GUN3AvS9ImVHdNhfHkzOY
         xPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKuuowu65ntkUW+SgwOnRVN2Na7MpxvGfnawSxxv+bE=;
        b=Aphp9i9lGocRt12EagOBnDP38j6Z0eJKiKA5xfuEGupNyzE/0f0wzf7sZdaaczHa0+
         8YhIegEpWPFAtpIVbRxCTqZm7o00JennhMMi2eaGAd7F+ZLGaRZ8wC6sLcJvSacUEOvt
         RAuqOxb5IoiJHHkkoHIYH1dhLiWVeQN9pK2ueODC0lOqXFwljQvzR+o8oR3LHANw96TZ
         7ay2TGjHpDDVJlf+jKpWzcEAOCLYm8Ol6Ac32O1uwTxUwFal/oJ2YIL9czOnBbE7VQkD
         R08AFrYNMz0HEUQzmqH/n3p7Frh84DLNFEM2YzRbfq3fMG2gHIigjd/JrAfoFDLcjo8R
         m4uw==
X-Gm-Message-State: AOAM5310qgc4EwGv5ZQvFK1CNVSg96DNMd4aDcgJB0yXzQ7oZ4Ay2ikc
        X7Aoaaoc1jcmG1ixNJntm6gPL16vdabWHyTq
X-Google-Smtp-Source: ABdhPJzaj10OoXUWHJrG2mailb50iOYBmc/aFoQlUKgvSOPdev4c8NvvTiEztMtpbD4hLlHupWFlXA==
X-Received: by 2002:a02:ccb9:: with SMTP id t25mr356125jap.21.1602694570909;
        Wed, 14 Oct 2020 09:56:10 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:547d:7aac:e654:2f06])
        by smtp.gmail.com with ESMTPSA id s23sm78169iol.23.2020.10.14.09.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 09:56:10 -0700 (PDT)
Date:   Wed, 14 Oct 2020 12:56:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Nipunn Koorapati <nipunn1313@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Partial clone fails with file:/// URI
Message-ID: <20201014165607.GA2044338@nand.local>
References: <CAN8Z4-XgctFZxZoTWRpD1V9NFr34ObzG2dxUoAfuJ4NOsBDdtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN8Z4-XgctFZxZoTWRpD1V9NFr34ObzG2dxUoAfuJ4NOsBDdtg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nipunn,

On Wed, Oct 14, 2020 at 05:38:15PM +0100, Nipunn Koorapati wrote:
> Hi friends,
>
> When I run a git clone with --filter and a file:/// URI - it fails.
>
> Repro steps:
>
> I have the `git` repo cloned and built into the CWD at v2.28.0
> git/git clone --filter=blob:none file:///home/nipunn/src/git git2

I couldn't quite reproduce this. Here's my reproduction:

  #!/bin/sh

  rm -fr repo clone
  git init repo

  (
    cd repo

    git config uploadpack.allowfilter true
    git config uploadpack.allowanysha1inwant true

    for f in a b; do
      echo $f > $f
      git add $f
      git commit -m "$f: initial commit"
    done
  )

  git clone --filter=blob:none file://$(pwd)/repo clone

That works on v2.28.0, and v2.29.0 for me. Is git installed properly on
your system?

Thanks,
Taylor
