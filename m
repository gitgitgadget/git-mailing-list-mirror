Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE9BC433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC6B650A9
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 23:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhCEXL7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhCEXLb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 18:11:31 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C63FC06175F
        for <git@vger.kernel.org>; Fri,  5 Mar 2021 15:11:31 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id g7so2256333pll.11
        for <git@vger.kernel.org>; Fri, 05 Mar 2021 15:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1IoTnhELr+p7e7GlbC1veCgPcKpeq2VOvxDi14X4PhM=;
        b=odvxLZoZ2keogjTtCnCflOFgEWd94prUmX1nmHTlfAtO0NC0b1DQ4iJlBriW2n4jSy
         VCoPfu++Hbs8eQnrmuUoV5lO1Sgu+34c0Yo9kNh/y5Bz+aa7f1P5Zyrj+/GV7f/ou5+0
         AfU5gNOZSMjFxNxF7CrKzEaG8VMk+JxeAQEl3kqw89H3h+zdB8m3l/ZvFtGeokSY/eLd
         Pux3u/hfnxVplwgBhMb/ZnTkLuM5OoATBdEhdUZvsmAknjmO2gcPYAbODXPgH8JEsw1s
         vXmvRc4Pu7Owbu5eS/9Br4Th2O1sarlgCxYNP+8N7EhWMcvSaob32IgSE/aKh9bQLrti
         ryBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1IoTnhELr+p7e7GlbC1veCgPcKpeq2VOvxDi14X4PhM=;
        b=nXSBBsJFneANG+3aJiHDI9iQx4zpvY4eGi+mW6qY3oezy1GON870lXhIknKm40vQFG
         Jr9mCbFwgt9eiQ3ZVk7feHl+jrmnmbH6FLFv9xIvJFwbNunn9CyEEIs9QkUFuJU1vC2G
         oyMlq+u7Bhndt3N7OQV7Z2iXKdSJcMeR+JXsJ1lFiUDhvBOSJOpXve+aQrdUsiktYdRF
         Yz6gK+3jWCo2R8e9M4wRcmmFUXshA02t2IU6exLTcPNtkZy5QssIg4Y9TB9mJIdfXHxS
         lI4RK8jxrBB+VG0GlijlgznpRCJ5JpRFP1Ux/gOaByrGjZ3UX5ybn4xtxAYELvvfu6u+
         z83g==
X-Gm-Message-State: AOAM5318E5tp1UCCXZVXtNWlte/aixFL2OMy+BjcyVljj/ZZ2AD8Nzho
        SUZAZPYel6qwAfx1bCPMzfRGjjROUk4sPpEMA/VK
X-Google-Smtp-Source: ABdhPJy8+TBWJ5uje49E2uC0uAJMW/Ajrcuf6RMkKb/oqHNe+yPC3JnOfupxU7CiJKbBQd75kMvu2BHkEvtlsDjLMf7u
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:eb11:b029:e4:a5c3:4328 with
 SMTP id l17-20020a170902eb11b02900e4a5c34328mr10835839plb.7.1614985890939;
 Fri, 05 Mar 2021 15:11:30 -0800 (PST)
Date:   Fri,  5 Mar 2021 15:11:28 -0800
In-Reply-To: <xmqqmtvh9ye8.fsf@gitster.c.googlers.com>
Message-Id: <20210305231128.741196-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqmtvh9ye8.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: Re: [PATCH] fetch-pack: do not mix --pack_header and packfile uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        nmulcahey@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> By the way, the band-aid in this patch may be OK for the upcoming
> release (purely because it is easy to see that is sufficient for
> today's codebase), but I said the above because I worry about the
> health of the codebase in the longer term.  The "pass_header" may
> not stay to be the only difference between the URI packfile and
> in-stream packfile in the way they make index-pack invocations.

That is true, but at the same time, I think it's better to have the
arguments be the same because there are options (e.g. --promisor and
--fsck-objects) that have to be duplicated, and I think that for the
most part, the URI packfiles and the inline packfile will be processed
identically.
