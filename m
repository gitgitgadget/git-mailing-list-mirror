Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92CAC38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 13:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CFC20A8B
	for <git@archiver.kernel.org>; Fri,  8 May 2020 13:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="IQIhdHcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEHN7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 09:59:13 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:33907 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbgEHN7M (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 May 2020 09:59:12 -0400
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 May 2020 09:59:11 EDT
Received: from mxback18o.mail.yandex.net (mxback18o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::69])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 68C74F200E4;
        Fri,  8 May 2020 16:52:45 +0300 (MSK)
Received: from iva1-bc1861525829.qloud-c.yandex.net (iva1-bc1861525829.qloud-c.yandex.net [2a02:6b8:c0c:a0e:0:640:bc18:6152])
        by mxback18o.mail.yandex.net (mxback/Yandex) with ESMTP id UTG8M8804R-qjvuZrIP;
        Fri, 08 May 2020 16:52:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1588945965;
        bh=zoZB7UXw+xUFOskXqmHh7IFmntSQWblXOCDf1JW2ECI=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=IQIhdHcxihdPU/FtyaCBSRNsTPxqiwm31l9/n058zFo4BY02gbOiPtbgltHD1gOa1
         tDk5YHfRTL4yqnRdK7upqLpiTq2fvG/aVMODV/6No334MoC+xkHT9EB8LgqMA6cyvi
         b95vFsUPgk5vqrkOrgTUTtw8+qwPYAlZQlu2EG2c=
Authentication-Results: mxback18o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva1-bc1861525829.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id BOlyjVW2PE-qiQWU9PM;
        Fri, 08 May 2020 16:52:44 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: git apply -3 doesn't work
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <d9d549eb-e888-c930-1aeb-38cd3aad1b3b@yandex.ru>
 <bf5fab9b-78f0-8c8c-dcf6-e6672014412f@gmail.com>
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
Message-ID: <f5e4a133-8cfc-0f6f-bfeb-b62acca5d110@yandex.ru>
Date:   Fri, 8 May 2020 16:52:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <bf5fab9b-78f0-8c8c-dcf6-e6672014412f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/8/20 4:47 PM, Phillip Wood wrote:
> Hi Konstantin
> 
> On 08/05/2020 11:35, Konstantin Kharlamov wrote:
>> As description says. To check that the 3-way merge should actually work subsitute `git apply -3` with `git am -3` in the following steps. This way it works.
>>
>> # Steps to reproduce
>>
>>      $ git init
>>      Initialized empty Git repository in /tmp/foo/.git/
>>      $ echo hello > file1 && git add file1 && git commit -m "initial commit"
>>      [master (root-commit) 8334093] initial commit
>>       1 file changed, 1 insertion(+)
>>       create mode 100644 file1
>>      $ git checkout -b mybranch
>>      Switched to a new branch 'mybranch'
>>      $ echo bye > file1 && git add file1 && git commit -m "change file1 text"
>>      [mybranch 1807900] change file1 text
>>       1 file changed, 1 insertion(+), 1 deletion(-)
>>      $ git format-patch -1 --stdout > 1.patch
>>      $ git checkout master
>>      Switched to branch 'master'
>>      $ mv file1 file2
>>      $ git add -u && git add file2 && git commit -m "renamed file1 to file2"
>>      $ git apply -3 1.patch
>>      error: file1: does not exist in index
> 
> Judging from the error message it never gets as far as trying the 3 way merge because it first tries to apply the patch which modifies file1 but file1 does not exist in the index. If it were to try a 3 way merge in this case then on one side of the merge you've modified file1 and on the other side it has been deleted so there would be a merge conflict. The reason 'git am' succeeds is that the rename detection kicks in and so it applies the patch to file2 rather than file1
> 
> Best Wishes
> 
> Phillip
> 

Thank you. I wonder if it would make sense to `git aplly -3 1.patch` to behave similarly to `git am -3 1.patch && git reset HEAD^` (except without modifying reflog). I.e. so all heuristics `git am` makes use of would also apply to `git apply`
