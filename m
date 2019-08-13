Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1F1B1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 22:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfHMWGi (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 18:06:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41280 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfHMWGi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 18:06:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id m9so49662286pls.8
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 15:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Zuh2DmSys2aujTITZt5lvIyyfJbKoMwR8OoHlTi45Qg=;
        b=M0L8GUXyjB1+/wDiuV+fxtx89lVfxstd0+MJUZb2XWIe9jDXhFvCc4e0Ua44ep467y
         3yz4kuI5PFWdhyRLLZQs6KK1LeyWA4Ij2pXLcDmWa2i7bKOKi2mdj2ukfcNoydAWwoa/
         B4UJaAI8B+u3kOq54x1tu6ez85tzUrRRFs6GHp5yPWl5wg4yMpUMX15FGZ5fu5j0UDve
         u8FtHUYDTGy0eaWh521ObJQ3cQu8YtUe7iXrtRk8QqPDmJ1fmE7BYlQxnI0rMCXP+fCX
         uw2GYpP6jSidTBhCJJ3mEL9pPw16aYcRH9B3ml338XsWwkaPtlPwE2Gp0FKi3qTDn4Qp
         wpDA==
X-Gm-Message-State: APjAAAUJpALBhqsWvTSVFf8NAY4Jyf4vxv0hw557MkEOuLyKV373bT1k
        g1nAMQU9Or4GJmYYaoa/MFjh3n/VkMU=
X-Google-Smtp-Source: APXvYqz9svuelxCef3IwEuI5BtE5gT/OHzAlNVsvBfXH6mNSN7ebw7iwgVLwI+yHX4wnaZoVfnsBZw==
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr40024067pln.304.1565733997091;
        Tue, 13 Aug 2019 15:06:37 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id i11sm13816139pfk.34.2019.08.13.15.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 15:06:36 -0700 (PDT)
Date:   Tue, 13 Aug 2019 15:06:36 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 15:06:33 PDT (-0700)
Subject:     Re: [PATCH v2 5/5] fetch: Make --jobs control submodules and remotes
In-Reply-To: <xmqq7e7g7mky.fsf@gitster-ct.c.googlers.com>
CC:     git@vger.kernel.org, peff@peff.net, e@80x24.org,
        chriscool@tuxfamily.org, jonathantanmy@google.com, tboegi@web.de,
        bwilliams.eng@gmail.com, jeffhost@microsoft.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     gitster@pobox.com
Message-ID: <mhng-f7e42958-08d9-4bbc-a745-4e40a67cb6f2@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 13 Aug 2019 15:00:13 PDT (-0700), gitster@pobox.com wrote:
> Palmer Dabbelt <palmer@sifive.com> writes:
>
>> The existing --jobs argument was defined to control the number of jobs
>> used for submodule fetching, but it makes more sense to have this
>> argument control the number of jobs to be used when fetching from
>> multiple remotes as well.
>>
>> This patch simply changes the --jobs argument parsing code to set both
>> max_children_for_{submodules,fetch}, as well as noting this new behavior
>> in the documentation.
>
> That's a sensible, if overly careful, transition plan.  This patch
> cannot be queued together with the other four, though, for the plan
> to be practical.  It probably needs to come a few releases after the
> other four hits a release.
>
> A less involved and much more careless transition plan may be to
> just declare that "--jobs that only controls submodule fetches is a
> bug and it must also affect how fetches from multiple remote
> repositories are done" and come directly to this step, without
> necessarily introducing options that control them independently.
>
> I have a suspicion that we can afford to go the careless route for
> this particular one, if we wanted to, as not may people would care
> about controlling these independently.

This was brought up as part of the v1, and the cover letter lays out a plan to 
do so.  I'm happy to re-spin the patch set to just have --jobs control 
everything.
