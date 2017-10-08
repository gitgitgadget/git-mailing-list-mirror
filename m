Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E11932036B
	for <e@80x24.org>; Sun,  8 Oct 2017 04:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750884AbdJHEUc (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 00:20:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61551 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750771AbdJHEUb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 00:20:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF544AC5FC;
        Sun,  8 Oct 2017 00:20:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Gpo3uJXf77ypPI5QIcR++EuOJQI=; b=YWVJKf
        GLQSpFS58b8L79lfFlA3tTSLKTkGVHnFpUuimQDqlhJlww0MDTwLTQnSk0dYc0m6
        58uKv8WriQG+kfuS3QaT98D9jie7BpsMRNFnw7F59vcGsyxwJ6B2W16VKRDGnohE
        55vLecSgK+EgpKxmLors9iVflZEicqyJ37Tdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oH1cZ3OOX/tvTiATjbWLclPf15Z1S4mx
        tNYt8qhIhYAiBhAYRPLPf3EV8uNFARvXbi5048v8arSKHWEbRNhqxwq1IzPLzH+x
        8zOg5tUegfxnJxKdFfy5K4FMfsGnPttfqVgTI/OPO1sxBZbmo/Gf7DW9/huGHQ/5
        lyFg5jiLSwQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7991AC5FB;
        Sun,  8 Oct 2017 00:20:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5600DAC5EB;
        Sun,  8 Oct 2017 00:20:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>
        <20171007190402.GH3382@zaya.teonanacatl.net>
        <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
        <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net>
        <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
        <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net>
        <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
        <1507412674.8322.4.camel@mad-scientist.net>
        <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
Date:   Sun, 08 Oct 2017 13:20:13 +0900
In-Reply-To: <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
        (Robert P. J. Day's message of "Sat, 7 Oct 2017 17:55:48 -0400 (EDT)")
Message-ID: <xmqqy3oms22q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC199706-ABDF-11E7-A841-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

> ... so if, in the kernel source
> tree, i ran:
>
>   $ git rm \*.c
>
> i would end up removing *all* 25,569 "*.c" files in the kernel source
> repository.

Yes, as that is exactly what the command line asks Git to do.

If you said

    $ git rm *.c

then the shell expands the glob and all Git sees is that you want to
remove a.c b.c d.c ...; if you said "git rm -r *.c", unless b.c is
not a directory, these and only these files are removed.

>   however, let's say i wanted to remove, recursively, all files with a
> *precise* (non-globbed) name, such as "Makefile". so i, naively, run:
>
>   $ git rm Makefile
>
> guess what ... the lack of globbing means i remove only the single
> Makefile at the top of the working directory.

Again, that is exactly what you asked Git to do.

    $ git rm $(find . -name Makefile -print)

would of course one way to remove all Makefiles.  If you let POSIX
shell glob, i.e.

    $ git rm */Makefile

the asterisk would not expand nothing but a single level, so it may
remove fs/Makefile, but not fs/ext4/Makefile (some shells allow
"wildmatch" expansion so "git rm **/Makefile" may catch the latter
with such a shell).

By letting Git see the glob, i.e.

    $ git rm Makefile \*/Makefile

you would let Git to go over the paths it knows/cares about to find
ones that match the pathspec pattern and remove them (but not
recursively, even if you had a directory whose name is Makefile; for
that, you would use "-r").

Earlier some people mentioned "Unix newbie" in the thread, but I do
not think this is about Unix.  In general, Unix tools do not perform
grobbing themselves but expect the user to tell the shell to do so
before the tools see the arguments.  In that sense, I do think the
combination of "-r" and globbing pathspec may produce a result that
looks confusing at first glance.  

"git rm [-r] <pathspec>..."

 (1) walks the paths it knows/cares about, rejecting ones that do
     not match the <pathspec>;

 (2) decides to remove the ones that match; and

 (3) when it is asked to recursively remove, the ones that are
     directories are removed together with its contents.  If it was
     not asked to go recursive, it refuses to act on directories.

where (1) and (2) are not something the tool needs to worry
about---what is given from the command line is the only set of paths
that the tool is asked to operate on.  These two steps are quite
unlike regular Unix tools.

Once you decide to give the tool the flexibility that come from
taking pathspec, however, steps (1) and (2) do have to happen inside
the tool.  And great power takes some understanding of the tool on
the part of the user to exercise.  I suspect that the occasion you
would need to use "-r" with "git rm" is a lot less frequent than a
plain "rm".

Of course, there is no confusion if you do not quote wildcards.  By
quoting wildcards and not letting the shell to expand them, the user
tells Git that the fact _it_ sees the asterisk is because the user
is doing so on purpose---so that Git would find paths that match the
pattern.

Hope this clarifies and helps.
