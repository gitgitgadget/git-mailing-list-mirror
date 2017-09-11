Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4B2E20286
	for <e@80x24.org>; Mon, 11 Sep 2017 04:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751019AbdIKEBn (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 00:01:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64788 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750715AbdIKEBm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 00:01:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60AC8A1E48;
        Mon, 11 Sep 2017 00:01:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Vq2HeD+AtcrgfVDBz7TSCKJEAs=; b=xn+Hix
        +2d4KbHqFZXizg4OTpjJuo3M8TYhk2KfNWQkAdABm/DT1xcJGls05fRDWWYEl0AX
        pUv21ItZeEY2K1RTOsyZ7d8p5POz+C2y0h/ss8AyEHTETDKl7nnZz/mA1X5NMFbH
        OeslFP31xc9/RhIUCI4cu4SHQMnBFWVSGtx3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fHv1IJl380nt/J8k6yNjO6xDImGHvDX0
        4VHiQ9xKF0ThV0AYfXGnArOy/buzcOmPvkP+HiaBmqDbTvy8d6YvzARla0WDBY1L
        79VajsojVVCF5Irf+j0NltzZwbA+kNFxGMUOj61Bb6LrAK0XUfER7c20Qob7bYut
        5PkZIVcGzcs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 570F6A1E47;
        Mon, 11 Sep 2017 00:01:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7477A1E46;
        Mon, 11 Sep 2017 00:01:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "pclouds\@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH 1/1] reset: fix reset when using the sparse-checkout feature.
References: <20170908180050.25188-1-kewillf@microsoft.com>
        <20170908180050.25188-2-kewillf@microsoft.com>
        <xmqqvaktxawk.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB0014638E5D9CBFD0D9D85F10B7950@SN1PR21MB0014.namprd21.prod.outlook.com>
        <xmqqr2vgy2yt.fsf@gitster.mtv.corp.google.com>
        <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
Date:   Mon, 11 Sep 2017 13:01:39 +0900
In-Reply-To: <SN1PR21MB00140C84DC02F3491F4E8469B76A0@SN1PR21MB0014.namprd21.prod.outlook.com>
        (Kevin Willford's message of "Sat, 9 Sep 2017 04:54:31 +0000")
Message-ID: <xmqqh8w951ek.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA9792B6-96A5-11E7-821E-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <kewillf@microsoft.com> writes:

> I agree with this when you are not dealing with a sparse-checkout.
> When using a sparse-checkout I expect git not to touch things
> outside of what I have specified in my sparse-checkout file.  If it
> does, it should let me know or put my working directory in a
> state that is expected.  Especially when it is changing the
> skip-worktree bits causing files outside the sparse-checkout to be
> reported incorrectly by status.

Well, whether using a sparse-checkout or not, I would expect Git not
to touch *any* filesystem entity when "git reset" (not "--hard",
just "git reset [<tree-ish>]") is given, whether the path is inside
or outside the sparse-checkout area.

Stepping back a bit, I am not sure if it is sane or even valid for
the end-user to modify paths outside sparse-checkout area, but that
is probably a separate tangent.


