Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4D5F20986
	for <e@80x24.org>; Tue, 27 Sep 2016 20:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934274AbcI0UL5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 16:11:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62409 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932573AbcI0ULz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 16:11:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF18D3EB93;
        Tue, 27 Sep 2016 16:11:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AB0B6gXrddrf8YKs6Z9PiEE8HFw=; b=rlKJes
        lFPukNOvzUWo/Enw0eiUvnk7zU74mXbDNKZaXFFzf7p1XUevbfPb5Ss85EFSdDsb
        iBtburGsEUR2eE1U17eidZL1GsxMKn6B9VjLLsu6U9BO4UjD/x/9e026Vd1b+lAy
        M3yeONuPLlt30lAm8dhbxoGKiO/4xxx1EuV2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pPIag62ICuML5IVxOv6AjKa2EQ78467P
        Yk7nsb6Lr7mvq3/6nNV+dkkl3hbv0havB6zYBriWnVGVt4lYUMHfKXXmsRvqGSiH
        xVpTPiS98bHmO7A6VOqJugunZ0oqOWAYZ8j9lj0cAsLx8GsIxSaJYRD/KelQa3AT
        J3m4CXbUFvQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B82A33EB92;
        Tue, 27 Sep 2016 16:11:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 439613EB91;
        Tue, 27 Sep 2016 16:11:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] ls-files: pass through safe options for --recurse-submodules
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1474930003-83750-4-git-send-email-bmwill@google.com>
        <xmqqh991nq34.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Sep 2016 13:11:52 -0700
In-Reply-To: <xmqqh991nq34.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 27 Sep 2016 11:40:47 -0700")
Message-ID: <xmqqwphxm7av.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A263B930-84EE-11E6-ADA8-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In nul_to_q and q_to_nul implementations (t/test-lib-functions.sh)
> we seem to avoid using "tr", even though q_to_cr and others do use
> it.  I wonder if we had some portability issues with passing NUL
> through tr or something?
>
>     ... digs and finds e85fe4d8 ("more tr portability test script
>     fixes", 2008-03-12)
>
> So use something like
>
> 	perl -pe 'y/\012/\000/' <<\-EOF
>         ...
>         EOF
>
> instead, perhaps?

I actually think it would make more sense to add

    lf_to_nul () {
            perl -pe 'y/\012/\000/'
    }

to t/test-lib-functions.sh somewhere near q_to_nul if we were to go
this route.
