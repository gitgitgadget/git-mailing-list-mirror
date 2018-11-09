Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CB0C1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 05:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeKIO5o (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 09:57:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58163 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbeKIO5o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 09:57:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92AF31119B0;
        Fri,  9 Nov 2018 00:18:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=h+daxSBkC6a8hvBgXdb/CLg1y
        dI=; b=c3XY/u7GKdZ/eRJn7K66nLzuKdcdjI+FHMgJlhO3qGJcHbcty//Me1h/I
        jhTfdQuDDQsTEIwRJpbK5kaX7AEIlfLFPiDOTD9ZYsPeoAm2nOpevN01WKU0+eK5
        sDbe2bTrYYHUWIdChzFqoAs0dJ80QjRczpHcOsFjP2XFXV9bOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=QZ9OVNHsRnufU4I+au6
        9hM/vn3x/qBgJPhLA88xQcFQQmaXspRK5szr9UlJgJZW2S0LmVqvH9IQXbzZb9HK
        6T3IhkuIlfHfFil+v+Jg4CEqlEDcAxX+SWQEMMxsJCQxg/4AC9NlaJJ9qv+y+6bH
        VZRXoHmcnztFv8pVLkKDJsmg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 89D3D1119AF;
        Fri,  9 Nov 2018 00:18:48 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDD5E1119AD;
        Fri,  9 Nov 2018 00:18:47 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, szeder.dev@gmail.com
Subject: Re: [PATCH] Makefile: add pending semantic patches
References: <20181030220817.61691-2-sbeller@google.com>
        <20181108205255.193402-1-sbeller@google.com>
Date:   Fri, 09 Nov 2018 14:18:46 +0900
Message-ID: <xmqqzhui4ymh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EFC77FF8-E3DE-11E8-BB25-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> From: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
> Add a description and place on how to use coccinelle for large refactor=
ings
> that happen only once.
>
> Based-on-work-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> I consider including this patch in a resend instead.
> It outlays the basics of such a new workflow, which we can refine later=
.

Thanks for tying loose ends.

> diff --git a/contrib/coccinelle/README b/contrib/coccinelle/README
> index 9c2f8879c2..fa09d1abcc 100644
> --- a/contrib/coccinelle/README
> +++ b/contrib/coccinelle/README
> @@ -1,2 +1,62 @@
>  This directory provides examples of Coccinelle (http://coccinelle.lip6=
.fr/)
>  semantic patches that might be useful to developers.
> +
> +There are two types of semantic patches:
> +
> + * Using the semantic transformation to check for bad patterns in the =
code;
> +   This is what the original target 'make coccicheck' is designed to d=
o and
> +   it is expected that any resulting patch indicates a regression.
> +   The patches resulting from 'make coccicheck' are small and infreque=
nt,
> +   so once they are found, they can be sent to the mailing list as per=
 usual.
> +
> +   Example for introducing new patterns:
> +   67947c34ae (convert "hashcmp() !=3D 0" to "!hasheq()", 2018-08-28)
> +   b84c783882 (fsck: s/++i > 1/i++/, 2018-10-24)
> +
> +   Example of fixes using this approach:
> +   248f66ed8e (run-command: use strbuf_addstr() for adding a string to
> +               a strbuf, 2018-03-25)
> +   f919ffebed (Use MOVE_ARRAY, 2018-01-22)
> +
> +   These types of semantic patches are usually part of testing, c.f.
> +   0860a7641b (travis-ci: fail if Coccinelle static analysis found som=
ething
> +               to transform, 2018-07-23)

Yup, and I think what we have in 'pu' (including your the_repository
stuff) falls into this category.

I've been paying attention to "make coccicheck" produced patches for
the past few weeks, and so far, I found it _much_ _much_ more
pleasant, compared to having to worry about merge conflicts with the
topics in flight that changes day to day (not just because we add
new topics or update existing topics, but also the order of the
merge changes as topics mature at different rates and jumps over
each other in master..pu history), that "make coccicheck" after
topics are merged to integration branches fixes these issues up as
needed.

> +   3) Apply the semantic patch only partially, where needed for the pa=
tch series
> +      that motivates the large scale refactoring and then build that s=
eries
> +      on top of it.

It is not quite clear what "needed for the patch series" really
means in the context of this paragraph.  What are the changes that
are not needed, that is still produced if we ran "make coccicheck"?

Are they wrong changes (e.g. a carelessly written read_cache() to
read_index(&the_index) conversion may munge the implementation of
read_cache(...) { return read_index(&the_index, ...); } and make
inifinite recursion)?  Or are they "correct but not immediately
necessary" (e.g. because calling read_cache() does not hurt until
that function gets removed, so rewriting the callers to call
read_index() with &the_index may be correct but not immediately
necessary)?

> +      By applying the semantic patch only partially where needed, the =
series
> +      is less likely to conflict with other series in flight.

That is correct.

> +      To make it possible to apply the semantic patch partially, there=
 needs
> +      to be mechanism for backwards compatibility to keep those places=
 working
> +      where the semantic patch is not applied. This can be done via a
> +      wrapper function that has the exact name and signature as the fu=
nction
> +      to be changed.

OK, so this argues for leaving read_cache()-like things to help
other in-flight topics, while a change to encourage the use of
read_index() takes place.  That also makes sense, and this directly
relates to "less likely to conflict" benefit you mentioned above.

But it is still unclear to me then what are "necessary".

... goes and thinks ...

OK, so a series that allows a codepath to work on an arbitrary
in-core istate, for example, may need to update a function to take
istate and use it to call read_index(istate...), and the old code in
such a call chain must have used read_cache(), always operating on
&the_index.  For the purpose of that series, it does not matter if
other codepaths that are not involved in the callchain the series
wants to update are still only working on &the_index, so a change to
turn read_cache() into read_index(&the_index) is *not* necessary
(but still would be correct) and should be left out of the series.
But any change the series makes to the callchain in question that
turns read_cache() into read_index() with something call-specific
(not &the_index) is a necesary one.  Is that a reasonable example
of what these paragraphs wanted to convey with the distinction
between "needed for the patch series" and other changes?

