Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CEEC61DA4
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 23:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjBVXIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 18:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjBVXIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 18:08:17 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71EB15551
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:08:11 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id il18-20020a17090b165200b0023127b2d602so10072594pjb.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 15:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=im052o1yknkXDe/ZjLQj16QWQazzUinFKdewYaOWqjU=;
        b=QnCigQyVXggyCw4OEfl6H8q32yu/wCey+VdfDWKAr9KN7PU/Je793VcYT0Yri8+Y30
         aZVTIERBXtxC4UTW1yEN4jgZTwKztCAbRnhB4jH7t3rYSR/w89b+hHH8fs5k88i+4lIs
         5c5isfMOeL9APX52Dk7ATtFq5pRK5LgApun1YPWWWYpRYy/kWTNQeXSJo+AUsAHi76OJ
         fiq73C9qa9GqRVWzQtSvdS7U9z/LZlyZlET1M+yjjYgetXPUA7H4PZ5l4Y8TPD2jGWFD
         g8M0ECEnYuFwz8jUtV+wBk1E6ZDjjArxszpTa8Th/VrzQNyA/VsTY4+CVxlLNskDY7Hn
         HZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=im052o1yknkXDe/ZjLQj16QWQazzUinFKdewYaOWqjU=;
        b=gIk+HFhEuIbCqtbSpKK8p2CZ3gOncJGspW2Ic3gKv1vxDSxfFietFGU03w0VYN4MTw
         JlOfNXfQp/CQckytGXGBl67u30P2Np+zO6GgNliyVms39VpQMScwFH/0F7ceRRddXFD+
         NtWKzWvBTKap8F9v2IVPK23sq5ZM8cnXHjn0kpC5atHZqZwioGB0Ew2ZuLwPKbhhpY/G
         HidNKvHbSViT/iM/Ghk7iUdoL/zMf6F61fmkZSMBmX8VJmNIFDT+D5iZ8e2ZHnpGQ7Hf
         5rGZVFAAVQYPBuKqlGbB+R5tO/mKg2VWYBWdQigE3uLgd8ch45X0xlCDvhmz9ijzxcts
         G0GA==
X-Gm-Message-State: AO0yUKVHRQnXxSsGlYWX3MIMPPdqtMV+ur+60V1619gub21wQngwDP8p
        +WnLCtxkU+nFa00epWyXjm0VgEkEsfA=
X-Google-Smtp-Source: AK7set8o4hLyrOI7LJSWD7OhjNk8E0QsSDcqzevSivUmQBuQ1ZzopADDb7UFpxKi0aZcTbzgTfceRw==
X-Received: by 2002:a05:6a20:734b:b0:cb:cfb1:5009 with SMTP id v11-20020a056a20734b00b000cbcfb15009mr4272446pzc.34.1677107290990;
        Wed, 22 Feb 2023 15:08:10 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id bk13-20020a056a02028d00b004fb9250c9fasm5225806pgb.37.2023.02.22.15.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 15:08:10 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, newren@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2 3/4] rebase: stop accepting --rebase-merges=""
References: <20230221055805.210951-1-alexhenrie24@gmail.com>
        <20230221055805.210951-3-alexhenrie24@gmail.com>
        <852c6efd-49a7-f6f0-dd6a-b28cb0909784@dunelm.org.uk>
        <CAMMLpeQ9gEKNX5VtGCgLL_Qzk59ZYji57u-SPy-XeSRPuF2NwA@mail.gmail.com>
        <f0d0a3fb-d7eb-84d6-7852-0d30eb38af63@dunelm.org.uk>
Date:   Wed, 22 Feb 2023 15:08:10 -0800
In-Reply-To: <f0d0a3fb-d7eb-84d6-7852-0d30eb38af63@dunelm.org.uk> (Phillip
        Wood's message of "Wed, 22 Feb 2023 10:18:28 +0000")
Message-ID: <xmqq8rgpcn8l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> The usual way we handle that is to set the value of rebase_merges from
> the config before calling parse_options(). However your solution is
> fine.

Is it?  If it is not too much to ask, I'd prefer to have code that
does not surprise people, and "the usual way" you mentioned is what
readers around here expect to see.  I didn't check and think about
the patch in quetion, and especially the existing code that the
patch needs to touch, too deeply, so if it is too convoluted already
that it would be a lot of work to make it work in "the usual way",
it may be OK, but otherwise, the solution may not be fine. 

Thanks.
