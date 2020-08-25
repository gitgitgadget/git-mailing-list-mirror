Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC58C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E710020786
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 16:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEy1F7wX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgHYQSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHYQSp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 12:18:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA2EC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 09:18:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n129so11450807qkd.6
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dVG8QxbuiI7ogS0C8mbpCV7MLUEHwO0BVOkfqWTr2l8=;
        b=aEy1F7wXR47yehpxZzNFV6Gppui9l2BEW7PkNvXuaxTzIMZ9i1YqGjtOy4vkM4Pvzb
         OMOF/5BODtyDjwuwUObKedwpmUJuJdrY/SaWP/ZqGiaiICnd0UFuyUJmDNW5Zg3ylWVZ
         Rei6HDh8blyLAcz+mPIlH+gh8hp5bGWVFN1jxSLt0XY/nDG+M13YgMUPmeifdaXLTi+w
         QU6ifYVqlqdRUKNlAJygUM5MfO7s3rjkqRXmIFq7tAzk8kwwogmSeQtfn4eIF6eKaLZn
         YNC8rlQqJbAKqQd2mRyOZT0gqdg8eksOZnMjpyvUXUeV1W4gL9yTiw0geYHMysx31K18
         JhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dVG8QxbuiI7ogS0C8mbpCV7MLUEHwO0BVOkfqWTr2l8=;
        b=IQswCdmZqWHiud/aB/TyoO+P10/0hTcq2aWQauIowqLhe29XN4kobPJ9d+DShiNDr+
         RUirMNOJcbpfP40Dv49Su1s5zXRgDsF60nZC9uwLV5ab1RwuPU86b4qeoD3MT/dX7N7l
         FK5tb/WRRBvQPaIgDR0J/ZFWpAvrCYuuaXGVdE8G5jvFeXp+/1YLymGyc1c8NrG7VZ7X
         /lqxCYWl7TdYXK7l6WU8rlDscOZ58bCz6efehD1sSp99lgJBTL9ah3maPABzzI9NDxpe
         7MGDTp9j3HHUtTY1NMbk5MoaYYmMAtJL5mheG9kRFGf5bERWOMqWcAZANxEu59vbYNLC
         c1NA==
X-Gm-Message-State: AOAM530L+G/IPnNpzO6BqHb1/u93TiAha5nC9E4PaN0divxPweK/D0I9
        Vk0a8zi2LDqY1+Y/NpECPhA=
X-Google-Smtp-Source: ABdhPJw8D914tbhXMCqJH2KM0v5J8mJ+FbAkwcM5weKJfmFHbHtbD5HWWvJEGvFQ1O2dgcgigat5hQ==
X-Received: by 2002:a37:9c8b:: with SMTP id f133mr10371466qke.332.1598372323973;
        Tue, 25 Aug 2020 09:18:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:600d:49d2:12ae:f5e7? ([2600:1700:e72:80a0:600d:49d2:12ae:f5e7])
        by smtp.gmail.com with ESMTPSA id i66sm1462038qkc.63.2020.08.25.09.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 09:18:43 -0700 (PDT)
Subject: Re: [PATCH] builtin/repack.c: invalidate MIDX only when necessary
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com
References: <ef9186a8df0d712c2ecccbe62cb43a7abadb9c96.1598320716.git.me@ttaylorr.com>
 <20200825022614.GA1391422@coredump.intra.peff.net>
 <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c78b3108-b760-d252-9428-6f03549fea11@gmail.com>
Date:   Tue, 25 Aug 2020 12:18:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqtuwq1zux.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2020 11:58 AM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> Does "git repack" ever remove just one pack? Obviously "git repack -ad"
>> or "git repack -Ad" is going to pack everything and delete the old
>> packs. So I think we'd want to remove a midx there.
> 
> AFAIK, the pack-redundant subcommand is used by nobody in-tree, so
> nobody is doing "there are three packfiles, but all the objects in
> one of them are contained in the other two, so let's remove that
> redundant one".
> 
>> And "git repack -d" I think of as deleting only loose objects that we
>> just packed. But I guess it could also remove a pack that has now been
>> made redundant? That seems like a rare case in practice, but I suppose
>> is possible.
> 
> Meaning it can become reality?  Yes.  Or it already can happen?  I
> doubt it.
> 
>> E.g., imagine we have a midx that points to packs A and B, and
>> git-repack deletes B. By your logic above, we need to remove the midx
>> because now it points to objects in B which aren't accessible. But by
>> deleting it, could we be deleting the only thing that mentions the
>> objects in A?
>>
>> I _think_ the answer is "no", because we never went all-in on midx and
>> allowed deleting the matching .idx files for contained packs.
> 
> Yeah, it has been my assumption that that part of the design would
> never change.

Yes, we should intend to keep the .idx files around forever even when
using the multi-pack-index. The duplicated data overhead is not typically
a real problem.

The one caveat I would consider is if we wanted to let a multi-pack-index
cover thin packs, but that would be a substantial change to the object
database that I do not plan to tackle any time soon.

>> I'm also a little curious how bad it is to have a midx whose pack has
>> gone away. I guess we'd answer queries for "yes, we have this object"
>> even if we don't, which is bad. Though in practice we'd only delete
>> those packs if we have their objects elsewhere.
> 
> Hmph, object O used to be in pack A and pack B, midx points at the
> copy in pack B but we deleted it because the pack is redundant.
> Now, midx says O exists, but midx cannot be used to retrieve O.  We
> need to ask A.idx about O to locate it.
> 
> That sounds brittle.  I am not sure our error fallback is all that
> patient.

The best I can see is that prepare_midx_pack() will return 1 if the
pack no longer exists, and this would cause a die("error preparing
packfile from multi-pack-index") in nth_midxed_pack_entry(), killing
the following stack trace:

+ find_pack_entry():packfile.c
 + fill_midx_entry():midx.c
  + nth_midxed_pack_entry():midx.c

Perhaps that die() is a bit over-zealous since we could return 1
through this stack and find_pack_entry() could continue searching
for the object in the packed_git list. However, it could start
returning false _negatives_ if there were duplicates of the object
in the multi-pack-index but only the latest copy was deleted (and
the object does not appear in a pack-file outside of the multi-
pack-index).

Thanks,
-Stolee
