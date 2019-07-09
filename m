Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3297D1F461
	for <e@80x24.org>; Tue,  9 Jul 2019 23:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGIXWq (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 19:22:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58466 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGIXWp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 19:22:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E67573C21;
        Tue,  9 Jul 2019 19:22:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=54OwaE8W/7kSKaVDswxF167LZrY=; b=gFTb6G
        ZrgXXzAWbbexKOzVod0cuPKebWCHbDhEHKE135sIbzb421SIWQPheWLLfI57DTNH
        6jm4jhVDSrHzhqM02yIYJ535GEd6kAevUPcsn1xuYejFRu/BAi/viA/eaEAPB2h7
        ybvAN4G7iRYEFB3X49Y4XAnxtiaCGjs8k+HMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TvbPbV73Aq6O74yPbyeBkkQw6KqGRmvM
        moKk4SUQbUPUZr581QNJETi+ed68rvbsI5bL7CyT69N7z6Kmx8OC61ptzQ8v1k3f
        x1TqWigqwe54MSrq8QFlXpBzAbWw+eU6IyzlnAtmLCkwV51G8KTiuGAzh+R9y8C/
        7Cw8CQZSEAk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38DA473C20;
        Tue,  9 Jul 2019 19:22:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5867C73C1F;
        Tue,  9 Jul 2019 19:22:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 07/14] apply: make parse_git_header public
References: <20190705170630.27500-1-t.gummerer@gmail.com>
        <20190708163315.29912-1-t.gummerer@gmail.com>
        <20190708163315.29912-8-t.gummerer@gmail.com>
        <xmqqimsbuhdy.fsf@gitster-ct.c.googlers.com>
        <20190709212359.GD15477@hank.intra.tgummerer.com>
Date:   Tue, 09 Jul 2019 16:22:40 -0700
In-Reply-To: <20190709212359.GD15477@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Tue, 9 Jul 2019 22:23:59 +0100")
Message-ID: <xmqqa7dmvlmn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73439378-A2A0-11E9-8473-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Maybe it would be even better to name it 'struct gitdiff_data', as
> it's really only used for those few functions?

Is it really the case where "these three are only used by the
codepath you made public"?  If so, I agree that "gitdiff_data" is a
perfectly good name for it.

I however had an impression that it is the oppposite, i.e. "the
codepath you made public only needs these three, but these three are
used by other (still private) parts, too."  If this is the case,
then "gitdiff_data" is a misnomer, if we were to embed an instance
inside apply_state.

It seems that it is not a good idea to do such embedding, and if
that is the case, "gitdiff_data" is a fine for the three-field
struct.

Thanks.

