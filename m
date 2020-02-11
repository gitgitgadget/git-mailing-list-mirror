Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF17C352A3
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3186320848
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 16:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yPQz+QYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgBKQcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 11:32:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55158 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgBKQcC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 11:32:02 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 913024B9BC;
        Tue, 11 Feb 2020 11:31:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yNZHDKyNk9hQ/Y4Ryhby82dtUU8=; b=yPQz+Q
        YOAtAcgWIRKn1lAYG0RsJ7V0jazql8A/PUO7TNlNGo/ywgaiyV8x7ETSP03VYHgi
        1N0QaFGRQZJ4d0HKmZOdhboYU5WCc7C9aidRMsNERFmynZCYVC7Zzlzpr9xFQAE4
        Nmg4DUTKwjc+G53m9B9cuSCc2wye24zJ4PgL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DhbcxHkKaYi2he2/eIpp24WWsgP+nWi2
        aSsFUKB/Uw2ZmD5OOLxWsrXBoCy2sprSdDUnTINwqECso50wmWNP2rqmKlJZQddS
        JOPgmPXfueW6dZEnLXYrXsf4rgFMF9yxfOnUrpMiC3cQhx5Nyeugf5NHbnWqAQZE
        IJ1HLW7xod4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 87B8E4B9BB;
        Tue, 11 Feb 2020 11:31:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E09474B9BA;
        Tue, 11 Feb 2020 11:31:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v4 4/5] Add reftable library
References: <pull.539.v3.git.1580848060.gitgitgadget@gmail.com>
        <pull.539.v4.git.1581029756.gitgitgadget@gmail.com>
        <02d2ca8b878a67a3334b222725645dd035b4289c.1581029756.git.gitgitgadget@gmail.com>
        <20200207001612.GF6573@camp.crustytoothpaste.net>
        <CAFQ2z_P+sdd5+46Ov_CO8ae4j_3aA4ahdVR5D_K1qKSQ-q+OcQ@mail.gmail.com>
        <20200211000520.GA6454@camp.crustytoothpaste.net>
        <CAFQ2z_N1sYh1TBzKue5y0039xQ+F6BBEUcFYCXS_OKjoxJ7v_g@mail.gmail.com>
Date:   Tue, 11 Feb 2020 08:31:55 -0800
In-Reply-To: <CAFQ2z_N1sYh1TBzKue5y0039xQ+F6BBEUcFYCXS_OKjoxJ7v_g@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Tue, 11 Feb 2020 15:20:16 +0100")
Message-ID: <xmqqwo8tw0ec.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0513D59C-4CEC-11EA-A96E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> I've uploaded https://git.eclipse.org/r/c/157501/ that proposes a way
> to encode the hash size. I  look forward to feedback.

Development and design discussion happens here.  Please do not
require people to go click at an external website---once people
start doing so, we'd have to go around 47 different places to piece
one discussion together, which is just crazy.

Here is what I saw:

    A 24-byte header appears at the beginning of the file:

        'REFT'
        uint8( format_version )
        uint24( block_size )
        uint64( min_update_index )
        uint64( max_update_index )

    The `format_version` is a byte, and it indicates both the version of the on-disk
    format, as well as the size of the hash. The hash size is indicated in the MSB
    of the `format_version`. For the SHA1 hash, `format_version & 0x80 == 0` and all
    hash values are 20 bytes. For SHA256, `format_version & 0x80 == 1`, and all hash
    values are 32 bytes. Future hash functions may be added by using more bits at
    the right.

    The file format version can be extract as `format_version & 0x7f`. Currently,
    only version 1 is defined.

If you cast in stone that "& 0x7f is the way to extract the
version", then you cannot promise that you may steal more bits at
the right of MSB to support more hash functions, as you've reserved
the rightmost 7 bits already for the version number with 0x7f and
there are only 8 bits in your byte.

It seems that you are trying to make the format too dense?  Is it
too much a waste to use a separate word or a byte for hash?  Or
perhaps declare that format version 1 uses SHA-1, format version 2
uses SHA-256, etc. (in other words, do we want to support both SHA-1
and SHA-256 when we are at format version 7)?

Thanks.





