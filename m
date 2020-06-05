Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10A1C433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 00:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0E42074B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 00:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vF65274r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgFEA4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:56:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56599 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFEA4o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 20:56:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A201CC6637;
        Thu,  4 Jun 2020 20:56:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XSHcWT7UNxbYlC4degAxYChl6xE=; b=vF6527
        4rEiC/B9M7bubVIFqPFp/l5eMAngdBVpOkengxtIC1NtNYcDv9C2yDji7DJFm/7U
        TNx7lT+V1t+uDbWC4ytS2eaHA1qdVm3gD7XSbXlcbAwCDuuPTS7u4v1NuxmVcMV4
        fxYEjIsjF51B9WpYluR28cMXfgBETzOBo+3S0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uoy6wM+KlaJzoz9Cbqh4N7tvbeLsxLnn
        XKKrRFgrANXbiM1+7W23rIjct/Gp5WjpD7YjZg4Gs343xgqT76KnpMLbRg8Z5RIE
        Sece3G5fdAXijCOJQEPAbH3WEvAjIwW3rZ0okCnBCWxWGUiL2cl/0LvT1lQ0lxi9
        0n0UK4QTD2A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98756C6636;
        Thu,  4 Jun 2020 20:56:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D9042C6630;
        Thu,  4 Jun 2020 20:56:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Shaun Case <warmsocks@gmail.com>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible regression for sparse-checkout in git 2.27.0
References: <CAD3+_6CUX0RPr-dgfUnfGDNNfqu80SYCskioYnu=MS6aJv2dEQ@mail.gmail.com>
        <CABPp-BGvc3GZfFuiXaqDk6391ZexQ7D3x9gr5JK6-L+rDQQ4sg@mail.gmail.com>
        <c1f9d76a-bf39-8508-1f4f-b34be77450a0@gmail.com>
        <CABPp-BHyDUrOLg6-VONewbmXNFHUvKoDXfRTLgg8aEhJFtJLuQ@mail.gmail.com>
        <CAD3+_6AK390F5iVqCmP-FY8MxJtcUoS7HsbunhZ0qNzOdT53CQ@mail.gmail.com>
        <0aab7056-7176-01bc-ca7b-01356cbace4c@gmail.com>
Date:   Thu, 04 Jun 2020 17:56:37 -0700
In-Reply-To: <0aab7056-7176-01bc-ca7b-01356cbace4c@gmail.com> (Derrick
        Stolee's message of "Thu, 4 Jun 2020 20:32:42 -0400")
Message-ID: <xmqqtuzqnxdm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A38DECE-A6C7-11EA-80F6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> The first is due to the .gitignore syntax. The syntax allows exact
> matches for _directories_ using a trailing slash "/". For example,
> we can match everything in A/B/C with the pattern
>
> 	A/B/C/
>
> This would match the files in A/B/C/ and its subdirectories, but will
> not match a file A/B/C.txt or A/B/C1/. There is no equivalent matching
> for files, so A/B/C _will_ match a file A/B/C and A/B/C.txt. Whether this
> matters to you or not depends on your file structure.

The pattern A/B/C _will_ match a file A/B/C and a directory A/B/C/,
but I do not think it matches a file A/B/C.txt (or a path with any
other suffix).

I suspect that for the purpose of your explanation, the pattern
A/B/C does not have to match A/B/C.txt to cause trouble; the fact
that it matches directory A/B/C would be sufficient, I guess.
