Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5370B1FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 20:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756203AbcH2UDP (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 16:03:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63945 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752296AbcH2UDO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 16:03:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9E4E39CC4;
        Mon, 29 Aug 2016 16:03:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2oTyr/+xmrfi+T239ufUVqL9/dc=; b=HnQgOJ
        Oxbu4sNRb37Zf1LGsj7PEsYLZD+2yFq2tyAm+wztpj9qc7zWwlYa9tzHHgvUheQA
        KOvQau67ykJu2SPyALLiaHyLD0LS+SpilteABkd+Vt+Z50+w+rTPKOqY77p0Ec1F
        qjXs9fBNnFdvKUmn2LxuFfUFAmACTHHBiDHYw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WUHnLGGbxfzj/j6maGYF5LLXR9IDzJfr
        VvAK8hD7GrWGcHWMcW9lgE+nglqgWoTyJ6Rz7SRfmQrFQUkU1t6d6Fk0FjMfwd68
        htJfOX4a4BL6JS1WIXyd0cVZGsccfxL290Ry/y2WCZWFJJ3YPkJHWxaTTGZHti95
        YpBUXi7XwWk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1F1239CC3;
        Mon, 29 Aug 2016 16:03:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EEFB39CC1;
        Mon, 29 Aug 2016 16:03:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uma Srinivasan <usrinivasan@twitter.com>
Cc:     git@vger.kernel.org
Subject: Re: git submodules implementation question
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
Date:   Mon, 29 Aug 2016 13:03:10 -0700
In-Reply-To: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
        (Uma Srinivasan's message of "Sun, 28 Aug 2016 16:24:54 -0700")
Message-ID: <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D56F89E-6E23-11E6-837F-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Uma Srinivasan <usrinivasan@twitter.com> writes:

> git_dir = read_gitfile(buf.buf);
> if (!git_dir)
>
>                 git_dir = buf.buf;
>
> Can anyone explain to me why we are replacing a failed reading of a
> git file with the original sub directory name?

A top-level superproject can have a submodule bound at its "dir/"
directory, and "dir/.git" can either be a gitfile which you can read
with read_gitfile() and point into somewhere in ".git/modules/" of
the top-level superproject.  "dir/.git" can _ALSO_ be a fully valid
Git directory.  So at the top of a superproject, you could do

	git clone $URL ./dir2
        git add dir2

to clone an independent project into dir2 directory, and add it as a
new submodule.  The fallback is to support such a layout.

