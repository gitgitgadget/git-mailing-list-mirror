Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2E4C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15CE248E4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 17:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D/hN371S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgKRRfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 12:35:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56044 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgKRRfU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 12:35:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C26B8E795;
        Wed, 18 Nov 2020 12:35:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QguXD3T80YFSj4OnCZdYwnecLbc=; b=D/hN37
        1SglVHa9BdKKh0hq3iLd9iCjWihlnVoEHbJqtfGbA1LozHTYcZcd9cqVpOiEUt3w
        SDpP6B1ORbPeu//LSDttsXYtradtYtFwz43Ud6bKs5LuSVPQc5n+h4RKkXBMgsfO
        mtXv1mIvZ/ufTN1rofL3Tqp2Z3M/fqYEqkOS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fSVD7UClLcckdGFg0DFNgdGVUqd/LIIT
        veim3CBWFsNu9OekinS280f9KqZhATmll0C7+SpIFrosOSeesOilS+pzBHStpvQs
        DTabrUrzXzJUQOrC8l0GKbZJqzq2amxODJhi0aJQhL+I3mLaGIS/XAzPUUyueeqg
        dyjTVzX18xk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 127558E794;
        Wed, 18 Nov 2020 12:35:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CD848E793;
        Wed, 18 Nov 2020 12:35:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter Hadlaw <hadlawp@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re* Keeping the original init.defaultBranch config value
References: <CABrPy+GrSB87mFm5tXsXkC+OKg6NBxUJA5b0NYsa18a8EbcrNw@mail.gmail.com>
Date:   Wed, 18 Nov 2020 09:35:15 -0800
In-Reply-To: <CABrPy+GrSB87mFm5tXsXkC+OKg6NBxUJA5b0NYsa18a8EbcrNw@mail.gmail.com>
        (Peter Hadlaw's message of "Wed, 18 Nov 2020 10:46:30 -0600")
Message-ID: <xmqqd00a36wc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BECC700-29C4-11EB-BF06-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter Hadlaw <hadlawp@gmail.com> writes:

> Hello,
>
> Just wanted to confirm that in order to keep new repositories
> initializing with `master` as the default branch the command would be:
>
> ```
> git config --global init.defaultBranch master
> ```

Yes.

If you have to ask the above question, that would mean the
documentation we have right now probably is not clear enough.  

It is understandable, given that our documentation does not mention
any future plan to change 'master' to other value, but it may still
be a good idea.

The following patch is on 'seen' with Dscho's "prepare for main but
do not flip the final switch yet" series.  I am not committed to the
phrasing, but just showing it as a discussion starter.

Thanks.

--- >8 ------ >8 ------ >8 --- cut here --- >8 ------ >8 ---
Subject: "init" doc: mention the configurability more clearly

Update the description for the '--initial-branch' option to mention
that the historical default has been `master` and it can be
configured to use any name.  When actual transition happens to
another fixed name, say 'main', the description would further be
updated to mention like:

	... fall back to the default name 'main', but it can be
	customized with the `init.defaultBranch` configuration
	variable.  Note that the default name historically was
	'master'.

in order to help people who wonder why more mature projects or
documentation tend not to say 'main'.

While we are at it, stop referring to "HEAD file", which was a
remnant from 2005 that talks too much about implementation detail.
The most important fact is that the current branch is set to an
unborn branch and not detached HEAD.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-init.txt | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git i/Documentation/git-init.txt w/Documentation/git-init.txt
index 59ecda6c17..62c7552a12 100644
--- i/Documentation/git-init.txt
+++ w/Documentation/git-init.txt
@@ -20,8 +20,9 @@ DESCRIPTION
 
 This command creates an empty Git repository - basically a `.git`
 directory with subdirectories for `objects`, `refs/heads`,
-`refs/tags`, and template files.  An initial `HEAD` file that
-references the HEAD of the master branch is also created.
+`refs/tags`, and template files.  An unborn branch (see the
+`--initial-branch` option below for its name) is made to the current
+branch.
 
 If the `$GIT_DIR` environment variable is set then it specifies a path
 to use instead of `./.git` for the base of the repository.
@@ -73,8 +74,10 @@ If this is reinitialization, the repository will be moved to the specified path.
 -b <branch-name>::
 --initial-branch=<branch-name>::
 
-Use the specified name for the initial branch in the newly created repository.
-If not specified, fall back to the default name: `master`.
+Use the specified name for the initial branch in the newly created
+repository.  If not specified, fall back to the default name
+'master', but it can be customized with the `init.defaultBranch`
+configuration variable.
 
 --shared[=(false|true|umask|group|all|world|everybody|0xxx)]::
 
o
