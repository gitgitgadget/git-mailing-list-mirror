Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E58C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 21:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F686105A
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 21:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhJNVwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 17:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhJNVwe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 17:52:34 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636D1C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 14:50:29 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id y23-20020a17090abd1700b001a0b6d87a3cso5742157pjr.7
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 14:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=fcgEqNl05Su3dqpNQ1UYCE2xDiSUTsGF40fY0MqmwOc=;
        b=mRQL36SvC+AFVEKhDZBP6tD3SzfEs99KlkmgSnWgTRBpWACHS0PEho/sKyPVZFuLGr
         vdazGnbQ0TVHVyQ63rrPRY31QuqchE5JgtYPWhonkA+5tsb5TJDXjmvNgiIRmRg+8hBF
         lDr6tCLISD8g0zItUvIxxJgtPhKeC8ODODwAuHbwzadwR2LDwFSZgV1si6GKez3Kppnw
         buVgrdKqKnpgVWQ8YWIfs6sWosuRQ71Nlb4U8wCK5feYDIDQsE/F2TmnuY9OrRJKOONm
         pk2eMKL18hIKobwc00Edx9wAFOReX9V/EoyDmPaKTlurxQU8VbHQju4htNtdG2qGN1Yz
         nprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=fcgEqNl05Su3dqpNQ1UYCE2xDiSUTsGF40fY0MqmwOc=;
        b=XGCesSGN5YbuvA6v0pa5AWp0Uhguvc6IpimtdQqnmfWhaJn3hwoe4Q9dybJBrbGR9e
         LCxr2+jqe+PipruGu5YCALnuDhE8y1vw4sbZHdsajhSnLCRk2irXd9eM+zltEaZkWsQg
         pXna8lLWnP88JKjxPxueAGyPGMK57TJU6eQ1QXQGW75H3EJKsll7xSTEDG5N6gp2XpAG
         7fvffvbI6onmk/pECzXdRKEfx5ULWk5PGWeA78PN1mFvkeZwxSBNPWqVxCXXElDX7OqC
         D40S1bY/GQYn1kNbUZsxZ1KSuqsa3PKmFRTNw9g3ULA76egmMnkEws1mH623F4QDKLoo
         AlUA==
X-Gm-Message-State: AOAM532XkhnrHoA5/VqQGSHbGW1gjQwtmuCdayE3SxwUyRydrmUDhX4Y
        TiOMocfnKkUpvk02sXbz2fmHfONV24RTcw==
X-Google-Smtp-Source: ABdhPJy/EfXz648YjI8lsipGgF2RlDwaberdRTgX/HAiRlMVD8+iPd0i6cJVfoutajbPbyxa6Z6lBNEvjOWCOQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:db53:: with SMTP id
 u19mr23328293pjx.234.1634248228914; Thu, 14 Oct 2021 14:50:28 -0700 (PDT)
Date:   Thu, 14 Oct 2021 14:50:20 -0700
In-Reply-To: <20210907115932.36068-1-raykar.ath@gmail.com>
Message-Id: <kl6la6jb1dk3.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20210907115932.36068-1-raykar.ath@gmail.com>
Subject: Re: [PATCH 00/13] submodule: convert the rest of 'update' to C
From:   Glen Choo <chooglen@google.com>
To:     Atharva Raykar <raykar.ath@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This series builds upon the previous conversion work on 'submodule update' and
> moves out all of that shell logic in 'git-submodule.sh' into
> 'builtin/submodule--helper.c'.

Hey Atharva! I'm working on a series that will teach "git branch" how to
handle "--recurse-submodules". I plan to do this in-process because I
think this will take less overall effort than using child processes, and
to make it happen, I'm planning to add a helper function like
"for_each_submodule()", which would call a C callback function on each
submodule.

This is conceptually similar to "git submodule foreach" and
for_each_listed_submodule() (though not exactly equivalent), so I'm
reaching out to you in case this work is already on your radar. If so,
and if it is coming soon, it might be easier to for me to base my work
off yours instead of duplicating our efforts :)
