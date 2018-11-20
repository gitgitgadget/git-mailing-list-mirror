Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84E401F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 13:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeKTX3B (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 18:29:01 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:45906 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeKTX3B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 18:29:01 -0500
Received: from [192.168.2.240] ([92.22.32.73])
        by smtp.talktalk.net with SMTP
        id P5dFgf4q6dJAeP5dGgagVR; Tue, 20 Nov 2018 12:59:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1542718799;
        bh=lyUYJ/l5RjPzBE11D6eDsxaDwiU13vTkfm9tmZzuRs8=;
        h=Reply-To:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=AHYIRiIIowKIuop7RB5USCan0cLACbeuhk0AxJ1vLpl4TFBRaSq4IoHf+M8tqh/ad
         UAY3eengDff4iVlo9omlIDCsIRlXeCF5X4hk7PcZeMTcTDSa/dwOrloll4BKcShCsN
         Hfm9ezbY+dr6q8E2JIYJIzjLD6g9Hj6nP/El4hrw=
X-Originating-IP: [92.22.32.73]
X-Spam: 0
X-OAuthority: v=2.3 cv=V8BTL9vi c=1 sm=1 tr=0 a=w3K0eKD2tyZHkEydg3BQCA==:117
 a=w3K0eKD2tyZHkEydg3BQCA==:17 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8
 a=bvO3h1hXSd0ujmJnNEQA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     sxenos@google.com, git@vger.kernel.org
Cc:     sbeller@google.com, jrn@google.com, jch@google.com,
        jonathantanmy@google.com, stolee@gmail.com, carl@ecbaldwin.net,
        dborowitz@google.com
References: <20181115005546.212538-1-sxenos@google.com>
 <a4c5d89c-cf82-6b1d-2690-82c7f8a95cc4@talktalk.net>
Message-ID: <8f580b70-3eb2-d751-eb37-6ec025e167ab@talktalk.net>
Date:   Tue, 20 Nov 2018 12:59:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <a4c5d89c-cf82-6b1d-2690-82c7f8a95cc4@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAPfb0xFT/Y2RXGz5veITLp44ug+ggNm1l69xFUzK9ALD9zawSwW1QvW3GmY5Cug8If1YnmSk5aauR0ooZDdQdzdpmaEmRuDdQWFMcDjbU6Z1MbKcEX2
 8bO8YrbA2IIqeTY3ZCk6Wao+RWR0WhzifE3Jhom8GtNzq7xGkTxpUhQuLUkmkbiv9xLSc1Rn4rF98g8KsmSxQehrWi0hboMuCLKMS73Frk4r425uSLM/sWif
 GeMA4EOxW2z8FSlrlPWpD9hKRjb7TqkKqAsjiBg2/2Y8INe5WI+bb+G5hzLfa5lZhKOk0HbZUCxJjhRiBvU6rKAFIWkRZiTNmR/dClWhGyk+Pb+loQu4b4up
 4IPZs3xXj983qGSjLwnkfwFXAW7JlYirZxLhmntU1olwhTXHAD0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/11/2018 12:18, Phillip Wood wrote:
> On 15/11/2018 00:55, sxenos@google.com wrote:
>> From: Stefan Xenos <sxenos@google.com>
>> +Divergence
>> +----------
>> +From the user’s perspective, two changes are divergent if they both 
>> ask for
>> +different replacements to the same commit. More precisely, a target 
>> commit is
>> +considered divergent if there is more than one commit at the head of 
>> a change in
>> +refs/metas that leads to the target commit via an unbroken chain of 
>> “obsolete”
>> +edges.
>> +
>> +Much like a merge conflict, divergence is a situation that requires user
>> +intervention to resolve. The evolve command will stop when it encounters
>> +divergence and prompt the user to resolve the problem. Users can 
>> solve the
>> +problem in several ways:
>> +
>> +- Discard one of the changes (by deleting its change branch).
>> +- Merge the two changes (producing a single change branch).
> 
> I assume this wont create merge commits for the actual commits though, 
> just merge the meta branches and create some new commits that are each 
> the result of something like 'merge-recursive original-commit 
> our-new-version their-new-version'

That should have been

merge-recursive original-commit^ -- our-new-version their-new-version

Best Wishes

Phillip

