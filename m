Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB49120229
	for <e@80x24.org>; Thu, 10 Nov 2016 22:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756114AbcKJWzK (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 17:55:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56033 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756077AbcKJWzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 17:55:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3DC074FF48;
        Thu, 10 Nov 2016 17:55:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uy+XVjPhWo7UGk3BOyGfWJFSjPY=; b=SzvpqH
        eDYhtJbM8i796Rc0bqJgTU/1NpZqPgWtye7V/d7RuxFwWsWQsDFv66d4QptZQMbc
        xssIpex2kFrVrgBMIDjOUEYcPZbRKmut87IJq1Q4+2uksIHuxeYfAlObglFK29U/
        JS1v2fo93JAnP2O3os7q6ToFFict1yBn+R/cU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wGSJMZ7/L5XwxvHH5n+4Kvi3ObdaDU/D
        l9Gz6qDWMPV87RovR9Pzn1L99IgQHfPrbW0pwrnw77gdhgzyGWAfUgM/P4fcbuYc
        sirg/foOFPIHLO2iyrgY1Co60oUI3gOhGJqFPnXNlts7pnMDC+4ucNDpQGCEI6QK
        7lhcVtf4lFA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35F504FF47;
        Thu, 10 Nov 2016 17:55:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C5034FF46;
        Thu, 10 Nov 2016 17:55:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andreas Schwab <schwab@suse.de>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] t6026-merge-attr: don't fail if sleep exits early
References: <mvmtwbhdhvb.fsf@hawking.suse.de>
        <20161108200543.7ivo3xoafdl4uw6h@sigill.intra.peff.net>
        <alpine.DEB.2.20.1611091437280.72596@virtualbox>
        <mvmzil8btzb.fsf@hawking.suse.de>
        <20161109153128.aqm2lgdntdlycnaq@sigill.intra.peff.net>
        <mvm8tsrbusp.fsf_-_@hawking.suse.de>
        <xmqqbmxn6t11.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611102254340.24684@virtualbox>
        <xmqq60nv55o3.fsf@gitster.mtv.corp.google.com>
        <20161110223522.4b35ojaz5nhk4sll@sigill.intra.peff.net>
Date:   Thu, 10 Nov 2016 14:55:06 -0800
In-Reply-To: <20161110223522.4b35ojaz5nhk4sll@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 10 Nov 2016 17:35:22 -0500")
Message-ID: <xmqq1syj54j9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9DD9FE6-A798-11E6-B461-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do think the test would be a lot more obvious if it confirmed at the
> end of the test that the process was still running, as opposed to
> relying on test_when_finished to check it.

I agree that "check that the process is still running" is a wrong
thing to do in the first place.  What would it mean if the process
is no longer running?  It is a timing-dependent bug in the test;
after all we failed to produce the condition that could trigger a
bug that we are guarding against.  And "let's do '|| :'" is sweeping
the bug (not in the code we are testing, but in the test that will
fail to notice a bug we are preparing against) under the rug.  So I
agree with Dscho that we should do that first.

If we ensure that the process is still running, then such a check is
a good belt-and-suspenders way to catch a breakage in the mechanism
we choose to ensure it.  So probably we can require that the kill in
the "when finished" part to actually send a signal to a process that
is still running.

Is there an equivalent to pause(2) available to shell scripts?  I
really hate a single "sleep 3600" or anything with a magic number.
