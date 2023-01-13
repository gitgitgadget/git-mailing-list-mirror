Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50043C6379F
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 20:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjAMUBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 15:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjAMUBT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 15:01:19 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F0540867
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:01:19 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d3so24470152plr.10
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 12:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQweS6vArBTlqC61RqJilCLPciSfDb89qZY++MdZInM=;
        b=XDWRhm4hprUOkdF0LG/Cg4j9BzFADDGBXDjc7m5sz6HTCCYUhMUy66kJmEBJdMjeoT
         mbA50f+HFvKxukG1KkhZr32nibXqyHsxz2AJjtDaInTTY0NddQpXds9R1/OR1i/vcJRt
         n6Yx99C5vMKNiTkqoZpZOhDnj6pITk6bwwcJupmUN+jl2rNYLSq3RZLfnz3sYGza8Inj
         FJzppDijhNfou9aJukZtK9D8kUgAZG172aOl16IIBxErK3PKemRcfXN7RyrSDFrLQ588
         tI0jur1B0Ew59czWWPUWcQxzz0GCrDyfJ27ZBBd2wVrh7ZKEURe7D7RCKUHHJa9RrnQL
         mVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uQweS6vArBTlqC61RqJilCLPciSfDb89qZY++MdZInM=;
        b=kKkd0q9nWgeqvgs5SkpYzqf1s5mogpqyITCk1dFWDWXNrgEjxkHsvVr+d5/SMaUqVZ
         jiAZBo8nAqQf/+BJmLyJBk/bee9vhQDU/ItQd2dsmvoyIpDEySomqxSDEaxq7/icBtDZ
         drTS+9KOeRnbU7rhbzxRZEW+vhT2npAErYZlLugTSObUBfB3xY1jTsj3+KSq2i17Fzry
         v8RhtkrBCouOyfINONyXvjtKD0SnuYMRMoRhlvWjX08CKXa1REuuDtZLaZ7mm5qCKaHK
         TqN4B2Ia+L0QzLS6VBsYhNEEvQHYSf3Gt+ELwGIYAsORoKlKZx/SOZlQmEVJKEm1F2rX
         c1bA==
X-Gm-Message-State: AFqh2kqp/0+7cFUiiYQtnE3Ff5MwKmK60UPw9IOx3AiO7ok6FhD5a6E/
        hQ9LMKYMdT0Blqf+YfvpItnFuzjjl0k=
X-Google-Smtp-Source: AMrXdXvWVV5ZWQqRj6BWWS5JXWPkqd9MURp/glIUsn2QFn0ycdXFCWieZOsR1B13eMzjRFNel8sxmg==
X-Received: by 2002:a17:902:e951:b0:193:2ed4:561a with SMTP id b17-20020a170902e95100b001932ed4561amr22194528pll.38.1673640078772;
        Fri, 13 Jan 2023 12:01:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001928d49bf84sm14463506plb.191.2023.01.13.12.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:01:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     William Sprent via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, William Sprent <williams@unity3d.com>
Subject: Re: [PATCH] ls-tree: add --sparse-filter-oid argument
References: <pull.1459.git.1673456518993.gitgitgadget@gmail.com>
        <CAPig+cRgZ0CrkqY7mufuWmhf6BC8yXjXXuOTEQjuz+Y0NA+N7Q@mail.gmail.com>
Date:   Fri, 13 Jan 2023 12:01:18 -0800
In-Reply-To: <CAPig+cRgZ0CrkqY7mufuWmhf6BC8yXjXXuOTEQjuz+Y0NA+N7Q@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 13 Jan 2023 09:17:04 -0500")
Message-ID: <xmqq8ri62ohd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>>     Note that one of the tests only pass when run on top of commit
>>     5842710dc2 (dir: check for single file cone patterns, 2023-01-03), which
>>     was submitted separately and is currently is merged to 'next'.
>
> Thanks for mentioning this. It's exactly the sort of information the
> maintainer needs when applying your patch to his tree. And it can be
> helpful for reviewers too.

Indeed it is.  Thanks for pointing it out---I just wish other
contributors see and follow such a wise piece of advice buried in
review of a patch by others.
