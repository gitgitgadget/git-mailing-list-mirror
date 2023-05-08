Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAACFC77B75
	for <git@archiver.kernel.org>; Mon,  8 May 2023 15:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbjEHPzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 11:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234093AbjEHPzd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 11:55:33 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE3990
        for <git@vger.kernel.org>; Mon,  8 May 2023 08:55:32 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-52160f75920so3128590a12.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683561331; x=1686153331;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=je7z8lVUSJx8ngT4CubtwYgP1YLxwOZncoTJj5sKz+Y=;
        b=SDclaFdAnfvjUtj8VsxgdFt9RU6j0uvVMt3EWs4NI+NLTWn0XAibe+/GMEIiWgAfBJ
         cu4A/QzUPKN2ZxYZF+UKe1481qlz8dMcVCFBHizB9f4joOjR3AhjYqFtWEE3ayOrtDkb
         YKqLMcDTGfS4X17jKuhYKFrufrMZGK4RtDBob9twb3WZRs700d+7MjdnlmhtduFZGybX
         mvK4z4/NXbNtle4wGWkyzJH/GSZjVoRm3AjOO0zIGMbtZ//kzndWcd2qaoEozGtEGGiX
         Gq3fjeA0eJss57TmBhLo56XnDoqfuWAR3ljBr2ethB8vJZF5pIOvKWlK/ubdpVBQuH0y
         nouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683561331; x=1686153331;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=je7z8lVUSJx8ngT4CubtwYgP1YLxwOZncoTJj5sKz+Y=;
        b=YhHcfyvJ49NTrPBG2BhpgJl7zCfliXnLuQ+7D/FGN8+eOsm/bwpmdL1MX8rgZJli3r
         cO2PqmyRUTrKhzjAA/EeFpBE+GiTKU9d9XGRwRnMLfPbc81cVCLYkGsnKEDZYGurr5i8
         4NfkQPU5Yrd2PKHHVVXuJYyW5hUJqeAaTDU4A18AISdLJz6jMKMPeCG4hYwmteoOCk+X
         jzm8RhRVeefCPCxrC0Ov80zQ9qxHbz/o+I7E9t6R2zqCOJj+Hq6qrDdZrvRuqh1zT8e3
         IAURH9Hdi6Q2lV+winNajyDpnvsxtqgiA4CgsCVGIk7HvY6wFA6UpPRY5d8OdejN/eZv
         Mu2A==
X-Gm-Message-State: AC+VfDxoZbdlPWbPaY0mfqwGgUk8wSOraGGHBd9xP3FIiuiegWq6dMds
        uAWlDg72ILRUumztsQqysCxvRcUgzM4=
X-Google-Smtp-Source: ACHHUZ4RSMOfgPnLOxnBG3F3n30HNYVM2mgL+PoqJ1BxU60Pjs/T4SUV38VRAXYzEVJGmzJY2gRkTw==
X-Received: by 2002:a17:902:d902:b0:1a9:86ca:38cd with SMTP id c2-20020a170902d90200b001a986ca38cdmr10946865plz.2.1683561331390;
        Mon, 08 May 2023 08:55:31 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id n5-20020a1709026a8500b001ab0d815dbbsm7440367plk.23.2023.05.08.08.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:55:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/24] Header cleanups (final splitting of cache.h, and
 some splitting of other headers)
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 08:55:30 -0700
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com> (Elijah Newren
        via GitGitGadget's message of "Sun, 07 May 2023 03:45:25 +0000")
Message-ID: <xmqqttwmrf65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Maintainer notes: (1) This series is built on top of a merge of
> en/header-split-cache-h-part-2 into master, (2) This series has no conflicts
> with next, but has three simple & small conflicts with seen:
>
>  * a textual conflict with tl/notes-separator (affecting builtin/notes.c; to
>    address, nuke the conflict region and add an include of alloc.h after
>    builtin.h)
>  * a textual & semantic conflict with cw/strbuf-cleanup (affecting strbuf.c;
>    to address, delete the conflict region and also delete the include of
>    repository.h)
>  * a semantic conflict with rn/sparse-diff-index (affecting
>    builtin/diff-index.c; to address, add an include of sparse-index.h).

After looking at them myself, I think that the above resolution
makes sense.

> This series continues to focus on splitting declarations from cache.h to
> separate headers, and also cleans up some other small header issues. By
> patch 16, cache.h is gone.

It is a nice touch to update the part of the coding guidelines
document that names which header files other than <git-compat-util.h>
can be the first one to include.

