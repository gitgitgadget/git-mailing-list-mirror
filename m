Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9692B1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 17:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390904AbfIERBY (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 13:01:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61944 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389399AbfIERBY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 13:01:24 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 61304730F9;
        Thu,  5 Sep 2019 13:01:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hzaiLIOtvXl61m10M5HTeTYgOgI=; b=VARh/B
        FzkQDyugiUfl0S/3hn+xDtllZeyxR7q5P0IKBtfjDl36wZrZ1A6qA+fhDrBaTpUc
        rk0rDreZhRD+bHM14UGxfj0bm80KrtYIr8V3bCx344N093bQzDzoZ/2HlsfCURWY
        VMfa3OGA0vBCvf7e41Z8N5ssTLP67g5xUI31M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H3MHIWCIUiWJr5qn6GHMyTfIKiodbqN7
        oB+jIxb/ZXjF2VXu/sVqV9qHMbu/yJPMIsER7S47AQZutDg5QuCnp/ExOiSF8Bcp
        lb6dkXjPHGPfW41TogXKzOkDBM+xy0pLc5iTd7bOCF977LMqjywETwimn0mRez9a
        T3iB+rzppGo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58FC4730F8;
        Thu,  5 Sep 2019 13:01:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 821C0730F6;
        Thu,  5 Sep 2019 13:01:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] reset: support the --stdin option
References: <pull.133.git.gitgitgadget@gmail.com>
        <017945a55a64ebe1913d64919b699adb3f9d5d96.1567633109.git.gitgitgadget@gmail.com>
        <fd300972-4fe7-54e4-3701-061ab4769c10@syntevo.com>
Date:   Thu, 05 Sep 2019 10:01:17 -0700
In-Reply-To: <fd300972-4fe7-54e4-3701-061ab4769c10@syntevo.com> (Alexandr
        Miloslavskiy's message of "Thu, 5 Sep 2019 12:58:06 +0200")
Message-ID: <xmqqtv9qr82q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C7FE2302-CFFE-11E9-908A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com> writes:

> Johannes, thanks for working on this problem!
>
> In the previous discussion, there was a suggestion to change
> '--stdin' to '--paths-file', where '--paths-file -' would mean stdin:
> https://public-inbox.org/git/066cfd61-9700-e154-042f-fc9cffbd6346@web.de/
>
> I believe that was a good suggestion for a few reasons:
> 1) Supporting files in addition to stdin sounds reasonable for its cost.
> 2) '--paths-file' will support files and stdin with the same "interface",
>    avoiding the possible need for another interface later.
> 3) '--paths-file' sounds more self-documented then '--stdin'.
>
> Later, we intend to provide patches to extend the same feature to
> multiple other commands, at least {add, checkout, commit, rm, stash},
> and I'm merely trying to avoid possible design issues for this
> larger-scale change.
>
> If you don't mind the suggestion but not willing to spend time
> implementing it, we'd like to step in and contribute the remaining
> work.

Ahh, I completely forgot about the earlier exchange.  Thanks for a
pointer.

While I do like the idea of adding an option to take the pathspec,
which you would usually give from the command line, from the
standard input, as a standard technique to lift the command line
length limit on various platforms, what I do not find right in the
posted patch is that it conflates it with something orthogonal.

When you already have a set of paths you would want to give to the
command, and when these paths may have wildcard letters in them, you
would want to tell the command that you do not want wildcards in the
pathspec to take effect.  That is a valid wish and we already have a
standard solution for that (i.e. the "--literal-pathspecs" option).

But it is orthogonal to how you feed these paths to the command.  I
would not say "unrelated", in that there may be correlation between
the cases where you would want to feed pathspec from the standard
input and the cases where you would want these pathspec taken
litearlly, but the choice is still "orthogonal".  

If we said "when feeding from the standard input, they are taken
literally by default, but on the command line, the wildcards are
expanded", that is bad enough---I do not think we want to hear any
unnecessary "Git UI is inconsistent" noise raised from such a design
choice.

The posted patch does not even do that.  It takes its input as
literal pathspec and it is done unconditionally without any way to
override it.

If we introduce a new --paths-from-file and make it take only paths
and never pathspecs (i.e. no wildcard expansion, a directory does
not mean everything underneath it), that would be less worrisome wrt
the UI inconsistency front (but we may need to commit to teach
existing commands that take pathspec from the standard input the new
option, too, so that all subcommands that can take some form of
paths specification would work the same way with --paths-from-file).

Or we can do --stdin (or --pathspec-from-file=-) that takes pathspecs,
whose literal-ness is controlled by the '--literal-pathspecs' option.

Thanks.

