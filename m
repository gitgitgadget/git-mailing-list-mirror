Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FEAC43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 19:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2CB207EA
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 19:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIsHTNoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgINTtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 15:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgINTto (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 15:49:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC31C06174A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 12:49:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i26so1613210ejb.12
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 12:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RV2Oiz7/YPIvF5tGQV6EUgwwEZEegxn/L4Wkh6YyAG0=;
        b=hIsHTNoaBex0nQsvR9LgK53Se9Olq3Xnl0kIJgxQXaaDMtibxD3NzkeevxoY0fqIF0
         bN6Anv3wXYqFZpKeNKT9WytA++apr1Cr0aHLJorQi+MwGzZevxBJBcOJmr6X4l8aDVki
         M75UADOGE+JgBYBX7X7iwBOs5o3KSQLEE81zDTM9TXJdcILLeX0eOnGS2qFGg6O+Vb+m
         PBc+jyMXi21BkAdJoL4bHtkQrHkB7V0I5nT7JCUhHTSIEaLAdXF/xouTPnsrdmPI/oQw
         a3jxHk4hlwcKzZKgZNNCr91zcHbTHOSLygGXCRjIClUN6Ko0Bv5PCOR0OLDKJM1T2qfa
         iYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RV2Oiz7/YPIvF5tGQV6EUgwwEZEegxn/L4Wkh6YyAG0=;
        b=I4hcE8gunCXQZPuEJNlUMuBXMWQHgtCNH2h3WnUK7vjGcqx93xTtYDdBY4JxSGZNck
         OochIKiMKgHsab1X+Hp/SXKUtJibM7DOWbKABtyeSEYCUkXyWqMxGQmVXNAuYycWPHk9
         lYgolw0VLHxjdGEIZtOyw9Q7BWEZ7V7iacDvnl+6zXR7NkpvFzjSRa+TWwiEOnNxti8q
         pWzEbqj+NjpL1ojXk0dSiEklpeNvzzWG2y2wkL+YYAAldI9zDd4HMFBueguK6xZBmvMz
         kq9MmEc0sMC325ytSU9Xc8tJjkRJ1DxtNGvJf0cANNAYLqlqbeLxk0eYRRJZA55QNKp0
         sfVw==
X-Gm-Message-State: AOAM530mNiNygCNjXOfVX6am9fjecb/5pwBqevaGOevt+PTLF3+RbxUl
        THObxcA/EKq9yiy9RklAqUSSPyiKySY=
X-Google-Smtp-Source: ABdhPJzeyjVg0GkrgadSLKMNRdFLvgV864jlV5AxVjsIDfIOOntbZ0EHScvxXhP9fh0sL6WHSuBoxA==
X-Received: by 2002:a17:906:4d97:: with SMTP id s23mr16886036eju.157.1600112980800;
        Mon, 14 Sep 2020 12:49:40 -0700 (PDT)
Received: from contrib-buster.localdomain ([212.86.35.156])
        by smtp.gmail.com with ESMTPSA id n26sm8218672ejz.89.2020.09.14.12.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 12:49:40 -0700 (PDT)
Date:   Mon, 14 Sep 2020 19:49:38 +0000
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com
Subject: bug found on the new git maintenance builtin command
Message-ID: <20200914194938.GA4235@contrib-buster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I found a minor bug when testing the new maintenance built-in command that was
introduced on 679768e2a1 (maintenance: create basic maintenance runner, 2020-08-25) submitted in [1]

When running `git maintenance` without argument it receives
a segmentation fault. I'm running git built on the current `seen` branch that is pointing
to bf3e2864f3 (Merge branch 'ds/maintenance-part-3' into seen, 2020-09-11)

I did a little investigation and it seems the command needs to check when no arguments
are passed to the cmd_maintanance() function and either quit with usage or redirect to man.

To reproduce the error, just run the `git maintenance` without any arguments

$ git maintenance
Segmentation fault

Analysign with GDB right before the SEGFAULT are thrown, we can see
the argv[1] pointing to NULL as follows: 

(gdb) list
1628    int cmd_maintenance(int argc, const char **argv, const char *prefix)
1629    {
1630        if (argc == 2 && !strcmp(argv[1], "-h"))
1631            usage(builtin_maintenance_usage);
1632
1633        fprintf(stdout, "run");
1634        if (!strcmp(argv[1], "run"))
1635            return maintenance_run(argc - 1, argv + 1, prefix);
1636        if (!strcmp(argv[1], "start"))
1637            return maintenance_start();
(gdb) print argc
$5 = 1
(gdb) print argv[1]
$6 = 0x0

Hope all this information helps with the fixing it

[1] Patch submission can be found in:
https://public-inbox.org/git/aa961af387b7f458f75ad60b9a2a45da4bb43794.1599224956.git.gitgitgadget@gmail.com/

Regards,
Rafael Silva
