Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E7CC433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607BE61040
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241596AbhJHUYf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbhJHUYe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:24:34 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06B7C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 13:22:38 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z12-20020a655a4c000000b0029506c80060so2180259pgs.20
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qDbnNdhbAY8x549oWd0lRICP3c9CNnQ8bgau1NtEo2o=;
        b=lkAyv7OSqP/s9x90XX0SWdGM7eQV/j9ZpI1Sun+HmM8ojnZwNG/6Lc13sErvfglF4a
         fyBRKtyxl3QofcsTQ9b4Osw/8Hm8wod1eGUTO1yzMycE3tNS7pt9mqVHsObOL2ZJ/0gb
         lXYJTMpq+B42UFy1nNpxHFZPEcZtAFnL+Mx8Nhjq9HUev/JnAedux9pD6QgRozLI9yvb
         S767zGOHLMClSeeYxXAZOIsS5Yu5/vinudFDIPJW2aFhAya11F6zteLvaKBJL4ucVl8E
         V+VnYW57mMx/R+/JSr7yzDANWdBsb5uZjdfCIo1mBlZ202Cla8jdGAROWvRstlxXrrwG
         M8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qDbnNdhbAY8x549oWd0lRICP3c9CNnQ8bgau1NtEo2o=;
        b=5hoj5IVRc99rEARE4fLg4wUuzfn6KuTg7EaSh9k52O6o3pHsPizSPTDGRVAAqiEtaX
         LJuBfbtBAhsgF5gL3HFCHzZVKurWjDCnjTQou9FdaK1p0x+qKsIoqDsO6nKzEfIcOU4b
         Nz7FUAclBsixWR+ynLOidbSyqQZLMZOP+4BX6WNZbJDb8/YMqvIfEb8tA0lq/mWYbNFV
         4z22qmyD9oVCmnZOC2JPf6EpoHxOTgWjdo89KAoC3UGH9jdOWv4qwTgrI4LJANK2oUS4
         t6TjkIOH+cuhq0Tk3FKFvWnLrkEJ1STK+0/if3G73jU6nsyWQVXwxxGt/OZUnh8yylR0
         ilSQ==
X-Gm-Message-State: AOAM532y89OK+KMxrdqyjIcPcVON33M9447nIBT37/F8KyMO3q1c41FH
        4WyrJkwCad5F865XPasrvQ/qEOYJg4ZlZTpP5FAP
X-Google-Smtp-Source: ABdhPJwVBNBje/OzjWeXJXo392eN7CRWNM635H8RgoxVQDaeH39hMIcOTVQ+C1CYAAw5E2AmaiX6r81sPoZaFeoR930d
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:8b8d:: with SMTP id
 z13mr578391pjn.0.1633724558112; Fri, 08 Oct 2021 13:22:38 -0700 (PDT)
Date:   Fri,  8 Oct 2021 13:22:35 -0700
In-Reply-To: <YV89ukrCS3NmIKsl@google.com>
Message-Id: <20211008202235.1326279-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YV89ukrCS3NmIKsl@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: Re: [PATCH v3 5/7] object-file: only register submodule ODB if needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > @@ -1614,7 +1614,8 @@ static int do_oid_object_info_extended(struct repository *r,
> >  				break;
> >  		}
> >  
> > -		if (register_all_submodule_odb_as_alternates())
> > +		if (r == the_repository &&
> > +		    register_all_submodule_odb_as_alternates())
> >  			/* We added some alternates; retry */
> >  			continue;
> >  
> > -- 
> > 2.33.0.685.g46640cef36-goog
> > 
> 
> It looks like this is just a small bugfix, but can you expand on the
> implications here? What happens if r != the_repository?

The purpose of the quoted block (before and after the check added in
this patch) is so that reading submodule objects by reading them as if
they were in the_repository works, and it follows that this is only
necessary if we pass the_repository (because we are reading them as if
they were in the_repository). I'll add a comment explaining this.
