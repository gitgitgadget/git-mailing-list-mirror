Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC13B1FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 18:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751569AbcLESKJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 13:10:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61550 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751320AbcLESKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 13:10:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCC7154D73;
        Mon,  5 Dec 2016 13:10:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fsv/Juywcg5lJMDWfO/RQd38+5g=; b=tGatp6
        f8ZU3saxzCljcgTfxeVqfQX8AMTpNDHW490lUE4139YBKfis+7KjTsHaCdraWN7m
        3AZWicsnmADmWxqwVOrdh495g2iRl1LSRqHdgAf5dlsW9/oANLxTHMzMZEkXWA2e
        4kpBMzn3LwmHQi46Tn7vwf5Yl819yhQguxqtw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sIYplkO0P4WWNOqocDsZEIvMUH27KYyV
        ZDOlJkzWdWEd9u4BjI+L0jYmnQeBrVpj8E9givr4+9lrTk+tMX7Rkk2CS91M4AY6
        yg72UCPkFW4fmNMVu5mxybLzQUBAw9dZGua4Js3+cMKenwQPpxnEpOD7lQ+1ZQrd
        HBw2fvz2wFY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B283554D70;
        Mon,  5 Dec 2016 13:10:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0EFB54D6F;
        Mon,  5 Dec 2016 13:10:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC PATCH] GIT-VERSION-GEN: set --abbrev=9 to match auto-scaling
References: <22e9dfa0-47fb-d6fd-caf4-c2d87f63f707@ramsayjones.plus.com>
        <20161205053258.jtnqq64gp5n7vtni@sigill.intra.peff.net>
        <ab1e7ce9-1022-0c72-2f72-63e3b9182bc9@ramsayjones.plus.com>
Date:   Mon, 05 Dec 2016 10:10:05 -0800
In-Reply-To: <ab1e7ce9-1022-0c72-2f72-63e3b9182bc9@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 5 Dec 2016 11:21:14 +0000")
Message-ID: <xmqq7f7e5jsy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D553FC2-BB16-11E6-9B03-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Heh, that was the first version of the patch. However, I got to thinking
> about why --abbrev=7 was there in the first place; the only reason I
> could think of was to defeat local configuration to get a measure of
> reproducibility.
>
> Unfortunately, you can't get the 'auto' behaviour from --abbrev
> (on the pu branch):
>
>     $ ./git describe --abbrev=-1
>     v2.11.0-286-g109e8
>     $ ./git describe --abbrev=0
>     v2.11.0
>     $ ./git describe
>     v2.11.0-286-g109e8a99d
>     $

What is the reason why the last one is undesirable?  Is it because
the user may have core.abbrev set to some value in the configuration
and you want to override it to force "auto"?

I am not sure how rigid GIT-VERSION-GEN wants to be to countermand
such an explicit user preference (i.e. existing configuration).

> I did think about using '-c core.abbrev=auto', 

Having said that, if countermanding end-user's configuration is
desireble, I agree that "-c core.abbrev=auto" is the way to do so.

> but that would depend on Junio's patch (nothing wrong with that,
> of course):

You caught me.  I'll need to polish that into a usable shape soon
then.  And that is orthogonal to the "does it make sense to force
'auto' in this context?" question.
