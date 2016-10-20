Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF671F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 16:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754314AbcJTQaM (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 12:30:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54888 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753907AbcJTQaL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 12:30:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8350846A2C;
        Thu, 20 Oct 2016 12:30:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fOUb11qIQKpLJp+bNlA412kiclQ=; b=JHIjow
        qnkQH/SBB06JaTIPPOebh1jCl9mYzN5p15/5Veuqg4fCPkVjxviS+C7Yw6HPy/Q7
        AR/EuT0MMd364k1548Dz4x0tbhhGPv+sw9PomVZnfZ/mZNkjPz2oA4oM6Cyejzp2
        3e8zpTHdoWtONiV4RG3vxpBlVv90o9rgdQ+1s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YVk+RB/dFhcypylr+YZAecWQ0XlUodJO
        wDRpc3eofl7shoGAroVKvuOpfyZqxZFgiziTdP6b4CcMW3kN+eJtWfpcHNp+U4ul
        xG8uuMPUX2Jlv5fktyV59v2K+5718rrjwlqo8VrATwl2pQa35Y35Xi9exyZRF2Ii
        pti/gBxlQyc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A9E946A23;
        Thu, 20 Oct 2016 12:30:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2BB646A21;
        Thu, 20 Oct 2016 12:30:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
        <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net>
        <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
        <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net>
Date:   Thu, 20 Oct 2016 09:30:05 -0700
In-Reply-To: <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 19 Oct 2016 22:13:23 -0400")
Message-ID: <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76B1224A-96E2-11E6-94B0-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> I still think it's worth while to add a check for git-commit which
>> does something like check when we say "git commit <files>" and if the
>> index already has those files marked as being changed, compare them
>> with the current contents of the file as in the checkout and quick
>> saying "please don't do that" so as to avoid the problem in the first
>> place.
> ...
> I suspect both of those would complain about legitimate workflows.
>
> I dunno.  I do not ever use "git commit <file>" myself.

Users are different.  I do use this all the time, and it is not
unusual at all to have changed contents on paths other than <file>
already added to the index when I do so, i.e. an unrelated small
typofix in <file> jumping ahead of the real changes I am working on
in other parts of the tree.

"Please don't do that" would break.  Jacob says "avoid the problem",
but I do not see a problem in allowing it (it could be that the
problem Jacob has is in other parts of his workflow, but I do not
know what it is offhand).
