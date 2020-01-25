Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686E6C35241
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 07:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 311F22071A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 07:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GNpEdbYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgAYHiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 02:38:08 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42704 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAYHiI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 02:38:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so4760991wro.9
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 23:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3e/TaLtC2D2Miw3dHbIiSY1d6jgQsqnluyYF8izuY28=;
        b=GNpEdbYmxhHA34WlQo0t8RTjyVWW+6dLFcv9Dv6gOVD1FuMyOLi0MnQpeWR/yygUuI
         Jaw9uzr4nGdbbGQekb9BogGBRrxmIwNbQxRW3a94EHsY6qIBwe5mMrSVyMgpWWHKXMMI
         EHunCi3oEwDhlMhXPOCUflzZizPJ6y1uB32RYTkYeObt60m02LWYCZkwao2TGNVIPoPa
         YBdX40j5P/jnsoIoQRSf+BP86sOqXjU/ElLQJOincKbclg5LobYpQ/6OR3O5PUpRt/51
         EUyub+sCOe6cnFfeC5/X52oDv4jepPmfjBDcJDU7H5xfpz7qIgACbx4dJ+9f3sFTQi9p
         Hqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3e/TaLtC2D2Miw3dHbIiSY1d6jgQsqnluyYF8izuY28=;
        b=F/XMO+8m2LX3MaFqD92bouBvhhE7h2H+j2bbDThfzbG3Q87DUJYlPT13pJJcMR2J7H
         QPZc7EAas2lgdNR3CQliOGnTasHARX9B581njpd1rBn7mcndlsmUbMy8U/9wHOSLiQEc
         OH1zjisGVlAzsfDFlAEnKK8Ny+2NAAvqE1h2XZbvsiOILh02QrmdaNdmIwNJHZKp+51p
         qQQAzpBg9jW5nzYlAVmPFPfkBjEPy7UJPcBW2SQob4IGNaW+XjFo2KeEoLyxqI0S5O8f
         XEDWIXTmeHrRmLwLbxRBldtdWIa7SC81zCtIXBqTCgLCFers+cYeIdnzVStY68c57jgz
         VEnQ==
X-Gm-Message-State: APjAAAXqfc9zZUwsPvbp49+uLjV8MHFF8N28xG02RowH0iFaywllLuoC
        zIeA/XkIXzdonDUKMCM=
X-Google-Smtp-Source: APXvYqz3Ez1LpoM06RcWjXNRNAcwJtAoEipkehKLEVRVrnconLkvMPP+QwvKOKoSqKK2B0VPkzRnFw==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr8632068wru.382.1579937885493;
        Fri, 24 Jan 2020 23:38:05 -0800 (PST)
Received: from ?IPv6:2a02:810a:8c80:d2c:1d4:baf0:179f:5856? ([2a02:810a:8c80:d2c:1d4:baf0:179f:5856])
        by smtp.gmail.com with ESMTPSA id c2sm10724500wrp.46.2020.01.24.23.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jan 2020 23:38:05 -0800 (PST)
Subject: Re: [Q] push refspec with wildcard pushes all matching branches
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <ed9a0485-1e6c-79ae-6a59-655105203728@googlemail.com>
 <20200125003836.GA568952@coredump.intra.peff.net>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Message-ID: <b4c31e50-6da5-7699-1069-d94091f768bd@googlemail.com>
Date:   Sat, 25 Jan 2020 08:38:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200125003836.GA568952@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25.01.20 01:38, Jeff King wrote:
> On Fri, Jan 24, 2020 at 09:29:53PM +0100, Bert Wesarg wrote:
> 
>> I'm a little confused, that a push refspec with a wildcard changes the number of branches pushed.
> 
> I'm confused about which part you're confused about. :)
> 
>>      $ git push --dry-run
>>      To ../bare.git
>>       * [new branch]      master -> master
>>      $ git config remote.origin.push 'refs/heads/master*:refs/remotes/origin/master*'
>>      $ git push --dry-run
>>      To ../bare.git
>>       * [new branch]      master -> origin/master
>>       * [new branch]      master-two -> origin/master-two
>>
>> Is this expected behavior?
> 
> You asked it to push master*, so it did.
> 
> Is your confusion that you had set push.default to "current"? If there
> is a refspec (either in the config or specified on the command line),
> then that takes precedence over push.default.
> 
>  From git-push(1):
> 
>    When the command line does not specify what to push with <refspec>...
>    arguments or --all, --mirror, --tags options, the command finds the
>    default <refspec> by consulting remote.*.push configuration, and if it
>    is not found, honors push.default configuration to decide what to push
>    (See git-config(1) for the meaning of push.default).
> 
> If that's not it, can you clarify what you expected to happen?

thanks for this pointer. My initial pointer was the help for push.default:

  From git-config(1):

        push.default
            Defines the action git push should take if no refspec is explicitly
            given. Different values are well-suited for specific workflows; for

Thus I expected, that this takes effect, when just calling 'git push'.

What I actually want to achieve, is to track a remote branch with a different name locally, but 'git push' should nevertheless push to tracked remote branch.

In my example above, befor adding the 'push.origin.push' refspec, rename the branch:

     $ git branch -m local
     $ git push --dry-run
       To ../bare.git
        * [new branch]      local -> local

Is it possible that this pushes to the tracked branch automatically, and because I have multiple such branches, without the use of a push refspec.

Thanks for the help.

Best,
Bert

> 
> -Peff
> 
