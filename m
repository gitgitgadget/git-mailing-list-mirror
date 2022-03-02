Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC0FC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 16:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbiCBQoR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 11:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiCBQoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 11:44:16 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8524E52E50
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 08:43:32 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id e22so1927903qvf.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 08:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ScMKSgg6ANDowyG/BlGWQS/AhqNGuanDzG+o8QxEAmk=;
        b=cp0t6s4OvSr1osb47mcKKi6zEmtNldG45uQiChwO/4iDJsUTupAuy9VChq0EGTO+6f
         Jon04HyN67iCP9hcttIbKse1SDFk/SM2WXaqXXYhfzpYXutBm6QYzL7Ym7ItXOKpZTsV
         9AT5VGxJOSqxCZgLbAm6BrgWYmdaHj/Zgal0OD2FdWdKWctalF9n8rSY9b1FYNUogPqp
         H7KusYf9CJ7Mui5sIQf5xbQkv5lDnKhLzTTp5j2LxuK8EZsp598SYdzRRzx/ZqSo+XVi
         gDtHEKZ1QqhBsPYdDcXDcH3x1h1EegBQH+SkN2EdFkoQTdNNoOah2H3f2n+rWBs3ic/A
         xHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ScMKSgg6ANDowyG/BlGWQS/AhqNGuanDzG+o8QxEAmk=;
        b=xAB4ss8V+Eor+R7S7te1MeuUld/5/+w0f3pPQo2jcfRz821n2n2L0occ0ycvXnxoIH
         GyqklPxf+x1WOa8Y3uFE2Dsv+Nf6nq4fflU3eoxUXOSj279xD3hh2smkuW6Jvt5v2Kqa
         CgdA7hLy4QMUBuVJtmZqfvboUUGk+/j6uisQ5BpwU/BgJ0el2DBmyc4hafVqD1nGAS3z
         RurBOhUr+JTF+kZfDGT8Gk97DVEJNW4SwG2eae2vsxNxLNezc1CDa7Wd6UfFiJzg3Le5
         RJAwnUKWya+OCwtO/dEkyiVApJsq+kT2rGshtJTyhZC3jpUAfqE106FCnwRBsOuzowKa
         v1Vw==
X-Gm-Message-State: AOAM533WearcutoZdHN8q9U/HZUculMskc1wRmPNZT1Njp8fMam7mCSZ
        dYiLKa57DMOieo21CJFM7Gz5FcQcbDU=
X-Google-Smtp-Source: ABdhPJyYNjWOFTZdio3rOmLm1c0svTVnyAStmeONW2ZOWzELna1yX2ahHR4vIIGJNq2Sgyhb4yDiIA==
X-Received: by 2002:a05:6214:c2b:b0:435:2ae8:e9a8 with SMTP id a11-20020a0562140c2b00b004352ae8e9a8mr1239577qvd.40.1646239411513;
        Wed, 02 Mar 2022 08:43:31 -0800 (PST)
Received: from [10.37.129.2] (c-73-165-109-16.hsd1.pa.comcast.net. [73.165.109.16])
        by smtp.gmail.com with ESMTPSA id p25-20020a05620a057900b005f1928e8cd0sm8048853qkp.134.2022.03.02.08.43.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Mar 2022 08:43:30 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     git@vger.kernel.org
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/3] libify reflog
Date:   Wed, 02 Mar 2022 11:43:29 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <69041BB1-569D-4462-A1CE-2F1BDA9A76C0@gmail.com>
In-Reply-To: <YhkwG5JGNKB2yl3i@nand.local>
References: <pull.1218.v2.git.git.1645554651.gitgitgadget@gmail.com>
 <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
 <YhkwG5JGNKB2yl3i@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Just wanted to bump this thread. It'd be good to get another ack on these
last set of changes.

On 25 Feb 2022, at 14:38, Taylor Blau wrote:

> On Fri, Feb 25, 2022 at 07:30:49PM +0000, John Cai via GitGitGadget wrote:
>> John Cai (3):
>>   stash: add tests to ensure reflog --rewrite --updatref behavior
>>   reflog: libify delete reflog function and helpers
>>   stash: call reflog_delete() in reflog.c
>>
>>  Makefile         |   1 +
>>  builtin/reflog.c | 455 +----------------------------------------------
>>  builtin/stash.c  |  18 +-
>>  object.h         |   2 +-
>>  reflog.c         | 432 ++++++++++++++++++++++++++++++++++++++++++++
>>  reflog.h         |  43 +++++
>>  t/t3903-stash.sh |  65 +++++--
>>  7 files changed, 539 insertions(+), 477 deletions(-)
>>  create mode 100644 reflog.c
>>  create mode 100644 reflog.h
>
> Thanks; I glossed over the discussion about tests (since it looks like
> you and Ævar already have a good handle on how things are going there).
>
> The rest of this version of the series (which I looked at more closely)
> looks good to me.
>
> Thanks
> Taylor
