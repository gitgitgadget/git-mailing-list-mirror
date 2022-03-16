Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D61C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 17:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353666AbiCPRfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 13:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239152AbiCPRf2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 13:35:28 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC41C937
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:34:13 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6942C16D925;
        Wed, 16 Mar 2022 13:34:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aFRdX+TRPQKw4Rf8+P43xS6Z20lH3phbJzX8S9
        Ebf7Q=; b=kAROwjOofinXpm3t/oP9AQjjfk0XIYp37GjJyAAV/Kv1a2/o18FdKG
        zG7vFUpR3uEVTE+hvKrUIoPLh6W7OnX1tEdfXA1S9IE7sAvc1cqPcYoDV1zzcmYe
        Fd39OQIKttX+DRbcOX2B1CtQpo+X4yQ5RwH1AtgtHoGMumZAAFKK8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6266516D924;
        Wed, 16 Mar 2022 13:34:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE85D16D923;
        Wed, 16 Mar 2022 13:34:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 6/6] doc: add stash export and import to docs
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220310173236.4165310-7-sandals@crustytoothpaste.net>
Date:   Wed, 16 Mar 2022 10:34:09 -0700
In-Reply-To: <20220310173236.4165310-7-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 10 Mar 2022 17:32:36 +0000")
Message-ID: <xmqq35jhn6ni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A44003E-A54F-11EC-B8DC-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Now that we have an easy way for users to import and export their
> stashes, let's document this in manual page so users will know how to
> use it.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  Documentation/git-stash.txt | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 6e15f47525..283677314a 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -20,6 +20,8 @@ SYNOPSIS
>  'git stash' clear
>  'git stash' create [<message>]
>  'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
> +'git stash' export ( --print | --to-ref <ref> ) [<stashes>]

Again, "[<stash>...]", I think.  Do we want SP inside () but no SP
inside []?  That looks inconsistent.

I.e.

    'git stash' export (--print|--to-ref <ref>) [<stash>...]


> +export ( --print | --to-ref <ref> ) [<stashes>]::
> +
> +	Export the specified stashes, or all of them if none are specified, to
> +	a chain of commits which can be transferred using the normal fetch and
> +	push mechanisms, then imported using the `import` subcommand.

Ditto.

> +import <commit>::
> +
> +	Import the specified stashes from the specified commit, which must have been
> +	created by `export`, and add them to the list of stashes.  To replace the
> +	existing stashes, use `clear` first.

A tangent.

I personally prefer the style to have a blank line after the
"<dt>::" in asciidoc's way of doing description list used here, both
in these two new entries and many existing ones, by the way.

We probably should do that consistently, though.

>  OPTIONS
>  -------
>  -a::
> @@ -239,6 +253,19 @@ literally (including newlines and quotes).
>  +
>  Quiet, suppress feedback messages.
>  
> +--print::
> +	This option is only valid for `export`.
> ++
> +Create the chain of commits representing the exported stashes without
> +storing it anywhere in the ref namespace and print the object ID to
> +standard output.  This is designed for scripts.
> +
> +--to-ref::
> +	This option is only valid for `export`.
> ++
> +Create the chain of commits representing the exported stashes and store
> +it to the specified ref.
> +
>  \--::
>  	This option is only valid for `push` command.
>  +

There is one more necessary update after this, no?

diff --git i/Documentation/git-stash.txt w/Documentation/git-stash.txt
index 283677314a..acce92b5d9 100644
--- i/Documentation/git-stash.txt
+++ w/Documentation/git-stash.txt
@@ -283,7 +283,7 @@ For more details, see the 'pathspec' entry in linkgit:gitglossary[7].
 
 <stash>::
 	This option is only valid for `apply`, `branch`, `drop`, `pop`,
-	`show` commands.
+	`show`, and `export` commands.
 +
 A reference of the form `stash@{<revision>}`. When no `<stash>` is
 given, the latest stash is assumed (that is, `stash@{0}`).
