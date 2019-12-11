Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2D0C2D0C6
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF962054F
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 17:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCThuQog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbfLKRNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:13:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41521 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfLKRNA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 12:13:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id x8so11060424pgk.8
        for <git@vger.kernel.org>; Wed, 11 Dec 2019 09:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZpHQmHW5A8/7Vpm8mflrZjs4foIerdYsMou5TBssh1c=;
        b=BCThuQoggE6bUDqn+xq8bsffVb04O2t+bh7nQyB7GiGFyooDFOmULwrSoSlEnvuPHy
         9TI1iXl+3JIlfva9yMcxaGVnJTKR3FYnQjbd1DIBI1jjEhkcLpwBgbeWcDI4hkjvzv35
         lxQ0shWiDgOMwlk9UiCYVZ0ij7mrbIw7kMJgB/g8e6u8xroLZh8wMwfpa9Yl5cVU3GvT
         VmFXKq1GzlFOylysxe29x1Cd2r/7AzM0augJNy53f+xCoXnN9fxchw0sI3gR0f36DEZb
         +Br5r+C7xYcOaRfa1dDwKzeInnsDEGDwBXfx1HWNZPt2Xq467E3VFV5drK3S0em6zuCg
         3RRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZpHQmHW5A8/7Vpm8mflrZjs4foIerdYsMou5TBssh1c=;
        b=hLfRkJ95cj58hdJ9V38OzAyfFY4EvU0nWa/fHRjJY6q7mzgV5m6UKUhFx6HDhGAMQh
         5PTJdlCbSLOrgryJtZU4xPWO8bPFEoBhlICd0c7V9e9WvzvOMhgz6n0pqptOBImFfgT6
         Dg77WCLk97NWeCUQ8PKqA6x6lOoTcxLKB5umNy9PJtypuPcY5LgwQzRhaR9ySv8JdSGv
         CugYAS412Vl/0zrId7uIMDNWwRbSUDQ1rZQodXVXEZy0+qrKh1l7gek4QzcpLCFwSIJt
         7HBODeOfPXYfLFXt+hCXTgY1/KHNJY+NwPLuKPoTG+96CjGy1+MXH6rj6U9BpVDdwh8n
         HvNw==
X-Gm-Message-State: APjAAAVAvSMw7btTEYJCnvv7pYajshDoAsfNWI+v/rNMWHBvvBkDDF9S
        zrLFR7gRbcXjSGM8vNpriFc=
X-Google-Smtp-Source: APXvYqw2cphjXpj69v/SBn7bS5Uubtn7LAdpSs4rOfOtcnKwXKm3Zyd+ANd0UuMWHhY4W4+ydtJJFw==
X-Received: by 2002:a63:70e:: with SMTP id 14mr5212535pgh.266.1576084380137;
        Wed, 11 Dec 2019 09:13:00 -0800 (PST)
Received: from generichostname (c-73-15-240-142.hsd1.ca.comcast.net. [73.15.240.142])
        by smtp.gmail.com with ESMTPSA id k23sm3515973pgg.7.2019.12.11.09.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 09:12:59 -0800 (PST)
Date:   Wed, 11 Dec 2019 09:13:56 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Keene <seraphire@gmail.com>, Jeff King <peff@peff.net>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v5 00/15] git-p4.py: Cast byte strings to unicode strings
 in python3
Message-ID: <20191211171356.GA72178@generichostname>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
 <20191207194756.GA43949@coredump.intra.peff.net>
 <95ead4b6-21bb-1aa2-f16f-888e61a4e4c0@gmail.com>
 <xmqqwob2pzty.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqwob2pzty.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 08:54:49AM -0800, Junio C Hamano wrote:
> Ben Keene <seraphire@gmail.com> writes:
> 
> > Yes indeed!
> >
> > I hadn't pulled before I attempted the rebase, and got bit.  Yes those
> > shouldn't be there!
> 
> So, other than that, this is ready to be at least queued on 'pu' if
> not 'next' at this point?

From what I can tell, Ben agreed to have this series superseded by Yang
Zhao's competing series[1].

That being said, I haven't been following along too closely but it seems
to me this series is further along and has received more review
feedback so maybe it should be picked up?

[1]: https://lore.kernel.org/git/afa761cf-9c0e-cdcc-9c32-be88c5507042@gmail.com/
