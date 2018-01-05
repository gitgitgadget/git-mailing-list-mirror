Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB6D1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 19:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeAET4x (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 14:56:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61540 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbeAET4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 14:56:52 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 49D8BCD5B4;
        Fri,  5 Jan 2018 14:56:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HrddaPW5I01gV+6Ds+maeF2kawo=; b=MP1Rls
        TYe16FuzNJwgQIURe9vH2b0S4q/Kz4fLR1zgvuq1Oxi2ArBhpS+F6GEdSIBxojD/
        KC69epIE7fW5M8C6pxDHe+UijdMqvZmzlBQ7A49mUNRJeYUQppeXNCfjrFKHO1Jo
        Pl5siCpADr+WuN8d3TO3G2MjE5adT+Ym6bZsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g+r7Pw2oKDbkPnyuewTDEmYasl5D+3Y/
        mlEfBOrMOQBgRWjn02lUH748ijK9WCzkEztUcWjpKzPDyBTXG4qDV15zShKhsuP9
        869D5sJmTnz5CGtFbEpYuyynBJLU1euLbau77zi0rEnNBqGPKnbb6o4XImFkt1UO
        2fEURS0csfM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41656CD5B3;
        Fri,  5 Jan 2018 14:56:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B3430CD5B2;
        Fri,  5 Jan 2018 14:56:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 0/5] Add --no-ahead-behind to status
References: <20180103214733.797-1-git@jeffhostetler.com>
        <20180104230630.GA2599@sigill.intra.peff.net>
        <2887ad5a-5de9-3c5b-92c3-40b19120e604@jeffhostetler.com>
Date:   Fri, 05 Jan 2018 11:56:50 -0800
In-Reply-To: <2887ad5a-5de9-3c5b-92c3-40b19120e604@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 5 Jan 2018 11:46:24 -0500")
Message-ID: <xmqqbmi8cc59.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92844CAA-F252-11E7-BC23-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> I kinda trying to serve 2 masters here.  As we discussed earlier, we
> don't want config options to change porcelain formats, hence the
> true/false thing only affecting non-porcelain formats.  On the other
> hand, VS and git.exe are on different release schedules.  Normally,
> I'd just have VS emit a "git status --no-ahead-behind --porcelain=v2"
> and be done, but that requires that git.exe gets updated before VS.
> We do control some of that, but if VS gets updated first, that causes
> an error, whereas "git -c status.aheadbehind=<x> status --porcelain=v2"
> does not.  It is respected if/when git is updated and ignored until
> then.  Likewise, if they update git first, we can tell them to set a
> config setting on the repo and inherit it for porcelain v2 output
> without VS knowing about it.  Sorry, if that's too much detail.

That is not really too much detail.  

But if the above is your plan, then boolean=2 cannot merely be "an
experimental" as described in [5/5]; it needs to be carried for some
extended period of time, depending on the release schedule of the
other half of the coin.

> It is OK with me if we omit the last commit in the patch series (that
> does the experimental =2 extension) and I'll deal with this separately
> (maybe differently) in the gvfs fork.

I think that sounds more sensible.  Thanks.
