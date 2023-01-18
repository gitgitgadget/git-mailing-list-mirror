Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC685C38159
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 23:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjARXv5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 18:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjARXvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 18:51:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B11A3BDBF
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:50:37 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id b5so280166wrn.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DKuiSV5pqIcSmS2mowWABCnVsr6VLoR/gVrw0wpiMZ0=;
        b=bYjxAogX8B6JAJFfaus4q9WwRF4uwOnD+aTd6POnq+XqmyXQGDldRNztZW4zZE1NY6
         yt6LXuuEYvY7icGX2iUPDbUB9vxuYKuGO/cPC47UDRjLT9tdURfUjogUbgSRHPqhDLuP
         TSX7VtfQVNK1tXW1lru2f8x+uEYHv9TKXIpmAXzVIc7xVo6fBINobe8vnh1gqdNHJ2fy
         fUHccGKsAFOwrYash9/7BxF3ybmrTyrZa3BQnMDWpRjddCKNNYx1YHePHVKfzI2oW9xG
         Gr+xNay5yZP2PvRPTeLbXlL7LfeLV6veXVORxqvFGETrLMIstoravo+fp3lCezTHox+8
         fdzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKuiSV5pqIcSmS2mowWABCnVsr6VLoR/gVrw0wpiMZ0=;
        b=2TOhAhbWBTIVzTS36cNPZ3A+IQ3DHPQeCqL6R9HfgtcJyfw2mam4qKP4wCZpmL3X35
         BZfl9MvUJbt13T1nycl+0XlbS9iRLUrwYPrDczY/gmL5U1HzQkkFztqIcDNDZas+zyvu
         KRLfMSLZSEkjZMFmU2qRCs+dsE96EwBuMwdiUDnY/MsD5g21afaeRiUdGDggJI18Fx+I
         rj00JYPFbZaDkmiJ5RMlh6hxTd2x1sxthdfP6/D0rjTdbIKqBgBocp2KDvWVS0Q+MsB1
         VjfkwM0wFG0+rQOZPbI2Tiq0lBtqVfQy8x6xBzNk95sk8Qp0p2rP0AFQjpyw+VKpsgL+
         nhHA==
X-Gm-Message-State: AFqh2krjcTJvoOs1dL9CrhjDT0NMzgVJ0M1hAJrFGUfFnC4VbSMc8Zc1
        eIJKQc9v/qr/PAt4sQIVFjU=
X-Google-Smtp-Source: AMrXdXuiX9wnZb67UdmWELzkIAdfcyProc2LMYaz5o3brIRjVIEorzthxULmoP4lMNdasBmkG/3h0w==
X-Received: by 2002:a5d:4e90:0:b0:2be:a9f:797f with SMTP id e16-20020a5d4e90000000b002be0a9f797fmr7313441wru.18.1674085835929;
        Wed, 18 Jan 2023 15:50:35 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d65c1000000b002be15ee1377sm6499834wrw.22.2023.01.18.15.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 15:50:35 -0800 (PST)
Subject: Re: [PATCH] worktree: teach find_shared_symref to ignore current
 worktree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <xmqqilh491y6.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <f209958f-e824-181b-f9d5-6e4bc8e53646@gmail.com>
Date:   Thu, 19 Jan 2023 00:50:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqilh491y6.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 17-ene-2023 15:27:29, Junio C Hamano wrote:

> being solved. Rather, it is unclear what problem you are solving.

Sorry, I didn't explain the motivation well in the message.

First, I'm not sure if "ignore_current_worktree" is correct, maybe needs
to be "prefer_current_worktree".  Having said that, let me use an example.

With...

	$ git worktree add wt1 -b main
	$ git worktree add wt2 -f main

... we get confuse results:

	$ git -C wt1 rebase main main
	Current branch main is up to date.
	$ git -C wt2 rebase main main
	fatal: 'main' is already checked out...

The problem I'm trying to solve is that find_shared_symref() returns the
first matching worktree, and a possible matching "current worktree"
might not be the first matching one.  That's why die_if_checked_out()
dies with "git -C wt2".

find_shared_symref() searches through the list of worktrees that
get_worktrees() composes: first the main worktree and then, as getdir()
returns them, those in .git/worktrees/*.  The search is sequential and
once a match is found, it is returned.  And so die_if_checked_out(),
when asked to "ignore_current_worktree", is going to consider for
"is_current" the worktree which may or may not be the "current" one,
depending on the sequence from get_worktree(), and getdir() ultimately.

If we want to disallow operations on a worktree with a checked out
branch also on another worktree, we need the "ignore_current_worktree".
But, and now I'm more in favor of this, if we prefer to allow the
operation, we need a "prefer_current_worktree", to induce
find_shared_symref() to return the "current" one if it matches, or any
other one that matches.
