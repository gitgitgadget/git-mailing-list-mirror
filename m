Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CABC77B7E
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 01:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjD3BGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Apr 2023 21:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjD3BGF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2023 21:06:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3B6E75
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 18:06:04 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aae1bb61edso5718435ad.1
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 18:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682816763; x=1685408763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0MYSd+0UoYuDi+ao9EoyO/nwLtTXbOwKa2CdS1GstI=;
        b=CzZ79A9BsZ23oDd9gPw+UwlEMTATV+QNId8H3f9jIrry5fFUCdM8/c1xRXkrMHqnAn
         o+zrXlBQsVUspn14tbZ2KOseRuMHBsyQf/UWvPFjfVjlCCV6dYUNBLPQvIW9EZi9zjPP
         vMCl3hAtKNPG89jKfkeMpxzd7jp3M/awfykjOY8xq04BTwosj9t5ANY/X5dr35Lci/2V
         SVR4cqTY7XR2dbNtBdBdS3V624Dyzl5dDPHzvcrRtsk7EItRCSDdwuEb5/kNPIj5CeHS
         QtaUTLBXzji3s65AnXPaHLJV8m6lQSGhgyBkLakeXR+b7jn7MAk02mjKWWYXxs1r2hFR
         CElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682816763; x=1685408763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0MYSd+0UoYuDi+ao9EoyO/nwLtTXbOwKa2CdS1GstI=;
        b=SeoElK7w3BtI61o2sJs1P+DOK5SHkxnwslhrdvj2SZGhI1ROoO/XUpSRF/shDBu5qy
         lFTak3bt+qUBTSpgjxv4ScC2Ancl4fse9GLUdqYP/ZgylOn9pmnwbhx4Cp2IZL7Qo57S
         sE5TXu5iwV+kz4jAoCC790MC4VdREYXRHVcMMfanMKSjTtD/D6mjoZjpcg6D/3YoUJXW
         CL//OXfWHPM2YxXoh77AQ8jgFX+rKGk8Dn+zXp0Wlh0J0l8V6irIVQeAhlKtjL1BcRXp
         bMURSKveDtGtguoC1A7OWpNH3fJKyzBQ3aGJZEhOSWk00bGTNZVACeqtKxi2wIPSBJbM
         AtrQ==
X-Gm-Message-State: AC+VfDxzOwnlqUIYz0hg0+4YpbJLn22l3fVchAmkyOOlgHGyXqCFSx9J
        gmDXcyUKrBG9EHXwRyG4mx0=
X-Google-Smtp-Source: ACHHUZ4mb7DCuy2eG8XHgrlOh5bGF4O1Yik9Pgz1AK3+vAuzaiWh+YQFrTFjW6ftdLApx8zVOV1lUw==
X-Received: by 2002:a17:902:da8f:b0:1a1:add5:c355 with SMTP id j15-20020a170902da8f00b001a1add5c355mr11783836plx.5.1682816763510;
        Sat, 29 Apr 2023 18:06:03 -0700 (PDT)
Received: from localhost.localdomain ([39.144.154.84])
        by smtp.gmail.com with ESMTPSA id a15-20020a1709027d8f00b001a6527f6ad7sm15456067plm.85.2023.04.29.18.06.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Apr 2023 18:06:02 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     felipe.contreras@gmail.com
Cc:     --cc=avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 1/1] push: introduce '--heads' option
Date:   Sun, 30 Apr 2023 09:05:53 +0800
Message-ID: <20230430010553.4253-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.40.1.445.gf85cd430.dirty
In-Reply-To: <644bba3f96e3b_1c66e29436@chronos.notmuch>
References: <644bba3f96e3b_1c66e29436@chronos.notmuch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Teng Long wrote:
>> From: Teng Long <dyroneteng@gmail.com>
>> 
>> The '--all' option of git-push built-in cmd support to push all branches
>> (refs under refs/heads) to remote. Under the usage, a user can easlily
>> work in some scenarios, for example, branches synchronization and batch
>> upload.
>> 
>> '--all' was introduced for a long time, meanwhile, git supports to
>> customize the storage location under "refs/". when a new git user see
>> the usage like, 'git push origin --all', we might feel like we're
>> pushing _all_ the refs instead of just branches without looking at the
>> documents until we found the related description of it or '--mirror'.
>
>Completely agree.
>
>This is something I spotted a long time ago. Although I would prefer
>`--branches` over `--heads`.

I will cook this recently, maybe we need some well prepared test cases
at first.

Thanks.
