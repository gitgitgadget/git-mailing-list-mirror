Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D595C1F770
	for <e@80x24.org>; Mon, 31 Dec 2018 11:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeLaLYZ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 31 Dec 2018 06:24:25 -0500
Received: from smtp.msys.ch ([46.175.8.2]:19269 "EHLO sleipnir.msys.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbeLaLYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Dec 2018 06:24:25 -0500
Received: from mail.msys.ch (smtp.msys.ch [46.175.8.2])
        by sleipnir.msys.ch (8.14.3/8.14.3) with ESMTP id wBVDClY2017450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 31 Dec 2018 13:12:47 GMT
Received: from dev.arcapos.ch (dev.arcapos.ch [46.175.8.141])
        (authenticated bits=0)
        by mail.msys.ch (8.14.3/8.14.3) with ESMTP id wBVDCkg4030369
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 31 Dec 2018 13:12:47 GMT
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
From:   Marc Balmer <marc@msys.ch>
In-Reply-To: <CACsJy8AQ1raB+2wjEBtDrAvJm0v-3exJ-FVB2ZyL6VpRFQkspQ@mail.gmail.com>
Date:   Mon, 31 Dec 2018 12:24:16 +0100
Cc:     Git Mailing List <git@vger.kernel.org>, roger.strain@swri.org,
        Junio C Hamano <gitster@pobox.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0F754615-C852-49D8-8E0C-DD2A00A15ED1@msys.ch>
References: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch>
 <CACsJy8B7=xNBeyYYgMqh-aU_1-Rb8g5t5SwK5jvfbMw4ch-ZLQ@mail.gmail.com>
 <11AC6C27-4C74-43B1-89F6-98ABBFE74E0E@msys.ch>
 <CACsJy8AQ1raB+2wjEBtDrAvJm0v-3exJ-FVB2ZyL6VpRFQkspQ@mail.gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-SMTP-Vilter-Version: 1.3.6
X-Spamd-Symbols: BAYES_00,RCVD_IN_DNSWL_LOW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> Am 31.12.2018 um 12:20 schrieb Duy Nguyen <pclouds@gmail.com>:
> 
> On Mon, Dec 31, 2018 at 6:13 PM Marc Balmer <marc@msys.ch> wrote:
>> 
>> 
>> 
>>> Am 31.12.2018 um 11:51 schrieb Duy Nguyen <pclouds@gmail.com>:
>>> 
>>> On Mon, Dec 31, 2018 at 5:44 PM Marc Balmer <marc@msys.ch> wrote:
>>>> 
>>>> Hi
>>>> 
>>>> One of the last three commits in git-subtree.sh introduced a regression leading to a segfault.
>>>> 
>>>> Here is the error message when I try to split out my i18n files:
>>>> 
>>>> $ git subtree split --prefix=i18n
>>>> cache for e39a2a0c6431773a5d831eb3cb7f1cd40d0da623 already exists!
>>>>  (Lots of output omitted)
>>>> 436/627 (1819) [1455]       <- Stays at 436/ while the numbers in () and [] increase, then segfaults:
>>>> /usr/libexec/git-core/git-subtree: line 751: 54693 Done                    eval "$grl"
>>>>   54694 Segmentation fault      (core dumped) | while read rev parents; do
>>> 
>>> Do you still have this core dump? Could you run it and see if it's
>>> "git" that crashed (and where) or "sh"?
>> 
>> It is /usr/bin/bash that segfaults.  My guess is, that it runs out of memory (as described above, git-subtree enters an infinite loop untils it segafults).
> 
> Ah that's better (I was worried about "git" crashing). The problematic
> commit should be 19ad68d95d (subtree: performance improvement for
> finding unexpected parent commits - 2018-10-12) then, although I can't
> see why.
> 
> I don't think we have any release coming up soon, so maybe Roger can
> still have some time to fix it instead of a just a revert.

In a (private) Email to me, he indicated that had no time for a fix.  Maybe he can speak up here?

In any case, if I can help testing, I am in.  I just don't know the inner workings of git-subtree.sh (I am a mere user of it...)


> 
>> 
>>> 
>>>>  process_split_commit "$rev" "$parents" 0;
>>>> done
>>>> 
>>>> Please note that this regression can not easily be reproduced, normally a subtree split just works.
>>>> 
>>>> Reverting the last three commits "fixes" the issue.  So I kindly ask the last three commits to be reverted.
>>> 
>>> Please provide the SHA-1 of the "good" commit you tested.
>> 
>> I reverted these three commits (actually the last three commits to contrib/subtree/git-subtree.sh):
>> 
>> 19ad68d95d6f8104eca1e86f8d1dfae50c7fb268
>> 68f8ff81513fb3599ef3dfc3dd11da36d868e91b
>> 315a84f9aa0e2e629b0680068646b0032518ebed
>> 
>> And then it worked.
>> 
>> - Marc
>> 
>> --
>>> Duy
>> 
> 
> 
> -- 
> Duy
