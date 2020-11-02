Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACCCC388F9
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C88522268
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LdPK36Ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgKBSzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:55:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54642 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKBSzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:55:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF2288DB53;
        Mon,  2 Nov 2020 13:55:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=yiWvaF+n8EsYrOEp3Rq6YNWeHd4=; b=LdPK36EvLY9a4IbgqO2Y
        iLa4ozdp4kz0vmZoHmLmcUBmHpSkqApC6CLM7KxvucMvl5zEO7EfwBUr27t+ErH/
        p2T6ab9343Esvpa4p8Et1iYyBgkopdY+x3cIFaATyR/U9m/AWMTV+l1ni4yRqaTg
        rugS6Y5W4yd/SNPXw4M0eOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=rEHKzGY5m6KKaMBQB9SkT9fPcMHl5/r38HsFTMHLqVev13
        O+WJAJY0DtNCHIlgERb3MTLmwNe0Pb7VM6lvawrCCY8cPBQgTLXHH6jA+mfrMviF
        whwTJj7HCnYUYB7XVzDpWjC8QExg4M4W5bO9YGMFqTHx2I5Ra1wuiBX5nUDTY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9BE928DB52;
        Mon,  2 Nov 2020 13:55:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1A10E8DB51;
        Mon,  2 Nov 2020 13:55:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: enable -Wsparse-error for DEVELOPER build
References: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
        <xmqqsg9uxchb.fsf@gitster.c.googlers.com>
        <6676a08d-0c25-14ba-4ea6-677bc7ab0e20@ramsayjones.plus.com>
Date:   Mon, 02 Nov 2020 10:55:18 -0800
Message-ID: <xmqqh7q7vbah.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3D92BCA-1D3C-11EB-AFE2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Yes, anybody who just does 'make sparse' will notice the failure, so
> that would be a definite improvement. (How many people run 'make sparse'
> though?).

At least, I was planning to add one to the number when I wrote the
patch, so that I would start using it as part of daily integration
build before pushing day's result out.

I can tweak my $(MAKE) command line arguments in the script I use
for daily integration builds, so the patch is not strictly needed
for me personally.

> I guess it would be most useful on a CI build, but I don't know what
> would be involved in setting that up.

CI builds already have enough stuff around invocation of "make test"
etc., and it would be trivial to pass SPARSE_FLAGS from the command
line when adding "make sparse" invocation to one of the scripts in
ci/ directory, so from that point of view, this patch is not needed
for them, either.

My hope was that it would make it harder for individual contributors
who run "make sparse" and fail to notice an error from it.
