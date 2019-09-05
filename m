Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 917A01F461
	for <e@80x24.org>; Thu,  5 Sep 2019 21:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391723AbfIEVD2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 17:03:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53823 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbfIEVD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 17:03:28 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77C6175394;
        Thu,  5 Sep 2019 17:03:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ONLh/30DTZMY9fUq5yaAO4e6Jt8=; b=morAHm
        u8IbbU3fURAdD2qK1lpyvezsqjUZjG1rVUj2B0LtjOxiPC5K2NrXuZuAkdFKsRmk
        d6msZO+oQo08XbiENU0+ArM+GnKnr9zRE+HchpWlHqyakn6G+MEVAYIBSu1N6pi7
        TVVjiOpBkk91ipqJEc+XwOyICavCc8n2PORJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EuhRUe9FhFVgsBSYI2unqFaHeqIwPKcK
        tyPgyrhXoMm51Oc8R0rL7pP7FadGSRUp50mmiG3rm9vHQPGIy2kZvm/takj0OUF3
        wmE1wM75cSatSF+R84smp7DOYZIutiOj3MU3b2kxlg74jUrDWbbjMJisl3Jz7VnW
        +iit/khUcbE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F64375393;
        Thu,  5 Sep 2019 17:03:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 98BCD75392;
        Thu,  5 Sep 2019 17:03:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        jon@jonsimons.org, matvore@comcast.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/5] treewide: rename 'struct exclude' to 'struct path_pattern'
References: <pull.329.git.gitgitgadget@gmail.com>
        <8cdffbd1c82c34a7dbdb18cb396e5e422889aad6.1567533893.git.gitgitgadget@gmail.com>
        <20190905065518.GD21450@sigill.intra.peff.net>
Date:   Thu, 05 Sep 2019 14:03:19 -0700
In-Reply-To: <20190905065518.GD21450@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 5 Sep 2019 02:55:18 -0400")
Message-ID: <xmqq4l1qpiaw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97D6457A-D020-11E9-99F4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wonder if there's a name that could more clearly distinguish the two.
> Or if it's sufficient to just become Git jargon that "pathspec" is the
> command-line one and "path_pattern" is the file-based one (we're at
> least pretty consistent about the former already).
>
> I think one could also make an argument that the name collision is a
> sign that these two things should actually share both syntax and
> implementation, since we're exposing too similar-but-not-quite versions
> of the same idea to users. But given the compatibility issues, it's
> probably not worth changing the user facing parts at this point (and I
> also haven't thought too hard about it; there may be reasons why the two
> _should_ differ).

Hmph.  I did not realize there are so many differences X-<.  

A pathspec is relative to $CWD, and there is a syntax, i.e.
prefixing with ":(top)", to make it relative to the root level.  An
entry in a .gitignore file will never affect paths outside the
directory the file appears in.  And there should never be such a
mechanism to allow it.

An entry without slash in .gitignore is a basename match, and there
is a syntax i.e. prefixing with "/", to anchor it to a single
directory.  A pathspec without slash also can be a basename match
(e.g. "*.c" matches "a/b.c" as well as "d.c").  A pathspec with a
slash can be made to tail-match (e.g. "**/*.c" matches "a/b.c",
"a/b/c.c", etc.) but I do not think of a way to make an entry with a
slash in a .gitignore file a tail-match the same way.  I do not think
this is intended but merely a missing feature.

So, yes, eventually we may want to make them more similar, but I
suspect that there are some things that should be in one but never
be in the other.
