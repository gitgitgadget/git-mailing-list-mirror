Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC949C3F2CD
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B404E20722
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xwx6pt7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgCWRlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:41:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61312 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWRlX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 13:41:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BA46428C9;
        Mon, 23 Mar 2020 13:41:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xtaioxNAfH3r
        a8iGmHZd7T5Z+1M=; b=xwx6pt7TUyFwoCdeFVZg3bgBPYhrL13Sgtrv0ulPkkMl
        lU9Z2TFyxxp9jrJ6Mwr7omu1+vt1NvxFdPsJxQXuPgy/MEbgPq4PDcQH4+NJWjTI
        YAc3Eyyz1j1C92+A4tmAR5i+1tC9BJMHzTHCC5VydCRxwU4o3F5R97uClcmLbzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=doyQHX
        y3W9nV4/UFQCAu3DYn3nRruBw/RFyt/JBemuVLVD32XhEilx/c7bJyE4ph64I310
        mCSdNfyhnyZcL0+gDFHPx/hOOBii/0FXnNXHNTUsOOHRrM+SBfPiaav7KhBZdTbU
        tPsJV5gUczdhcti0zczPpgEVpa+QZS1MPkfrU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41B93428C8;
        Mon, 23 Mar 2020 13:41:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B4D7C428C7;
        Mon, 23 Mar 2020 13:41:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] import-tars: ignore the global PAX header
References: <pull.577.git.1584968924555.gitgitgadget@gmail.com>
        <fce519db-5ad4-270f-abcf-0e26549486cb@web.de>
Date:   Mon, 23 Mar 2020 10:41:20 -0700
In-Reply-To: <fce519db-5ad4-270f-abcf-0e26549486cb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Mon, 23 Mar 2020 18:09:39 +0100")
Message-ID: <xmqqh7yf55q7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 81D7E56C-6D2D-11EA-A462-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 23.03.20 um 14:08 schrieb Johannes Schindelin via GitGitGadget:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> Git's own `git archive` inserts that header, but it often gets into th=
e
>> way of `import-tars.perl` e.g. when a prefix was specified (for exampl=
e
>> via `--prefix=3Dmy-project-1.0.0/`, or when downloading a `.tar.gz` fr=
om
>> GitHub releases): this prefix _should_ be stripped.
>>
>> Let's just skip it.
>
> git archive uses a global pax header to pass the ID of the archived
> commit as a comment, and for mtime values after 2242-03-16.  Ignoring i=
t
> in a simple importer seems reasonable for now, but I don't understand
> how this relates to prefixes.  Is it because the header is treated as a
> regular file with the full path "pax_global_header" (independently from
> any prefix for actual files) and can thus be placed outside the expecte=
d
> destination directory?

Thanks for asking the question, as I was also curious if we are
throwing away too much (perhaps "prefix is given as a global pax
header, and ignoring all global pax headers is the most expedite
way" was the reason the patch was written that way?).  I agree with
you that for the purpose of simple-minded importer, it probably is
acceptable to take such a short-cut, but it would help future
developers if we clearly documented that it is a short-cut that
throws too much.  That would welcome their effort to enhance the
importer, if they find it more useful to keep some other information
found in global headers, without breaking the intent of this change.

Having said all that, even before "git archive" existed, release
tarballs by many projects had leading prefix so that a tarball
extract would be made inside a versioned directory.  To truly help
users of the importer, doesn't the logic to allow the user to say
"please strip one leading level of directory from all the tarballs I
feed you, as I know they are versioned directories" belong to the
command line option of the importer?

