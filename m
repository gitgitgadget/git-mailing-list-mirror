Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989D52036D
	for <e@80x24.org>; Sat, 25 Nov 2017 03:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbdKYDUN (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 22:20:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51443 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751494AbdKYDUN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 22:20:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B902BACD2;
        Fri, 24 Nov 2017 22:20:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=a7b4ZE6zKVcwNZxnEP+fC74p/C8=; b=Re6fY7
        wJP5LPQUCnuDQroRyDpIVUJgNySEQSoDnE9WRHXIF8t7pOktlEYiUFCSwKow614V
        H1RDedDoa9uLi4CL+na1mqq/uwNyL01dwrCai7f6PrZbl1mWUkcGDaprAUAFOKMK
        bkNtlgl7V6lwuEi+oqPJLeLLp0ZW/2/hULI9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ancVr22wodoml6Tgzi0VxTET+8f0Um1e
        iwUe75ySN7PsX2ahAbceOAhtMqpNa6VdgSMFF166w8fBKeFUn84kcNNi0OssJsDk
        OnAqUnsJONl/LG5eAupJg6xZJvroAD75PZll+UL9Vt0enWPr2iTyD/5XMUlzlcfQ
        WWpbiRl980Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 742BEBACD1;
        Fri, 24 Nov 2017 22:20:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EEE8CBACD0;
        Fri, 24 Nov 2017 22:20:11 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] sha1_file: don't re-scan pack directory for null sha1
References: <20171120202607.tf2pvegqe35mhxjs@sigill.intra.peff.net>
        <20171120203523.c3pt5qi43e24ttqq@sigill.intra.peff.net>
        <xmqqd14cjr13.fsf@gitster.mtv.corp.google.com>
        <20171121225744.GA21197@sigill>
        <xmqqwp2jxf5l.fsf@gitster.mtv.corp.google.com>
        <20171122223613.GA1405@sigill>
        <xmqqpo89rac6.fsf@gitster.mtv.corp.google.com>
        <20171124173201.GA29190@sigill>
Date:   Sat, 25 Nov 2017 12:20:10 +0900
In-Reply-To: <20171124173201.GA29190@sigill> (Jeff King's message of "Fri, 24
        Nov 2017 12:32:01 -0500")
Message-ID: <xmqqh8tjkpsl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8C266C46-D18F-11E7-B8F2-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I dunno. That is far from exhaustive, but it does seem like most
> cases should assume the presence of the file.

You are right.  I should have considered that "we got a random
object-name looking thing and we do not care if it does not exist"
is a very narrow minority case.  Most of the object names we deal
with come from local repository traversal and unless things like the
"fsck-promisor" comes into the picture, we should always have them
available locally.

> But it may not be that big a deal. For the most part, all bets are off
> in a corrupt repo. My main concern is just that we do not want the
> corruption to spread or to make it harder for us to recover from (and
> that includes allowing us to delete or overwrite other data that would
> otherwise be forbidden, which is what's happening in the fetch case).

Absolutely.

Thanks.
