Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21846C49EA5
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3AD61C3D
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 17:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFZSAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Jun 2021 14:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhFZSAA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jun 2021 14:00:00 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323FC061574
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:57:37 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id t40so15588582oiw.8
        for <git@vger.kernel.org>; Sat, 26 Jun 2021 10:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=XEPvOBbjvrjaIuYspIWFMZjOxtSuN6G9XCueLvtEnVU=;
        b=Ssnh5DlDZe3Jr7f/SRiKKK67NG3+NSlGPq25ik5D0GwjO7jI3BsLfwzWlDsMWIMAlm
         wzIHy/M36/3XpvkMlJ0TsE9vlInLxLCCzJVp59fEeCskmzbmIWblpOlNesSsg9KOQaOL
         H6Af3cRg/Z/cPcXyLwh2FMoCpSZ5hVeObrknCPgai39J0c5t54N5JZh73DbhYEdJvU8t
         HXo4O7Rhc05oU6UKUFH2pZ/bC9Sl0pplcFVIPYeEakhd5gEMGpvn5MjZVxCNBG9t17l9
         CaDBRb0r1ydE1bVTJktU0Sxwll+FbbKXFFQqcK1ILic7OpZKmis0OXe0TIh2g3Gqip/N
         NWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=XEPvOBbjvrjaIuYspIWFMZjOxtSuN6G9XCueLvtEnVU=;
        b=DHLV0qIjSJEAQpOZgzNNuIdIyMunjVnu22MXJ+bAB7DQpv+II39ap5eMsE8WilBxh8
         srrHblPEs8IZMfqjuWUbBC7PX94QIWY8Uc2NR6YgXt12ZYBXrFHnaDUDSSABCt7Qg6lc
         4jZhn/HO3QnpZngqVxrDuOyJXuXbzzfnOKLAy+4fUlIorf1OvW7fOsuR9qweS9cprVoO
         N5ZeWaRQl1ociGj7EKFJwdf7fW34/lXria0dDiPchBUSdpJlmKvUx3XeB3USHI2Ba21t
         Hk4y+s1Hm99eUnEKh7rZciXNwZ4nQihsSoE6vaiMjVYSsXqsbOUbPnIhdyVH91bTe312
         /D0g==
X-Gm-Message-State: AOAM532QkJWUTzVuRuWDhJtR+jksZax97Iofvh4rEAv/FKZEq23zn3tY
        gLx6qLwZpzz2VtnYlChr6zA=
X-Google-Smtp-Source: ABdhPJyl3cYEowBL0V3pSD3bG8q/bdn9szBLMLrheHej3Sej+UJjrJvmKNbwXNUOpnnK/Xgd6mEMhg==
X-Received: by 2002:aca:5e04:: with SMTP id s4mr12686376oib.133.1624730257185;
        Sat, 26 Jun 2021 10:57:37 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id y7sm2218815oti.80.2021.06.26.10.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jun 2021 10:57:36 -0700 (PDT)
Date:   Sat, 26 Jun 2021 12:57:35 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Message-ID: <60d76a8f5d2d6_1740d20882@natae.notmuch>
In-Reply-To: <20210626163219.4137317-1-rybak.a.v@gmail.com>
References: <20210626163219.4137317-1-rybak.a.v@gmail.com>
Subject: RE: [PATCH] help: convert git_cmd to page in one place
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrei Rybak wrote:
> Depending on the chosen format of help pages, git-help uses function
> show_man_page, show_info_page, or show_html_page.  The first thing all
> three functions do is to convert given `git_cmd` to a `page` using
> function cmd_to_page.
> 
> Move the common part of these three functions to function cmd_help to
> avoid code duplication.

Makes sense.

Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
