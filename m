Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D50DC433F5
	for <git@archiver.kernel.org>; Sun,  1 May 2022 23:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355929AbiEAXRq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 May 2022 19:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiEAXRo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 May 2022 19:17:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052381400A
        for <git@vger.kernel.org>; Sun,  1 May 2022 16:14:17 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7E5D19CFD1;
        Sun,  1 May 2022 19:14:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=43odZ5A1CHODHOGFqZVoJzHHQ6+8h87dbDFdAX
        gBZTI=; b=tVo97TVrBMWsuec5jE6Dv1Wq3pVUz6ZyJM2mtw4H2HUzyDB/3yigSg
        MaEsWchOgmrNkO1FYMMg94Ae39XhBgIcqOhfIxDlypPZDpfSJ1hqAtEmQx/gDj/Z
        vc7QWbEiSbfiU5HfCynYhMmfL4WqXCCeFdbiFc+pWgFtugGKcMA1Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BF2C419CFD0;
        Sun,  1 May 2022 19:14:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4373419CFCF;
        Sun,  1 May 2022 19:14:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
        <20220430041406.164719-2-gitter.spiros@gmail.com>
        <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email>
        <xmqqpmky70jb.fsf@gitster.g>
        <a3e06290-052e-af36-4170-301e567d561d@iee.email>
        <xmqqr15e5fm3.fsf@gitster.g> <xmqqmtg25cjw.fsf@gitster.g>
        <CA+EOSBnx3-G02=zXGUrRuKPTDPBSYoBY=rERCORe8NtywEOiGg@mail.gmail.com>
Date:   Sun, 01 May 2022 16:14:08 -0700
In-Reply-To: <CA+EOSBnx3-G02=zXGUrRuKPTDPBSYoBY=rERCORe8NtywEOiGg@mail.gmail.com>
        (Elia Pinto's message of "Sun, 1 May 2022 19:04:06 +0200")
Message-ID: <xmqqbkwg4zi7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68469BF4-C9A4-11EC-90F6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

>> What I found curious is that the result of applying these patches to
>> v2.36.0 and running coccicheck reveals that we are not making the
>> codebase clean wrt this new coccinelle rule.
>>
> It is possible, I did not use coccicheck to apply the semantic patch
> (on next)  but i use a my script which I think is slightly more
> efficient but perhaps it is not so correct. Anyway, given the
> discussion that has taken place so far, what do you think is best for
> me to do? Do a reroll (perhaps with only 2 patches in total ) or wait
> for the "right" moment in the future as foreseen by the Documentation
> and dedicate the time to more useful contributions for git? Thank you
> all for the review

Hmph.  Even if these patches were created by coccicheck we should
sanity check them to make sure we are not applying some stupid and
obvious mistakes, but if they were created by an ad-hoc tool, it
means we would need to check a lot more careful than a patch that
was done with a known tool with a clear rule (which is what running
"make coccicheck" with your new rule file would have given us).

To avoid unnecessary conflicts with in-flight topics, ideally, we
perhaps could do something along this line:

 * Pick a recent stable point that is an ancestor of all topics in
   flight.  Add the new coccinelle rule file, take "make coccicheck"
   output and create a two-patch series like Philip suggested.  Queue
   the result in a topic branch B.

 * For each topic in flight T, make a trial merge of T into B, and
   examine "make coccicheck" output.  Any new breakages such a test
   finds are new violations the topic T introduces.  Discard the
   result of the trial merge, and add one commit to topic T that
   corrects the violations the topic introduced, and send that fixup
   to the author of the topic for consideration when the topic is
   rerolled (or if the topic is in 'next', acked to be queued on
   top).  Do not fix the violations that is corrected when branch B
   was prepared above.

As I assumed that applying the patches in this series would create
the branch B, and then I saw that the tip of 'seen' after merging
this topic still needed to have a lot more fixes according to "make
coccicheck", I got a (false) impression that there are too many new
violations from topics in flight, which was the primary source of my
negative reaction against potential code churn.  If we try the above
exercise, perhaps there may not be too many topics that need fix-up
beyond what we fix in the branch B, and if that is the case, I would
not be so negative.

Thanks.



