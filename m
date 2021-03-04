Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AD3C433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775BA64F6C
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 01:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbhCDBPO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 20:15:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61362 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243418AbhCDBMO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 20:12:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22729BF3F5;
        Wed,  3 Mar 2021 20:11:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DGiGylCWYH0lU1gnYiK2abSj1oY=; b=gLYzcJ
        a+oYGAcXcXMwxxQrz1NHQrRbcedMHzibFX77Cxz0Drc9c3mGbbqJdE6erHoMe/kB
        IV+GdkvsMg1JBb8i2Z9DTrqUWYww8Vx5HkjatMfBam+WC8GCBffV4q1fEUgqrMUU
        q+dmAi1UJoqIH6AmAARvdNiuaxhipti0BoUTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x0wHtDBTHc9ZJP8aHRaTfhNnJGrOwEMR
        QXv/d+I40A/jAnLMaTbjTnXU35rZjDR2W7g677j+jeGt9YWVJA7S1yoELktoMIuI
        p3b8S1kjFpeC2aXENm8iGc4SFEiz2TCBW1OOjezM9lvzS5T8TtAVlLtcq/jy7OWz
        A8mXfKDvov0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1960DBF3F4;
        Wed,  3 Mar 2021 20:11:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C71DBF3F3;
        Wed,  3 Mar 2021 20:11:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shubham Verma <shubhunic@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9801: replace test -f with test_path_is_file
References: <20210302185056.65929-1-shubhunic@gmail.com>
Date:   Wed, 03 Mar 2021 17:11:28 -0800
In-Reply-To: <20210302185056.65929-1-shubhunic@gmail.com> (Shubham Verma's
        message of "Wed, 3 Mar 2021 00:20:56 +0530")
Message-ID: <xmqq8s73g1tr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8CEA3B08-7C86-11EB-9FC1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shubham Verma <shubhunic@gmail.com> writes:

> -		test -f file1 &&
> -		test -f file2 &&
> +		test_path_is_file file1 &&
> +		test_path_is_file file2 &&
>  		test ! -f file3 &&

You chose not to touch the last one, which is the right thing to do.
Replacing "test -f P" with "test_path_is_file P" can be done
mechanically, but it takes understanding of what the test is doing
to come up the correct replacement for "test ! -f P".  It may be
expecting P to be a directory, or it may be expecting P to be
missing, for example.

Will queue.  Thanks.

