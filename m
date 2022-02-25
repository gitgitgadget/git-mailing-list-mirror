Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056D8C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 03:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbiBYDF3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 22:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiBYDF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 22:05:28 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4472763C5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 19:04:57 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id c14-20020a17090a8d0e00b001bc72e5c3ecso2220021pjo.3
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 19:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Q8NgJCsAi8YNvrWyp53vai/J4aR6Xi3b12utc/Za5m0=;
        b=TJ/t94l2mNqfArxalQcbvQW6cpsMHcp/Jz5lqXYlnKfN5HwqsdHjWufGWyPI3gPdrp
         qUjZ/WoH1u5d0Dd2x2f+LYLhtKTj1AFeQmVCFtPUFTPCBkNSuPycpiwoxlojXrm1AMJk
         BHIn5id5gtViAYdimzxXyxyqdQGtaAgtzzyfVN/E2QawPyequWLtdyAKNnTj5dO0NXGt
         5bHeDJjcaZeV2RhYtJhCU3E+VvBXqpxIECWN2TY34/PA/MPIBDf1LIzvGGnOTR6OzNk3
         ihZKLz3M4YosQsolLY7ZU9qvYWOucJLwX+SSuZJ6nOTrx03B9M8y/NSyZHUhzDMpllyj
         VOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Q8NgJCsAi8YNvrWyp53vai/J4aR6Xi3b12utc/Za5m0=;
        b=UDg6j64nS9euhgSVxdKH4wKCbT8K6xYrCfc7eNekKJ/yTdTroZkN4WdIxZdv/RNQ0S
         Ka6IUNCHserPz+9T0JxK4l5Gz0lPEOOrrYWMW5dlavn0DSpK3EMfEQ40liif9sgWf+Zl
         2iZgaenrUEG5ERTu95vlaGC4wrsY9p/23EkSn7fFpk94YVijWFHsU+MreDoHYETyFZJz
         9xWTFatEXRIX4EhAEVIw1EeQETFG+g2FuppogcnLsG0TWAcqaVN4VmRH6SfphP6T9y8L
         fdzz4JM6FcuzX2DUtUFTb7Ouv+jOrpa6L/OP3oLmjH5rQC91GQGnaCNiSBmaoZb62exc
         zi6Q==
X-Gm-Message-State: AOAM531h9zKHFucKG9UTDzUovwc92jj+/y+McUGYF1F9hqDPssOlvXJK
        Dw7ZFJqmWmsrrE07zmboXXhfNZJdrVxotQ==
X-Google-Smtp-Source: ABdhPJyYrXo73Ru5mnWcj9nxcnC7qyuvhUQd8aDt7KMCKGkGmg5BLF7p8yVslYlhbUdh0x1bW1hfC6geKUGbeQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8495:0:b0:4e1:6419:3d3c with SMTP id
 u21-20020aa78495000000b004e164193d3cmr5465130pfn.57.1645758297126; Thu, 24
 Feb 2022 19:04:57 -0800 (PST)
Date:   Fri, 25 Feb 2022 11:04:55 +0800
In-Reply-To: <xmqqy220j6kf.fsf@gitster.g>
Message-Id: <kl6lbkyv4pew.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
 <20220224100842.95827-10-chooglen@google.com> <xmqqy220j6kf.fsf@gitster.g>
Subject: Re: [PATCH v3 09/10] fetch: fetch unpopulated, changed submodules
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Glen Choo <chooglen@google.com> writes:
>
>> +	char *path;
>>  	/* The submodule commits that have changed in the rev walk. */
>>  	struct oid_array new_commits;
>>  };
>> @@ -818,6 +828,7 @@ struct changed_submodule_data {
>>  static void changed_submodule_data_clear(struct changed_submodule_data *cs_data)
>>  {
>>  	oid_array_clear(&cs_data->new_commits);
>> +	free(cs_data->path);
>
> OK.
>
>>  }
>>  
>>  static void collect_changed_submodules_cb(struct diff_queue_struct *q,
>> @@ -865,6 +876,8 @@ static void collect_changed_submodules_cb(struct diff_queue_struct *q,
>>  		if (!item->util)
>>  			item->util = xcalloc(1, sizeof(struct changed_submodule_data));
>>  		cs_data = item->util;
>> +		cs_data->super_oid = commit_oid;
>> +		cs_data->path = xstrdup(p->two->path);
>
> Iffy.  If item->util were populated already, wouldn't cs_data
> already have its .path member pointing at an allocated piece of
> memory?  Can we safely free it before assigning a new value, or does
> somebody else still have a copy of .path and we cannot free it?

Great catch! This is a silly mistake, it looks like this because I
copied the pattern that we used to _append_ new commit oids, but
.super_oid and .path aren't appended, they're replaced.

But we don't even need to replace .super_oid and .path, we can use the
first values we encounter and ignore subsequent ones.
