Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA986C2BBFD
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC912072C
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 16:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="M2tRfnbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgDMQVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731410AbgDMQVn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 13 Apr 2020 12:21:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA702C0A3BDC
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:21:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g2so3556996plo.3
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 09:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sEEpL6j2AvA9GNxsZV+JX2b7XMyqEYFwJLyCt+dc08M=;
        b=M2tRfnbTVL9SNcq2qDmJ6y0IRJ1AR4TDpH0T9XfQO19zLgvob9TrOQ/V5/N1fM7Scx
         VSND/WTnSSjri0OA17Yt59VAobigO9WLZjl1dI3rSkzZgfUA446CNV09gwGWcIgbovOI
         /upuIy8S2dbswpJZUdDgbguMevSAIi0tMCuC2JmKUYwSJFkYyECzgiyyk0m0GpajRJcK
         SiUm1pZ/jZmFUxhunq1GbDiCnfBb2TFkAz6yHIAVerkvPiDr/P5ZyMoog5devSDVHWSP
         eO943RrGSFUfuCwmhriEmPqRDTjCFhvc73glFkzLdvfOOVg72674wqzaeewuC6jfYhDW
         YcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sEEpL6j2AvA9GNxsZV+JX2b7XMyqEYFwJLyCt+dc08M=;
        b=KS94acj7X+e1nvSorv1gv4XfwawaHZNjcbMrSStRWffjKRk7Gmbc3SsRm1qMTTZNg3
         i2xuR8H2zNfOM8ZiOhvJvBWsuy3lnWmzFaDUXBe3S8dQbGEvYDBoWBt/W9hpNFdWOR5C
         59B00XztbBtxwR8TNY5zybdC561Fc1dOcagJkDdPcWt4J0N+2DJggti1K3RN/dYAeT9V
         ZxaZ9DiNpAPIXG4R3eliWNN4D8952Gr+W6KQokzod14nH8tjvPyu9Ly7TTnVsiGCyMdK
         GL7Xf/+u/v6rhcNCRuK1Dgi87Jt952bTyzc1jEZpuT1xaHJvL10BuqqcEmUVpEtm7500
         nong==
X-Gm-Message-State: AGi0PuYNWfSPy/0/IyaA5Iw/up4gYqm/7Fmbr3S2KZf4t/vhQZMIPlfw
        5DtDfSr6Vl0mLSgKGjiMYuOb6w==
X-Google-Smtp-Source: APiQypI0mGhpK9NUhDUI2RQoH9BMLZjUbtgy7XG1Zzij2F82qn3FQq12J5wz6bSp8ppv9+J608m+7A==
X-Received: by 2002:a17:90b:380d:: with SMTP id mq13mr22446434pjb.145.1586794903340;
        Mon, 13 Apr 2020 09:21:43 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id c201sm9094578pfc.73.2020.04.13.09.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 09:21:42 -0700 (PDT)
Date:   Mon, 13 Apr 2020 10:21:41 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, jnareb@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 0/4] Integrate changed-path Bloom filters with 'git
 blame'
Message-ID: <20200413162141.GF59601@syl.local>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.609.v2.git.1586789126.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 13, 2020 at 02:45:22PM +0000, Derrick Stolee via GitGitGadget wrote:
> Updates in v2:
>
>  * Added PATCH 3 to write commit-graph files during 'git merge' if
>    GIT_TEST_COMMIT_GRAPH is enabled.
>
>
>  * Updated PATCH 1 with the simplification recommended by Taylor.
>
>
>  * Fixed the lower-case "bloom" in the commit message.

This updated version looks great to me. Thanks for looking at all of my
suggestions :-).

  Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
