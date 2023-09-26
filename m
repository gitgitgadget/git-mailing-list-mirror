Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C599E7E653
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 17:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjIZRIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjIZRIb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 13:08:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B9AE5
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 10:08:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E7BC19BA62;
        Tue, 26 Sep 2023 13:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Rp/ViTLBuGyY+/N7w1SAFTqCD4HGfi4kLqXDMq
        g9kh8=; b=SNBxSXz4ij47en+A9FkznwZJtgZviPMXbT4eGrjnH99NUyQzbT+Wh7
        fJQCTtJgomlw1WJe7NL4T2aoPqvCM+0Y/h9YcXnn1vsHLUPSuwwZvQX2tZBEklVO
        Yk2i/QC5RTKAZg8JVRleSrCWItt8x87TQEUO9/KbnVTykmxrpR3GU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 563B219BA60;
        Tue, 26 Sep 2023 13:08:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8301B19BA5F;
        Tue, 26 Sep 2023 13:08:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-merges: introduce '-d' option
In-Reply-To: <87bkdpl2yx.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        26 Sep 2023 12:04:54 +0300")
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-3-sorganov@gmail.com>
        <xmqqtts0tof8.fsf@gitster.g> <87o7i7hler.fsf@osv.gnss.ru>
        <xmqqled8h01w.fsf@gitster.g> <87y1h8wbpo.fsf@osv.gnss.ru>
        <xmqqzg1nfixw.fsf@gitster.g> <87ttrudkw9.fsf@osv.gnss.ru>
        <xmqqjzsdps0h.fsf@gitster.g> <87bkdpl2yx.fsf@osv.gnss.ru>
Date:   Tue, 26 Sep 2023 10:08:20 -0700
Message-ID: <xmqqa5t8ooaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BB8B74A-5C8F-11EE-B224-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> No need to ask for a new option, as the behavior you describe is already
> there, and is spelled "git log --diff-merges=first-parent"
> (--diff-merges=1 for short).

Ah, that changes things.  

Making "--diff-merges=<how>" only about the presentation of merge
commits, requiring a separate "-p" for single-parent commits [*],
does make the life for those in the "merges are the only interesting
things" camp a lot easier, exactly because the lack of "-p" can be
used to say "I am not interested in chanages by single-parent
commits".

	Side note: I personally think it is a design mistake of
	--diff-merges=<how> (e.g., --cc and --diff-merges=cc do not
	behave the same way) but that is a different story, and it
	is way too late now anyway to "fix" or change.

So "-d" that stands for "--diff-merges=first-parent -p" makes the
more useful (to those who think "merges are the only interesting
things", which I do not belong to) "--diff-merges=first-parent"
(without "-p") less useful.  And the combination is not useful for
those of us who find individual patches plus tweaks by merges
(either --cc or --remerge-diff) are the way to look at the history.

I still do not think that we want to give a short-and-sweet single
letter option for such a combination.

Thanks for clarification.
