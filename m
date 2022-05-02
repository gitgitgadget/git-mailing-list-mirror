Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E0BC433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 10:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384375AbiEBKEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 06:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384424AbiEBKEY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 06:04:24 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0495826D1
        for <git@vger.kernel.org>; Mon,  2 May 2022 03:00:52 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nlSrK-0008EY-7d;
        Mon, 02 May 2022 11:00:50 +0100
Message-ID: <13dc6ee6-f4ee-c246-b610-ec3d0a72a4ed@iee.email>
Date:   Mon, 2 May 2022 11:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
 <20220430041406.164719-2-gitter.spiros@gmail.com>
 <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email> <xmqqpmky70jb.fsf@gitster.g>
 <a3e06290-052e-af36-4170-301e567d561d@iee.email> <xmqqr15e5fm3.fsf@gitster.g>
 <xmqqmtg25cjw.fsf@gitster.g>
 <CA+EOSBnx3-G02=zXGUrRuKPTDPBSYoBY=rERCORe8NtywEOiGg@mail.gmail.com>
 <xmqqbkwg4zi7.fsf@gitster.g> <xmqqmtg01mir.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqmtg01mir.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05/2022 07:22, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> To avoid unnecessary conflicts with in-flight topics, ideally, we
>> perhaps could do something along this line:
>>
>>  * Pick a recent stable point that is an ancestor of all topics in
>>    flight.  Add the new coccinelle rule file, take "make coccicheck"
>>    output and create a two-patch series like Philip suggested.  Queue
>>    the result in a topic branch B.
>>
>>  * For each topic in flight T, make a trial merge of T into B, and
>>    examine "make coccicheck" output.  Any new breakages such a test
>>    finds are new violations the topic T introduces.  Discard the
>>    result of the trial merge, and add one commit to topic T that
>>    corrects the violations the topic introduced, and send that fixup
>>    to the author of the topic for consideration when the topic is
>>    rerolled (or if the topic is in 'next', acked to be queued on
>>    top).  Do not fix the violations that is corrected when branch B
>>    was prepared above.
>>
>> As I assumed that applying the patches in this series would create
>> the branch B, and then I saw that the tip of 'seen' after merging
>> this topic still needed to have a lot more fixes according to "make
>> coccicheck", I got a (false) impression that there are too many new
>> violations from topics in flight, which was the primary source of my
>> negative reaction against potential code churn.  If we try the above
>> exercise, perhaps there may not be too many topics that need fix-up
>> beyond what we fix in the branch B, and if that is the case, I would
>> not be so negative.
> So I tried that myself, and the topic branch B was fairly
> straightforward to create.
>
> We have ~60 topics in flight (not counting this one), and it turns
> out that there is no topic that introduces new code that fails the
> equals-null.cocci rule.  IOW, the follow-up fixup per topic turns
> out to be an empty set.
>
> So, I'd probably use the [01/23] and then a single ~5k lines patch
> that was generated with equals-null.cocci rule as the branch B
> above, let it percolate down from 'seen' to 'next' to eventually
> 'master'.
>
> Thanks.
That sounds like a good result.

It may also be worth Elia cross checking against a previous release
(v2.35.0?) for relatively recent introductions, to cover the potential
revert scenario, just in case..

Philip

