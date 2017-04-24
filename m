Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8606207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 23:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979312AbdDXXdl (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 19:33:41 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:16976 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S979309AbdDXXdk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 19:33:40 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id 2nU9dUCwcHGLw2nUAdtp86; Tue, 25 Apr 2017 00:33:38 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8
 a=pGLkceISAAAA:8 a=5rxgeBVgAAAA:8 a=nc0sOGcMyoZwE_-mOooA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <4BF0A1BFFFFD421EB8C5F7E6FEF14357@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>,
        "Orgad Shaneh" <orgads@gmail.com>,
        "Dakota Hawkins" <dakotahawkins@gmail.com>
Cc:     "git" <git@vger.kernel.org>
References: <CAGHpTBJCjNa8gQRkMah30ehESdsVVKNy+6CuLSf9hfDedR+tPA@mail.gmail.com> <CAGZ79kZ5440r1EHOVP3eXxe5u=u16y_jXTA0C4hLJA2kUkF-kg@mail.gmail.com>
Subject: Re: Submodule/contents conflict
Date:   Tue, 25 Apr 2017 00:33:38 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfK1OlMbi8WFy/VAV/EsBt2zelzBBbcuTj60kc507p51npXbu7nEVEFC75LL50ZPSCP4buSryEsIlaD8POXPmZIdfBR4qD9IEC+dxK6wBYYEUhKszw//N
 YnG59aqlMLS7JZkvYpZTrEUVA19ls1P0TpcwaN5yIBLHdWQhDJxbl+BdH0usawYr2/BE14CgC6t+NVNYxAhxa0iOLvVgxxvggbWM0kO6VxDpVl54awwBLGJZ
 c4mthB4tFOfKziq3G/wgTQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
> On Mon, Apr 24, 2017 at 1:06 AM, Orgad Shaneh <orgads@gmail.com> wrote:
>> Hi,
>>
>> I've noticed a strange behavior with submodule/content conflict. My
>> current Git version is 2.12.2, but the problem exists since I
>> remember.
>>
>> Branch A has a submodule.
>> In branch B which diverged from A, I replaced the submodule with its 
>> contents.
>>
>> Now, every time I merge A into B, and A had changed the submodule
>> reference, all the files inside the ex-submodule directory in B are
>> being "re-added".
>>
>> Moreover, aborting the merge prints an error, but seems to work
>> nevertheless, and if I run git reset --hard all the files in that
>> directory are actually written to the disk, even though they haven't
>> changed at all.
>>

This is almost the same as just reported by 'vvs' [1] 
https://public-inbox.org/git/CAM1zWBtfgHT=pT0pidQo1HD=DfrXLG3gNaUvs0vZKvYfG1BHFw@mail.gmail.com/, 
originally on the 'git user' list 
https://groups.google.com/forum/?hl=en#!topic/git-users/9ziZ6yq-BfU

It also has a similarity to 
https://public-inbox.org/git/1492287435.14812.2.camel@gmail.com/  regarding 
how checkout operates.

It does feel as if there are two slightly different optimisations that could 
be used when the desired file pre-exists in the worktree, but isn't 
immediately known to the index.


>> When the submodule is small, it might be ok. But in my project we have
>> a huge submodule with ~16K files, and on each merge all the files are
>> listed, and even mixed reset takes several minutes.

That sounds like a wait that is not wanted!
>>
>
> A similar bug report
> https://public-inbox.org/git/CAG0BQX=wvpkJ=PQWV-NbmhuPV8yzvd_KYKzJmsfWq9xStZ2bnQ@mail.gmail.com/
>
> "checkout --recurse-submodules" (as mentioned in that report)
> made it into Git by now, but this bug goes unfixed, still.
>
>> The following script demonstrates this:
>> #!/bin/sh
>>
>> rm -rf super sub
>> mkdir sub
>> cd sub
>> git init
>> touch foo
>> git add foo
>> git commit -m 'Initial commit'
>> mkdir ../super; cd ../super
>> git init
>> git submodule add ../sub
>> touch foo; git add foo sub
>> git commit -m 'Initial commit'
>> git checkout -b update-sub
>> git update-index --cacheinfo 
>> 160000,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa,sub
>> git commit -m 'Update submodule'
>> git checkout -b remove-sub HEAD^
>> git rm sub
>> mkdir sub
>> touch sub/foo sub/bar
>> git add sub
>> git commit -m 'Replaced submodule with contents'
>> git checkout -b remove-2 HEAD^
>> git merge --no-ff remove-sub
>> git merge update-sub
>> # Adding sub/foo
>> # Adding sub/bar
>> # CONFLICT (modify/delete): sub deleted in HEAD and modified in
>> update-sub. Version update-sub of sub left in tree at sub~update-sub.
>> # Automatic merge failed; fix conflicts and then commit the result.
>> git merge --abort
>> # error: 'sub' appears as both a file and as a directory
>> # error: sub: cannot drop to stage #0
>>
>> - Orgad
>
--
Philip 

