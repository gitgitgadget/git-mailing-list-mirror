Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDFCC35E04
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 17:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CE62082F
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 17:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aFADtsx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbgBYRsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:48:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57911 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729553AbgBYRsH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 12:48:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C02D94F97D;
        Tue, 25 Feb 2020 12:48:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0y1VQuS9NUlvXdWDrFkxl71fqKM=; b=aFADts
        x7hUcynYH05AgUQvspzCQNS8QcZwkJBdBvbX4ix54ppKOqamQiHMR+1DwHv3yo74
        pKWDJt3bRy2tZwBWW+zzN6zlsRyuEgShOQZaUAZ5s9VJt1DGHCEO92wA6S1j8Xem
        Lo+2Y3jjwwef/OMl4U8rHINgmkWZ1DnCFb3WM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vthnYRvIHMYnK8RAAexnVsSdaRx91u1P
        t5G61yNGR7dnkcQdvLwrYg84Sybv/bWiVzPrL2Wz3zW5pzkCYRNRqkeBylmPn0fJ
        l0fop5tg1MOyBh3wnWD7HEN84DG+z2G01yUqoubG8aRFcasff2P/Gl44g3YuYFTY
        2GAoz6ep+zI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B49CB4F97C;
        Tue, 25 Feb 2020 12:48:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 796B24F97B;
        Tue, 25 Feb 2020 12:48:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v5 3/3] tag: use new advice API to check visibility
References: <pull.548.v4.git.1582557199.gitgitgadget@gmail.com>
        <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <01b195ebe1d2ab1593915318b7e8adbee5d9614c.1582628141.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Feb 2020 09:48:02 -0800
In-Reply-To: <01b195ebe1d2ab1593915318b7e8adbee5d9614c.1582628141.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Tue, 25 Feb 2020 10:55:40
        +0000")
Message-ID: <xmqqlfoqmuct.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8C10916-57F6-11EA-BE1D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Heba Waly <heba.waly@gmail.com>
>
> Following the new helpers added to the advice library,
> replace the global variable check approach by the new
> API calls

The last paragraph of the proposed log message you had for [2/3]
described that this step is just an example better than the above
one, which would leave readers puzzled what our plans are for dozens
of existing advise() calls.

> +	if (type == OBJ_TAG)
> +		advise_if_enabled(NESTED_TAG, _(message_advice_nested_tag),
> +				  tag, object_ref);

This is probably a good enough example why OBJ_TAG is a good name
but NESTED_TAG is not---type could be something different from
OBJ_TAG but the other possiblities are all OBJ_<object-type>.  We
want the advice types to have the same property.

