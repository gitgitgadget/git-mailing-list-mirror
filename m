Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 632B91F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 07:38:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbeKZScJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 13:32:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52177 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeKZScJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 13:32:09 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FD38112D6C;
        Mon, 26 Nov 2018 02:38:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i6MG/69p/JSVbSyOXPL+nnBVoKw=; b=r1XZUE
        R/nOsOmfgBa9iw7s2E+Sv+vaJSSwDALGV9kPkb+QZ4YeHaLGrt+fLAWYm8z8g2IR
        MiDX+TtkfehTthNsl15M+ncBmB/S6h38ZBOhpEDQtSUCBZ0LaI9R4TzN4t4LsmrP
        KK/MpHSTm3asTQYoLCScs0EF+HgsSFLP4Z8aI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=asvZ756U5AA3uSKu/4aWrZapAb/5niUM
        OIp5NmQHOKktgQpnan+C6HUWFxY4p2BDNnhaHuFDbxp81D1IAwDYob48Mx8oyxBg
        PfS7UXCpMtgsyDCTYp5WDTk9/ZOP7gtWIlf++pG063brJdbbmIIfCEv8BqDHaOE6
        Nm+GgJKi0iM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 792BF112D6B;
        Mon, 26 Nov 2018 02:38:53 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9F9E112D6A;
        Mon, 26 Nov 2018 02:38:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v11 00/22] Convert "git stash" to C builtin
References: <https://public-inbox.org/git/cover.1539553398.git.ungureanupaulsebastian@gmail.com/>
        <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
        <20181125215504.GJ4883@hank.intra.tgummerer.com>
        <xmqqa7lwz8xm.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 26 Nov 2018 16:38:51 +0900
In-Reply-To: <xmqqa7lwz8xm.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 26 Nov 2018 14:47:49 +0900")
Message-ID: <xmqq8t1gwano.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 528FA8BE-F14E-11E8-8244-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> Thanks for your work on this!  I have read through the range-diff and
>> the new patch of this last round, and this addresses all the comments
>> I had on v10 (and some more :)).  I consider it
>> Reviewed-by: Thomas Gummerer <t.gummerer@gmail.com>
>
> Thanks.
>
> One thing that bothers me is that this seems to have been rebased on
> 'master', but as long as we are rebasing, the updated series must
> also take into account of the sd/stash-wo-user-name topic, i.e. if
> we are rebasing it, it should be rebased on top of the result of
>
> 	git checkout -B ps/rebase-in-c master
> 	git merge --no-ff sd/stash-wo-user-name
>
> I think.

https://travis-ci.org/git/git/builds/459619672 would show that this
C reimplementation now regresses from the scripted version due to
lack of such rebasing (i.e. porting a correction from scripted one).

