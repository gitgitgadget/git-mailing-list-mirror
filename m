Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA75C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 01:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A17223EA
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 01:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BRaLry9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgKDBMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 20:12:47 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59844 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbgKDBMr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 20:12:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 56141F01E4;
        Tue,  3 Nov 2020 20:12:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JpUtzxVBFTH7
        dELkHijaWLuQnBc=; b=BRaLry9OD2scwXUYiu//l+G8KihIhKC2dJ8u6kYRSrkh
        mA4gZ9Fu1xy+qdkwnXOWw0AtYsTWGnTeqOdiihr2utoayPDMpC6U7jIslOuBr9XP
        vdry9a6wuRhZJdDczHG7k/D3uRalHtOc+gxE7LRuxpp7PrJgSmFwaT72ThagROA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iL3Rpu
        OeM6Rd8f3kzWRU9nuYsaMBjz/ECXilUzvWifFxSVyjtCGPaxWOE1+iIA5KaKkWqH
        ZfOHEsB4cpEmbffyYxE5EjV7cNc4aZcSoJCFOXggNCtVflgnm3AIcxpzv54oh3AQ
        fof3J9X0W0S9pEbEwRceq5t9VbpeOQQUTIfrY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E2E3F01E3;
        Tue,  3 Nov 2020 20:12:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9AE30F01E1;
        Tue,  3 Nov 2020 20:12:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?M=C3=A1rio_Guimar=C3=A3es?= 
        <mario.luis.guimaraes@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug with --abbrev option in git log?
References: <CAF7CYk51BC0KcsBb0KjKWAj17AMU2c9Y6Y81ddwX6oOAFYhT8w@mail.gmail.com>
Date:   Tue, 03 Nov 2020 17:12:42 -0800
In-Reply-To: <CAF7CYk51BC0KcsBb0KjKWAj17AMU2c9Y6Y81ddwX6oOAFYhT8w@mail.gmail.com>
        (=?utf-8?Q?=22M=C3=A1rio_Guimar=C3=A3es=22's?= message of "Wed, 4 Nov 2020
 00:55:36 +0000")
Message-ID: <xmqqk0v1q60l.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D772384C-1E3A-11EB-8178-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

M=C3=A1rio Guimar=C3=A3es  <mario.luis.guimaraes@gmail.com> writes:

> In the Git repository run this command:
>
> git log --raw -r -c --abbrev=3D6 --pretty=3Doneline -n1
> a7144d4bc5ab58f306a1e5c73b27196fb999a63d

This is not one of my object, so above won't be usable as
reproduction recipe.  But that is OK.

> What did you expect to happen? (Expected behavior)
>
> I was expecting to get this line in the output
>
> ::100644 100644 100644 639a41 111378 05ba1d MM Documentation/git-rebase=
.txt
>
> What happened instead? (Actual behavior)
>
> I got the following line instead
>
> ::100644 100644 100644 639a41 111378 05ba1d3 MM Documentation/git-rebas=
e.txt

The above command tells us that you locally have an object whose
name begins with 05ba1d3, which I do not have.  But my history
shared with the entire world has an object whose name begins with
05ba1d7, and I am reasonably sure that your repository has it, since
it is a part of 17f26a9e (git-am: fix shell quoting, 2009-01-14).

So in my repository, 05ba1d is enough to uniquely identify 05ba1d7,
but in your repository 05ba1d is not enough to uniquely identify
05ba1d3, because 05ba1d7 also exists in your repository.  And when
the object cannot be uniquely specified with the given abbreviation
width, Git makes sure its output is usable to uniquely identify the
object it wants to name.

In short, I think what you observed is totally expected.

The documentation has some room for improvement, I also think.

How about saying something like this?



 Documentation/diff-options.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git i/Documentation/diff-options.txt w/Documentation/diff-options.=
txt
index ee52b65e46..114e440c5b 100644
--- i/Documentation/diff-options.txt
+++ w/Documentation/diff-options.txt
@@ -446,7 +446,8 @@ endif::git-format-patch[]
 --abbrev[=3D<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
-	lines, show only a partial prefix.
+	lines, show only a partial prefix that uses at least '<n>'
+	hexdigits.
 	In diff-patch output format, `--full-index` takes higher
 	precedence, i.e. if `--full-index` is specified, full blob
 	names will be shown regardless of `--abbrev`.
