Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2DAC1F461
	for <e@80x24.org>; Wed, 15 May 2019 01:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfEOB4u (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 21:56:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56276 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEOB4u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 21:56:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13D4A13A486;
        Tue, 14 May 2019 21:56:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PcC5oGqcgqbXi961nfrSjrK5RpI=; b=kAG/r9
        pCC90ciOr/crTThHHcqjJR61riJzvwwxtk2AX8mMRSJZ+dsyJQAeiCca8gE4THmY
        6rpEBJg8iEkApZUyCmiMBqIjAO9OQmX2JTqwJqiiQrId7byQ29Dr+47HiRBEWEHL
        WikxRoBirL6/vkl/nqErdX+HPHVJETKjxRiDA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EzjyFo3cu5K8TpnsqsSdL2SH2gCduVF4
        2wZpuNGQik6vXKEmO9VChpXODskKN4AbSSGvhR/y6w/0fi/ybwYjiDKF0QhQODVY
        eqqT5A/bK2haVAOgWhzBRBgSts/cEQKmfbT71Peoy822xfm6tkdyH2pajmySmj1E
        xFKKTQ93vIc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A9D913A485;
        Tue, 14 May 2019 21:56:48 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 68A6313A484;
        Tue, 14 May 2019 21:56:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Is git-checkout's restoring d/f conflict really sane?
References: <CACsJy8Bew3i6AL_XWfhLhCvdSFYVCGoEQepi9KLmSDPVmDu5Zg@mail.gmail.com>
        <xmqq8sv99vac.fsf@gitster-ct.c.googlers.com>
        <CACsJy8DoxHoi0H3R91ovqDPjk0tN3Rr8fQOjaLt_2P9O3n9b_g@mail.gmail.com>
Date:   Wed, 15 May 2019 10:56:46 +0900
In-Reply-To: <CACsJy8DoxHoi0H3R91ovqDPjk0tN3Rr8fQOjaLt_2P9O3n9b_g@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 14 May 2019 17:49:03 +0700")
Message-ID: <xmqq1s108opt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B29EE85A-76B4-11E9-AF61-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Technically 'one' is still tracked (even if it's a directory) so what
> we're doing is right. I'm just not sure if there's some big surprise
> factor here. And whether it's better to pause and double check with
> the user before deleting everything.

I agree to all of the above, including the part "technically it is
correct", but more importantly "stop and double check".  

As changing between a directory and a non-directory is a rare event
anyway, I do not mind making it a bit more cumbersome and say "you
asked me to check out a regular file 'one', but you have a directory
'one', that has an unignored untracked file in it, so I'd refuse to
do so.  Come back after you removed them manually, or use the '--force'
option".

We should not refuse if 'one' is an empty directory or all files in
it are ignored, though.

Thanks.


