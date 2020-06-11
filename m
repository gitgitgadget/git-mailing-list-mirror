Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1568CC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 05:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2492074B
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 05:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S/yMQgBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgFKFmT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 01:42:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62754 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgFKFmT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 01:42:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 377B97C3AD;
        Thu, 11 Jun 2020 01:42:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ERc5u3LUtapP6WD48T4OSpGUmc0=; b=S/yMQg
        BDo1N2ClqJrnhBaV3WjjesKf7/Hm9ju9//Mp83Pdk9yWtjyAJ18wt9ryMaDQZ+yP
        KEnocR+p49fKjE7C5YeXdgv96r+ZP/jQr0G3jmnjHMYGRpFbHH++4umsjxTAuroX
        5/gSOO/AC6rvs8XJRhzrY+UAz6oFkdGfcDFAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ai+Nlnchk9667T6L56b9CVvh9NlzUSmu
        4Cc1ylHFBVSR4a10HdHkLA/Xq41IUd2M90EoxkBJtKARpiomGkI2eEPW59DxGj9v
        e8GdhPChnlZxC8LGjZ6wsmFuEaJ3kuOjzCrY9NGSAOORzSCJ9lxsPtj2lpXpcq1y
        koxwwbWozTE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E1EC7C3AC;
        Thu, 11 Jun 2020 01:42:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B094B7C3AB;
        Thu, 11 Jun 2020 01:42:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/9] Allow overriding the default name of the default branch
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <xmqqk10eecsg.fsf@gitster.c.googlers.com>
Date:   Wed, 10 Jun 2020 22:42:16 -0700
In-Reply-To: <xmqqk10eecsg.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 10 Jun 2020 16:11:59 -0700")
Message-ID: <xmqqy2oub1l3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F0D039E-ABA6-11EA-AB87-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> ...
>> This series DOES NOT change the default automatically, but only provides an
>> opt-in mechanism for interested users. It also presents a way forward for
>> such a transition, if and when we decide to do so. Specifically, the new
>> GIT_TEST_DEFAULT_BRANCH_NAME environment variable could be used to update
>> test scripts on an individual basis instead of all-at-once.
>
> Yes.  I've been thinking about a way that does not hurt workflows
> used in existing projects while allowing a "git init" that is run to
> create a new repository by a new user who does not have any special
> customization in ~/.gitconfig to use the branch name that replaces
> the 'master' (I do not mind changing away from 'master', but I am
> not yet convinced it should be 'main', by the way---the actual
> choice of the final name does not matter at this point of the design
> of backward compatibility plan).  
>
> I think "git init" that is creating a new repository (iow, do not do
> anything when reinitializing an existing repostiory) can
>
>  - look at config.defaultBranchName in /etc/gitconfig or
>    ~/.gitconfig before initializing the per-repository config in
>    $GIT_DIR/config it just created (or it is about to create).
>
>  - if there is no config.defaultBranchName configured, then set the
>    per-repository configuration to 'main' in the per-repository
>    configuration.  Otherwise do not do anything.
>
> And then we make sure Don's git_default_branch_name() works this
> way:
>
>  (0) if there is config.defaultBranchName in relevant config file
>      (i.e. /etc/gitconfig, ~/.gitconfig or per-repo config), use the
>      specified name.
>
>  (1) otherwise use 'master' (not 'main').
>
> That way, an existing repository will keep using 'master' unless the
> user shows the preference (and accepts responsibilities for possible
> fallouts) in ~/.gitconfig or the repository's .git/config, while a
> new repository created by a user who does not show any particular
> preference will use 'main'.

A useful addition to these 9-patch series (i.e. even before the
default for vanilla usage gets changed) might be to give an example
to use "git config" to grab the default branch name, e.g.

    name=$(git config core.defaultBranchName || echo master)

Better yet (because the above forces the end users to write 'master'
in their script), we might want to teach "git var" about the
variable, so that the above can be written like so:

    name=$(git var defaultBranchName)

For those not so familiar with "git var", it is a command to query
"magic" variables whose value can be retrieved from different places
and is backed by non-trivial logic.  "What's the editor to be used?"
is queried by "git var GIT_EDITOR", but that is not a simple:

    if test -n "$GIT_EDITOR"
    then
	echo "$GIT_EDITOR"
    else
	echo vi
    fi

It takes the fallback `EDITOR` environment variable, and core.editor
configuration variable, into account, for example.

Similarly, "what is the default branch name" is not just about the
value of one configuration variable.  GIT_TEST_DEFAULT_BRANCH_NAME
environment needs to be consulted, and when there is nothing
configured, it needs to say 'master', so that end-users who use "git
var" do not have to hardcode the string 'master' in their script.


