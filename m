Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181CFC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 14:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E778C2073A
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 14:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MN3N1Dvv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGIOFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:05:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60305 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgGIOFj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 10:05:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4ACE0E4CC3;
        Thu,  9 Jul 2020 10:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JsSNyLR68tOeCWWkt8L3IEi3y5I=; b=MN3N1D
        vvNB7pVGNlpZ1tPlXJwxj4/RUlJ2b6dhB9A0dOPdk5aav1KBSd3iOIGlTeV/90C0
        DvPqdpwtjfCbfHtjjMEMueGGQiiwPZz4vQd/xeRNAAg19hDpfVXYy87XpvBVtZe7
        tBpfI/v/l7wWrBSE8jwPcTg0onnDW383ICd28=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=F9Y6SybxK+echUoQ25y57+nxYcDqLBol
        8mxlJeLgXVQ39bxjh5n0iCulmUPbutFjcXBeo0+Fm9ac/ZrGN0Ww4fXHF5dcI9ZO
        xybx35tM3LWWIYIbmU86Zdr/7MHJ3kLCuyNU0SVqlmcnXeGtQG1Ckk9jGPvE5LJG
        q97NsfUyGlk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 41A71E4CC2;
        Thu,  9 Jul 2020 10:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 70E72E4CC1;
        Thu,  9 Jul 2020 10:05:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 00/21] Maintenance builtin, allowing 'gc --auto' customization
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <20200708235719.GA3189386@google.com>
        <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com>
Date:   Thu, 09 Jul 2020 07:05:31 -0700
In-Reply-To: <ef6e2704-b122-f620-a952-75f3f9efab78@gmail.com> (Derrick
        Stolee's message of "Thu, 9 Jul 2020 07:21:00 -0400")
Message-ID: <xmqqv9iwyeac.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4146BE28-C1ED-11EA-A73F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> It is important to recognize that there are already several "tasks" that
> run inside 'gc' including:
>
> 1. Expiring reflogs.
> 2. Repacking all reachable objects.
> 3. Deleting unreachable objects.
> 4. Packing refs.
>
> Before trying to "remove" the gc builtin, we would want these to be
> represented in the 'git maintenance run' as tasks.

Yup.  I like the overall direction of this approach to (1) have a
single subcommand that helps all the housekeeping tasks, and to (2)
make sure existing housekeeping tasks are supported by the new one.

I can understand why it is tempting to start with a new 'main()'
under a new subcommand name because we expect to add a lot more
tasks, but the name of that subcommand is much less important.

As can be seen in the list you have above, "gc" already does a lot
more than garbage collection (just #3 is the "garbage collection"
proper), as it has grown by following the same approach.

What's more important is (2) above.  While the tool has grown under
the same "gc" name, it was easier to arrange---it fell out naturally
as a consequence of the development being an enhancement on top of
the prior work.  Now that we are reimplementing, we need to actively
care.  As long as we recognize that, I am perfectly happy with the
current effort.

For existing callers, "git gc --auto" may want to be left alive,
merely as a thin wrapper around "git maintenance --auto", and as
long as the latter is done in the same spirit of the former, i.e.
perform a lightweight check to see if the repository is so out of
shape and then do a minimum cleaning, it would be welcomed by users
if it does a lot more than the current "git gc --auto".

Thanks.
