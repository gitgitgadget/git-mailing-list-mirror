Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE7CC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 20:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCIUrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 15:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCIUqr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 15:46:47 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637C2FFBF2
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 12:46:22 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id i10so3302956plr.9
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 12:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678394781;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B3rNXkHmRiJI3iGa8fkyofxEuWobi1b6SHfLS9c6EgM=;
        b=CQc2bJgns45z+72avFA5b6SYtBro+4QGtTd3qqwW6lDcawxLLmWRUbey5qHAaD8XFy
         VS2u5X3nE6kqqgAQWIwJXoC1L76h0nvjSlpNH7qCyn4x98cffOIeoiMDm7R7UyMTCOK+
         f2JFRIyelle+a+IYWokDVKPoSW2fBEwCevVf+NAMMAZd+d6w1mHgKXtdL3sDblK5TOTL
         KbslClsCsMSVxglgs1Db+Yzyw31G2iv7gjJ6pi8AwyAj4lLkisyrQ1H9sqMcpjKUl+0G
         U6nwONih9pnpBs1gqCuB7VRVEkwURhYxAGyuGInRHSGBn4l4FDvzYSzmwhBfjlvRcIYs
         vKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678394781;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3rNXkHmRiJI3iGa8fkyofxEuWobi1b6SHfLS9c6EgM=;
        b=J4B90EkE76V7NPISf7zZk9NOuLCQbNFX0YtGNkdlByPz7Bj/PPLHAxDuTGrWS30yAi
         gZQZpVwIqATS1eu0+SItMC1IvSutrbQhwA+V12DRM1V9zegYTJ3lq6EmjApwDLb/n36g
         qcPGMhQFIqgpDcEf7k+4/nAYxXbCq3dwI+TZrm/hutHByQBSlQDmbmLmPjA6L2REreUN
         hBIT8uuILAO8JyLr7YqLIq1FkKMdx93RxlTmRjfodtXbSsIt0tyVLvVpXK51EO4NQZrk
         AWz5x1ClJyAmotAW7dk4sTTLU7/3pCNX1rtWUqMn4DnGn8mN36a9fX9G7yFxHFCb5JmR
         ehxQ==
X-Gm-Message-State: AO0yUKUNP5a9fqGw4bsnJYx3hNUSwKUdzS9Wu2aj/LQKQgnFf48AD0TM
        lQif+Y9Fajwq1CuMPqS5C4ZAG+qlOLA=
X-Google-Smtp-Source: AK7set8+/Xn9dnO/eCd2LPtAziIJV0MbFRJdUGxA1YXaE2c5BbrI+6anDkS7VaJxrMojjHT/xtxXcw==
X-Received: by 2002:a05:6a20:4f9e:b0:bc:f665:865f with SMTP id gh30-20020a056a204f9e00b000bcf665865fmr19055547pzb.19.1678394781256;
        Thu, 09 Mar 2023 12:46:21 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id j10-20020aa78dca000000b00594235980e4sm6800pfr.181.2023.03.09.12.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 12:46:20 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>, raymond@heliax.dev,
        zweiss@equinix.com
Subject: Re: [PATCH v7 0/9] config API: make "multi" safe, fix segfaults,
 propagate "ret"
References: <cover-v6-0.9-00000000000-20230307T180516Z-avarab@gmail.com>
        <cover-v7-0.9-00000000000-20230308T090513Z-avarab@gmail.com>
        <kl6l8rg5hhen.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 09 Mar 2023 12:46:20 -0800
In-Reply-To: <kl6l8rg5hhen.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 09 Mar 2023 11:08:16 -0800")
Message-ID: <xmqq4jqtac0z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> This series fixes numerous segfaults in config API users, because they
>> didn't expect *_get_multi() to hand them a string_list with a NULL in
>> it given config like "[a] key" (note, no "="'s).
>>
>> A larger general overview at v1[1], but note the API changes in
>> v2[2]. Changes since v6[3]:
>>
>>  * Glen pointed out that ejecting a commit in v6 orphaned a
>>    corresponding forward-reference in a commit message, fix that.
>
> Thanks for your patience with the rerolls :) I only spotted a minor
> comment issue [1] (which I think was what originally motivated v5?).
> IMO this will be mergeable once we reorder that comment.
>
> 1. https://lore.kernel.org/git/kl6ledpxhi3t.fsf@chooglen-macbookpro.roam.corp.google.com/

Thanks for carefully reading these patches.  I agree that this round
is in quite a good shape.

