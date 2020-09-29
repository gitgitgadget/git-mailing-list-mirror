Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ABDC4346E
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 06:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E81B206A4
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 06:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw7qS+CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgI2GZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 02:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2GZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 02:25:58 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170F1C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 23:25:58 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q4so2098416pjh.5
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 23:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rdFkBH/7O1mO45oqP4RK3C4Z+dGWiS10CAW76HyShZ0=;
        b=Rw7qS+CBsbAD0E4iSWlLO+v9it8t9K1g1GR4jhSwzNL5cuF8wzIAYtovoxoHTf+3Id
         S5SJ0LXfGHjWYkxC2E3oqQjIO9lM4kwNmzC849t8O3ATaaM9ZO23BsYVsZAWyRcpuPj6
         hTXPWix02P65PCW202tKeEpxI6pMmJ1ZNGzrsQqvImuaNYduT10dhsl2VK+zPXXQXvLw
         tNwsPlZU5DjbnTOheu87gts5vdju/ddi9kckRQhTzCvoH5i5ILzMwjItD3m7+YCOXCrX
         NsaTcMbtXa/brreydhVse6aqzK4DJoPmXt6AQvR8p1HzovQfesCR4WLXT6OeJjvhCxQS
         9NTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rdFkBH/7O1mO45oqP4RK3C4Z+dGWiS10CAW76HyShZ0=;
        b=SJTPMv8KJqWn/ifqGN1oM8bRyxTVbM2xYdoujDOoB90hzbWFRxRRUt7Fa7GZxFVdvL
         ZmeDnLnsx3HRybBZ/9ZvflHatpjoxfGJY/FnmgJjYWJQVU4Kw/3YiK4G5LzK4wpQHqBz
         oJ1YWUj+t5a6luLsEEcv0McRnCkmEfldJLXK8SFXB4KFLHAt0x+vLHUfViw4EXPTWNVF
         mIVgy+KX1jtCnkIVRirCzT/KtTVDw2pLyGrY+KP22YEOxlBI94wij4c2Glzf/PiepkLP
         BKss/EDbfhFgtXmD97EdzRBQeH802emfpF+P8o1WleTJut1SQ7wfpSGnUwKssa7joIZV
         teoA==
X-Gm-Message-State: AOAM531G4WxzdbN3j9r9Ambc40hTIzNJWOmcIwvxGr9D7o8vdixW3plz
        IXvJYxXUacX+9VOY2CGEAPA=
X-Google-Smtp-Source: ABdhPJznignNaiZRicSZ94w+J81NCM9RL02SdIhk6d2eAH9ka+pKHckzfRZ4WqqhxR1Aq8Sv67/Lzg==
X-Received: by 2002:a17:90a:e64e:: with SMTP id ep14mr2602868pjb.173.1601360757694;
        Mon, 28 Sep 2020 23:25:57 -0700 (PDT)
Received: from generichostname ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id v6sm4000520pfi.38.2020.09.28.23.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 23:25:56 -0700 (PDT)
Date:   Mon, 28 Sep 2020 23:25:55 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Karszniewicz <avoidr@posteo.de>, git@vger.kernel.org
Subject: Re: [PATCH] git-completion.bash: stash-show: add --patch-with-stat
Message-ID: <20200929062555.GA45164@generichostname>
References: <20200928110517.24915-1-avoidr@posteo.de>
 <xmqqh7rhn3nk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7rhn3nk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, Sep 28, 2020 at 11:43:11AM -0700, Junio C Hamano wrote:
> In any case, it might make more sense to do this instead, and then
> rethink what options make sense to these subcommands of "git stash".
> I do not think patch-with-stat should be among them.

Perhaps it would make sense to add --patch and --no-patch to
$__git_diff_common_options and then use that list for `git stash show`
since it's documented that all of the diff options are valid.

Thanks,
Denton
