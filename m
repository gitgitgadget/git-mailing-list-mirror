Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828F7C433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4766D64EDD
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhBBCXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhBBCXk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:23:40 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AF8C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:22:59 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id m64so14861438qke.12
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fjmyAUsbY4tbNAElTuKW2dQDwDY9ghdgxm5CZpqq+Xk=;
        b=JtzzKFo2l3ec+PbJiqf/dPcl4ic4Tfac2zPGn1piRJ9M9cMUCtEu2bvN6ZsP7LBLe6
         UgN1u1Fb/RIbWbRfUSsE2WlyHcm6/YUDD8kp69frMWexDW2+NcSfhYGSbWFa1NPtJBHN
         +HFh/N52rToRaC8Z91CMYlzqmTW7hePVtiyTp8KnCjDTZm1oZyRbB65He5FAEL1g/dTR
         ZgK4A4Uhsq/J5jEXC3lRAtnHHZkMYHelmATzQhF+UdTRiCtkL578ES+VXhtzg9RBJ0c6
         I1l774kYMY8nk/2wtv8lb41Wrll1J+H4Zkw3eI5F+MjLaB9SLu98my6MsxzFe2kbGxy8
         6URw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fjmyAUsbY4tbNAElTuKW2dQDwDY9ghdgxm5CZpqq+Xk=;
        b=c8684yko71kN0CtOfcLYYI/+Gj5TWCn0hCKfWsrbyXs/SRJupLvibuCAkVIiOpFvaN
         oDmeMbR8qokDfQbMPlda2jmYN1pNmmMIDFTXDYAkFqFza0z9bEiVWhp+9fnEyOeYoJmT
         psgM21V2o/ljlEZGRyJr+yul2ZkOh/iQnp6SZmZspk/yUbCBNRGD2R37daOCfbPLENaL
         O7KpMmldCwt9IE9PXoJ2kqi4amGSOGm3irnU2CQIJsp0GkVRi2B2ym89sc/Q3UQ3re0o
         +M/jTmIWZTTV6gkHz2lse835tV7ZtAwXqTczEEB8RBK/PV1f9fwZRBweVSI7eAk/rHbO
         cpBA==
X-Gm-Message-State: AOAM531D8w+vCOXYXOb+Q7VMY1h2FfUyoSYaNgiFy+oujPATQUjUcsCx
        Dz1MlKRM+PFKI/jTzFeqwHOrdZmrFXHfyWpvpYNp
X-Google-Smtp-Source: ABdhPJzk46WgqKiLMCnK+gVXdsBHpx6ESvSyLrr/rQQ/iC5ZSSH4PfyCm1yEJhFiaI2LGOyDHrWvTgjfpqRiD1gP3ds7
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:48c8:: with SMTP id
 v8mr18017318qvx.38.1612232579084; Mon, 01 Feb 2021 18:22:59 -0800 (PST)
Date:   Mon,  1 Feb 2021 18:22:54 -0800
In-Reply-To: <20210130044142.808860-1-jonathantanmy@google.com>
Message-Id: <20210202022254.1793991-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20210130044142.808860-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: Re: [PATCH v5 0/3] Cloning with remote unborn HEAD
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     avarab@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > I really don't care much, but this really needs a corresponding
> > documentation update. I.e. something like:
> > 
> >     init.defaultBranch::
> >         Allows overriding the default branch name e.g. when initializing a
> >         new repository or when cloning an empty repository.
> >     
> >         When cloning a repository over protocol v2 (i.e. ssh://, https://,
> >         file://, but not a /some/path), and if that repository has
> >         init.defaultBranch configured, the server will advertise its
> >         preferred default branch name, and we'll take its configuration over
> >         ours.
> 
> Thanks - I'll use some of your wording, but I think it's best to leave
> open the possibility that cloning using protocol v0 or the disk clone
> (/some/path) copies over the current HEAD as well.

Looking back on this, I think that it's natural to think that both an
empty repository and a non-empty one have a HEAD that points somewhere,
and "git clone" would behave the same way in both cases. So I'll hold
off on the documentation change.
