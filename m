Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AA7C71153
	for <git@archiver.kernel.org>; Sun,  3 Sep 2023 02:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjICC3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 22:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjICC3U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 22:29:20 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E195CC5
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 19:29:11 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 0DED1233B6;
        Sun,  3 Sep 2023 04:29:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 82C592332B;
        Sun,  3 Sep 2023 04:29:08 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id THxM7iNBrpph; Sun,  3 Sep 2023 04:29:08 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 285C723327;
        Sun,  3 Sep 2023 04:29:06 +0200 (CEST)
Message-ID: <8354f569-dbbe-4d01-95af-0d23a949c22d@opperschaap.net>
Date:   Sat, 2 Sep 2023 22:29:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] builtin/rebase.c: Emit warning when rebasing
 without a forkpoint
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq1qfiubg5.fsf@gitster.g>
 <20230902221641.1399624-1-wesleys@opperschaap.net>
 <20230902221641.1399624-3-wesleys@opperschaap.net>
 <xmqq4jkckuy7.fsf@gitster.g>
From:   Wesley <wesleys@opperschaap.net>
In-Reply-To: <xmqq4jkckuy7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=SPw8q9nH c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=N3miCFJ7AAAA:8
        a=cXgYEN2oqqfky9IpwxAA:9 a=QEXdDO2ut3YA:10 a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/2/23 19:37, Junio C Hamano wrote:
> Wesley Schwengle <wesleys@opperschaap.net> writes:

Thanks for the feedback. I won't continue the patch series because some 
of the feedback you've given below.

>> However doing so would trigger a different
>> kind of behavior.  `git rebase <upstream>' behaves as if
>> `--no-fork-point' was supplied and without it behaves as if
>> `--fork-point' was supplied. This behavior can result in a loss of
>> commits and can surprise users.
> 
> No, what is causing the loss in this particular case is allowing to
> use the fork-point heuristics.  If you do not want it, you can
> either explicitly give --no-fork-point or <upstream> (or both if you
> feel that you need to absolutely be clear).  Or you can set the
> configuration to "false" to disable this "auto" behaviour.

Isn't that what I'm saying? At least I'm trying to say what you are saying.

> By the way, while I do agree with the need to make users _aware_ of
> the "auto" behaviour [*1*], I am not yet convinced that there is a
> need to change the default in the future.

In that case, I'll abort this patch series. I don't agree with the `git 
rebase' in the lazy form and `git rebase <upstream>' acting differently, 
but I already have the rebase.forkpoint set to false to counter it.

> It might be better to extend the documentation instead, which will
> not distract those who are using the tool just fine already.

That is with the current viewpoints the best option I think.

>> +	diff -qw expect err &&
> 
> Why not "test_cmp expect actual" like everybody else?

As said in the initial patch series and the comment above the tests:

> There is one point where I'm a little confused, the `test_cmp' function in the
> testsuite doesn't like the output that is captured from STDERR, it seems that
> there is a difference in regards to whitespace. My workaround is to use
> `diff -wq`. I don't know if this is an accepted solution.

That's why.

Cheers,
Wesley

-- 
Wesley

Why not both?

