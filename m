Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A35C35280
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D5A1208CA
	for <git@archiver.kernel.org>; Thu,  7 May 2020 22:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="patMmWOf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgEGW6L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 18:58:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52669 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgEGW6K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 18:58:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D517446F2;
        Thu,  7 May 2020 18:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FZdO7mMQD4WhuD/hC5MaskXfDxM=; b=patMmW
        Of+ohJhsormhX83OxqI6izyrsczeI/jPMeusw+pQLK8q9XwD9SFC204HpLaNgOxI
        PhyQIA5kdp4bgGUczXs91iR1vlLOuEhJVfE5n1LUDeRx94CHAnNWGOJ74aBgdj2j
        sp2KqDyGqWexetZReYr7gtU7i9aAl1+lDSdgs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QdJR0QHJ7efNH6oG0Jh8zRMpTN5NiDFu
        BDlIUcXuEmobkuG7ykG9abNMjl7WFLQvyaef8+oW9LS8RBCulf3BdjoYt1NJs46+
        BHxZ0YlRVQBvX6k8hHQoD5r312KaOo5CyBFxtcCIe73aDu1Ln9dapAzM+gN0xVR/
        aDNqe0aWw70=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 62B0D446F1;
        Thu,  7 May 2020 18:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AACD9446ED;
        Thu,  7 May 2020 18:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmaill.com, peff@peff.net,
        me@ttaylorr.com, jrnieder@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 04/10] sparse-checkout: allow in-tree definitions
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
        <2188577cd848d7cee77f06f1ad2b181864e5e36d.1588857462.git.gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 15:58:06 -0700
In-Reply-To: <2188577cd848d7cee77f06f1ad2b181864e5e36d.1588857462.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Thu, 07 May 2020
        13:17:36 +0000")
Message-ID: <xmqqeerv2w01.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3777F7C6-90B6-11EA-9623-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> One of the difficulties of using the sparse-checkout feature is not
> knowing which directories are absolutely needed for working in a portion
> of the repository. Some of this can be documented in README files or
> included in a bootstrapping tool along with the repository. This is done
> in an ad-hoc way by every project that wants to use it.
>
> Let's make this process easier for users by creating a way to define a
> useful sparse-checkout definition inside the Git tree data. This has
> several benefits. In particular, the data is available to anyone who has
> a copy of the repository without needing a different data source.
> Second, the needs of the repository can change over time and Git can
> present a way to automatically update the working directory as these
> sparse-checkout definitions change over time.

And two lines of development can merge them together?

Any time a new "feature" pops up that would eventually affect how
"git clone" and "git checkout" work based on untrusted user data, we
need to make sure there is no negative security implications.  

If it only boils down to "we have files that can record list of
leading directory names and without offering extra 'flexibility'", I
guess there aren't all that much that a malicious sparse definition
can do and we would be safe, though.

> To use this feature, add the "--in-tree" option when setting or adding
> directories to the sparse-checkout definition. For example:
>
>   $ git sparse-checkout set --in-tree .sparse/base
>   $ git sparse-checkout add --in-tree .sparse/extra
>
> These commands add values to the multi-valued config setting
> "sparse.inTree". When updating the sparse-checkout definition, these
> values describe paths in the repository to find the sparse-checkout
> data. After the commands listed earlier, we expect to see the following
> in .git/config.worktree:
>
> 	[sparse]
> 		intree = .sparse/base
> 		intree = .sparse/extra

What does this say in human words?  "These two tracked files specify
which paths should be in the working tree"?  Spelling it out here
would help readers of this commit.

> When applying the sparse-checkout definitions from this config, the
> blobs at HEAD:.sparse/base and HEAD:.sparse/extra are loaded. 

OK, so end-user edit to the working tree copy or what is added to
the index does not count and only the committed version gets used.

That makes it simple---I was wondering how we would operate when
merging a branch with different contents in the .sparse/* files
until the conflicts are resolved.

> In those
> files, the multi-valued config values "sparse.dir" are considered as
> the directories to construct a cone mode sparse-checkout file. The end
> result is as if these paths were provided to "git sparse-checkout set"
> in cone mode.

OK.

> For example, suppose .sparse/base had the following content:
>
> 	[sparse]
> 		dir = A
> 		dir = B/C
> 		dir = D/E/F
>
> and .sparse/extra had the following content:
>
> 	[sparse]
> 		dir = D
> 		dir = X
>
> Then, the output of "git sparse-checkout list" would be
>
> 	A
> 	B/C
> 	D
> 	X
>
> Note that since "D" contains "D/E/F", that directory replaces the
> position of "D/E/F" in the list.
>
> Since these are parsed using the config library, the parser is robust
> enough to understand comments and complicated string values.
>
> The key benefit to this approach is that it can be extended by defining
> new config values. In a later change, we will introduce "sparse.inherit"
> to point to another file in the tree. This will solve the problem of
> editing many files when core dependencies change.

With only a multi-valued sparse.dir elements allowed in these
in-tree .sparse/* files, I guess there isn't much mischeaf a
malicious .sparse/* file can do.  Can it try to [includeIf] some
paths external to the repository to cause a remote attacker to learn
about the paths on the local system, perhaps? 

> diff --git a/Documentation/config/sparse.txt b/Documentation/config/sparse.txt
> new file mode 100644
> index 00000000000..c1fce87cd33
> --- /dev/null
> +++ b/Documentation/config/sparse.txt
> @@ -0,0 +1,15 @@
> +sparse.inTree::
> +	The `core.sparseCheckout` config option enables the `sparse-checkout`
> +	feature, but if there are any values for the multi-valued
> +	`sparse.inTree` config option, then the sparse-checkout patterns are
> +	defined by parsing the files listed in these values. See
> +	linkgit:git-sparse-checkout[1] for more information.

Does "... but if ... then" mean "by parsing the files and ignoring
all other things that may otherwise define patterns"?

> +sparse.dir::
> +	This config setting is ignored if present in the repository config.
> +	Instead, this multi-valued option is present in the files listed by
> +	`sparse.inTree` and specifies the directories needed in the
> +	working directory. The union of all `sparse.dir` values across all
> +	`sparse.inTree` files forms the input for `git sparse-checkout set`
> +	in cone mode.  See linkgit:git-sparse-checkout[1] for more
> +	information.

If this is *not* a config in the usual sense, we probably should not
include it in this document and in the "git config --help" output.
That will allow us to drop the first sentence.

Those .sparse/* in-tree files are like .gitmodules in the sense that
they happen to use the same syntax so that the parser can be shared,
but they are not allowed to affect end-user configuration
(e.g. writing "[diff] external=rm -fr ." in the file has no effect)
at all, right?

And we should describe what we can write in these in-tree files
separately and make it clear that they are _different_ from the
configuration variables.

