Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370561F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 19:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfHNTdb (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 15:33:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50752 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHNTda (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 15:33:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D23437CE2F;
        Wed, 14 Aug 2019 15:33:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UShAuP4A8AbXYjcsSc05HmGJe8k=; b=MI3sSZ
        +6LeyLJ0BgubiDF/LgsEFw0W0b38AcCgyF1X7g0dZMeunPUCUzWfupWjKGhIO7Zb
        QaJOnV3M68cn3zTShapgjiZ8xPJZxhnST7r1OYTgBbxzTnt8PvI+Bs3IVc1JyQMl
        l7TxacZ8djgXPaECpZC42LX0bGo+1KoF6yozI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rAPdPi+aoZ7GcWtjLcaaygKeO7JI1qNW
        PyacnsKckOoBS9MgINnUv/B2z64QSw6BTXH8nV8v7vBMX4pDczfQTlPJC71GeOF8
        nRrvUanHyySCd6C5D24XHw/5crbFMSI/LdUd3DE+R1SswidtAPJiMNwesxHD060Q
        cXfLb6Yilbo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C9AD57CE2E;
        Wed, 14 Aug 2019 15:33:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id ED3C77CE2B;
        Wed, 14 Aug 2019 15:33:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v2 5/6] rebase -i: support --ignore-date
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
        <20190812194301.5655-6-rohit.ashiwal265@gmail.com>
        <xmqqblws7n8r.fsf@gitster-ct.c.googlers.com>
        <c03439bf-54bf-b53d-9400-bdc4dd2a1309@gmail.com>
Date:   Wed, 14 Aug 2019 12:33:23 -0700
In-Reply-To: <c03439bf-54bf-b53d-9400-bdc4dd2a1309@gmail.com> (Phillip Wood's
        message of "Wed, 14 Aug 2019 19:51:15 +0100")
Message-ID: <xmqq8srv5ypo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62B011F8-BECA-11E9-9E2A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> That's an important distinction, particularly if GIT_COMMITTER_DATE is
> set in the environment - are we aiming to have the author and
> committer dates match or are we just resetting the author date to now?
> Rohit - do you know which --ignore-date does in the am based rebase?

The purpose "am --ignore-date" was to ignore "Date:" that came from
the patch message, overriding it with the current date.  It might
have become harder to read in the C version, but "git show v2.0.0:git-am.sh"
would be an easier way to read how "--ignore-date" wanted to behave.

