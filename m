Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7D3B2036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751439AbdKVBmd (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:42:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53801 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751353AbdKVBmd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:42:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8227BA040;
        Tue, 21 Nov 2017 20:42:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=G7XCGFqCmQ39T/pTLLRnO28sdpM=; b=Sta30q
        GO0oQEwNij1JU1i8OWsebEP5b7mbflCGV61Sf5cxfSAsoDyViwJwnZ2D2K3txpZr
        uWeZ5raipQSLBNK/Q8hGW1H+t+6WafIT6kp0HeBU5vTdIalvEICDLIMS3foCp5m/
        HGi2kDTVCZVplU3HIkWuY+75uxLy2W2qTOwQs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LsIH3esjaa6XdXEEFNtJV9nLNAeUESVS
        tVQuZz/zQeVSGNshQrkANJaBDvlMaN/SA2QTTvKh+mh69UtODr7u3GAVf8TaJ+M5
        eKYPlsUsGTwoYPqicJ53PLT0bNCY8v1NIwTU5F4k48Wlv4opSyclwjkjj6cLHlWK
        eH+qdWjyWuw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A0C74BA03F;
        Tue, 21 Nov 2017 20:42:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1E694BA03E;
        Tue, 21 Nov 2017 20:42:32 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
        <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
        <xmqqd14cjr13.fsf@gitster.mtv.corp.google.com>
        <20171121225744.GA21197@sigill>
Date:   Wed, 22 Nov 2017 10:42:30 +0900
In-Reply-To: <20171121225744.GA21197@sigill> (Jeff King's message of "Tue, 21
        Nov 2017 17:57:44 -0500")
Message-ID: <xmqqwp2jxf5l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6829FDAA-CF26-11E7-9040-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm not sure what the right behavior is, but I'm pretty sure that's not
> it. Probably one of:
>
>   - skip updating the ref when we see the breakage
>
>   - ditto, but terminate the whole operation, since we might be deleting
>     other refs and in a broken repo we're probably best to make as few
>     changes as possible
>
>   - behave as if it was a non-ff, which would allow "--force" to
>     overwrite the broken ref. Maybe convenient for fixing things, but
>     possibly surprising (and it's not that hard to just delete the
>     broken refs manually before proceeding).

Perhaps the last one would be the ideal endgame, but the second one
may be a good stopping point in the shorter term.

