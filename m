Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2938A1F461
	for <e@80x24.org>; Wed, 15 May 2019 08:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfEOIui (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 04:50:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61159 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOIui (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 04:50:38 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 78DDC62C77;
        Wed, 15 May 2019 04:50:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gd8TbRgleqJaHdjB0RJ7YHF0AH8=; b=PDfDd4
        +AckTt/bqWFdTb/zEDFclcP+tY72FApZ362/oj+ckIHpqJTvC3tvwwcEeJR7GesW
        AIC8EuxAFUOGQkRSf3zY8byH4xMXZ5vABseclPsa/RrWeneDgc2EsttAq+bFZQnF
        yJnhs0mu6WamnBo/m9zglkP+g6tmBbflKajVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hfx+Zc4/fivSut3FJRcLqgM/1YIyb7K5
        fpteobMxniANTj7F4ZpnaRo1u7L7tVIrhcQ11jUE1by7/V/IMLoHi63u2VusEeEU
        GVGLKbpStAk6NjKGy9QozCO6Djo4OvFI77zplTp3hd4uQhCWwwgC0NIuw3QZ3+3A
        Q386pJ84oF0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70FBC62C76;
        Wed, 15 May 2019 04:50:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9C70A62C68;
        Wed, 15 May 2019 04:50:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: js/difftool-no-index, was Re: What's cooking in git.git (May 2019, #02; Tue, 14)
References: <xmqqa7fqbahj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905141153150.44@tvgsbejvaqbjf.bet>
        <xmqqef508q0y.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1905151015540.44@tvgsbejvaqbjf.bet>
Date:   Wed, 15 May 2019 17:50:28 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1905151015540.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 15 May 2019 10:24:40 +0200 (DST)")
Message-ID: <xmqqsgtg5cff.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E683C3C-76EE-11E9-AAD7-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> As far as `--no-index` is concerned, all files are untracked anyway. There
> is no index, so there are no staged/committed/tracked files.
> ...

Ah, I see I completely misspoke; sorry, there should be no "pretend
as if there were no --dir-diff".

In the normal usage, "difftool --dir-diff" materializes the two
tree-shaped things (I am using an invented term loosely here---it
may be a tree-ish, or what is in the index, or the working tree
files) in two temporary directories and runs a tool to compare two
directories, and what is copied out of the working tree is limited
to the tracked ones (for the obvious purpose to avoid showing them
the the directory comparison tool).

Extending that semantics literally to "--no-index" use would result
in nonsense.  As you say, there is no "tracked" thing under the
mode, so doing what "--dir-diff" literally does (i.e. only copy out
what is tracked for the purpose of comparison) would be to compare
nothing against nothing.  That is not useful.

What I was wondering when I wrote the message you are responding to
was complete opposite.  I was imagining what would happen if we
treat _everything_ in the two directories being compared by
"difftool --dir-diff --no-index" as if it is tracked.  We do not
even have to make copies (as we are not doing a selective "only the
tracked ones" copy), but if it is easier to implement we could make
redundant copies.  In either case, the two directories given to the
"difftool --no-index" would be compared with the same directory
comparison tool the end user is used to (as that is the one the
"--dir-diff" mode uses to compare without "--no-index").  When the
end user does this sequence, for example:

    $ rm -fr /var/tmp/1 /var/tmp/2 && mkdir /var/tmp/1 /var/tmp/2
    $ (cd /var/tmp/1 && tar xvf -) <version1.tar
    $ (cd /var/tmp/2 && tar xvf -) <version2.tar
    $ git difftool --dir-diff --no-index /var/tmp/1 /var/tmp/2

isn't that what the user wanted to do?

Obviously "git difftool --dir-diff --no-index" can be replaced with
the underlying comparison tool that "difftool--helper" would have
chosen by the end user, so it is not the end of the world if we do
not to support the combination and error it out instead, like your
patch does.  But I just thought it would be nicer to the end users
who extracted two tarballs into a pair of pristine directories and
wanted to compare them in a way familiar to them.
