Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC733C432C3
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 01:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85042222DF
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 01:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YalD2PIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfKTBEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:04:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61071 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfKTBEf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 20:04:35 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5BF709608B;
        Tue, 19 Nov 2019 20:04:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Dd7usXHaXyVNX0OFAwwkxw0S8lY=; b=YalD2P
        Ic+97U6aPn85QH9wGjkLHxus60jC5oblx55O3ag2QEWmk8P4RSKnVWw8IK0tSApW
        ZUfhgXt2c/Pp586I2UqC3jPs64OH2EdeA8oNI6vJjg4LLzdV5M/00ZdA6TERXPia
        a3SSLafmVCBv/9eZ4gX1VlrvjNwuw3BXPL/2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kKJ5BvPZ/gMpkSnfmEfQw8m8sOJgALob
        z77EVOY0GV4qNPRt37+jVUuNtFlx6zyrd62a6frD/YM6s+KIDZJzaFIjGDkbbAQl
        UsBwDlRRH2eOcbRPB4hnffnhw4taMbC8caXqRHRVb9oT743VUyXDIO9+GHhPxZV/
        XBnrqfBVr2M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 490729608A;
        Tue, 19 Nov 2019 20:04:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 105F996088;
        Tue, 19 Nov 2019 20:04:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] wt-status: show amended content when verbose
References: <20191116161856.28883-1-me@yadavpratyush.com>
        <xmqqd0dp3lfv.fsf@gitster-ct.c.googlers.com>
        <xmqq4kz13k8p.fsf@gitster-ct.c.googlers.com>
        <20191119145632.xi6zebglzu4lbgcq@yadavpratyush.com>
Date:   Wed, 20 Nov 2019 10:04:26 +0900
In-Reply-To: <20191119145632.xi6zebglzu4lbgcq@yadavpratyush.com> (Pratyush
        Yadav's message of "Tue, 19 Nov 2019 20:26:32 +0530")
Message-ID: <xmqqv9rfe4th.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4158308-0B31-11EA-B262-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> I'm afraid I don't follow what exactly this would do, and how it would 
> help differentiate between the "what the amend does" and "what the 
> amended commit does".

The resulting history would be

	O---A
         \
          B


where

	O = HEAD^ = HEAD@{1}^
	A = HEAD@{1}		- HEAD before the amend
	B = HEAD		- result of the amend

I wonder if

    git diff -c B O A

(with possibly different permutations of three revisions) is a
reasonable way to show what the final state is and where it differs
from the previous one (i.e. HEAD@{1}) and the original one
(i.e. HEAD^) in the combined diff format.

>>  2. would it make sense to show the differences between
>>     HEAD^..HEAD@{1} and between HEAD^..HEAD using the range-diff
>>     machinery.
>
> I considered using range-diff, but didn't go with it because of my 
> personal dislike for range-diff.

For a single-commit amend, the normal diff between HEAD@{1} and HEAD
would be far easier to read than such a range-diff, I would think.
