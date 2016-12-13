Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10EDD203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 20:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbcLMUFV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 15:05:21 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54611 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753682AbcLMUFH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 15:05:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 67BE25595D;
        Tue, 13 Dec 2016 15:05:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gfG80qBDIf3rhgtRNUNZes2gtHI=; b=jDzYz5
        zfskpPW/5QLwUxNhvTjICLtJWfTtRX+wXHlDNqiUL6geDWIG6mgDGl7qkSSvmuJh
        pWKnxRInHJ5WuDi451psdmCa43lYiZdh7Zva4CNuPSW2H3v3CTEWj1rN/6y/5Te+
        n/FFyWdYWIYJgBDX3wCd3VhmH5nbIXEgndFmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N6xmuMfyufs8QsHmQoxDdP23Jsnk1Kvk
        Q930S+KOAU4BPp63Rg9gAA7Ik9gfVXrMverwQxcEsuxcCSUNQb4sR+VPW9xm9xAn
        Tzhfg0pX64q9YYM2Q5Qr6m84iAOxx3w2eiWgWdZEZBS0PFUR9n2tgAd+AeIpECQH
        i+OW75LtNZk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A2D25595B;
        Tue, 13 Dec 2016 15:05:05 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1760355956;
        Tue, 13 Dec 2016 15:05:04 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH v3 00/16] Add initial experimental external ODB support
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
        <xmqqy400bno3.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1=-xKWaDnGKrtm2mzVxpH7N-Q3iqnOJeOM5QrtNpitrA@mail.gmail.com>
Date:   Tue, 13 Dec 2016 12:05:02 -0800
In-Reply-To: <CAP8UFD1=-xKWaDnGKrtm2mzVxpH7N-Q3iqnOJeOM5QrtNpitrA@mail.gmail.com>
        (Christian Couder's message of "Tue, 13 Dec 2016 17:40:16 +0100")
Message-ID: <xmqqshpr1tox.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FB95D74-C16F-11E6-A872-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> In general I think that having a lot of refs is really a big problem
> right now in Git as many big organizations using Git are facing this
> problem in one form or another.
> So I think that support for a big number of refs is a separate and
> important problem that should and hopefully will be solved.

But you do not have to make it worse.

Is "refs" a good match for the problem you are solving?  Or is it
merely an expedient thing to use?  I think it is the latter, judging
by your mentioning RefTree.  Whatever mechanism we choose, that will
be carved into stone in users' repositories and you'd end up having
to support it, and devise the migration path out of it if the initial
selection is too problematic.

That is why people (not just me) pointed out upfront that using refs
for this purose would not scale.
