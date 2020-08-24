Return-Path: <SRS0=3swP=CC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E532DC433DF
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 07:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E46206F0
	for <git@archiver.kernel.org>; Mon, 24 Aug 2020 07:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZoHXJkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgHXHun (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHXHuk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Aug 2020 03:50:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF10C061573
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 00:50:40 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v16so3838346plo.1
        for <git@vger.kernel.org>; Mon, 24 Aug 2020 00:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HPSuSXl5s17C53o/ROozunXQD++ALFWgud8mWZ96q4k=;
        b=QZoHXJkNgwyh9nnJ0ZtCzb8KV8Ypu67GZlb1sANemjwvHiBHM06EFTnKH45uRdlsqk
         nSSLHV2TPBJ2oW8d6Ny/VMtWTbjodKcl68aQ99QbNwFIgOxixVn4mScfFOOxDLvC7iCV
         E7kYD3t+WVajdWfV4YHa9kPdIRDCPSuP5a8lvifhiyc6gUe5kB/QzZXu1BcNRXYCT8hB
         kXV/Hhb6Qt+1O25q/pAgZDAn/BmcG/Q7U5AE3SmBJSNXnHzVldUpOdWQyh+JdCn6E+z9
         h7K+GOH2Dyte8z9jS+dWZj677Cw4wUtzSSmt0XBRyZcgmy87ikZf8ij7xBfkHNUuig9X
         9guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HPSuSXl5s17C53o/ROozunXQD++ALFWgud8mWZ96q4k=;
        b=ddLYTqmTJh+mNtYyIIrFQpo4XMQHzJ90L5LYdmShxkwsjSMUuQdKVjaCafKfed2I7S
         80Yd3qepERATifcfxtP5fzxynWnZzifaGaDgZes2fgAYGKHYwmfd3bMc1pZQLua/9pjY
         mUTBR1LO40wxfHsKnJvol+Aj1JUIhwEWpGhGJZ8wzuNvZdlNoUZ60t2cc7A+oZ7BV2XR
         vkSQKEWhSkrXMSrL/VQxzaUW8LlvrgGEOfUD/BgFsBnDSIXCxQn/A2Gu3qaLMsSnCtON
         73ejup8rYr90ChtUhL2RvY04s7mhzJMtJDkzAPKvr3MixL09rsWMgBWDSUZoIwtqk5en
         smZA==
X-Gm-Message-State: AOAM530+jak37PYYTowjnBwgKOaCgb9GyOacp7d8wmst3EC+SaR3mu92
        lJqZtzBy30gIhP6TWc4YtyT1gXX6rT/mZw==
X-Google-Smtp-Source: ABdhPJxceGfWjI3ryr8FRD1la7LuuDAKqJEW+egT0+Pm7rrrw2eWAXW+2je+V8a0jN01pkoaPAFffQ==
X-Received: by 2002:a17:902:bf03:: with SMTP id bi3mr3049390plb.285.1598255439777;
        Mon, 24 Aug 2020 00:50:39 -0700 (PDT)
Received: from konoha ([27.7.229.188])
        by smtp.gmail.com with ESMTPSA id x20sm8620473pgh.93.2020.08.24.00.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 00:50:39 -0700 (PDT)
Date:   Mon, 24 Aug 2020 13:20:33 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de
Subject: [GSoC] Shourya's Blog
Message-ID: <20200824075033.GC38870@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

This is the sixteenth installation of my weekly blog covering what I have
learned in GSoC and other like stuff.
https://shouryashukla.blogspot.com/2020/08/gsoc-week-16.html

Feel free to comment!

Regards,
Shourya Shukla

