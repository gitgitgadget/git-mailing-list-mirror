Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27FC61F597
	for <e@80x24.org>; Mon, 18 Jun 2018 16:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754637AbeFRQlq (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 12:41:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51368 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754642AbeFRQlp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 12:41:45 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BADBEF391F;
        Mon, 18 Jun 2018 12:41:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=pxw+sHjHZDPQlgmOPL9WOqIJILw=; b=mUqC/YC
        3P47DDHDnOSMC4sQRR1tbv1wapNTvAeOeD5K157kFyH2Vh1emjG3POi2ZhE9B/gm
        dEz9X9KG+i+5VPi46Rb8A+rQlWIV7lcRBfhg0K3bCRM5+TSnQOkbIuFG3jq3klIN
        /WES8YnIJ7/B+9FB9P9C/Zgjj2dDTzvWW4C0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=IJnSYWhDBK4FKQDsbOPjY+iEujnLpaXHH
        bIhWy/KI+qjwmJP2z1KOWEV6t5riIJZABK+77LFOhqmJfsSiRsBpD+2jP8ypcgSv
        r0+H8F1uz3dExvd0U+zuNm4dbTnSlyFkbLBu8r2GOF5n/17E8xl1NqjtlqA0YfRr
        qzj0jvHmn4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B30CEF391D;
        Mon, 18 Jun 2018 12:41:42 -0400 (EDT)
Received: from zaya.teonanacatl.net (unknown [98.111.125.125])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 38FA2F391C;
        Mon, 18 Jun 2018 12:41:42 -0400 (EDT)
Date:   Mon, 18 Jun 2018 12:41:40 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] rebase --root: fix `reword` on a root commit
Message-ID: <20180618164140.GN11827@zaya.teonanacatl.net>
References: <pull.3.git.gitgitgadget@gmail.com>
 <20180616201143.GH11827@zaya.teonanacatl.net>
 <xmqqd0woxdz9.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd0woxdz9.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Pobox-Relay-ID: 7AE16034-7316-11E8-8861-67830C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Todd Zullinger <tmz@pobox.com> writes:
> 
>> Hi Johannes,
>>
>> Johannes Schindelin via GitGitGadget wrote:
>>> From: GitGitGadget <gitgitgadget@gmail.com>
>>> 
>>> Todd Zullinger reported this bug in
>>> https://public-inbox.org/git/20180615043111.GS3094@zaya.teonanacatl.net/:
>>> when calling git rebase --root and trying to reword the
>>> root commit's message, a BUG is reported.
>>>
>>> This fixes that.
>>> 
>>> IMO the bug fix is trivial enough to qualify for inclusion into v2.18.0, still.
>>
>> It does indeed fix the issue.  I agree it would be nice to
>> see it in 2.18.0.  As a fix for a minor regression
>> introduced in this cycle, that seems reasonable.
> 
> Offhand it is not clear from the proposed log message where the
> original breakage happened, but if this is to fix a regression
> between v2.17.0 and v2.18.0, then let's have it.  As -rc2 slipped
> for a few days, it is reasonable to delay the final by a couple of
> days as well, if only to give the last minute fixes and translators
> reasonable time to breathe.

Perhaps replacing the first paragraph with this would make
it clearer?

    Since 21d0764c82 ("rebase -i --root: let the sequencer handle even the
    initial part", 2018-05-04), when splitting a repository, running `git
    rebase -i --root` to reword the initial commit, Git dies with

Alternately, a similar note could be added at the end.

    This regression was recently introduced in 21d0764c82 ("rebase -i 
    --root: let the sequencer handle even the initial part", 2018-05-04).

-- 
Todd
