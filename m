Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC9BC433DF
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AD7206E3
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 20:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eafNCj8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGWU7U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:59:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57369 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGWU7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jul 2020 16:59:20 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 261DF6CA13;
        Thu, 23 Jul 2020 16:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TotJDCXXnDZ2Vd3CbSZt2wMfPVQ=; b=eafNCj
        8Rs8D2R/6hcT1sxhzBjkEJTjXKyDKKaYovFrGGdnObTaZ+tQp6TE4DGzbo5f3v9e
        W4DFPXWqxPlNUi2lIDsE9NMX6GWdubJJqAS8OCkGJFroWMVXUA19Kko+yDVeFJEP
        9R3CbybKtbcoYAQH1J6znhT5Nj3se+n0WmqGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Vt+fqDVm7gcDO94IRjfNZ3lnRQHNJ7wH
        awQ1VggejG4N3SyDUVJ1xv4tyHhbBLvUntvR2ZtK98hZec/aq0oM++OfaBYXUMB7
        TYuZCPjc67zaIlN17xg8POGba/AgxlCJgIiPaoIJSuOXkY7HcWCrpRcibPQgWceF
        yQIKBefDk2w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 167BD6CA0E;
        Thu, 23 Jul 2020 16:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8EF8C6CA0C;
        Thu, 23 Jul 2020 16:59:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 09/18] maintenance: add loose-objects task
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
        <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <83648f48655ba68126110018d81c1d2e2bcc7a6f.1595527000.git.gitgitgadget@gmail.com>
Date:   Thu, 23 Jul 2020 13:59:16 -0700
In-Reply-To: <83648f48655ba68126110018d81c1d2e2bcc7a6f.1595527000.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 23 Jul 2020
        17:56:31 +0000")
Message-ID: <xmqqr1t2osm3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F650492-CD27-11EA-A3F0-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Create a 'loose-objects' task for the 'git maintenance run' command.
> This helps clean up loose objects without disrupting concurrent Git
> commands using the following sequence of events:
>
> 1. Run 'git prune-packed' to delete any loose objects that exist
>    in a pack-file. Concurrent commands will prefer the packed
>    version of the object to the loose version. (Of course, there
>    are exceptions for commands that specifically care about the
>    location of an object. These are rare for a user to run on
>    purpose, and we hope a user that has selected background
>    maintenance will not be trying to do foreground maintenance.)

OK.  That would make sense.

> 2. Run 'git pack-objects' on a batch of loose objects. These
>    objects are grouped by scanning the loose object directories in
>    lexicographic order until listing all loose objects -or-
>    reaching 50,000 objects. This is more than enough if the loose
>    objects are created only by a user doing normal development.

I haven't seen this in action, but my gut feeling is that this would
result in horrible locality and deltification in the resulting
packfile.  The order you feed the objects to pack-objects and the
path hint you attach to each object matters quite a lot.

I do agree that it would be useful to have a task to deal with only
loose objects without touching existing packfiles.  I just am not
sure if 2. is a worthwhile thing to do.  A poorly constructed pack
will also contaminate later packfiles made without "-f" option to
"git repack".

