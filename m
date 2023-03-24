Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3226C6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 19:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCXTJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjCXTJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 15:09:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63F3109
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:08:59 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o11so2743314ple.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679684939;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42CQo5q87LNeJqNR6xFP6STZEPkzThGy3SLGWKMUkdU=;
        b=k1zng26vpUtBBc5xy70AMR79UhoNgSmv+VUM1LeheTY3RUc6vJshLxtOd+g4jp+GVO
         qRNNJHogfSeUdQoVhZ6S60KIdUyLku9YPXa6427EPWISnD6VNrWNB4Wr++mD3kAbK/fd
         8xEkV46uzvYG3psCNuAnSsaVxKVqCp8YedsQ9lWY2OE1NobZvFkmoyKNFte0NzBBrO1Z
         5shA2Hqydr5w8Rr/cAwdyql3Wl7YXVAMZaM40lK+g1HVnuPB2Rj5oo+zFhMY4ooTUWoD
         pcr+voGbLndc578M/MCjHFeiEOnE/WPhjzH1G8a0hfC5McW50HuoyeHcTdIHShf2iAoz
         VGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679684939;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=42CQo5q87LNeJqNR6xFP6STZEPkzThGy3SLGWKMUkdU=;
        b=RP3nSFl3O32P6SHtpqahr1KjGBCuUmNU1RvyCHFDT/4owhJ2GyPjlQTE6F1jLdfI9k
         iASreeKCeY0MbSKFpHvYRWhSzg6spLKAcTKulxFlIaSmvofUBT4AhxBnt7PMgxWMaN66
         08mMSnkcDrrm87ErbZCN1iQh/FiUb7KKAafgEX/Ulsy6aDX8wMflhXk2rnjFFxVSB21N
         aGG0YVPxz9ErOFEBrU48Tfmrny11jkzSu8C7V71T/9N//OyeDiFSpn0Txj977K1i07Nu
         YuEm2/k89rkboevzEh8LzEQ7tHxenKBed/4LvqhkgPus1uhmnWQb5n3jX1EWSGr4nbSl
         rJOw==
X-Gm-Message-State: AO0yUKUUT9RO1l4+r4gMlwL5IfYDH2YgCcSKKi1/cbo2EicOFxgcvhmm
        Ty0GcuGa/Pqfi66/aOjFurc=
X-Google-Smtp-Source: AK7set+NZpWfe9H9qzgm38N4rJ46JVBj06nYoybX6m0ucwOECQJLoNhoMlGDN2byGpEVgBUmb1RUZA==
X-Received: by 2002:a05:6a20:b29f:b0:cc:a8d7:ad7e with SMTP id ei31-20020a056a20b29f00b000cca8d7ad7emr3659658pzb.60.1679684939175;
        Fri, 24 Mar 2023 12:08:59 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id x4-20020aa784c4000000b0062a7462d398sm2434355pfn.170.2023.03.24.12.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 12:08:58 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] blame: allow --contents to work with non-HEAD commit
References: <20230324170800.331022-1-jacob.e.keller@intel.com>
Date:   Fri, 24 Mar 2023 12:08:58 -0700
In-Reply-To: <20230324170800.331022-1-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Fri, 24 Mar 2023 10:08:00 -0700")
Message-ID: <xmqq5yaqezlh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> Changes since v2:
> * Improved commit message further
> * Re-wrote documentation for --contents. I really had trouble figuring out a
>   good succinct way to explain the behavior, so hopefully this is good.
> * Updated the comment in setup_scoreboard.

Looking good.  Will queue.  Thanks for a quick update.

