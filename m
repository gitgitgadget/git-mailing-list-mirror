Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67217C001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 20:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbjHHUhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 16:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbjHHUhX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 16:37:23 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BFFFEFB
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 13:05:26 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso6468897276.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 13:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691525125; x=1692129925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y+FgSbKayA0BV+/sLaNCW/jILWUrYLymkUIOaBQFZ4c=;
        b=Hx79fMwfjjXaoWP8+2O5Qt47pyLxHOtdDSh09SpTaXSaF1yHVTZpDDtSdfR9azaos0
         zqfEJ8sJXq5Uj+ESMmfIPu+S44/E3wyYkEl/QW3Xq/akB7i8zB20erI/V3C1ElVcrbF8
         G2g53hnAaWs7Zj/ROQ6U7O6WaWIl0g0CXJwOSODDKrtkzM0RwartMFz/CvAoqOkvpkKQ
         8xY0I0wNWkX9I7khsc4ojfRpRrRQnRGcE6q/5BriPsLR9VfDfom3t7taip86sgA+WbAM
         gQOsOf2Z40hh9my3pKl4XiWvi/LFLeCS/Be9eKb24w1XHORjpiseeX6lWZ5+bJFxow81
         Lkag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691525125; x=1692129925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+FgSbKayA0BV+/sLaNCW/jILWUrYLymkUIOaBQFZ4c=;
        b=iotQr0lwxDEKJiqF/oj1D2TCrAZWzNPYn2nQwhGi6z1mHRCP1RrOG2xQDTTH3vMRsx
         Pj94RqBwlfyklGMH6Wmp7DTtjdy2I4HRp9FIEoGamV3pp89YYh8X4qFGqN1EdC3Omgc2
         pBiPjpvAc+mTU7Al/r9NFggRhEPTvxkTE+vShqOQ4LR1IgvHmaKurrXscG+iZ3n5ZtDB
         OXyt9ca4dQEDb7TLVCHKyUOYYAKc9PxkrKNPAIdnSPgE/YULSy+Hbwz2hSpVg6bs+jK4
         ZhrmygmAeMEY7ct3BMfHZoFSm7AV6CoVRlOgY/dRWZOoo9shCln1Ws7vP7WRlPunyrRn
         BUsw==
X-Gm-Message-State: AOJu0Yw6Kre7wkhNmWB8XW2SzzKGtfTSgEvxEeczgJOC2/4BcmttnjP7
        qmECoNvWsHM96p/fRUl9RnWE/LztvsdogZpi00ifQA==
X-Google-Smtp-Source: AGHT+IHBY2gvpBFv5LWJLU34bmHqhH961mhr5nVa7Vhoy+CUthI9C917tJh643pivzhj1HaYlCi5xQ==
X-Received: by 2002:a25:5f42:0:b0:d3f:2238:8872 with SMTP id h2-20020a255f42000000b00d3f22388872mr547639ybm.63.1691525125434;
        Tue, 08 Aug 2023 13:05:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n3-20020a259943000000b00ca519aa8cf7sm2885302ybo.39.2023.08.08.13.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 13:05:25 -0700 (PDT)
Date:   Tue, 8 Aug 2023 16:05:24 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, lenaic@lhuard.fr
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
Message-ID: <ZNKgBMg+bU4k+9fU@nand.local>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
 <ZNFinmsgDI7Upw60@nand.local>
 <2db943c3-2ec2-4b7e-a161-a7c9b3f04d36@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2db943c3-2ec2-4b7e-a161-a7c9b3f04d36@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 09:49:40AM -0400, Derrick Stolee wrote:
> > But I figured I'd raise the question in case you did mean for them to
> > both run on either Sunday or Monday.
>
> I don't intend to change the day that is run as part of this change.
>
> I think all other schedulers run on Sunday, but systemd running on Monday
> is a particular detail of its "weekly" schedule.

No problem -- I figured that you didn't intend on changing the days
around here, just wanted to make sure it was known that the systemd
scheduler picks a different day of the week for its weekly schedule than
the others do.

> >> -static int systemd_timer_write_unit_templates(const char *exec_path)
> >> +static int systemd_timer_write_unit_template(enum schedule_priority schedule,
> >> +					     const char *exec_path,
> >> +					     int minute)
> >>  {
> >>  	char *filename;
> >>  	FILE *file;
> >>  	const char *unit;
> >> +	char *schedule_pattern = NULL;
> >
> > You should be able to drop the NULL initialization, since you assign
> > this value unconditionally in the switch statement below (or BUG() on an
> > unknown schedule type).
>
> Unfortunately, GCC complained about a possibly-unassigned value when I
> left this unset during development, so this actually is necessary for
> that compiler.

Ah, I would have thought that GCC would be smart enough to figure out
that schedule_pattern is unconditionally initialized via the switch
statement, but I guess not. Makes sense.

Thanks,
Taylor
