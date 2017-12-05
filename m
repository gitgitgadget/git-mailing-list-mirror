Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F9920A40
	for <e@80x24.org>; Tue,  5 Dec 2017 17:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbdLERJQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 12:09:16 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55531 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752931AbdLERJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 12:09:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A03BBBECF0;
        Tue,  5 Dec 2017 12:09:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UF4GzFiDHPHZCijDAOnTBJQXar0=; b=whFvgG
        e0ZtePOyyOFkyvdD2cqQyNpe0+yxt+6vMAx40f4gT3/ouRJbKLpOuYJ4DU5LkaT1
        t7XcFKt1ooXhBSsMsYXXycOWRYt4grfXGKNXY7gFl7y356zZ+GiGp8XcEIZUAGEU
        caJ9qxgKoxUoztup1rZ+smBUhYPklG3tJASZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vYUXHYk2jlRJOjkbjtg5tHbWdhNKkyrw
        1AXN0o/QiJFbqIooo46zbY+/EXxm7NPdUGSm35VgJMIz6it38Q7aWJrj9TkT1NZl
        XsnPGgCvQOKVxzlfL+tAghPgbH9L9OwE/1zCcbAQrv1on5PlRf8e9Y/z8N6qMDax
        sbZ43h1D2vI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9870DBECEF;
        Tue,  5 Dec 2017 12:09:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 07C73BECEE;
        Tue,  5 Dec 2017 12:09:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/git-clone: improve description for submodule recursing
References: <20171205025332.9835-1-sbeller@google.com>
Date:   Tue, 05 Dec 2017 09:09:12 -0800
In-Reply-To: <20171205025332.9835-1-sbeller@google.com> (Stefan Beller's
        message of "Mon, 4 Dec 2017 18:53:32 -0800")
Message-ID: <xmqqvahlhzk7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04DB0B22-D9DF-11E7-99A8-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> There have been a few complaints on the mailing list that git-clone doesn't
> respect the `submodule.recurse` setting, which every other command (that
> potentially knows how to deal with submodules) respects.  In case of clone
> this is not beneficial to respect as the user may not want to obtain all
> submodules (assuming a pathspec of '.').
>
> Improve the documentation such that the pathspec is mentioned in the
> synopsis to alleviate the confusion around the submodule recursion flag
> in git-clone.
>
> While at it clarify that the option can be given multiple times for complex\
> pathspecs.

Well written (modulo the backslash there, which I can easily remove
while queuing).

>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/git-clone.txt | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 83c8e9b394..42ca7b5095 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
>  	  [--dissociate] [--separate-git-dir <git dir>]
>  	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
> -	  [--recurse-submodules] [--[no-]shallow-submodules]
> +	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
>  	  [--jobs <n>] [--] <repository> [<directory>]
>  
>  DESCRIPTION
> @@ -231,14 +231,17 @@ branch of some repository for search indexing.
>  	After the clone is created, initialize and clone submodules
>  	within based on the provided pathspec.  If no pathspec is
>  	provided, all submodules are initialized and cloned.
> -	Submodules are initialized and cloned using their default
> -	settings.  The resulting clone has `submodule.active` set to
> +	This option can be given multiple times for pathspecs consisting
> +	of multiple entries.  The resulting clone has `submodule.active` set to
>  	the provided pathspec, or "." (meaning all submodules) if no
> -	pathspec is provided.  This is equivalent to running
> -	`git submodule update --init --recursive` immediately after
> -	the clone is finished. This option is ignored if the cloned
> -	repository does not have a worktree/checkout (i.e. if any of
> -	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
> +	pathspec is provided.
> ++
> +Submodules are initialized and cloned using their default settings. This is
> +equivalent to running
> +`git submodule update --init --recursive <pathspec>` immediately after
> +the clone is finished. This option is ignored if the cloned repository does
> +not have a worktree/checkout (i.e. if any of `--no-checkout`/`-n`, `--bare`,
> +or `--mirror` is given)
>  
>  --[no-]shallow-submodules::
>  	All submodules which are cloned will be shallow with a depth of 1.
