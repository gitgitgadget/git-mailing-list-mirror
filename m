Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6590F20986
	for <e@80x24.org>; Tue,  4 Oct 2016 16:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753907AbcJDQTF (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 12:19:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53472 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751479AbcJDQTE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 12:19:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB80C41FBD;
        Tue,  4 Oct 2016 12:19:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GXJwdivGLbVyZwiuMn03M0xkMVg=; b=oGB/WR
        go2bWStMn4EqmzCjCbzsTpqjlvI9dyaZCOVz8q59kbILTk/T01ZshtFs3z9gjn0B
        j2ntkec5tO6lh39Qv+7gZlPW2JyZoo2w6NWx2l3GbrsKsoYpgwPK9aIMfkVS0nbh
        iSYSAph5vlts1MivMasg1xIZLFQZCRbG8o1k8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sFlVR4cOcJr3Q0LnK03SxQPSVUDbYiI7
        OiRgOICIPzEH5QN7VFZ552vqm+ZCv656lrl2pxM2G+f4TGY0Qq3CEIbMCUz2MC7X
        lnVzYURlUmQSSRF/KUsIynlTueWLKLwmCHRFrJRdTe+A2jlmfT1kIYxPUj4iYOoU
        rZIOOLI9WXA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D247C41FBA;
        Tue,  4 Oct 2016 12:19:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F04A41FB9;
        Tue,  4 Oct 2016 12:19:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Slow pushes on 'pu' - even when up-to-date..
References: <CA+55aFyos78qODyw57V=w13Ux5-8SvBqObJFAq22K+XKPWVbAA@mail.gmail.com>
        <20161004111845.GA20309@book.hvoigt.net>
        <20161004114428.4wyq54afd4td3epp@sigill.intra.peff.net>
Date:   Tue, 04 Oct 2016 09:19:01 -0700
In-Reply-To: <20161004114428.4wyq54afd4td3epp@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 4 Oct 2016 07:44:28 -0400")
Message-ID: <xmqq8tu4w0i2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 43FBCA4E-8A4E-11E6-95A4-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> As I argued in [1], I think it's not just "this must be cheaper" but
> "this must not be enabled if submodules are not in use at all".  Most
> repositories don't have submodules enabled at all, so anything that
> cause any extra traversal, even of a portion of the history, is going to
> be a net negative for a lot of people.
>
> I think the only sane default is going to be some kind of heuristic that
> says "submodules are probably in use".

Why should we even have a default different from today's?  If most
repositories don't have submodules enabled at all, we can just let
those working with submodules enabled to toggle their configuration
and that is an very easy to understand solution, no?
