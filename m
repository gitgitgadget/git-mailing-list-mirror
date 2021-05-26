Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E108C47088
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A15613EC
	for <git@archiver.kernel.org>; Wed, 26 May 2021 18:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbhEZSfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 14:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbhEZSfD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 14:35:03 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5C8C061574
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:33:30 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so1947631otg.2
        for <git@vger.kernel.org>; Wed, 26 May 2021 11:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=3N8zNSNTeChpUgJraZnIgVkJIxHsGhCH9cOfGSQeJ90=;
        b=N+6AQ6s6zT973SeM5c7+7vAm2zSEmeuxHH8xEzSfzXOKjW9CHdofqicObU8pp94vSZ
         jBpB0ef69OwvQsena2yCJ55WUApNV9mrBmWNXxZb+cI9WWkG2UL6aaN/Q9B4M9FxVjPN
         CL7FG1q/S3JJ9mft875t0kPODKfllbiJ07db1TL+oxkeiX1H09ieBfQhpMv/hlyeZABM
         SZodclyK2ZBawPaKOlp7UDGv/6LtFu1UzQVPQY+uDoUTHhZtZofpgj1Gbk5qomM+YV80
         PzOWZlQb36s18GUyd2UscnknqfcOo0GqdKkfYNzQCRzwiP1zVRZIDZwmdxy5GQ9y+sZS
         9BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=3N8zNSNTeChpUgJraZnIgVkJIxHsGhCH9cOfGSQeJ90=;
        b=AteUG4za2nf3mRgaXXPwGj5S5umYNH47NYczI5cA9bWyWO34toBkBUZP/sY+K+7c9K
         jbgxYaxN0nnGUUMZS10Db3J+oNf1hmOsMXIgulVDjeiJ/Z3+kFMxRMN5TB3HAGNNNvbV
         b9/vhNLIfJ/H5Mw20EkHsHy7j3Y0ExdnktYdaR0fbmI3da0YGC1BvDFMFE0aA5Ol9BxP
         FFbrsGrPZ0cpy7zIsaXEsX+zHabQD2K99Z2jdOoCzLfvfH28iwZ3B0z0V1lQqvlT343Z
         ZBy5LZzX4V4lLvQI8pe0diJl1b/kpviZWN5Qq4NxDc9wnlVw9ZbCgSbc7XCwpxbJ8Dvs
         JC+g==
X-Gm-Message-State: AOAM531r1nwldmaf+gpJxoYWX3AWIUfTQ3HFx5JuFS4qHDHQVM1Zqn+x
        /CegGLttWkkv+6HcKGSqt9s=
X-Google-Smtp-Source: ABdhPJwfQHOCg/NDi1wW6kiy9oM9lup7GyInMfUYx4c7JPtioyIFGaKGT2+qevWRgj1kRam1Vs9YJQ==
X-Received: by 2002:a05:6830:1f52:: with SMTP id u18mr3383430oth.298.1622054009851;
        Wed, 26 May 2021 11:33:29 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t14sm4370443ooh.39.2021.05.26.11.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 11:33:28 -0700 (PDT)
Date:   Wed, 26 May 2021 13:33:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60ae947797deb_25ba2089c@natae.notmuch>
In-Reply-To: <da77d0a0-7fdb-e4c8-6510-87ea0294dac4@iee.email>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
 <60adb824bac10_2c7f620844@natae.notmuch>
 <da77d0a0-7fdb-e4c8-6510-87ea0294dac4@iee.email>
Subject: Re: fast forward merge overwriting my code
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley wrote:
> On 26/05/2021 03:53, Felipe Contreras wrote:
> > Andre Ulrich wrote:
> >> So the last point is where we still want to do some fine tuning. Right  
> >> now this looks about: my prof fetches my edits and locally checks out  
> >> a branch to compare the changes with git diff.
> >> But in this diff view you can't edit the files. So you have to  
> >> separately open up another window to edit the changes (lets say my  
> >> prof only wants to keep some of my changes, but not all).
> > So for example after fetching your changes your professor sees this:
> 
> Part of Andre's problem was that this diff wasn't stable because the
> underlying file format is said to be json so items can move around
> without issue (e.g. key value pairs swapping position) and that they
> aren't really working on the json file (it may as well be binary..) but
> on the jupytper notebook display view, so one step removed from the 'diff'.

Andre said they use the diff view, and he wants to be able to edit it.
Not sure how else would you interpret "But in this diff view you can't
edit the files".

-- 
Felipe Contreras
