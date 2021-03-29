Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA935C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 19:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B16561936
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 19:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhC2TPe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 15:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhC2TPB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 15:15:01 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29364C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 12:15:01 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l6so1928658qtq.2
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 12:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Awls6+wg54OA6KxR9KyaL4BYI5jDhDk2+SfIWo45dfY=;
        b=Zx0ZCstPIMj/O+5EnD0ZXd9igc/wFI/ybURx6psS67ST4e0iXrfuH8L42pqOzznjxX
         /dRS9gf9luDiWoy4/VyuVt9YqeV3GMpHGrvKekaJQ0MwT7V2dCC1nmIDADCY8p+W8MLX
         bzIAZPoXOH2WavlaZJ/vvl2284raPgULzhySretcjqYX1m24ZBHxtBZ6JWQ8QKAY0FOX
         SEwIfD1rhFxZwMXPAcyRuDa7+H/SZ+eeSqd0JiBJKf67yaxL0gM3JSJ2su9XLnsZPMcp
         IDEuZlttAOdCh1S/ecc7zmMnJstysYfmW1X0K7zA+y7xgeOxqMrIUBA0rA2OWN2oXjL9
         oJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Awls6+wg54OA6KxR9KyaL4BYI5jDhDk2+SfIWo45dfY=;
        b=KrYme0VRlkiel3jy6px4brMF1kYGh9f3HF79ynNlmgkR7KOM+pmitfufrQcugduebw
         sUC3Cy3WKZCfgUfV5uFyq7D3l2jE2O64n0MWZIRG/9IgvEZJ0JYT3q8YhxnKdriDuloL
         Hh5bSh6g7DN5WrpIebLwHsslsiXoB4iYSd8NlCDj5rD/t5GTKhdejySLiIl29d6CpIAf
         HIT9EXvJA0dTcG92q7oi5gNImXu89V1tlIGF+GlptbyG880XpGsMsszJYvfMtm0NKBOV
         Hgygpnt1T6NvshH66v/2CHua5sU0W8NW4TRGcfMCNMBblRIqM8OaBeVd8GdNeIgSDvBX
         v4Ag==
X-Gm-Message-State: AOAM531XfMVvfGfQ58mYZMd9WEc8lY8RbC/VVtqvspB0HI8zLJzG0BFi
        rvqSA27Le94d6go0/kxAgRGid1PAw0eP9Q==
X-Google-Smtp-Source: ABdhPJztx2Lw7eTPbIJB0tkxDVxmB4rTsPQWPALoPogW/jWMAqHlPdP9xF8JRcb7LWRV420Dc2GKmA==
X-Received: by 2002:ac8:4412:: with SMTP id j18mr24503160qtn.387.1617045300055;
        Mon, 29 Mar 2021 12:15:00 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:18fb:da6e:ec24:b27d? ([2600:1700:e72:80a0:18fb:da6e:ec24:b27d])
        by smtp.gmail.com with ESMTPSA id b17sm11351195qtp.73.2021.03.29.12.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 12:14:59 -0700 (PDT)
Subject: Re: Running scheduled maintenance in quiet mode
To:     Clement Moyroud <clement.moyroud@gmail.com>,
        Git List <git@vger.kernel.org>
References: <CABXAcUx0uWyk1e0UCaTwGt1VwVZkj1sV-OapSgZJOv3eS88eng@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f5db297e-e0e6-3eff-37de-8efafe07482a@gmail.com>
Date:   Mon, 29 Mar 2021 15:14:58 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CABXAcUx0uWyk1e0UCaTwGt1VwVZkj1sV-OapSgZJOv3eS88eng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/29/2021 12:45 PM, Clement Moyroud wrote:
> Hello,
> 
> Now that Git v2.31.0 has the fix for 'git maintenance register' on
> bare repositories, I've enabled it. I'm now getting a fairly useless
> daily e-mail with a couple of hashes listed (no other info).

Thanks for your interest in the feature! Sorry this is a
frustrating experience.

> I'd like to disable this e-mail and get the configuration to stick -
> changing my Crontab with either --quiet or a /dev/null redirect works,
> but the next time 'git maintenance start' is called, this will be
> rewritten.

You are right about that. We could alter the implementation of
'start', and the only downside is that you would need to rerun
the command to avoid those problems.

For now, you can stick to 'git maintenance register' instead of
'start' so the crontab schedule is not overwritten.

> I could not find a 'maintenance.quiet' option (or similar) in the
> config. Is there a way to do this currently?

This could also be an interesting workaround. To be distinct from
the crontab approach, it would probably be necessary to also make
the `git maintenance run --auto` output quiet by default, too.

I'm on the side of modifying the crontab schedule. I'd like to
hear other opinions before starting the work, though.

Thanks,
-Stolee
