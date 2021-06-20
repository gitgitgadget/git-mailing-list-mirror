Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E30C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB29A6109F
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhFTPWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:22:08 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:7374 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229872AbhFTPWF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:22:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 6C86AB53;
        Sun, 20 Jun 2021 17:19:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1624202390; x=1626016791; bh=GvCuILvRz1fqEQ6RsGg
        9Omia6zdWEvJ1EUBYvcKkfYk=; b=tiMxcqgWXEi4YffRDyiFMcuQgJHcCKRiFIu
        BAxltQSneUbHRO829n/5ocdgxRecKJodFPCNPaBCwPgN/vzHQ7r7kMgzss5UMrRB
        CuB4UjtyH9Mo+c00zIyAq71oaB7EDYLNimlbdxSKKf1kDooCVROO/JmWp7091Lre
        u0aj3tKRZ6jMJ8rvC/0d0ao3CwOCltEJYmdLawAbTvtAdCwzfYWbaLfy+Xo8zvqd
        PIG/CmGf463dNY1fP7t3L4QEk/Hg9auaIYfQUxuS3gIXmRQ9vMI6GS+Ry6e2MGwC
        d/Mcp/8xb4jspuqn3qqGOdzDS1MAwddBGTwax2Zm95m43aCZsAKhT4GcEnHumVDU
        Y5mm613+Qyrb94sUd8kVUaKDyroAJ41rCfeXG7hGW+sT4jRq7+Fi3o6uUY8alPeM
        o8Nx8+Pj2OA8O4wX8eAl5r/B4JTAxLMBan2kjohf+6AFaBTiYjUfkIEYZiBulFfI
        gqFyezf+AGO4fCSts1uJ8Be24Ng8P8rMaQPwLFgI+Xoz/kUYpjauoeOIhLxHbXwO
        hX9rU9NOzgRaBGRihWrwWXZasY/BJV3Jy/Y16pLXRFRxiCkdl9L1mTksh/i90//S
        c+vfoyj1Ea07Ycu8id2xC/dKipqAn/4bvI/VpAVs0PFF/Kv2Sskr8m1FPkYZIX1Z
        HkzuoSJQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BljRN-GAmY25; Sun, 20 Jun 2021 17:19:50 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 0861C660;
        Sun, 20 Jun 2021 17:19:49 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 87FFD3282;
        Sun, 20 Jun 2021 17:19:47 +0200 (CEST)
Subject: Re: [PATCH 0/3] Fix uninitialised reads found with MSAN
To:     Philip Oakley <philipoakley@iee.email>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
 <1966d581-5a02-bd28-0700-c1eb4c833d1e@iee.email>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <ef984f75-f5f2-6945-597b-1bfcb8ffb169@ahunt.org>
Date:   Sun, 20 Jun 2021 17:19:40 +0200
MIME-Version: 1.0
In-Reply-To: <1966d581-5a02-bd28-0700-c1eb4c833d1e@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 17/06/2021 11:28, Philip Oakley wrote:
> On 10/06/2021 17:48, Andrzej Hunt via GitGitGadget wrote:
>> This can be worked around with an annotation in zlib (which I'm trying to
>> submit upstream at [1])
>> Andrzej
>>
>> [1] https://github.com/madler/zlib/pull/561
> Andrzey,
> 
> Just had a look at the zlib PR and it has CI check failure asking for
> extra info.

Thanks for spotting this. This seems to be a configuration issue with 
zlib's CI itself, which I noticed is also affecting other PR's on the 
same repo: /. I'll wait for feedback from the zlib maintainer for now!

ATB,


Andrzej
