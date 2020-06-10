Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D44C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B088206F4
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ujscTDDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgFJXME (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:12:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50947 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgFJXME (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 19:12:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 77993618B6;
        Wed, 10 Jun 2020 19:12:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XexSRE1ONbSlZMyCYz23NG0I/8c=; b=ujscTD
        DpIDaAZsjLyDcFLH9Yhw68tMPlZ3F+cJWQErgdGNKngnDOPyjQFZj0uStrgSo5q1
        pXrUqDW+Zr/XhPdh9vRM9dhfz4XM1bw61P/oFpPIK3KLdDSTQQ1Nbq4mSNTHMwHV
        p+KUzlqAmm4uHK3NSUx9F9WCI+la+jmnixJf8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vz14+aB3pQ947+xaW65nWUBgnqcJNvJx
        V+AgG7Su2EJ1t1zNMGNPrcMzcIblCMBBwmA9hjWBzghp8qNRwwTxqT45Vi11YK9P
        eWlhkYIfsjcf9q6DddLZ3DNjk0rbOsvT5fKIh3xaemk7zEn0gl67MNeLeIz09oZK
        NkjesH+k30Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A0B6618B5;
        Wed, 10 Jun 2020 19:12:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B24B8618B4;
        Wed, 10 Jun 2020 19:11:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default branch
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
Date:   Wed, 10 Jun 2020 16:11:59 -0700
In-Reply-To: <pull.656.git.1591823971.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 10 Jun 2020 21:19:21
        +0000")
Message-ID: <xmqqk10eecsg.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C97024EA-AB6F-11EA-B2F2-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> A growing number of open source projects aims to avoid the branch name 
> master due to its negative connotation. See [1] for an existing discussion
> on this. The links [2], [3], and [4] describe community-driven ways for
> users to rename their default branches or use template edits to set a new
> default branch name.

I scanned the series quickly and the patches seem to cover all the
places I was aware of that has the hard-coded knowledge of the
default branch name being 'master'.  Looking good.

> This series DOES NOT change the default automatically, but only provides an
> opt-in mechanism for interested users. It also presents a way forward for
> such a transition, if and when we decide to do so. Specifically, the new
> GIT_TEST_DEFAULT_BRANCH_NAME environment variable could be used to update
> test scripts on an individual basis instead of all-at-once.

Yes.  I've been thinking about a way that does not hurt workflows
used in existing projects while allowing a "git init" that is run to
create a new repository by a new user who does not have any special
customization in ~/.gitconfig to use the branch name that replaces
the 'master' (I do not mind changing away from 'master', but I am
not yet convinced it should be 'main', by the way---the actual
choice of the final name does not matter at this point of the design
of backward compatibility plan).  

I think "git init" that is creating a new repository (iow, do not do
anything when reinitializing an existing repostiory) can

 - look at config.defaultBranchName in /etc/gitconfig or
   ~/.gitconfig before initializing the per-repository config in
   $GIT_DIR/config it just created (or it is about to create).

 - if there is no config.defaultBranchName configured, then set the
   per-repository configuration to 'main' in the per-repository
   configuration.  Otherwise do not do anything.

And then we make sure Don's git_default_branch_name() works this
way:

 (0) if there is config.defaultBranchName in relevant config file
     (i.e. /etc/gitconfig, ~/.gitconfig or per-repo config), use the
     specified name.

 (1) otherwise use 'master' (not 'main').

That way, an existing repository will keep using 'master' unless the
user shows the preference (and accepts responsibilities for possible
fallouts) in ~/.gitconfig or the repository's .git/config, while a
new repository created by a user who does not show any particular
preference will use 'main'.


