Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9488A1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 02:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfKFCmz (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 21:42:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52293 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbfKFCmz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 21:42:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FAAC2B13A;
        Tue,  5 Nov 2019 21:42:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=neujMBczOGVSo5KqUw/v26v0m8o=; b=q+btfx
        DeDDUxTR5PntluCapIj3NeDnmJrydAKmFD2xLQpD85PRz4Cepecd4LQyORC2yCEg
        vAdN0KaD3yn6x7npqaxQTJ5+n3pSh2fZEv+qz9cHj9OnUmuM+Tv51bpk9R+IlUmA
        2fzT8lIsK2bfXzYc1JB2wv/LhzVjsDc3fpvP4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DA/kkG1lGFP3E7bZnJUAEinmsefXNWdH
        vwXzqc6X7J681wC1DsQ2QGaLlS2f5mHoVQpfaK/UF97ua8/ktyWjvocQvRajEkOW
        Hl7lruamDAuRW8W4U3ZwgW5g52ejcy4v1IRbwBZGBVGD6vSMUphCuYSW7uQzRvia
        T/8/WFrpWyk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87BCE2B139;
        Tue,  5 Nov 2019 21:42:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EDCFC2B138;
        Tue,  5 Nov 2019 21:42:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     workingjubilee@gmail.com, git@vger.kernel.org,
        christian.couder@gmail.com, johannes.schindelin@gmx.de
Subject: Re: [PATCH v7 1/1] Implement rev-list --bisect* --first-parent
References: <20191105052141.15913-2-workingjubilee@gmail.com>
        <20191105230403.5542-1-jonathantanmy@google.com>
Date:   Wed, 06 Nov 2019 11:42:52 +0900
In-Reply-To: <20191105230403.5542-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 5 Nov 2019 15:04:03 -0800")
Message-ID: <xmqqtv7hvi6r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 21E64B18-003F-11EA-9B04-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Your commit message title should be of the form "<component>: <change>",
> e.g.:
>
>   rev-list: support --first-parent with --bisect*

Good suggestion.

> I would be much more laconic (in particular, omitting subjective terms
> like "minutiae" and "mountains of irrelevant data"), but perhaps that is
> just a matter of subjective style.

FWIW, I had the same reaction.  That part of the message was too
noisy without adding much actual value.

>> Note, bisecting on --first-parent becomes part of findall's previously
>> existing pass-through as an "option state" flag.
>
> I don't understand this part.

Me neither.

> Also, clarify in the commit message somewhere that this commit does not
> change the behavior of "git bisect".

s/\.$/ when used without the "--first-parent" option&/; you mean?

> As for the diff, besides my comments below, a change in the user-facing
> documentation of "rev-list" is needed, since --bisect and --first-parent
> now work together.

True.  I too am, like you are, happy to see that these two options
made to work well together.

Thanks, both, for the patch and useful comments.  My own review on
it may take a bit more time.

