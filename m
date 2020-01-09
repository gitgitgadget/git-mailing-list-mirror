Return-Path: <SRS0=y4cH=26=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C05C33CA1
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 20:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64472072E
	for <git@archiver.kernel.org>; Thu,  9 Jan 2020 20:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mu7KR5Re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgAIUSQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:18:16 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63737 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729542AbgAIUSO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 15:18:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AEECDA4A16;
        Thu,  9 Jan 2020 15:18:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HkQ9lQU1tzp7aXt2GAVgsNR349o=; b=Mu7KR5
        ReOO9FP18L5GFFYiWa5UbE+pZYIa/VWZLoOpqY5dd2TlJBnYpIF4fv6NP7Hc0c/m
        mD53XFB9XWXubPs7h/ko7oUvqokbrmRMkkcvmH1P6gjh/D0yrl1Wegefie1NSnCE
        1Q8i0L34OYdvtw0Pu/eW9Y6fRkvLRkV9/SzYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hBqHfy7SQ+9zg7oNn4EqxemRoM6TsII1
        y56Savzc3CPKRdgepmx1dccif7HvnCCmz+1MpqAGrzjYWHPcX9xV9Lt73r6cnYv2
        1ECWWlMLZjMUn+tSAduiOPtcSbiVU9AwQ2x3nza4iBsFXmX5YiY/18tf0Gz5YPH/
        6nnC6U8USqA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A656DA4A15;
        Thu,  9 Jan 2020 15:18:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D1CBEA4A10;
        Thu,  9 Jan 2020 15:18:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: reftable progress
References: <CAFQ2z_OhNHauK_W1wL7WcOJnm2vCUGXLfYn_ZmLnt2rez+_TDw@mail.gmail.com>
Date:   Thu, 09 Jan 2020 12:18:08 -0800
In-Reply-To: <CAFQ2z_OhNHauK_W1wL7WcOJnm2vCUGXLfYn_ZmLnt2rez+_TDw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Thu, 9 Jan 2020 20:16:14 +0100")
Message-ID: <xmqq4kx4z8n3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 28242606-331D-11EA-A7C3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> Hi folks,
>
> I have some alpha-quality code for Reftable support in Git at
>
>  https://github.com/hanwen/git/tree/reftable
>
> I'd be curious for some feedback, both on the library
> (https://github.com/google/reftable) and the glue code in Git.

If you are asking for feedback, sendign it over to this list with 
[RFC PATCH n/3]  as the subject prefix would have better chance.

I have a feeling that the patch to show-ref is done at the wrong
level.  The show_ref() function is given as the callback function
to head_ref() and for_each_ref(), and the way these functions call
the callback function is part of the ref API.  "In the reftable
format, ... are stored in the reference database too," is perfectly
fine (that is the implementation detail of the ref API backend) but
"and are produced when iterating over the refs" is not.  Hide that
inside the ref API backend you are writing for reftable and this
change will become unnecessary.

I agree with the general direction of the second patch that extends
setup.c to allow .git/refs to be a regular file to signal that the
repository is using reftable (instead of filesystem-based refs), but
the title "fix repo detection" is misleading---it is adjusting for
the new format (as there is nothing to "fix" if there weren't the
new format).  Also, the actual implementation may want to be a bit
more strict, i.e. saying "we allow refs/ to be a searchable
directory, and we also allow a readable regular file".

Thanks.


