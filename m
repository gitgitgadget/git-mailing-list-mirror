Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0BCC433E0
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD4282078C
	for <git@archiver.kernel.org>; Thu, 28 May 2020 18:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bo6lKodL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405924AbgE1Stg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 14:49:36 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55482 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405911AbgE1Stf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 14:49:35 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E8FFD3BF0;
        Thu, 28 May 2020 14:49:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=erB2g87I92mQ2xVsCK8wNiAaeBA=; b=Bo6lKo
        dLIP2BrHLVnuaa7a15JCLZCBJSFbF5A/6rzKeXoGHnD974gUrkJRiAv5KWuwDZ7Q
        gtzlN8abfAlddgwwZ6rz9N1WhgnSjZeSarFAtqeUvvHs04EQ8EMkeyzIVvG1//OX
        0ihZj3ekd7AGHA9zyabrDDT5dTXNjVEeTCUBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tu29o18HqdGpZhyuWmHbuKQhA6AmUxGv
        +XOlU/VHCzoXWFwrHvx37QQuCrCmNI2EeDZS9cxh+UzGXdprqD6G3sVgZx0hc8Xq
        d+EDScuZfKhdv1MJXcD8GjfD1mRvY9npLsMP2XP8X0btoe4uME7aCmckUcQBZGFO
        djuw8JbcI4I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2662ED3BEF;
        Thu, 28 May 2020 14:49:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 68D8ED3BEE;
        Thu, 28 May 2020 14:49:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kenneth Lorber <keni@his.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/6] doc: Add namespace collision guidelines file
References: <1589681624-36969-1-git-send-email-keni@hers.com>
        <20200525232727.21096-1-keni@his.com>
        <20200525232727.21096-4-keni@his.com>
Date:   Thu, 28 May 2020 11:49:27 -0700
In-Reply-To: <20200525232727.21096-4-keni@his.com> (Kenneth Lorber's message
        of "Mon, 25 May 2020 19:27:24 -0400")
Message-ID: <xmqqy2pb3new.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6274006-A113-11EA-871F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kenneth Lorber <keni@his.com> writes:

> +Git uses identifiers in a number of different namespaces:
> +
> +* environment variables
> +* files in $GIT_DIR
> +* files in the working trees
> +* config sections
> +* hooks
> +* attributes

The names of the subcommands "git" can spawn is a shared resource.
You can install "git-imerge" program in one of the directories on
your $PATH and say "git imerge" to invoke the program.  

Two third-party developers may have to coordinate to avoid giving
the same name to their totally-unrelated tools, if they hope that
both of their tools to be useful in the larger Git ecosystem.

> +In order to reduce the chance of collisions between names Git uses
> +and those used by other entities (users, groups, and extension authors),
> +the following are recommended best practices.

OK.

> +Names reserved to Git:

s/to/by/ perhaps.

> +Names reserved for individual users:
> +
> +* The directory `$GIT_DIR/my`

So an individual user is allowed to store anything in that
directory, and "git" or any third-party tools won't care.  OK.

> +* Environment variables starting with `GIT_MY_`

Likewise.  But then the users can use MY_FOO_BLAH without GIT_
prefix in the first place, so there isn't much gain there.  Downside
for "git" and third-party tool authors is not so big (just the loss
of a single prefix "_MY"), so perhaps it is OK.

> +* Configuration section `my`
> +* Files or directories in `$GIT_DIR/hooks` starting with `my_`
> +* Attributes starting with `my_`

The last one does not make much sense.  You have to forbid defining
my_attributes in .gitattributes files that are tracked in-tree;
otherwise I cannot work with you on the same project, because I
cannot use my_attributes for my own purpose in that project.  For
the same reason, reserving attributes for individual repositories
does not make much sense, either.

> +Names reserved for individual repos:
> +
> +* The directory `$GIT_DIR/this`

It is unclear what it means to have $GIT_DIR/my and $GIT_DIR/this
and how to choose which one of these two ought to be used for each
occasion a user finds a need to store something in these places.

> +* Environment variables starting with `GIT_THIS_`

The utility of this one is dubious.  

	$ export GIT_THIS_BLAH=value
	$ cd repo1 ; work work work
	$ cd ../repo2 ; work work work

Unless you arrange to reset GIT_THIS_* environment variable every
time you visit a separate repository, it would not be pratical to
use.

> +Names reserved for the lowest level group of people:

What's lowest level group of people?

Also, where did the guideline for third-party tools go?

At this point I need to say that this is not very well thought out
(yet), or that this is not very well explained, or perhaps both,
so I'll stop commenting on it for now.

Thanks.



