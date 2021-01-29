Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F488C433DB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0CD64DFB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 22:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhA2Wzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jan 2021 17:55:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56620 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhA2Wzc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jan 2021 17:55:32 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41971A1C39;
        Fri, 29 Jan 2021 17:54:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+Z/UlQE0q/vZ
        KwRu8YyUBQ3DBQI=; b=oMzsMJft6Q9tTTCAjsbqnuuWVkpCG+OLLKxkPUqC4h1q
        OJxulHnLV8afgNt2geaKeGr4UdCWpzPhTXdj8eJ7dN/D8tVT2cmg+FqYLOxrhj1B
        vaEDPQrABokiVdDqJlf6UK3mJFIfLnB+iuNb9ycK30KVe2b3v+QK3EcyvgVi+Uw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DtpHyg
        6unOJx0IP1IWUSbBHMHUrBJSMcdJO/Q4WX9QjKnjcvdv2k0DGujriiDJgvIVqBWD
        XBwZw2ECeV4OA2RoGYASNZEwKsbilTJapDK2xPWsgjF4ga9ruK/D9//yUB0usue9
        XvFzVIiNC+x0WTfN+PFgOJQz+9BmWtRkHfeRc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38D01A1C38;
        Fri, 29 Jan 2021 17:54:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6B7DA1C37;
        Fri, 29 Jan 2021 17:54:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Colton Hurst <colton@coltonhurst.com>
Cc:     git@vger.kernel.org
Subject: Re: Git Conditional Includes Question (possible bug?)
References: <1E4AB5E8-DD46-45CA-9A3F-C49F115BE0D4@coltonhurst.com>
Date:   Fri, 29 Jan 2021 14:54:48 -0800
In-Reply-To: <1E4AB5E8-DD46-45CA-9A3F-C49F115BE0D4@coltonhurst.com> (Colton
        Hurst's message of "Fri, 29 Jan 2021 16:21:44 -0500")
Message-ID: <xmqqlfcbs69z.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FDBA3F70-6284-11EB-B258-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Colton Hurst <colton@coltonhurst.com> writes:

> [Expectation] When I run `cd ~/colton/github/coltonhurst.com`
> (this is a valid git repo) and then run `git config user.email`, I
> expect =E2=80=98colton@coltonhurst.com=E2=80=99 will be returned.
>
> [Actual Result] When I run `cd ~/colton/github/coltonhurst.com`
> (this is a valid git repo) and then run `git config user.email`,
> nothing is returned.

The relevant part of the per-user config are

> [user]
> 	name =3D Colton Hurst

This is not conditional, and applies when you are in the repository.

> [includeIf "gitdir:~/colton/github"]
> 	path =3D ~/colton/github/.gitconfig

This is conditional, and applies when you are in a repository whose
".git" location matches the glob pattern "~/colton/github".  The
location in question is "~/colton/github/coltonhurst.com", which
does not match the pattern, so it would be skipped.

> [includeIf "gitdir:~/colton/sourcehut"]
> 	path =3D ~/colton/sourcehut/.gitconfig

Likewise.

So, nobody sets user.email in your example.  Isn't it expected that
nothing is returned?

I wonder what happens when the second one is updated to

> [includeIf "gitdir:~/colton/github/"]
> 	path =3D ~/colton/github/.gitconfig

as "git config --help" says:

 * If the pattern ends with `/`, `**` will be automatically added. For
   example, the pattern `foo/` becomes `foo/**`. In other words, it
   matches "foo" and everything inside, recursively.

and "~/colton/github/**" as a pattern would match the path to the
repository in question.

