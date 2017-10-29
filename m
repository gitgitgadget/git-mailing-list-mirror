Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9B12055E
	for <e@80x24.org>; Sun, 29 Oct 2017 03:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbdJ2DnR (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 23:43:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58453 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751646AbdJ2DnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 23:43:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF0FCAEC11;
        Sat, 28 Oct 2017 23:43:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qV3ut3RrCzC4NCN9AyZEp8E+ZSA=; b=MOONAm
        QVy+LAtSLWcn4CQjUrFH1AYqx7h2SCx3PxzqBMhG8b3cnN/L75MgoG/RY33VwPMq
        UXQtc0hLkf3nH6fmIfKLLQfeLEabchdNRoAhPTmvS2fTTW5pmyEYF/awcvMd40X4
        zOLXuuovlYuSHXH/JjEB/a9fQ1JJtoKq2vl7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qi3rWOX+fiMutonPBttm4pBw7l8bXV3G
        Oh9kduSapCxetCJuwkDMDEg6+IoP3fBpxz7D0/whsh2xQ+8W3kUpzvAuvChOfS61
        G0wRAA514p14zYrut//Zpoh62JZIICjGmAGnj0m58BwB0VZfsCRZ3xt2Hm21cFjf
        i4+wiS3T7dE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7972AEC10;
        Sat, 28 Oct 2017 23:43:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6321FAEC0F;
        Sat, 28 Oct 2017 23:43:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] revision.h: introduce blob/tree walking in order of the commits
References: <20171028004419.10139-1-sbeller@google.com>
        <20171028004506.10253-1-sbeller@google.com>
        <20171028004506.10253-2-sbeller@google.com>
        <alpine.DEB.2.21.1.1710281917260.6482@virtualbox>
        <CAGZ79kaVqSzzPebHN4=extkAPpyi=VagmjFU8mh_A_tYoJgU8g@mail.gmail.com>
        <CAGZ79kYEfFkUBZ18s=tDo+Dzo1KEA-MVNTZjLim_HHdZmeMa+A@mail.gmail.com>
Date:   Sun, 29 Oct 2017 12:43:14 +0900
In-Reply-To: <CAGZ79kYEfFkUBZ18s=tDo+Dzo1KEA-MVNTZjLim_HHdZmeMa+A@mail.gmail.com>
        (Stefan Beller's message of "Sat, 28 Oct 2017 20:23:19 -0700")
Message-ID: <xmqqfua2aab1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B9513E2-BC5B-11E7-B8E4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Sat, Oct 28, 2017 at 8:22 PM, Stefan Beller <sbeller@google.com> wrote:
>
>>
>> (Not making excuses, but...) I remembered some other senior members
>> having such commit messages, so I felt like I had to step up my game.
>>
>> https://public-inbox.org/git/70fbcd573f5c8a78a19a08ffc255437c36e7f49d.1495014840.git.mhagger@alum.mit.edu/
>
> I forgot to note though, that this never made it into the official tree, though.

Besides, leading by setting a better example would be the right
approach to gain seniority (if that is your goal, that is) ;-).

