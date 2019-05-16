Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88571F461
	for <e@80x24.org>; Thu, 16 May 2019 18:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbfEPSHY (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 14:07:24 -0400
Received: from outmail148096.authsmtp.net ([62.13.148.96]:45110 "EHLO
        outmail148096.authsmtp.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbfEPSHY (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 May 2019 14:07:24 -0400
X-Greylist: delayed 994 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 May 2019 14:07:23 EDT
Received: from mail-c233.authsmtp.com (mail-c233.authsmtp.com [62.13.128.233])
        by punt18.authsmtp.com. (8.15.2/8.15.2) with ESMTP id x4GHolD1057830;
        Thu, 16 May 2019 18:50:47 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
Received: from amoe.lan ([37.152.216.162])
        (authenticated bits=0)
        by mail.authsmtp.com (8.15.2/8.15.2) with ESMTPSA id x4GHojYE047541
        (version=TLSv1.2 cipher=AES128-SHA bits=128 verify=NO);
        Thu, 16 May 2019 18:50:46 +0100 (BST)
        (envelope-from bavison@riscosopen.org)
Subject: Re: [PATCH] clone: add `--remote-submodules` flag
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20190513175903.126079-1-bavison@riscosopen.org>
 <CACsJy8B589nOPNt6143BNQNojRYn4pyQCMNZKLRn+EGyWD4-mw@mail.gmail.com>
From:   Ben Avison <bavison@riscosopen.org>
Organization: RISC OS Open Ltd
Message-ID: <1376dce1-6ca1-88f2-97c9-c8dd2ac683a1@riscosopen.org>
Date:   Thu, 16 May 2019 18:50:45 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8B589nOPNt6143BNQNojRYn4pyQCMNZKLRn+EGyWD4-mw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Server-Quench: 2222d98d-7803-11e9-a01e-84349711df28
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd1YggXA1ZfRRob ESQCJDVBUg4iPRpU DBlFKhFVNl8UURhQ KkJXbgASJgRCAnRQ SnkJW1VdQFx5U2Z1 YQ5XIwZafEtLXRto UU5XQ1RQCwdtAxke B1BWVm4KKF8vDX50 YkNmXz5dWk1+O0R/ QEwAHGVSeGBoaGMC UUENfh4FcAIfYxdB aVR2U3IMNTMFbjQC El17DAgYAR5/HWxe RgYLIABaSEoHVjZ5 AgoPGDIzEAgeWi82 KBA7LlMHFA4fNkw9 WX4A
X-Authentic-SMTP: 61633632303230.1021:706
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 37.152.216.162/2525
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/05/2019 12:31, Duy Nguyen wrote:
> On Tue, May 14, 2019 at 2:46 AM Ben Avison <bavison@riscosopen.org> wrote:
>>
>> When using `git clone --recurse-submodules` there was previously no way to
>> pass a `--remote` switch to the implicit `git submodule update` command for
>> any use case where you want the submodules to be checked out on their
>> remote-tracking branch rather than with the SHA-1 recorded in the superproject.
> 
> Are there any other submodule options that could be useful passing
> from git-clone as well? What I'm getting at is, if there are multiple
> of them, perhaps we need a different/generic approach than introducing
> a bunch of --<something>-submodules. But of course if --remote is the
> only useful one left, then it's moot.

That's an interesting point. However, for many of the switches, it only 
makes sense to set them one way when you're calling `git submodule 
update` within `git clone --recurse-submodules`.


--quiet: already inherited from `git clone`

--progress: already inherited from `git clone`

--force: wouldn't have any effect since there cannot be any local 
changes to override yet

--remote: this is what my patch is adding support for

--no-fetch: since any submodules will be freshly cloned, there is no 
need to fetch from them again already, so you'd always want this on (as 
far as I'm aware, this only has effect when you also use --remote, so 
I've made it conditional on that)

--checkout/--rebase/--merge: since there cannot be any local changes to 
rebased or merged yet, these wouldn't have any effect, and it's fine to 
leave them as the default (--checkout)

--init: you always want this in this case

--reference/--dissociate: I suppose you might want these in theory? 
However, as far as I understand, it's only really useful for `git 
submodule update` if the superproject only contains a single submodule, 
since each submodule would require a different reference repository.

--recursive: at present this is applied unconditionally. I suppose you 
might only want to recurse to one level, but I'd think that's rare?

--depth: at present you only get to set this to a depth of 1, by passing 
`--shallow-submodules` to `git clone`. I suppose you might occasionally 
want a different depth, but again I'd expect that to be rare.

--no-recommend-shallow: there may be an argument for letting you set 
this one, and you can't at present

--jobs: already inherited from `git clone`


In summary, the most significant omission is --remote IMHO, though there 
may be an argument for adding a small number of others.

Ben
