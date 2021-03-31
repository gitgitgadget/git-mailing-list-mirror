Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286B2C433ED
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E907A61056
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 23:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCaXEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 19:04:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50653 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhCaXEa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 19:04:30 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6BD511FDC5;
        Wed, 31 Mar 2021 19:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Qoi/A0cgY4Sd
        KqKcRrxlL+3mHZ8=; b=KTVc3vBBHCQMmwSfxqnbeNjMVpRGGGsRXZrjDbxu1KW2
        d2SKYhtgE/t9iKH1u4XhqZzR/PisgHlogZvxbaHlp05VIqiN88R0V7lIgZotdyRN
        ZZnb6FlNRK5h+CCV/gxLxazjcGJ9gqJ6mp4IEfXIjLWX8K9EHxrwzaEzjy3eU3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YAq0pw
        BZx7BlWFC6UKfoLIdEAmVZzzh/rjcNN+jeNiCerWlprRJuodnRv5n/aVSAARVFZu
        IqC7zS3eJvzjd0oPG42oJNoCX4ke5EIBMBqhQ/cm4jqVSlSP9GPZ7VoCjLLEKEhe
        dtPxqnOye6uhLYMnXT1+jGbdHmuTYOj/5LBb8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DEFAA11FDC4;
        Wed, 31 Mar 2021 19:04:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2527711FDC2;
        Wed, 31 Mar 2021 19:04:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 05/18] mktree tests: test that "mode" is passed when
 sorting
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
        <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
        <patch-05.19-b3289f7bbe5-20210331T190531Z-avarab@gmail.com>
Date:   Wed, 31 Mar 2021 16:04:25 -0700
In-Reply-To: <patch-05.19-b3289f7bbe5-20210331T190531Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 31 Mar
 2021 21:09:33
        +0200")
Message-ID: <xmqqa6qj53ie.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 711FCD5C-9275-11EB-B1AD-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a test for the mode being passed to ent_compare(). That code dates
> back to 83f50539a9 (git-mktree: reverse of git-ls-tree., 2006-02-20)
> and there's never been a test for that particular edge case. Now we
> have one.
>
> I don't see how anything could run into this in practice. In order for
> that mode sorting to matter as a tiebreaker we need to have a
> duplicate entry in the tree, i.e. two "foo" entries, one a blob and
> one a tree. This asserts that if that happens we'll sort on the modes
> we encounter in such an invalid entry, i.e. we expect the tree entry
> before the blob.

It is more like "in a tree with 'foo.' and 'foo0' (both of which are
blobs), a 'foo' that is a tree should appear after 'foo.' and before
'foo0', because it sorts as if it were 'foo/'.  If 'foo' is a blob,
it sorts the first before 'foo.' and 'foo0'". =20

Checking a broken tree with both 'foo' (blob) and 'foo' (tree) that
does not even pass fsck is not very valuable, but the sort order of
these two trees (i.e. one with foo as tree, the other with foo as
blob) do need to be tested, as the unpack_trees merge machinery will
need to walk such pair of trees correctly.

Thanks.
