Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4022C27C76
	for <git@archiver.kernel.org>; Thu, 26 Jan 2023 03:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjAZDHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 22:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjAZDHH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 22:07:07 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5856469A
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 19:07:06 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r2so451946wrv.7
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 19:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjtUrPdwbY/O/oftVNeDeaxgc1qp1VANPALO7ZgbSHQ=;
        b=pjl6cxKnr7I9Eyb62qHrerJnOWw4uk5gpoljRl5Hrr3S4ZeTtnM0biqLdzARN/H6Xz
         7HouZoQN6x6NR7827i/whEkTTARGQgrfmL0hrz49LWz23wEa0c7+s5wIzcGUe2O7Ir1l
         pQ7YIomCrCx1FAFFBKnEqVEBw6g/N/luwJSVjCPZSW7C92Wo9wFoPlcyu6HjDUoT3wnT
         INCGGR7YyskstXILuU3grv1DzBTOUc9R6KB0sW9fsHmyWayB2VHzkoXmxcKiDnedNZAf
         0tzQNIeSc5pCEZ/NE1ILcljp20fVzSqIX+DuNJSI0w0LS68JfKek5khPh7K3SImQGD7d
         rQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjtUrPdwbY/O/oftVNeDeaxgc1qp1VANPALO7ZgbSHQ=;
        b=JLeTpoRkRNxtP8HmUuXqIsDIMO43VeSbj5GinB1qSnn36ikwNPEaDE/98Sv0REvIA7
         QNgaSjOmBrT3N4qwyelTL5CojNokCBk9ANt5hQ72Sw+i0i5W0LtCr8y0F3AP2CucxdOJ
         fYa1Ff9nCuP/9vGFgcWZ8FpjDEr1VfWMxW1odAPqpvwuT/3wLiE28x34MpZWR7Y6kKf8
         qC5TmokiRKC4Cq0rPjZAfKsuXSDuxIMe7RDBp1uM/gLxO1HLguazCK0uXutGkEF4Ew+l
         NUdkwmRmw/E+bjyDTxrqdksUYpZH7o2TEc/Dx8f1VZbwWHTseQwj9dAZ3rZyKkEYoMQq
         UpTg==
X-Gm-Message-State: AFqh2kpIWj5L7QaHqwf17SnhKZtHAfKqMb+7dQZvm06rLEw3y/mOGtPG
        5WIqpyQ0mlAKWSOTr26OL/9dsMwaTsM=
X-Google-Smtp-Source: AMrXdXuDr7jN0TyvnZvR5uaBHfff0J/NuX+BLP4QVOOjvLNEApIr2KMALdOJgdsdnF8aKCh5CNZIfQ==
X-Received: by 2002:a5d:420e:0:b0:2bc:7f8e:40ba with SMTP id n14-20020a5d420e000000b002bc7f8e40bamr28409325wrq.54.1674702424915;
        Wed, 25 Jan 2023 19:07:04 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d508b000000b002be099f78c0sm7934wrt.69.2023.01.25.19.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 19:07:04 -0800 (PST)
Subject: Re: [PATCH v2 1/3] branch: fix die_if_checked_out() when
 ignore_current_worktree
To:     phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <17f267b1-7f5e-2fb6-fb14-1c37ec355e65@gmail.com> <xmqqbkmruykg.fsf@gitster.g>
 <766b25e1-2d7a-7b5c-10a9-43e545a57dba@gmail.com> <xmqqk01eqr3m.fsf@gitster.g>
 <d61a2393-64c8-da49-fe13-00bc4a52d5e3@gmail.com>
 <1a7fa327-3833-8da3-46d7-60bfe8dae82c@dunelm.org.uk>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <e7943994-3a7a-f877-8cf2-71146def9076@gmail.com>
Date:   Thu, 26 Jan 2023 04:07:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1a7fa327-3833-8da3-46d7-60bfe8dae82c@dunelm.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24-ene-2023 10:35:26, Phillip Wood wrote:

> On 22/01/2023 23:21, Rubén Justo wrote:
> > I tried to maintain the relationship and the role, too.  Just introduce
> > the helper, as Phillip suggested and I think it is a good idea.
> 
> When I suggested adding a helper I was thinking of something like
> 
> static const struct worktree *do_find_shared_symref(struct worktree
> **worktrees,
>  					  const char *symref,
>  					  const char *target,
> 					  int ignore_current)
> {
> 	/*
> 	 * Body moved from find_share_symref() with a couple
> 	 * of lines added to support ignore_current
> 	 /*
> }
> 
> const struct worktree *find_shared_symref(struct worktree **worktrees,
>  					  const char *symref,
>  					  const char *target)
> {
> 	return do_find_shared_symref(worktrees, symref, target, 0)
> }
> 
> void die_if_checked_out(const char *branch, int ignore_current_worktree)
> {
> 	struct worktree **worktrees = get_worktrees();
> 	const struct worktree *wt;
> 
> 	wt = do_find_shared_symref(worktrees, "HEAD", branch,
> 				   ignore_current_worktree);
> 	/* rest unchanged */
> }
> 
> The aim was to avoid changing the public api

I thought about a solution like the one you suggest.  Also another one based on
iterations, something like wt_head_refs()....  I ended up with
is_shared_symref(), it adds some value, I think.

The public API remains unchanged, and I like that the comment for
find_shared_ref(), which is an important note, is moved to is_shared_symref(),
which contains the essential work related to the comment.

die_if_checked_out() needs to iterate (here was the wt_heads_refs()), but my
intuition makes me think it's a good step since we might need another level,
I'm not sure yet but, like "die_if_if_checked_out(allow_if_current)".

I'm going to send a v3 addressing the issues Junio commented, still with the
is_shared_symref().  If the above reasoning doesn't work for you or if the
change as-is introduces any problem, I have no objection to
"do_find_shared_symref()".

Thank you.
