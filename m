Return-Path: <SRS0=DQ4e=44=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFFBC10F27
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 10:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B47208E4
	for <git@archiver.kernel.org>; Wed, 11 Mar 2020 10:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg6aflus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCKKar (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:30:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43598 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgCKKar (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Mar 2020 06:30:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id v9so1855493wrf.10
        for <git@vger.kernel.org>; Wed, 11 Mar 2020 03:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XvL3+dlO4k8j0JMmqOVvqELgsnBZ8q4tNSr3XoCBzSA=;
        b=Pg6aflusi4W1jTuONee5L1K0UTbBI9/QC3IKiANwei8KjhpR+4XLg+/AhgpaAcEubU
         AeV6TS+DeQNOe4Nv6bMCqZGNq3MC7KqFBgsdQeKiW7fOXcQO/hFaeNsv9pL/a9fdOlrk
         Eb3o6Y5uMc72AMRp+474ApZm2RR2Eha5hdDzTY+B09BpxZ8zVC8FC3q0RkiM7QKM5oSd
         XIJbN4gEv2RrjAa2/lTwaohTRgSprQIdQK0Lseex7O6DvyETUXO3azQe/1rML+riKZBw
         ZmXDSRBBNbZk0w8ZG7rpghBMJcUnBThgtsXCZkIgAYYsMawLQV/N2B2zSRZyJr5WNVet
         uomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XvL3+dlO4k8j0JMmqOVvqELgsnBZ8q4tNSr3XoCBzSA=;
        b=Tm/ICGiXerYy1kiJSPrykv5j+kIyemLBlN4ff7sa/Dhk3mMPr1eLiYQ+tG1Pv4Rd4m
         ozqd+c1BkWbr1nRv2qUmccJjGsNSQN79GA0s+seCfSK/9gQI8cT1nanf2L48MrtAh7Mk
         l2Ow6EmF4+2xoOOHFFhoUhk7lo45b3IpGsM/jXtO1EM70YWn6oHAqkHxfBAm8X+O+b8o
         9SoMS9SPfgG83IBMWEKbJftn1BJRA8LRbhOZ5V6iohqLt65L30Fm6j81MtwEo9JZnly9
         paUFn8jE0jxKdwbc0LyWJ9V30a8+ijh3Mj8QQ1ubQXhEWfVi6Zl8SXGk3TyacDXx4Bu9
         9y6g==
X-Gm-Message-State: ANhLgQ308W4IqdSAY/7vQSCizsj4ADlqlDKJmqdfe2MzZCdH7o8xkR6b
        948wpvDazWmg2ZN/KtsQ6PI=
X-Google-Smtp-Source: ADFU+vtl8d7K9ix5CUZG3wbSctsC/3WO6IgVcJ1WKnfSWjEtK5jnjJbwD3JeZRyjk7KCCg5Pp8qyBA==
X-Received: by 2002:a5d:6a82:: with SMTP id s2mr3711597wru.11.1583922645346;
        Wed, 11 Mar 2020 03:30:45 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id 138sm2533678wmb.21.2020.03.11.03.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 03:30:44 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] sequencer: clear CHERRY_PICK_HEAD upon dropping a
 become-empty commit
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.722.git.git.1583903621.gitgitgadget@gmail.com>
 <132f769adb0a34e74b6c237ff84bf8b624ea0d9f.1583903621.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <94eec36b-581a-17eb-7aeb-2d24c90b8e73@gmail.com>
Date:   Wed, 11 Mar 2020 10:30:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <132f769adb0a34e74b6c237ff84bf8b624ea0d9f.1583903621.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 11/03/2020 05:13, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> In commit e98c4269c8 ("rebase (interactive-backend): fix handling of
> commits that become empty", 2020-02-15), the merge backend was changed
> to drop commits that did not start empty but became so after being
> applied (because their changes were a subset of what was already
> upstream).  This new code path did not need to go through the process of
> creating a commit, since we were dropping the commit instead.
> Unfortunately, this also means we bypassed the clearing of the
> CHERRY_PICK_HEAD file, which if there were no further commits to
> cherry-pick would mean that the rebase would end but assume there was
> still an operation in progress.  Ensure that we clear CHERRY_PICK_HEAD
> when we decide to drop the commit.

Thanks for fixing this, it needs to clean up MERGE_MSG as well though

Best Wishes

Phillip

> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   sequencer.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 7477b15422a..8b4e0200c5f 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1957,6 +1957,7 @@ static int do_pick_commit(struct repository *r,
>   		flags |= ALLOW_EMPTY;
>   	} else if (allow == 2) {
>   		drop_commit = 1;
> +		unlink(git_path_cherry_pick_head(r));
>   		fprintf(stderr,
>   			_("dropping %s %s -- patch contents already upstream\n"),
>   			oid_to_hex(&commit->object.oid), msg.subject);
> 
