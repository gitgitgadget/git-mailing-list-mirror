Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41441C433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 22:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E65D60249
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 22:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhIDWcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 18:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhIDWcH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 18:32:07 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF0C061575
        for <git@vger.kernel.org>; Sat,  4 Sep 2021 15:31:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id u16so3901720wrn.5
        for <git@vger.kernel.org>; Sat, 04 Sep 2021 15:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3biSuiPu1XhxIFc4kYYGpJ5r22RKL+To2/TJitdNtSs=;
        b=SH0eXRpkaHib2C+fY/80GKC1Umdr3cicRxKg3IJqJo/R2HqBN1cpv2zhamz7x7mNe9
         0d2gvA1ZfrLPT/RGyjex+FB0tiXbgUolt7FY1lI/qOnQqNGX89ebSuA0vjI/iCODVmJd
         vXkCR+LpppccHb5Uer0LSWcvpLlPvrIlpOim6P+g+NKOoXwIGgHuLSlcDBMj2kS10Oaq
         rWY6ooQpVKnMs0UXmiaNAOhOm1vM7uoYcS6VpfIKjVZcj8QcwK9pz6ffxmH0MGMs8O5P
         Vc9j1sAnrP6B+Q0865lCiQd+Lsu4gvCNMEYRIPoQ+LTQTtAQjHHart+RvgbLSrwjTOhb
         Onfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3biSuiPu1XhxIFc4kYYGpJ5r22RKL+To2/TJitdNtSs=;
        b=Snk4ExIWEejXNnX2gJSljJ3zYtN5ZRM6p5FyOz562qAFfgGiW7BTxKDzNglvOyVaeA
         NM90EXTgb+efkGPI4bLY/6kGq8QHmMp+xgiiyR4VOCG5Y5zhDgMshGFqW7/CchUNdzYs
         VIOTwYmbKwbeflbO/G7ANWPAmUCxTpSOOTKmvDPjHNPIPjO9HdTQ/Yia4GREqS2tYrZo
         //xrCf+8vLqc/TjTOfNmznwDwJ9gF/n4HmfNPwmmerxqOOeP7qG5jabqFIbPZDFzANSr
         l7fD+tsXybMzG4CNhyBZuajH9tyR+PMftP4Nf4YqEbrYdejIVHwPYSA4pcCXMerO2fEu
         ioSw==
X-Gm-Message-State: AOAM531EhKWCmDGnWs5fgesJy0/rU9upJSQDmVSDs1ceUulZxxC7vphw
        xBYEGgQKVmJXp7FNyn1/Yu8=
X-Google-Smtp-Source: ABdhPJx8sPrQ3WZ8WfCrgFKOE3XY+8gyHXVBJWtHVQBtlPa0x6EhX7Jhrq1UTCmcR+gm0K+4yirgPA==
X-Received: by 2002:adf:9e08:: with SMTP id u8mr5540366wre.383.1630794663717;
        Sat, 04 Sep 2021 15:31:03 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-295-72.w86-199.abo.wanadoo.fr. [86.199.78.72])
        by smtp.gmail.com with ESMTPSA id l11sm3428444wrb.15.2021.09.04.15.31.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 15:31:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] Drop support for git rebase --preserve-merges
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
 <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <62fbd389-28f5-76e5-d3f3-5510415a7bf5@gmail.com>
Date:   Sun, 5 Sep 2021 00:30:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 01/09/2021 à 13:57, Johannes Schindelin via GitGitGadget a écrit :
> In 427c3bd28ab (rebase: deprecate --preserve-merges, 2019-03-11) (which was
> included in v2.22.0), we officially deprecated the --preserve-merges
> backend. Over two years later, it is time to drop that backend, and here is
> a patch series that does just that.
> 
> Changes since v1:
> 
>  * Rebased onto v2.33.0
> 
> Johannes Schindelin (7):
>   t5520: do not use `pull.rebase=preserve`
>   remote: warn about unhandled branch.<name>.rebase values
>   tests: stop testing `git rebase --preserve-merges`
>   pull: remove support for `--rebase=preserve`
>   rebase: drop support for `--preserve-merges`
>   git-svn: drop support for `--preserve-merges`
>   rebase: drop the internal `rebase--interactive` command
> 

This is good.

preserve-merge is the only user of `rebase--interactive'.  In
builtin/rebase.c, it is the only producer of the following actions:

 - ACTION_SHORTEN_OIDS
 - ACTION_EXPAND_OIDS
 - ACTION_CHECK_TODO_LIST
 - ACTION_REARRANGE_SQUASH
 - ACTION_ADD_EXEC

Which in turn, are the only reason for these functions to exist:

 - transform_todo_file()
 - check_todo_list_from_file() (from the sequencer)
 - rearrange_squash_in_todo_file()
 - add_exec_commands()

This is from a cursory glance, it may go a bit deeper.

Should we remove these as well?

Alban

