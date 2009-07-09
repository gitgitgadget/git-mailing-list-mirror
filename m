From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: wsfix alias
Date: Thu, 9 Jul 2009 17:30:28 -0400
Message-ID: <20090709213028.GA28293@cthulhu>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com> <4A55958E.1050401@op5.se> <20090709160249.GA12830@cthulhu> <4A56590F.9050206@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jul 09 23:30:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MP1CN-0007sq-S7
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 23:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbZGIVaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 17:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754022AbZGIVa3
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 17:30:29 -0400
Received: from cthulhu.elder-gods.org ([140.239.99.253]:57103 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbZGIVa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 17:30:29 -0400
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id B7C19822106; Thu,  9 Jul 2009 17:30:28 -0400 (EDT)
Mail-Followup-To: Andreas Ericsson <ae@op5.se>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4A56590F.9050206@op5.se>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123014>

* Andreas Ericsson (ae@op5.se) [090709 16:54]:
> Larry D'Anna wrote:
>> * Andreas Ericsson (ae@op5.se) [090709 03:04]:
>>> I do have one alias, which is "wsfix". It fixes whitespace fsckups I've
>>> added to the index but not yet committed to the worktree. It's not a
>>> particularly complex one, but not exactly simple either.
>>
>> oooh, i can has?
>>
>>       --larry
>
> These are quite stupid and can lose data for you. Please use with some care.
> Oh, and I lied. I have two aliases. wsfixi is the one that applies staged
> stuff. wsfix fixes all whitespace errors since the last commit and stages
> all changes in the index. Again, use with care, and don't hang me if they
> break your day ;-)
>
> Mind the wrapping if your mua does things like that.
>
> [alias]
>  wsfix = !git diff HEAD >P.diff && git reset --hard && git apply --whitespace=fix P.diff && rm -f P.diff
>  wsfixi = !git diff --cached >P.diff && git reset && git apply --whitespace=fix P.diff && rm -f P.diff

a safer one: 

xargs -0 -I: <<'EOF' git config --file ~/.gitconfig alias.wsfix :
!
. "$(git --exec-path)"/git-sh-setup
if git-diff --quiet --exit-code; then
    if git diff --cached --check >/dev/null; then
        exit 0;
    fi
    echo fixing
    git diff --cached > $GIT_DIR/wsfix.diff
    git apply -R $GIT_DIR/wsfix.diff
    git apply --whitespace=fix $GIT_DIR/wsfix.diff
    rm -f $GIT_DIR/wsfix.diff
else
    echo wokring tree is dirty\!
fi
EOF


        --larry
