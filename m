Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92888C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE6361B5F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 09:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhHPJa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 05:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbhHPJa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 05:30:56 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66642C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:30:25 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id l12-20020a4a94cc0000b02902618ad2ea55so4778364ooi.4
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 02:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=FG9iK1RbbUR7QGdg7jwDmZIJYQgdJDCxFrabg0R8j64=;
        b=bDaNgVq2HrcGeW47aku3mTmZWq+gJkT+zE9fr8mmmltQEH/giOQjs9v3/BPnQUmatg
         YV+bzjImFgulue4M1tLutTE0ui9uAHJ3fXggzRzm75n0egSNvFknPA557LY1fEJlZU0T
         z6HVdzSMKvDgSGP86/2DUI6LAQQgNg7QdMLg8b17jOdeZlGHjDTSEgMJFQkkNFdVtBNk
         M8VLDk8n8rC7uTTM+R+Q9N+J3L9hM7Lb8ymW7iLh+Jh7v56KSjY+YWmdTcV11mnLUaKN
         lSdtT//YFalan8xW69SY3moUjKnNRfI+ipu5WKnRxs/v2W9gLLFBh/nHv+UIWAlQyW5/
         SRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=FG9iK1RbbUR7QGdg7jwDmZIJYQgdJDCxFrabg0R8j64=;
        b=rDVn8ftaZqLaVkyO+FTISBihQ8D0dFCCQMdiJYMC7rGlxeQOtM2F0ez9G0ykzdRscF
         0t2VUT2aFGHh2/2zn2zJBRxaVi6ojBaHXQsNaVuaclYOT4eSNfi/+CqGLjrd6nGevjDk
         hVRJJiEa42ktPz1ZuH/blrLkzuRezdt06y4tCZ+9pWnyBmoHMnPzob8vM+dUPBov5aZR
         gjAdVW5+qo6WdsI4RcuuC9mmhy5eFhhIh6eLLCn/kD6Y7INEiQhtql6nZKCPGKhELVZz
         1mCPkSoIDRyxfKYgSv8xlwFtF1mNXxiToF8ijTR58Ty9jR4irR5VzC8yJZMthJxAejA2
         5B2Q==
X-Gm-Message-State: AOAM533dgkHmP8y08MXeh4qgi/WupiWWtWeyC44DSGTe27bLdI9lzJzO
        6BGO18q0MYz+MnnYpJzRfQwyHEtsRYE=
X-Google-Smtp-Source: ABdhPJylcdCrkpZg4eLoR1m/9/kPiF5CDMTPFb8imXx+xskRmIWAoYxWoG4AkfjLBiZxh9yCVirVyQ==
X-Received: by 2002:a4a:cb19:: with SMTP id r25mr10671168ooq.39.1629106224615;
        Mon, 16 Aug 2021 02:30:24 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id r1sm1823486ooi.21.2021.08.16.02.30.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 02:30:23 -0700 (PDT)
Date:   Mon, 16 Aug 2021 04:30:22 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Message-ID: <611a302eba979_85ddc208e6@natae.notmuch>
In-Reply-To: <xmqqfsve1dfs.fsf@gitster.g>
References: <xmqqfsve1dfs.fsf@gitster.g>
Subject: RE: What's cooking in git.git (Aug 2021, #05; Thu, 12)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> * fc/completion-updates (2021-06-07) 4 commits
>  - completion: bash: add correct suffix in variables
>  - completion: bash: fix for multiple dash commands
>  - completion: bash: fix for suboptions with value
>  - completion: bash: fix prefix detection in branch.*
> 
>  Command line completion updates.
> 
>  Expecting a reroll.
>  cf. <60be6f7fa4435_db80d208f2@natae.notmuch>

As I already stated in my previous reply to your what's cooking for
June 17 [1], and June 10 [2], and July 6 [3] I already rerolled these:

https://lore.kernel.org/git/20210816091025.548095-1-felipe.contreras@gmail.com/

The reroll was sent nine minutes after.

I've sent the exact same series four times now, and the patches in total
eleven times.

[1] https://lore.kernel.org/git/60cb5f4632d62_127fb208bb@natae.notmuch/
[2] https://lore.kernel.org/git/60c22863185f4_b25b1208e2@natae.notmuch/
[3] https://lore.kernel.org/git/60e512f78ad67_2fc0f520816@natae.notmuch/

-- 
Felipe Contreras
