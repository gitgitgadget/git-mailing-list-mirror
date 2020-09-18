Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EA4C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D888208C3
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 16:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lfmX2roW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIRQwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 12:52:46 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60583 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIRQwq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 12:52:46 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 134E2F91FA;
        Fri, 18 Sep 2020 12:52:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=85xGqgUSWDyieh/JWQ9w3A1sZ88=; b=lfmX2r
        oW/Jk2nFESIBJL4y9kNEVnp+dEhBjni+Mm3eD4jw5Dcc7HFL07/Sg6j2QQ69l70+
        J2H3vMGcMtZRt7qPIaRtuy/QzOqRluCFal6D03WjjbderzyW7uBHk8W8VshJNOmq
        PFYaMaaTN0iAKli/twi2XuhAyvQBLgxNYx65A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K/U14uHUkbcyhuIxjs1izyYLdRImpTz3
        Tj6Euj4XKMCn3fBZU+/1MvbGh96FPI3USZq+XZNpJyA5mnZJzZDkpfLDoQrhM98v
        MChL4VZXDf8Prgkdd8QhWng+8dXcELNBDGRMtjA2lH99E8kHu0SwwuYlkvtg+h4x
        B1QzP4N2RaU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 09F1FF91F9;
        Fri, 18 Sep 2020 12:52:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 52E86F91F8;
        Fri, 18 Sep 2020 12:52:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v3 09/10] builtin/diff-tree: learn --merge-base
References: <cover.1599723087.git.liu.denton@gmail.com>
        <cover.1600328335.git.liu.denton@gmail.com>
        <c0d27b125e969e13c52b0fa806a8e3caa8c20ac6.1600328336.git.liu.denton@gmail.com>
        <xmqq363gs1mt.fsf@gitster.c.googlers.com>
        <20200918104833.GB1874074@generichostname>
Date:   Fri, 18 Sep 2020 09:52:39 -0700
In-Reply-To: <20200918104833.GB1874074@generichostname> (Denton Liu's message
        of "Fri, 18 Sep 2020 03:48:33 -0700")
Message-ID: <xmqqy2l7m3hk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DAF7CF2-F9CF-11EA-ABE4-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Since we're only interested in the oids, I thought that it would be
> possible to save a lookup_object() and just use the oids directly. If
> it's clearer, this can be written as something like this but the lookup
> feels unnecessary:

When running the tree diff, we'd need the object anyway, and the
result of the look-up made here is cached, right?

That is why I expected it would just be an insertion before the
existing code, like the other side.

But the existing "if we got either ^A B or B ^A, treat it as A..B"
logic is just like "if we got '--merge-base A B', treat it as
something else" we are adding, and they (and any future such special
syntax) should not interact with each other.  So in that sense, the
code structure you have in the originally posted patch (not the code
snippet in your message I am responding to) that does

    ...
    if (using merge-base feature) {
	do the merge base thing to populate oid[]
    } else if (user used A..B) {
	ensure "^A B" and "B ^A" both have A in oid[0] and B in oid[1]
    }
    ...
    call diff-tree between oid[0] and oid[1]

makes a lot more sense than anything else we discussed so far.

I wonder if turning the builtin/diff-tree.c to match that structure
make the result easier to understand (and I'll be perfectly happy if
the answer to this question turns out to be "no, the result of the
posted patch is the easiest to follow").

Thanks.

