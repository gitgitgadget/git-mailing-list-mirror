From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 09:19:52 +0100
Message-ID: <81b0412b0703140119s4691211bw8a5ef3ba25c5cbdf@mail.gmail.com>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
	 <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
	 <7vveh4hapk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 14 09:20:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HROiK-0003cL-54
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 09:20:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933122AbXCNITz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 04:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751727AbXCNITz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 04:19:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:56166 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbXCNITy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 04:19:54 -0400
Received: by nf-out-0910.google.com with SMTP id o25so118596nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 01:19:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VNw/rTi93RdTvvFlA9m5kmbu2/Dsm7+nWV5164H65HGfjpkM6lW7HlbQq2fXlJy3BTX8NKp8RA+QdUbSWmV+UIF3Ruz86puSRjotUGhxizoR9REWJLV5wfl2yCqJo10xkFBcUcU5TIp+W3Q3EkO9SwlnFKHOTDQUJq48s3fW2ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N4BPv+DvjlPtoTi/MrEeuaP8rXKse6QbjhGQPQwQSZ5hhxg280bFhClRlGUCB6qk0zS6foQlu0LHYQfmJW2xKyAtPlZX2we1o7fOEwQshN5e2OPsDJsOepZn2nOFFf71BUI69u5m2/7UGZAa351CMUKCByQEZVqio4jp7dPx7yQ=
Received: by 10.78.20.13 with SMTP id 13mr406983hut.1173860392776;
        Wed, 14 Mar 2007 01:19:52 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 01:19:52 -0700 (PDT)
In-Reply-To: <7vveh4hapk.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42183>

On 3/14/07, Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> > On Wed, 14 Mar 2007, Alex Riesen wrote:
> >>
> >> This introduces a new command-line option: --exit-code. The diff
> >> programs will return 1 for differences, return 0 for equality, and
> >> something else for errors.
> >
> > I don't think you should need a new command-line option.
> >
> > Is there any reason to not just do this unconditionally?
>
> Exiting with 0 for no-change, 1 for has-change and other value
> for error is something that falls into the
>
>     "I wish if we did it from day one, but now many people's
>     scripts depend on the behaviour, and heck we ourselves say
>     that the right way to see if there is difference is to check
>     if the output is an empty string (look at a few scripts of
>     our own), so it would be a huge backward compatibility
>     hassle"
>
> category.
>
> e.g.
>
> git-am.sh:      files=$(git-diff-index --cached --name-only HEAD) || exit
> git-am.sh:      changed="$(git-diff-index --cached --name-only HEAD)"

Isn't this crazy? Get the information and never really use it?
The second one does not check for errors, BTW. Will
break if someone sends enough files in one commit to go past
local limit on shell variable size (or the local limit on process size,
which is much worse situation: everything gets swapped out).

> And I expect people's scripts are modelled after how git's
> scripts do things --- if they were half competent, they'd know
> that would be the way to make sure their scripts would be
> compatible with future plumbing changes.

That is expert level. The half competents are used to diff(1).
