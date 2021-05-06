Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5E7C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 05:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4B1611AD
	for <git@archiver.kernel.org>; Thu,  6 May 2021 05:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhEFFmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 01:42:33 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:62074 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232889AbhEFFm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 01:42:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 0B72840948;
        Thu,  6 May 2021 07:40:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1620279618; x=1622094019; bh=uSC1uJqlR1YbAkJZrJZ
        ico8zSLwEu6cQUpJqTw9Xb20=; b=P7Am1SsfvhIdcGvbHzax7xMP+SEzhDVEWSh
        2XU0U+uQKSe2y99lGLavJNv2qL/6SsM/An71hnOgtNnV5/thufmDxKzbBgt3S44c
        XMoZYfF2rKsuv7u8BUsMLONpNUIk8k6zW6IY4Panbe69TDDlEKBUOR1mHaEJpznF
        sR0BxHMM0KVwq1zQqnnl0SITOGJ6gO+fQL1hwKcAMbBzhccu2vpSoO0TL0dHSsVx
        M9SSQlnR5piY7rrEn5j0CKDujMLHfIyJmJOvZvBY3ye9ZjmK8bWM6qhkSBhgNqJl
        Ingk0QQmIErm16GoMlfTwM1Yilwj+ORmKB5x9GeHrGXDlK0UXS+TaEKW6LMK0ZCd
        TK6W6DLqn/HWCUFak+aH8TCUwhNx6wKs1xauoQzqAE9ilcixy3JleSIKpWye9N/m
        Ck6G8SKeZtPc89FS69mbclpyfHpHaQXPnONRUiyaj1Jcc9lcGTAyvsArVNfAfjC+
        Z5C+7vUYLvO/e/ljICWVKagvifqF0G2Vsafk+yyxFaji6eyDTTQOE+aJsj26C4Yd
        5ZhRjDPoaoyvAJo+CGZWnuHEp6Lb3tYJzTMwOxJLuBBu7OMHuBK4ZYaaXFbT6OFE
        cKi9gW4hV/g6uoHmtnlOcCkloM25F2N+vSL1LhSTUiGdiGGFFBYx4CsMgsULCDyC
        7CBFq+Gw=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oKrkkQ7evJJl; Thu,  6 May 2021 07:40:18 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 3080F40344;
        Thu,  6 May 2021 07:40:17 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 4B082243A;
        Thu,  6 May 2021 07:40:15 +0200 (CEST)
Subject: Re: [PATCH] builtin/init-db: preemptively clear repo_fmt to avoid
 leaks
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Andrzej Hunt <ajrhunt@google.com>
References: <pull.1018.git.git.1620240022594.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2105052125452.50@tvgsbejvaqbjf.bet>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <79cd3791-bf6e-df3e-1045-c51801406905@ahunt.org>
Date:   Thu, 6 May 2021 07:40:13 +0200
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2105052125452.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 05/05/2021 21:28, Johannes Schindelin wrote:
> Hi Andrzej,
> 
> On Wed, 5 May 2021, Andrzej Hunt via GitGitGadget wrote:
> 
>> diff --git a/builtin/init-db.c b/builtin/init-db.c
>> index 31b718259a64..b25147ebaf59 100644
>> --- a/builtin/init-db.c
>> +++ b/builtin/init-db.c
>> @@ -512,6 +512,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
>>   			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
>>   	}
>>
>> +	clear_repository_format(&repo_fmt);
> 
> I am afraid that this might not be correct, as t0410.27 experienced a
> segmentation fault (see
> https://github.com/git/git/pull/1018/checks?check_run_id=2511749719#step:5:2845
> for the full details):


Thanks for spotting that. On further investigation this looks like a 
preexisting issue on seen (my github PR was based on seen - in hindsight 
that was probably not a good idea) - here's a CI run from seen this 
morning exhibiting the same failure:
   https://github.com/git/git/runs/2515095446?check_suite_focus=true

To gain more confidence, I've rebased my patch onto next, and I no 
longer hit any CI failures:
   https://github.com/ahunt/git/runs/2515309312?check_suite_focus=true
(I ran this on my fork because changing the base branch appears to have 
confused the PR's CI configuration.)


Nevertheless, I was still curious about what might be causing the 
failure in the first place: it appears to only happen in CI with gcc on 
Linux, and I was not able to repro on my machine using (tested with 
gcc-7.5 and gcc-10, with seen from this morning):
   make CC=gcc-10 T=t0410-partial-clone.sh test

I'm guessing that understanding this failure might require the help of 
someone with an Ubuntu install to debug (unless there's some easy way of 
using Github's Actions to run a bisect)?

-- snip --

ATB,

   Andrzej
