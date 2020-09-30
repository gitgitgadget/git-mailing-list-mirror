Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41762C4727E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB9FB206A1
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 19:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fSSTeACT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbgI3TLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 15:11:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64887 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgI3TLV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 15:11:21 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A3C521007C9;
        Wed, 30 Sep 2020 15:11:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jsOrpMgZvdnM0zUsBuGpw2eZFjw=; b=fSSTeA
        CTXsT5Yv9RA82HU/WXh1As0nAuPU84Ia7EMXdstq7GwSgt60EO9bmRkOt6Q6AqUs
        TMi8EKqSspl8//XPIr0Z0heHjG/q82w358drGRwOKySHv8SE1Xbf3/8CspfC+WX6
        xQN1pkb0t/0zEloJLxMREJmdhM789+3sKWXR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=euGnWbwuVf/Wn/+RcJk4VB2ga3W09vyl
        JN9VAaqNvG0I30UQXQ0YtatNEoRed9EiQNsynh8hn4I73Vn6q1TZpHZGxz38CLEI
        SUova5taA8xZsC2H/OTKfYCKVJhyoMMwZGXlY0FCXKPDvCAZ1mndwtIWSqLz1sYM
        YgrefjupvtY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9BE1C1007C8;
        Wed, 30 Sep 2020 15:11:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D09631007C7;
        Wed, 30 Sep 2020 15:11:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: jt/keep-partial-clone-filter-upon-lazy-fetch, was Re: What's
 cooking in git.git (Sep 2020, #08; Tue, 29)
References: <xmqqv9fwgrvg.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2009301536070.50@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Sep 2020 12:11:15 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2009301536070.50@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 30 Sep 2020 15:36:40 +0200 (CEST)")
Message-ID: <xmqqk0wbgjvw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7138EAC-0350-11EB-B97A-843F439F7C89-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Tue, 29 Sep 2020, Junio C Hamano wrote:
>
>> * jt/keep-partial-clone-filter-upon-lazy-fetch (2020-09-28) 2 commits
>>  - fetch: do not override partial clone filter
>>  - promisor-remote: remove unused variable
>>
>>  The lazy fetching done internally to make missing objects available
>>  in a partial clone incorrectly made permanent damate to the partial
>
> s/damate/damage/, I assume?
>
Thanks.
