Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A7EB64DD
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 12:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbjHIMil (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 08:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjHIMik (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 08:38:40 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5129C1FCA
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 05:38:34 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 3142024617;
        Wed,  9 Aug 2023 14:38:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id AD59D244C8;
        Wed,  9 Aug 2023 14:38:31 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id twmlGVVyEfBW; Wed,  9 Aug 2023 14:38:31 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 5580924355;
        Wed,  9 Aug 2023 14:38:29 +0200 (CEST)
Message-ID: <1eef1bff-8b65-abac-e75b-acd98b013e7b@opperschaap.net>
Date:   Wed, 9 Aug 2023 08:38:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: git pre-push hook not getting the lines from STDIN
Content-Language: en-US
To:     Sean Allred <allred.sean@gmail.com>
References: <676330b6-720a-e262-d583-9012e549bba7@opperschaap.net>
 <m0wmy4lbd0.fsf@epic96565.epic.com>
Cc:     git@vger.kernel.org
From:   Wesley <wesleys@opperschaap.net>
In-Reply-To: <m0wmy4lbd0.fsf@epic96565.epic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=GP927dFK c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=p0WdMEafAAAA:8 a=2z1OXlWFAAAA:8
        a=NEAV23lmAAAA:8 a=f0iG_GcXrEStkm3_-PgA:9 a=QEXdDO2ut3YA:10
        a=SNRPda0NjyR9MlWdJ_lJ:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello Sean,

> Have you looked at simplifying this script to the bare minimum to
> identify the issue? I might suggest starting by just slurping stdin and
> writing that to a file:
> 
>      #!/bin/sh
>      echo "$@" >pre-push.$$.args
>      cat >>pre-push.$$.stdin
>      exit 1
 >
> I'm not familiar with the particulars of Zsh scripting, but I suspect
> there is a bug in your script. Zsh works with my script, too, so it
> doesn't appear to be a problem with Zsh itself.

This is the bare miminum. You can also take the example script from the 
git sources which does it in bash[^1] and uses while read syntax. It 
produces the same output, with the exception that you don't see the 
empty echo statements because it cannot read the input from STDIN and 
exits immediately.

It seems it works intermittently.

In my zsh repo for example with the following remotes:

origin	git@gitlab.com:waterkip/zsh (fetch)
origin	git@gitlab.com:waterkip/zsh (push)
upstream	git://git.code.sf.net/p/zsh/code (fetch)
upstream	git://git.code.sf.net/p/zsh/code (push)

Locally my patchlevel-in_version branch is at commit b7f280ab5. If I 
`git pull --rebase upstream master` and than push it (`git push origin 
HEAD) with hook configured it doesn't show any of the things I expect in 
LOCAL_REF etc. This happens with my version of the script and the 
version provided by git (in .git/hooks/pre-push.sample).

Cheers,
Wesley

[^1]: 
https://github.com/git/git/blob/87c86dd14abe8db7d00b0df5661ef8cf147a72a3/templates/hooks--pre-push.sample

-- 
Wesley

Why not both?

