Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A79CC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FFF20719
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 16:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMKx5ScK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389679AbgDBQKR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:10:17 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:38643 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389041AbgDBQKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 12:10:17 -0400
Received: by mail-wm1-f47.google.com with SMTP id f6so4296868wmj.3
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TATL4dANvqKDEqqYEEyXPTQ6UMQ2qkUP93zgRDb9Uy4=;
        b=gMKx5ScKqNgD8nRooUd4UisDwpjwm4pfvWGIAGSgmSYKdO3WQRj5FgerY7P8ujTyfc
         HzPVhaAtthViLTT/D1/Z4Ri4mONjhyXkMEjCpBrY4Rgo35TTIAhev/eiE4A6uC4LDa7t
         /AjGnWXOIvs83XYnSm/UllXZ0YXxaxxaYGdE04cZ1Xq5aBkZCsYBokTAtn48HW1lvECn
         99b8w1YniXLbb5B+KkgiqsTrktU94jSQtHYHklmIP9E+wi0WtTCq6Ni6GR3qqloTTaLi
         5CHYlm5mLjDJbq7GHxT7iKDLdTdJ3DLy6FCsTvCYYawdLDuPjdpFCZPM+jTgmOxfFQvq
         ys4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TATL4dANvqKDEqqYEEyXPTQ6UMQ2qkUP93zgRDb9Uy4=;
        b=RIpaar7Zo6bysLZKCmUsWLdqo7FZGkpzOmLxMjFaWsuTFc497xiTY/a8rzFjzizHK6
         wPomTrguCtNme6KUDbFvoqDgXU6hmKnH2eU9LFEOQwbEECr/62INChlOQpxknf+F3zRB
         i809LLOeSwUyiKGuUxRTtPS8lPvQWiJaOGkn+Iiipf2DXVNcufw1PUBemRQfnQH2ZUqg
         E6LJKsuVLFvLbhkuAW+/ZHbQ4mKaHmCy5LVx4IN7kMcBxyWRvpyFd7BBOCAXOEfsiaxn
         wJhRyJHW2ZSX4DWMxt9O8JkGEEH1LFbyL72HzJlQ3O1OZGXVCyUNvozlGTJO/NAPVUv4
         DuCA==
X-Gm-Message-State: AGi0PuZmiPaLYuFOwpoLOs/Al9ei6M1Vzb3k0jTGo8RvShqwoLjHQu1Q
        jj2X4b17PBYVItHoFbKgjFGm8VPt
X-Google-Smtp-Source: APiQypKXCPeA6iqSRBRN+LcKT5/pYsJHC7ueXgkpwUoD63YcQ5hT93zfs0Tse57wUISNvSae7l9hgg==
X-Received: by 2002:a1c:c246:: with SMTP id s67mr4171679wmf.160.1585843811542;
        Thu, 02 Apr 2020 09:10:11 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id 91sm2042441wrf.79.2020.04.02.09.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 09:10:10 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Mar 2020, #10; Tue, 31)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3b472af5-2b23-a155-78b5-cf28c3494864@gmail.com>
Date:   Thu, 2 Apr 2020 17:10:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ku46s8z.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 01/04/2020 00:04, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> [...]
> 
> * dl/merge-autostash (2020-03-24) 19 commits
>   - pull: pass --autostash to merge
>   - t5520: make test_pull_autostash() accept expect_parent_num
>   - merge: teach --autostash option
>   - sequencer: implement save_autostash()
>   - sequencer: unlink autostash in apply_autostash()
>   - sequencer: extract perform_autostash() from rebase
>   - rebase: generify create_autostash()
>   - rebase: extract create_autostash()
>   - reset: extract reset_head() from rebase
>   - rebase: generify reset_head()
>   - rebase: use apply_autostash() from sequencer.c
>   - sequencer: make apply_rebase() accept a path
>   - rebase: use read_oneliner()
>   - sequencer: make read_oneliner() extern
>   - sequencer: configurably warn on non-existent files
>   - sequencer: make read_oneliner() accept flags
>   - sequencer: use file strbuf for read_oneliner()
>   - t7600: use test_write_lines()
>   - Makefile: ASCII-sort += lists
> 
>   "git merge" learns the "--autostash" option.
> 
>   Will merge to 'next'.

I've posted some comments on this today, I'm not sure about the behavior 
of 'git reset' after 'git merge --autostash'

Best Wishes

Phillip
