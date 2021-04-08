Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42375C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10CF461106
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhDHXE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHXE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:04:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBD6C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 16:04:42 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h19so6662141lfu.9
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 16:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=XNxK8QlUP2gLgKWE4qrTwqQUU+KsVIOVg4fJfrPgwc0=;
        b=Wnk7LhWAKgrW8X5gqiAI2aKzLM7Vy/DfTdcb7O/TNk2brAW3I+ebD3pd+HrzCU0HHi
         /jE8lnkpOl9lejJtpqC0eH4sgEKeE00TZfGiHbZbkpQ24KGWluvmctBTcboIM0GhSAfk
         JC9C1ZwsM9yru33N0xnvSmU/QwXYNgV6KrxEkYCSci8/5ExM+yuAUdwrsVi7L88D5F3P
         b0N+8lDG9MJwrgPSFjT/m24k/bak7A2IIrVI5GFB6HJP7FlP7vQOJpSyIRPFZ7sIyDKv
         8IsxMx/eFvNaOhU9vRdgi0mDR30OjqZnxdn1Hs0pZaGTWDyIIzPP9vHhMEZPPPXH4saW
         RwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=XNxK8QlUP2gLgKWE4qrTwqQUU+KsVIOVg4fJfrPgwc0=;
        b=eTxbbBMwxIPv9LwnUH+Z1CA2qw2W64Sx5DkGkndDQOrbltMx5Rb2o/idDOqxSKKRAH
         vSopqBJTt35jG2j6RlblDWlPJZjJLuIQ6Npbg+yTGGcy4VFAwzOnsDRt7TOKH4xBTP6r
         /qCJOYYQiGzUKn+GYWqA+i8B8uJbk5hW/wt5gKgVcG9ER7Uz7jU5jwbYMWhPLV1PzTqM
         cJPcnxV82GB2mWIFaMAdKYIf3b/iOnbpQfZxmMnFTSR6J6gnk8v0NbZnqw13CbTdfGgC
         a1bcQUus3xFaOUW0WvpdOMMk2n1CD0v0rhi3b8EuVkO2wks5RPVaTeJkeLHIu1D9/Ju+
         LA5Q==
X-Gm-Message-State: AOAM532bjX3eh1TfZmExHyyS47fLEp08x8e/DOj5xISMHVDuNE43Xk9e
        CzCRRM9LveX0kYEXUzm+2kcBV9rbT9Q=
X-Google-Smtp-Source: ABdhPJwXTc59VMJHw32IU049BSzBKYZbGtq2aQzsxaPOGsUIjhRdTPDfhTniBjJH0M1NhzoMb3BYQA==
X-Received: by 2002:a19:3804:: with SMTP id f4mr8644579lfa.117.1617923081096;
        Thu, 08 Apr 2021 16:04:41 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l4sm81299lfg.123.2021.04.08.16.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:04:40 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/9] diff-merges: introduce log.diffMerges config variable
References: <20210407225608.14611-1-sorganov@gmail.com>
        <20210407225608.14611-4-sorganov@gmail.com>
        <20210408213736.GB2947267@szeder.dev>
        <20210408215115.GB1938@szeder.dev>
Date:   Fri, 09 Apr 2021 02:04:39 +0300
In-Reply-To: <20210408215115.GB1938@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Thu, 8 Apr 2021 23:51:15 +0200")
Message-ID: <87lf9s5qew.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Thu, Apr 08, 2021 at 11:37:36PM +0200, SZEDER Gábor wrote:
>> On Thu, Apr 08, 2021 at 01:56:02AM +0300, Sergey Organov wrote:
>> > New log.diffMerges configuration variable sets the format that
>> > --diff-merges=def will be using. The default is "separate".
>> > 
>> > Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> > ---
>> >  builtin/log.c |  2 ++
>> >  diff-merges.c | 11 +++++++++++
>> >  diff-merges.h |  2 ++
>> >  3 files changed, 15 insertions(+)
>> 
>> Please don't forget to document this new configuration variable.
>
> Oh, just noticed that you do document it in the last patch of the
> series, and, similarly, you add new options early in this patch series
> and add the corresponding documentation in the second to last patch.
> Please squash in those documentation updates into the corresponding
> patches.

Sorry, I fail to see how to do it that way, as documentation has mutual
references between --diff-merges=def and log.diffMerges, that are
introduced in different commits.

That said, after squashing tests into corresponding code commits, that
has been already requested, the documentation updates will be closer to
the code commits. Is it OK with you then to leave documentation changes
as separate commits?

Also, Junio, please clarify what you prefer as maintainer, fine-grained
commits, or squash everything even remotely relevant into a single one?

I honestly fail to see where the preferred margin is, and start to get a
feeling that I'd better squash everything together.

Thanks,

-- Sergey Organov
