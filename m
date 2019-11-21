Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A967FC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 14:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAA82068E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 14:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcDI2v5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfKUO3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 09:29:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39504 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUO3E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 09:29:04 -0500
Received: by mail-qt1-f193.google.com with SMTP id t8so3881255qtc.6
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 06:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jFOZaKkiHgmodn/CHsP5omeOJd1iqSB+M35JLTXVFTY=;
        b=HcDI2v5NLmK+ufxnXYyVPiRMsWnK97KBwfC4V0gbeiAcGTe9qPDzle3D44kmRe4KFe
         qC/FLGk91JUOU65EK4L9KNEOwVnVKcyqhvX8x2P1H/ZCE5QEXiEWN6x5zIXyZbn62uPX
         N2goPEdsIYr2wy2CsFDL17TNosZRaZZfk+RwIgnrXCe4N4gefaZsd5IlQKMJ1ZVa3HHx
         wx+ryoVM7KROTO918hsKaM5rcZNC2r8+acgk6xaDbJcqK7/a0kTUrnfY6cJrEZJzlSu7
         /afmorlg1k7q6w/s17GhIzZ9CIDOK3oKX6vCc3YXVDcKPqWLKY8NR93ZcIHDCKgLB1Qr
         4nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jFOZaKkiHgmodn/CHsP5omeOJd1iqSB+M35JLTXVFTY=;
        b=rqg9EBx1kGWMBZMiW/T49LTJhKUZwwM+2ECNKVpzb+PQgUGA9/ABCYDUdUcyntMvRZ
         gusVu95qqDqx0BaqLy+TozqngDHfQRkvQvmiAXmX+43AqbuDCO+4XTiyBpLVqYlvkaw+
         Vfkv9dI5J5poFSzDHgM9iRQfUtu0YWg4r6u+85eDd8gcfr0iLxtpL1iUC/x4LYXN0SGB
         16bCXWCjt1gEfeeCNK0a6gdXNPSqMFNt2DSIB2dWH1zRcXpMWLZhNIhamkT6aX1aS07N
         ZiuT5YlPiXw0SW0jbsuWiwY2xzLJamloncCc0ICx3m7jb0WEphr4jjUrD/BWDSHCFkUd
         PmaQ==
X-Gm-Message-State: APjAAAWy7SZTJXeqnBYoXNXcCHH11E5OZmkc058sHTwpB6aM1yyHrnrI
        QIX1RysUlwilFyGQz4xp0vOH4q2lHcw=
X-Google-Smtp-Source: APXvYqxpjG9VXTwRTOe9+ELXSFJb7Vp7AInPIZT47rPkIfheSB56WIOCxvPXOqWk3UToZ/zrKSK/pw==
X-Received: by 2002:ac8:6f3a:: with SMTP id i26mr8990695qtv.344.1574346543279;
        Thu, 21 Nov 2019 06:29:03 -0800 (PST)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id l186sm1465060qkc.58.2019.11.21.06.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 06:29:02 -0800 (PST)
Subject: Re: [PATCH v5 02/17] sparse-checkout: create 'init' subcommand
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <a161cee0dfec76e7a08253083f488e2e6d26299e.1571666186.git.gitgitgadget@gmail.com>
 <20191121114936.GR23183@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <147bf5a9-6ae5-23ea-a007-68b8046c94ea@gmail.com>
Date:   Thu, 21 Nov 2019 09:28:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <20191121114936.GR23183@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21/2019 6:49 AM, SZEDER Gábor wrote:
> On Mon, Oct 21, 2019 at 01:56:11PM +0000, Derrick Stolee via GitGitGadget wrote:
>> Getting started with a sparse-checkout file can be daunting. Help
>> users start their sparse enlistment using 'git sparse-checkout init'.
>> This will set 'core.sparseCheckout=true' in their config, write
>> an initial set of patterns to the sparse-checkout file, and update
>> their working directory.
> 
> Enabling sparse-checkout can remove modified files:
> 
>   $ mkdir dir
>   $ touch foo dir/bar
>   $ git add .
>   $ git commit -m Initial
>   [master (root-commit) ecc81bd] Initial
>    2 files changed, 0 insertions(+), 0 deletions(-)
>    create mode 100644 dir/bar
>    create mode 100644 foo
>   $ echo changes >dir/bar
>   $ ~/src/git/git sparse-checkout init
>   error: Entry 'dir/bar' not uptodate. Cannot update sparse checkout.
>   error: failed to update index with new sparse-checkout paths
>   $ cat dir/bar 
>   changes
> 
> So far so good, my changes are still there.  Unfortunately, however:
> 
>   $ git add -u
>   $ ~/src/git/git sparse-checkout init
>   $ echo $?
>   0
>   $ ls
>   foo
> 
> Uh-oh, my changes are gone.

Here, your changes are not "lost", they are staged, correct? A "git status"
should report that your changes are ready for committing. This seems to be
the expected behavior.

As to your other message about leaving the sparse-checkout file even when
the 'init' command fails, I'll fix that by using the in-process mechanism.

-Stolee

