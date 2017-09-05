Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 435B7208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 21:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753537AbdIEV1F (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 17:27:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57907 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753513AbdIEV1A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 17:27:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE3F19208C;
        Tue,  5 Sep 2017 17:26:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rBDvCWfwroIsIaHgJceBibBzX4Y=; b=Y4D0gM
        QWYSXRmU2/X67w5jSbPxAyKOoLeqwO0ff+Za7Ce/hWimG13CR31jfjwuBWtPd4iw
        RN0BuwdY65rsv+B14bG3Ijes/I8QUNZlNbHXuEdmJUAl1RSZ6yGjbUn6fC5Tsu3p
        CWadyzK3397kdMO0fZiqi+QjHd0iNLBYD2SaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AMofXTmHTnjAAOr576H2IeCwEfAyH1tQ
        U0EN+WDDJdq1AkXFfb5epsU74LhmIpRS3pSJuUGK4sAYH/O86teJK9QnZCHWeqB7
        R2/2/+FokHM5DztDlTtYAVKRKvE1iwWV0aT9jSJP/tdvhnw54MDQ513pW9pHMU3p
        BHnM0aKlTiY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5F549208B;
        Tue,  5 Sep 2017 17:26:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 253409208A;
        Tue,  5 Sep 2017 17:26:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] refs/files-backend: add longer-scoped copy of string to list
References: <CAN0heSqn59sFF3A-eQ593G+ZDWnO9pKM5F=sgiSQk+prUr-nSQ@mail.gmail.com>
        <4b4c0d178ad2216eecbc49fb6f54dd8a1d1ac119.1504024261.git.martin.agren@gmail.com>
        <91e365b5-6a5d-1e1c-ab7a-579efa7c1ae8@alum.mit.edu>
        <CAN0heSqa8OnPnkd1xbyZ=QN9qg_8OaxBYnwzOZDDA3g+uGE71g@mail.gmail.com>
        <xmqq60cxcvjk.fsf@gitster.mtv.corp.google.com>
        <CAN0heSqnrPUEgP-BgvuHuVrDG2ifuHHDOPPmxiXJ73u4-PrOng@mail.gmail.com>
        <20170905203622.6fs3hr7zfa7mwpqn@sigill.intra.peff.net>
Date:   Wed, 06 Sep 2017 06:26:56 +0900
In-Reply-To: <20170905203622.6fs3hr7zfa7mwpqn@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 5 Sep 2017 16:36:23 -0400")
Message-ID: <xmqqmv68bzvj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F29926B0-9280-11E7-B2E0-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I noticed the HEAD funniness, too, when looking at this earlier. I agree
> with Junio that it's not quite consistent with the general rule of
> "string list items point to their refnames", but I don't think it
> matters in practice.

Yup, we are on the same page; the "fix" I was alluding to would look
exactly like what you wrote below, but I agree the distinction does
not matter in practice.  IOW, I do not think the code after Martin's
fix is wrong per-se.

Thanks.

> I think the fix, if we wanted to do one, would be similar to what you
> did in split_symref_update(). Like:
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index f3455609d6..3f9deff902 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2095,8 +2095,7 @@ static int split_head_update(struct ref_update *update,
>  	 * transaction. This insertion is O(N) in the transaction
>  	 * size, but it happens at most once per transaction.
>  	 */
> -	item = string_list_insert(affected_refnames, "HEAD");
> -	if (item->util) {
> +	if (string_list_has_string(affected_refnames, "HEAD")) {
>  		/* An entry already existed */
>  		strbuf_addf(err,
>  			    "multiple updates for 'HEAD' (including one "
> @@ -2111,6 +2110,7 @@ static int split_head_update(struct ref_update *update,
>  			update->new_oid.hash, update->old_oid.hash,
>  			update->msg);
>  
> +	item = string_list_insert(affected_refnames, new_update->refname);
>  	item->util = new_update;
>  
>  	return 0;
>
> -Peff
