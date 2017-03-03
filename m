Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714F920133
	for <e@80x24.org>; Fri,  3 Mar 2017 18:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbdCCSYL (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 13:24:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50807 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751584AbdCCSYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 13:24:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E75E862E7E;
        Fri,  3 Mar 2017 13:24:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aWdVKEf+PmJotXehbhx7s+OSpj0=; b=ni6T2n
        Pn0usOtrWroJ+E5jOz4KiWrTVpv5O+0I+0sWbVLPqpRer0PzwO44h//jaOX7R0J6
        HIjWZO3CINWlI2z+zv9ZwUG2CD33UbZgDaSiQIcJ/YZDWvxAEAWkcrivRENkdCCD
        PQ/cKpre6r6H/5lcDsa39ssMcXYYoy9EQDsgc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=u1e7l+i1fDxwtJI6ahueO2pHHFGgtUVO
        miG3pzBjSKF6rhI6xwFp0PtAbhcZ5ExSnanFf5yPu5n6oObFAnTc5y+0D906cFrj
        eDdEm3TzFxUexqUVsQGc+F+/+yZ5Kya3JpPLBZOc9mIkexTjk1w6wxdrftIbqykY
        Vkp1DFdNkMI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFA1862E7D;
        Fri,  3 Mar 2017 13:24:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 318B762E7B;
        Fri,  3 Mar 2017 13:24:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, sschuberth@gmail.com,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 0/3] Conditional config include
References: <20170224131425.32409-1-pclouds@gmail.com>
        <20170301112631.16497-1-pclouds@gmail.com>
        <20170303063329.ji6do6eqjbpuwmxz@sigill.intra.peff.net>
Date:   Fri, 03 Mar 2017 10:24:05 -0800
In-Reply-To: <20170303063329.ji6do6eqjbpuwmxz@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 3 Mar 2017 01:33:29 -0500")
Message-ID: <xmqqlgsm9q2i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96919D68-003E-11E7-8952-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For those following on the mailing list, there is some discussion at:
>
>   https://github.com/git/git/commit/484f78e46d00c6d35f20058671a8c76bb924fb33
>
> I think that is mostly focused around another failing in the
> error-handling of the config code, and that does not need to be
> addressed by this series (though of course I'd welcome any fixes).

Thanks.  Without a message like this, the list may have never known
about the discussion taken elsewhere.  I'd appreciate such a report
to appear on list the next time much earlier ;-)

When built with FREAD_READS_DIRECTORIES=Yes on Linux, the error in
the test can easily reproduce.

In early days of UNIX it was sometimes handy to be able to read the
bytes off of directory to "investigate", but we are not a filesystem
application, and I do not offhand see any reason why we should be
relying on being able to successfully fopen() a directory for
reading.  A FILE * successfully opened that just returns EOF when
read is totally useless for any purpose anyway.  

When the path to be opened from the end user (either from the
command line or in a configuration file) is a directory, it is
better to diagnose it as a user error, and if the path was computed
by our code, it may be a bug.

I am wondering if we should enable this on Linux, at least in
DEVELOPER builds but possibly even on the release builds, to catch
these problems more easily.


