Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9822C46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjASX1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjASX1D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 18:27:03 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106632685D
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 15:27:02 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o17-20020a05600c511100b003db021ef437so2476259wms.4
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 15:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExXZBQYt8zcH7xsnyQU9t7lwMrz+2dCPds3IrIwEwa4=;
        b=OC8JYctVer+8hyR7kQWVEBQAaXonfkpmKUMWb/wybZEaV93BZyT4MmOW14jdqLEs15
         aeIEs7aknT21Her7QOukeZbh8759nENPuQEXaWWh1xzoVJ8vAnFnUg0T18jXIXl9q4RT
         Tx7VTDAOHDQweMAOlmX3d8MP6oEpv/kIMjcL79sPeIxUpVJDbCcJQqpBYzpS/f27EAng
         CUkP9pWHkqlkyYMOVyC3Q4nihEEZ06w0vI5XD/3G0zpPFMWOcoaJ/8X6WNL0Ufx6gpLF
         SraPYDXY1tFzhZjwgaV3sVag8A8k/SPnYYDQ/geIg4rZwXCQoNntKDDRl+QWP5LpJ557
         l7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExXZBQYt8zcH7xsnyQU9t7lwMrz+2dCPds3IrIwEwa4=;
        b=V3ONHNvylmhp57Q3kz10jwmi18IX4ZD0xOPzT+ryejTXsASbpc66ISWErFpdDTRfk2
         8zHzCh0s0jRY6Lul58IMlLtC/19APCI0Q1S5/Xk701f/dfRu++G4xnA/3MCFpysNcM2Q
         MMhA7okmh4ZPP7wyE82EvsIowH7XPmIPt1InYrOpBvPSfS2P8z3sbiFt21wVb+CCPQpb
         db5Z8tdS+tfNUzBFLWRID+KvPJh1vaiLhoTJEWWld9i35sDBrzRps/eT0/VM2EPwU6p/
         +ByuABe4UJ51tdrg5fB283B/708L+1W5ruZDfY8XmtQNisq0sUJebto9jcmRfvUCFqH8
         tO1Q==
X-Gm-Message-State: AFqh2kppLU8vHaOiUIjQZM9mVkTSgjl8hQandQAnizbol2f78d2Yh/4r
        /+GLGdIdTqK5uEsrBHZvWbhqqog+QJI=
X-Google-Smtp-Source: AMrXdXvN18eihod8kL3vOteugSG9PGmaGr/seTh7qS10IwUrv5A/TknPEhwkp4B4Cut33Bwtsqabkg==
X-Received: by 2002:a05:600c:b96:b0:3db:19:798 with SMTP id fl22-20020a05600c0b9600b003db00190798mr8098497wmb.39.1674170820473;
        Thu, 19 Jan 2023 15:27:00 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id m26-20020a7bcb9a000000b003db2dede1a2sm504359wmi.26.2023.01.19.15.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 15:27:00 -0800 (PST)
Subject: Re: [PATCH v2 1/3] avoid unnecessary worktrees traversing
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <bc82dd95-c968-146d-0dea-f82631b74765@gmail.com> <xmqqilh21ale.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <f369f68e-5921-095f-e3e8-3d324d1688f4@gmail.com>
Date:   Fri, 20 Jan 2023 00:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqilh21ale.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19-ene-2023 13:24:45, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > -static void reject_rebase_or_bisect_branch(const char *target)
> > +static int ishead_and_reject_rebase_or_bisect_branch(const char *target)
> 
> The original name was already horrible but it became much worse by
> acquiring a non-word "ishead" as part of it X-<.
> 
> At least let's replace "rebase or bisect" with something a bit more
> generic, extensible, and shorter phrase.  For example, isn't the
> point of having the function was to give us a mechansim to see if
> the branch with the given name is not to be modified because it is
> being worked on elsewhere?  "The branch is in use" would be a good
> phrase to express such a concept, so die_if_branch_is_in_use() or
> something along that line may be easier to grok.

I agree, the naming is ugly.

The idea is to return, if not die(), from the iteration we are doing in
that function, whether the branch is checked out in any worktree.  That
information allows us later, if we know in advance that no HEAD needs to
be adjusted, to avoid calling replace_each_worktree_head_symref(),
saving us a new and unnecessary traversal of the worktrees.

There is a second idea to, in next commits, return also if the branch
is an unborn branch.

die_if_branch_is_in_use() is a better name for reject_rebase_or_... but
don't know how it fits with these ideas.  I'm open to suggestions.

I'll reroll with a better approach.

Thank you.
