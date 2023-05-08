Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C61C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 21:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjEHVJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 17:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEHVJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:09:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1146E82
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:09:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64389a44895so4084175b3a.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 14:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683580191; x=1686172191;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTG+in0PdLDiayre5efpImroTRPaZuuGZd67moc0SwE=;
        b=hZPTUmzCPV5gEbJjEuzoxP1o06FWeMDm6Kt3n5D6Bviw6465eqKqybsLe7bap3bP/M
         jF+9vqPUl7/f4H4mJP7uO+ZES3MHLw82JL/pgLi7wHtm2L58OknCNEIDGKJgQJbZRTOq
         uOxrG22w6o/1tdVOq+LSYkNAFmVw/h4HG3ru6RXPYALfMFguHhiCY0OVGlyeJ+8updTD
         HXC+5PUdx5XZf5ZvDMOSS5OeB3YOA+8w8QRQBXK8W9RsHQEZkQ68LCPpaidH20PHn+2a
         d3IPOPV0SDqwXoiKUjzbZuYYpRsDfHKKl8o9cXp5kzslrhTtL4mHhtOx9n3hZxGXBGG+
         cmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683580191; x=1686172191;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aTG+in0PdLDiayre5efpImroTRPaZuuGZd67moc0SwE=;
        b=DsXqj+7zAWjzXE75esKL+kjulMr7MQEQUoyxNGvDEziibZdWPmk55MN30fq2OWAwaa
         C/AMCPrmRBKMxeW/m19dSPoWSI7zaKBFa4V0559Cy8JUgg+3h/huEHhUW1bFmW4YZNuP
         lRpu01spQRxo69OCaH9OwpDWZ5BB/qoIiVl1hFrPh57Rzh/wncZetwqoY1LgGIKSy/9M
         PbHtSFG5EPVIFmAKWo4grvAQ0OX3STrHSlYrp6K2g1VyMDCQ9AheVCOzlOZUgzg3vSkM
         9fBt9kJ+apoNn0oWvVjWnzdeUdFxZ215K1Jmeg0ef4Bfu034Enn+HP/j5TQfkhTZKcxL
         3MAA==
X-Gm-Message-State: AC+VfDybHLlBKEY9w4/+BvrumEWSZGyeGaSw2FuP+UmTXrrDSfIJWjV1
        T/FY+LkfrX8+sWknaKVl6gE=
X-Google-Smtp-Source: ACHHUZ5r7GaYy2HQuKpTtMemAzU1kRSMv4ghvzWEazRH+mRCqjAcOAT7MH4kvd4VSPiUjZPxQ0y70Q==
X-Received: by 2002:a05:6a00:179b:b0:63b:62d1:d868 with SMTP id s27-20020a056a00179b00b0063b62d1d868mr17669026pfg.8.1683580191087;
        Mon, 08 May 2023 14:09:51 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id v13-20020a62a50d000000b0064309cd0551sm389828pfm.85.2023.05.08.14.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:09:50 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, derrickstolee@github.com
Subject: Re: [PATCH v6] write-tree: optimize sparse integration
References: <20230508200508.462423-1-cheskaqiqi@gmail.com>
        <20230508202140.464363-1-cheskaqiqi@gmail.com>
Date:   Mon, 08 May 2023 14:09:50 -0700
In-Reply-To: <20230508202140.464363-1-cheskaqiqi@gmail.com> (Shuqi Liang's
        message of "Mon, 8 May 2023 16:21:40 -0400")
Message-ID: <xmqqednqmswx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang <cheskaqiqi@gmail.com> writes:

> * 'on all' in the title of the test 'write-tree on all' was unclear;
> remove it.
>
> * Add a baseline 'test_all_match git write-tree' before making any
> changes to the index, providing a reference point for the 'write-tree'
> prior to any modifications.
>
> * Add a comparison of the output of 'git status --porcelain=v2' to test
> the working tree after 'write-tree' exits.
>
> * Ensure SKIP_WORKTREE files weren't materialized on disk by using
> "test_path_is_missing".
>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>

As we have lost the change to the code, the title has become stale.
How about I retitle it like so after queuing the patch?

    Subject: t1092: update write-tree test

The changes to the test seem to match what Victoria already gave a
thums-up in her review of v4; I see nothing surprising or unexpected
there.

Thanks.  Will queue.
