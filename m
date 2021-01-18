Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9258EC433E9
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A1222DA9
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 21:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394751AbhARVcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 16:32:13 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58951 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394734AbhARVb7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 16:31:59 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D03F112442;
        Mon, 18 Jan 2021 16:31:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/UxjeB+qFAAM
        gSNQnkmoAuuYBrI=; b=KQdMLtLGQfb1ZfCvmSDBiTAGrXxtm+C7HlfxZlv4B/gQ
        L3cVMph/NY2DBpOHGVEqoLzvkycFb0kWyNsqZmt9tb4H1YbhoNmL3NMai2DYh/Nm
        7kCudPFl02yklvwEEFs9HHPWLBCAdKyY0DmNEMNVti6ZE3p95den1DFC90It/ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IB8LDR
        +Cb59zWocSoBiJP+Nos3xyDZmYq3NjsK/wzmMg7pGcvKEWjjEeRR2BhoGj2kVb8c
        LnrYkhNWKm1kWtLGV1UYXWXN/v0stZKhOkb5KsmqzXoaNKW3rP7hQlP4rq/NIuVf
        3TrA2Z9skIxTzRdcBmr/OR0BU1swIy4JycWxI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41E7A112441;
        Mon, 18 Jan 2021 16:31:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 41741112440;
        Mon, 18 Jan 2021 16:31:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/3] ls-files: add --deduplicate option
References: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
        <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <0c7830d07db0aa1ec055b97de52bd873d05e3ab1.1610856136.git.gitgitgadget@gmail.com>
        <xmqqbldnkuja.fsf@gitster.c.googlers.com>
        <CAOLTT8Syp2ZeTXW-m+e=dn2W773nScB_kwZLS3MjLTcFQ_bctw@mail.gmail.com>
        <CAOLTT8QnhNqnJCgiqOZnd9cjxicAuk2Js1GKdHEJD_XK15UU+Q@mail.gmail.com>
Date:   Mon, 18 Jan 2021 13:31:11 -0800
In-Reply-To: <CAOLTT8QnhNqnJCgiqOZnd9cjxicAuk2Js1GKdHEJD_XK15UU+Q@mail.gmail.com>
        (=?utf-8?B?IuiDoeWTsuWugSIncw==?= message of "Mon, 18 Jan 2021 14:05:53
 +0800")
Message-ID: <xmqqczy2j5k0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7D2AA204-59D4-11EB-9E82-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=E8=83=A1=E5=93=B2=E5=AE=81 <adlternative@gmail.com> writes:

> Here I am thinking about the role of this "--deduplicate" is to
> suppress duplicate filenames rather than duplicate entries. Do you
> think I should modify this sentence?
>
>> > OPT_BOOL(0,"deduplicate",&skipping_duplicates,N_("suppress duplicate=
 entries")),

I see no strong need to.  One set of output entries from "ls-files"
may say

    $ git ls-files -u
    100644 536e55524db72bd2acf175208aef4f3dfc148d41 1	COPYING
    100644 536e55524db72bd2acf175208aef4f3dfc148d43 3	COPYING

and these three "entries" are not duplicates.  Another set of output
entries may say

    $ git ls-files COPYING
    COPYING
    COPYING
    COPYING

and these output entries are duplicates.  If you deduplicate the
latter but not the former, then "suppress duplicate entries" is
exactly what you are doing, I would think.

And if you are asked to show entries that would look like this in a
not-deduplicated form:

    $ git ls-files -u
    100644 536e55524db72bd2acf175208aef4f3dfc148d41 1	COPYING
    100644 536e55524db72bd2acf175208aef4f3dfc148d41 1	COPYING
    100644 536e55524db72bd2acf175208aef4f3dfc148d43 3	COPYING

"suppressing duplicates" would give us the first entry and drop the
second entry that is identical to the second entry, I would think
[*1*].

So "duplicate entries" would probably be more correct description of
what we want to happen than "duplicate filenames".


[Footnote]

*1* Multiple "common ancestor" versions at stage #1 for the same
    path is not an error.  That is how "merge-resolve" expresses
    criss-cross merge where multiple merge-bases exist.

    Multiple "their" versions at stage #3 for the same path is not
    an error, and "merge-octopus" should use it to express contents
    from histories being merged into ours, but the implementation of
    the octopus strategy does not use this feature of the index.

    Multiple "our" versions at stage #2 by definition should not
    happen ;-)
