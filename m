Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EBAC2BB1D
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1F520716
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 18:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI3IkQP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCLSqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:46:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44321 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgCLSqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 14:46:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id b72so3681291pfb.11
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 11:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZpjLKUxRL5pcKKs4ylz4VloC3xrRHzN9FkD/lVpUrWM=;
        b=dI3IkQP+ht1HgdR6xKG/7K1ka0HOGZv/kjG5MvlPdcRcwRGmuVGOqBFnjumpBt32Tt
         lM4KGmX6WyQnOemXkHEKCQfD49HNOHGcvESUL0nz9eOPuvNhoQidfyBGEujR5TLPJm/l
         jMyy5AuRLDZe99T8AIaxDyAS1001jGBagND6TFa3KjS5IApAxxQghrzVOQhAf2sy+UG9
         zO/t7bYGD+jZu7HsKdFIkNn9c1Z+eq5GeFF8ERbuwspLcWCxxwKl7AmnbamIpk7lYqlm
         LLgEnkvwDDqmK0VF+hWttav89ot9qVpH+LsMZKBSpT7Xc7zMESesWBrkqh+zM//+0iB0
         eRZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZpjLKUxRL5pcKKs4ylz4VloC3xrRHzN9FkD/lVpUrWM=;
        b=KVOubdbsYcjQBT7/ejpQF4pJwMECKVq4IOk0KejoS+CKF7jVz8M/Ta+DKq2+8YJwb9
         R9F7+zx4Qhzwl66CWHVbh3BhsZlyRBCF4lef7ndllSjfu43ORBAPb036vIE19NwpoMKu
         nI/8nvnPCN6/VG5pkQxT9tb6y3ISKlm4nhw2PhvGKgGFBk2s7CUWqr4FM+bF6V/xdD37
         15RlEraf8pPMTSUt2frSJKU4MqLV5YNLPuaI6b8EMeCZu3EB/epQVry9wOWnl2tREGYk
         /e/tln0Q0+ge/c5TbcbiBGECg3OHLUD0i4U9ZAGVjL31vETC1SpizmdBVhqEjbQ+/qV9
         ix7w==
X-Gm-Message-State: ANhLgQ1aQYmJJXXxptR0Ptr3NM6vkzG4aW1vcxDpk62exLPlXxO6P6xB
        uCjJxFipQJQbHSqi/nUteZY=
X-Google-Smtp-Source: ADFU+vtpBxroZZykJwcDtkQsOjc4YwCkqjBfRmQPURxv/SFVf2eOZbDDea3niItrGjzesWhgKd8SIA==
X-Received: by 2002:a63:5f51:: with SMTP id t78mr9202543pgb.362.1584038783946;
        Thu, 12 Mar 2020 11:46:23 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id c190sm15841080pfa.66.2020.03.12.11.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:46:23 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:46:21 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v5 20/20] rebase: rename the two primary rebase backends
Message-ID: <20200312184621.GD120942@google.com>
References: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
 <pull.679.v5.git.git.1581802602.gitgitgadget@gmail.com>
 <ad8339aebf28ec84c22ed59cef06614d204adb55.1581802602.git.gitgitgadget@gmail.com>
 <20200312151318.GM212281@google.com>
 <CABPp-BHyNvxQZ5q=9WXXESTPmxFe4fAiE5roGeV2H+XJ_cpDmg@mail.gmail.com>
 <20200312175548.GC120942@google.com>
 <CABPp-BFLwpa019Prd3nf7s4BY2jWp8utOvJD9pzHcbg66b8fWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFLwpa019Prd3nf7s4BY2jWp8utOvJD9pzHcbg66b8fWw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Thu, Mar 12, 2020 at 10:55 AM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> What if we support multiple merge.backend values, with semantics:
>>
>> - last recognized value wins
>> - if no value is specified, use the default
>> - if values are specified but none are recognized, error out with a
>>   clear error message
>>
>> ?
>
> Sure, but...isn't that what we already do, other than maybe the
> 'clear' part of step 3?

Sorry for the lack of clarity.  I mean allowing

	[rebase]
		backend = am
		backend = apply
		backend = futuristic

with behavior

- on "git" that understands am but not apply or futuristic, use the am
  backend
- on "git" that understands apply but not am or futuristic, use the
  apply backend
- on "git" that understands apply and futuristic, use the futuristic
  backend

That way, a single config file is usable on all three versions of Git.

Thanks,
Jonathan
