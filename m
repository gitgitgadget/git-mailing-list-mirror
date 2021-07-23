Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ADAC4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35BA660EB5
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbhGWPT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbhGWPTy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 11:19:54 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D40C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:00:26 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so2448129oto.12
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 09:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=wYBBGo9H3NcLYobkCDwfKYdbVok34KxqzwOSnoIIIT8=;
        b=XNRUaeKjy0N56wTpF6CljFR0mPjocgLYaawxeVyXzIh+40OIGehJj77K3vLqgj/rgU
         r7EpDnRH3odoCdubvOphySokwKJUxKFfoXYo+IUiJPrIhJlKDFl/TlDKjc72fHb/lt83
         RTyIHOLIviKpd5mxFxIrjfcpoZeqTp15AjokKdfLJ9VseOoh2fTR674S4tQCnaRiHkD5
         IjknWcxhRtklBjvYXz/wz22aLv9PG5icvcyC3UXs978RSxp8MBBzQq1JxgvbDU7ttvsb
         EmYKWth/xEvwr6ctj7HGoKAdCnnQG5D1KryTiaFhd59sASPo3BfC9DfBuWB/rRAB1lto
         9wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=wYBBGo9H3NcLYobkCDwfKYdbVok34KxqzwOSnoIIIT8=;
        b=tQ3wDS+yu5JetcnUKjnMPR849/z5jS8t3BJNVbGE+IQxZkWV15QfadCTXzHgAhTJ00
         VLkoJtJhvs5eWc9rScI8FttKGQ5fc4m+taWqpIZadJ3jf2MslQ9QCY26MJ2E3rUr5y6l
         WVh8rk8F2yCyVNOCn8XwHWRzLZzIr4FE9zvfdAwwlk+sdFHgz201MfOCpY61xxboaS+j
         GZLs+8JfHmCn/Dwx2qC5jaZQJ78VAGEvuqv5PzffxvzdVjoj5mfcBiy5Y63vUDIUtu2N
         TA/nGKkbGBWBAo2TBgGQ6tn2dPvLwdPGin/a40CR6mRdlJrEQpRtiO+tpiKH2qjZVEDb
         DrOg==
X-Gm-Message-State: AOAM531iGBZEubbV9tdRCNZ+Etjtnwv1jV+KZ4MKJkp8vKMUOYrABJQB
        4UEga2vjoW/C8utoXTkSrkI=
X-Google-Smtp-Source: ABdhPJwMkvDIIWPHW6+5F3HJbou032eZLbqDrclRE7EHevK/oxWdPIaM3Ku55LFH16c+GVch5KBEcQ==
X-Received: by 2002:a9d:2f47:: with SMTP id h65mr3576786otb.299.1627056025926;
        Fri, 23 Jul 2021 09:00:25 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t16sm4783581otm.63.2021.07.23.09.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 09:00:25 -0700 (PDT)
Date:   Fri, 23 Jul 2021 11:00:24 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <60fae7982f7b0_defb208c7@natae.notmuch>
In-Reply-To: <5d3d95c9cb978ee02d9e39c5eb70b49ecdbd218f.1627042470.git.gitgitgadget@gmail.com>
References: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
 <5d3d95c9cb978ee02d9e39c5eb70b49ecdbd218f.1627042470.git.gitgitgadget@gmail.com>
Subject: RE: [PATCH 2/4] Documentation: define 'MERGE_AUTOSTASH'
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain via GitGitGadget wrote:
> From: Philippe Blain <levraiphilippeblain@gmail.com>

> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -154,7 +154,8 @@ endif::git-pull[]
>  --autostash::
>  --no-autostash::
>  	Automatically create a temporary stash entry before the operation
> -	begins, and apply it after the operation ends.  This means
> +	begins, record it in the special ref `MERGE_AUTOSTASH`
> +	and apply it after the operation ends.  This means
>  	that you can run the operation on a dirty worktree.  However, use
>  	with care: the final stash application after a successful
>  	merge might result in non-trivial conflicts.

Although normally I'm against mentioning low-level technical details in
high-level documentation, there doesn't seem to be a better location to
explain MERGE_AUTOSTASH, and it's just a simple sentence.

Fine by me.

-- 
Felipe Contreras
