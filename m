Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A35C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803CB6054E
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 21:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhJVVen (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 17:34:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53042 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhJVVem (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 17:34:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 53670E08D4;
        Fri, 22 Oct 2021 17:32:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dQ7pLhAaBlvF
        FGNSQnQVEKUh9oFJAZBLFsaCsuiWfIo=; b=phgIgMF3x2/JBVphodgLxtXH+PYm
        1t9eNkQzDRbOoyEccHpjtQRuYME3bKhGweKHbiXDU2uRkNzvCzr7zAX9B5Z6fqa2
        dctZGmvKi0HeEpuuciK2fcdY2linW3hfRmmyf+xDwtHzS0P3U8WegsJrOakEDBwK
        gDPxBfAO6nZO41Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A343E08D3;
        Fri, 22 Oct 2021 17:32:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9883E08D2;
        Fri, 22 Oct 2021 17:32:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kalyan Sriram <kalyan@coderkalyan.com>,
        git <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Git submodule remove
References: <0101017ca3e30c39-f111f739-4db7-4c1e-aff2-3ee50f546591-000000@us-west-2.amazonses.com>
        <YXHdaQ98GJiFj0OK@camp.crustytoothpaste.net>
        <xmqqbl3ihu6l.fsf@gitster.g>
        <CAHd-oW5PfygyNsRWGg4_W2pxR_HbePvguKRf-bK9RtY3cuAX9g@mail.gmail.com>
        <xmqqee8egddw.fsf@gitster.g>
        <211022.86lf2ll00x.gmgdl@evledraar.gmail.com>
Date:   Fri, 22 Oct 2021 14:32:22 -0700
In-Reply-To: <211022.86lf2ll00x.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 22 Oct 2021 14:12:11 +0200")
Message-ID: <xmqq8rykeoex.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8B924C18-337F-11EC-B41A-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Why would it be a good thing to change it even if we could? We added
> that section with "git submodule add", it makes sense to have it remove=
d
> on "git init".

... on "git submodule rm", yes.  Not "git rm". I am not sure what
your "git init" is your typo for.

That is primarily because I do not believe the "git submodule"'s
world view is the _only_ valid porcelain UI for a feature that lets
you use another project as if it is one of your subdirectories.  So
whatever opinionated policy the current "git submodule" implements,
I'd prefer to keep it in "git submodule" (and ".gitmodules", which is
where the data to support "git submodule"-style submodule handling
lives in), not in the lower level "git add" and "git rm".

> If anything I think it would make sense to extend this behavior. E.g. i=
f
> we "git rm" a <path> and notice that the <path> was the only thing that
> matched a given entry in .gitignore we should remove that entry.

I think that is a wrong analogy.

It does not make sense to me to remove "*.o" from my .gitignore,
when I do "git rm vendor-binary.o". I have "*.o" in .gitignore
because I do not want to add .o files produced by compiling my
source files, and the "git rm" does not change that fact at all.

I unfortunately had to keep track of an opaque vendor-supplied
binary, which got replaced recently with a new version, and that is
why I am running "git rm" on it.  "git add -f vendor-binary-v2.o"
is what I was planning to do next.

I do not want you to mess with my .gitignore; you are assuming too
much on my workflow.

> See 95c16418f03 (rm: delete .gitmodules entry of submodules removed fro=
m
> the work tree, 2013-08-06) for the commit that gave "git rm" these
> smarts.

I know.  That is exactly the layering violation I am unhappy about
but we came with it too far to remove.
