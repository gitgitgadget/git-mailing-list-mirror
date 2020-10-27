Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C5DC4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C649F2076D
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 22:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506891AbgJ0WyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 18:54:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53023 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2502065AbgJ0WyK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 18:54:10 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09RMs3lZ009864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Oct 2020 18:54:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 317B2420107; Tue, 27 Oct 2020 18:54:03 -0400 (EDT)
Date:   Tue, 27 Oct 2020 18:54:03 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Filipp Bakanov <filipp@bakanov.su>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Proposal: "unadd" command / alias.
Message-ID: <20201027225403.GJ5691@mit.edu>
References: <CAAdniQ5pRHKUU77XVmZkZ_gUgfYYFpo9=Xt2T6EgzJ3hoT0YMg@mail.gmail.com>
 <xmqqblgnbea5.fsf@gitster.c.googlers.com>
 <20201027215638.GI5691@mit.edu>
 <CAAdniQ4vx4z9KnfvG7thzxf1xBa=P_nnbY1G=RTFUBb4Zxqeaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAdniQ4vx4z9KnfvG7thzxf1xBa=P_nnbY1G=RTFUBb4Zxqeaw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 28, 2020 at 01:02:11AM +0300, Filipp Bakanov wrote:
> >> Indeed, I have a similar alias in my ~/.gitconfig
> 
> Why not just add it to git by default for everybody? revert-file is
> also ok, anything except `checkout HEAD --` will be good.

Because everyone may have their own favorite aliases?  Just because
*I* have the following aliases doesn't mean that everyone else would
find them useful.

[alias]
	new = !gitk --all --not ORIG_HEAD
	dw = diff --stat --summary
	di = diff --stat --summary --cached
	dc = describe --contains
	revert-file = checkout HEAD --
	l  = log --pretty=format:'%Cred%h%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
	lr = log --reverse --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
	rl  = log -g --pretty=format:'%Cred%h%Creset %gd %gs %Cgreen(%gr)%Creset %s' --abbrev-commit
	rl1  = log -g --date=relative --pretty=format:'%Cred%h%Creset %gs %Cgreen%gd%Creset %s' --abbrev-commit
	lg  = log --graph --pretty=format:'%Cred%h%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
	lgt = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
	rlt = log -g --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit
	lgt-nc = log --graph --pretty=format:'%h -%d %s (%cr)' --abbrev-commit
	st = status -s
	recent = for-each-ref --count=15 --sort=-committerdate refs/heads/ --format='%(committerdate:short) %(refname:short)'
	gerrit-clone = !bash ggh gerrit-clone
	start = !bash ggh start
	upload = !bash ggh upload
	prune-branches = !bash ggh prune-branches
	fixes = log -1 --pretty=fixes

I have a huge number of bash aliases, and that doesn't mean everyone
else should have those bash aliases.  For that matter, I have the
following in ~/bin/git-rp-ext4 so that I can type "git rp-ext4
tags/ext4_for_linus".  But that doesn't mean this script is right for
everyone....

Cheers,

					- Ted

#!/bin/sh

START=origin
URL=git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
END=""

print_help ()
{
    PROG=$(basename "$0")
    echo "Usage: $PROG [-n] [--start <START COMMIT>] [--url <URL] [<END COMMIT>]"
    exit 1
}

while [ "$1" != "" ]; do
    case $1 in
	--start) shift
		 START="$1"
		 ;;
	--url) shift
	       URL="$1"
	       ;;
	-n) NO_ACTION="echo" ;;
	-*) print_help ;;
	*)
	    if test -n "$END"
	    then
		print_help
	    else
		END="$1"
	    fi
	    ;;
    esac
    shift
done

$NO_ACTION git request-pull "$START" "$URL" "$END"

