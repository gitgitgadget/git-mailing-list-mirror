Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B94F203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934827AbcLMSsL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:48:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56431 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933449AbcLMSsL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:48:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 48E505375C;
        Tue, 13 Dec 2016 13:48:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kD4VgzixNp7GVp0vkq+e0C97mQI=; b=OS9U6U
        +s5bEc7DAvxo7GkCtsPZYBwlrzBsFOQY3JVKdb6lFQ8kDmuM55NBPuvSrQ+nCLN9
        +AnUEQcjNCDuhQRIX6O4tRnDKylSjr49XuuATBwuuYBOO1oXWJoOWFZhvZ8eWg/Q
        8VT0BI1EaTGOc0dxoBG+Z8aQxNa20EOkE71tM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TZCI1NhkmBLSEvwsSqK4TNcJ61/JLJDh
        H3mVoVWXay2tP0pEeC0sfzgjqVSk6VSPWSFf0CLj+/y0pP0jDAYLlsrqu7wUhD/z
        e2J/tSq0fPykflbRkCMzwIfO4CyyL0aKQ+2RjwqzFXdTneJRLgiR0yhEB/isU3sD
        rP5vjENvKys=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41AC95375A;
        Tue, 13 Dec 2016 13:48:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B202F53759;
        Tue, 13 Dec 2016 13:48:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stephan Beyer <s-beyer@gmx.net>, Ariel <asgit@dsgml.com>,
        git@vger.kernel.org
Subject: Re: git add -p with new file
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
        <20161209141129.r53b4rbtgd76fn2a@sigill.intra.peff.net>
        <alpine.DEB.2.11.1612091331170.13185@cherryberry.dsgml.com>
        <20161210085556.nwg3pbay367jqin5@sigill.intra.peff.net>
        <xmqq37hvphji.fsf@gitster.mtv.corp.google.com>
        <20161211130034.ygj5l2gbx33uknlk@sigill.intra.peff.net>
        <dc698b79-6311-a2a3-c564-a43ef071e62b@gmx.net>
        <20161213173341.wemlunlixdp6277h@sigill.intra.peff.net>
Date:   Tue, 13 Dec 2016 10:48:07 -0800
In-Reply-To: <20161213173341.wemlunlixdp6277h@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 13 Dec 2016 12:33:41 -0500")
Message-ID: <xmqq7f734qe0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0BD4246-C164-11E6-8B99-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I am also not really sure what problem this feature is trying to solve.
>> If the "problem"(?) is that it should act more like "git add" instead of
>> "git add -u", for whatever reason, this may be fine (but the
>> configuration option is a must-have then).
>
> I think the problem is just that "add -p" does not give the whole story
> of what you might want to do before making a commit.

The same is shared by "git diff [HEAD]", by the way.  It is beyond
me why people use "add -p", not "git diff [HEAD]", for the final
sanity check before committing.  

Perhaps the latter is not advertised well enough?  "add -p" does not
even page so it is not very useful way to check what is being added
if you are adding a new file (unless you are doing a toy example to
add a 7-line file).

>> > I'd also probably add interactive.showUntracked to make the whole thing
>> > optional (but I think it would be OK to default it to on).
>> Hm, "interactive.showUntracked" is a confusing name because "git add -i"
>> (interactive) already handles untracked files.
>
> Sure, that was just meant for illustration. I agree there's probably a
> better name.

"interactive.*" is not a sensible hierarchy to use, because things
other than "add" can go interactive.

addPatch.showUntracked?
