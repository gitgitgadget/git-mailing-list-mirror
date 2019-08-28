Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D330F1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 02:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfH1Crk (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 22:47:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51800 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfH1Crk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 22:47:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 629A37C538;
        Tue, 27 Aug 2019 22:47:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1bKtUvnwy70CUCM5t1hsDfh7DFY=; b=KLpe2G
        4d6Lye1CPW1SGzQCc2hDq63dP1O98dMGlSUziTa6wAxasqaoBOUQRcAwPKeffIqs
        V/9vxaPLvww2pbtDj6OaCwTZ1ZnzhnRyi32rErS+5tJIclKnM6Z6qGKziz33QaGl
        cEAW1QiVvGTXSl0Y4oWUMr0w4DQ7Uhxg/fIdg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kkcQmV+pzX+39Li7jD+hZlLjFRY11EoB
        ysLUPXHuwujwvEroYBYdd1svXJmRu+wBOmctWbiPfh/K/rSt5/2UZ/k7yTj7fKKb
        BijsvKAOdmGdRitv1pstmIjNwsqSXLu8c3qlbZWrlJz9P8XIq21v/f1/HEr2sWfv
        ECUxOkQ4dr0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4971A7C537;
        Tue, 27 Aug 2019 22:47:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4D1327C535;
        Tue, 27 Aug 2019 22:47:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] status: mention --skip for revert and cherry-pick
References: <cover.1566637431.git.liu.denton@gmail.com>
        <cover.1566880835.git.liu.denton@gmail.com>
        <be64ce1e92c60f9587b137d36e98532604d4a1ff.1566880835.git.liu.denton@gmail.com>
        <xmqqef162rx2.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 27 Aug 2019 19:47:33 -0700
In-Reply-To: <xmqqef162rx2.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 27 Aug 2019 14:56:57 -0700")
Message-ID: <xmqqwoey0zwa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30ACCDF8-C93E-11E9-B8C6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Is this a good thing, though?
>
> Giving up (because you do not have enough time or concentration to
> finish the cherry-pick or revert in progress) with --abort, and
> committing to the resolution after spending effort to deal with a
> conflicted cherry-pick or revert with --continue, are both sensible
> actions after seeing the command stop due to conflicts.  Is "--skip"
> a recommendable action in the same way?  Doesn't a multi-commit
> series often break if you drop just one in the middle, especially
> if the series is sensibly structured as a logical progression?

Addendum.

"rebase" (especially with "-i") is fundamentally different from
"cherry-pick" and it makes tons of sense to suggest "--skip" in the
former.  "rebase -i" is a tool to take a messy work in progress and
polish it by reordering, discarding and combining commits.
"cherry-pick" is to take a finished work already in one integration
track, and transplant to another, often an older maintenance track,
and there is no place for "this conflict is too much to resolve so
let's drop it".

