From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Distinguishing trivial and non-trivial merge commits
Date: Sun, 2 May 2010 15:29:44 -0500
Message-ID: <20100502202943.GB16746@progeny.tock>
References: <19419.1721.763210.679444@winooski.ccs.neu.edu>
 <20100502181854.GC16051@progeny.tock>
 <19421.54064.178345.489772@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sun May 02 22:29:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8fnU-00041f-7b
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 22:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756998Ab0EBU3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 16:29:45 -0400
Received: from mail-iw0-f202.google.com ([209.85.223.202]:43091 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab0EBU3o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 16:29:44 -0400
Received: by iwn40 with SMTP id 40so2391257iwn.1
        for <git@vger.kernel.org>; Sun, 02 May 2010 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Yax74YcMZ13Gt4FCBIfxqbub1tQtd+Gj5R5OQnENvFY=;
        b=oat8mK3bm1y798xnwRixsGH2g+9j/xKcaDMvvR1h9bf4M8TVTso4fulFjepxnTTi3e
         Vd43/5iWk5SUqPeJP2dBqqrCvGJaGf36r4mqSdIfH+d/Du3tXtqnFMflk12kTReltLic
         Uvu9pv9rFKSZRuB9JQNvmdyZVmMPCgva0VWWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KmCTcgDFjbhsiLRniR7ydd0dZ9TubmKfAQ5sNQ2VogU42PEqKKZTQvwxwuB6m81KsQ
         BWXXM0qeiCv5FlWaahkJbGuDxLgZ3OO5/gCL+ePa/0DqsE95Z8tsuCM2ALtsUDEENr4h
         ga8pGKsoTZHh7dbyyKYQoKJAxQ8OBS54yxsPA=
Received: by 10.231.147.15 with SMTP id j15mr4003740ibv.91.1272832183160;
        Sun, 02 May 2010 13:29:43 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm3678337iwn.15.2010.05.02.13.29.41
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 02 May 2010 13:29:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19421.54064.178345.489772@winooski.ccs.neu.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146201>

Eli Barzilay wrote:
> On May  2, Jonathan Nieder wrote:

>> Note that most conflicts will not show up here: if the merge result
>> matches either parent, then git diff --cc and friends will not
>> consider it interesting at all.
>
> Isn't that a good definition of a trivial commit?  I'm not talking
> about the whole commit -- just any file that is not identical to one
> of its parents.
[...]
> For my purpose, I basically just want
> to know whether there was manual tweaking involved in the merge.

diff --name-only follows exactly the example heuristic you described.
It still does not catch all manual merge resolutions[1].

Sometimes two branches introduce different changes to completely
separate parts of a file.  This is not a conflict, and diff --cc will
correctly report the merge as trivial (whereas diff --name-only does
not pay enough attention to do the same).

On the other hand, sometimes two branches introduce conflicting
changes, but the correct resolution for each conflict hunk is to pick
one as winner.  Though simple, this can be error-prone, because
rejecting one change from branch A might end up breaking another
change that was accepted from the same branch.  diff --cc examines
only the selected revision and its parents and for all it knows, this
is just another trivial merge.

>  git show --pretty=format:"" --name-only "$r" | grep -q "."
>    --> test if it's trivial

I would have expected

	git show --name-only --exit-code --quiet "$r"

to take care of this, but apparently it always exits zero.  Probably
no one had tried it before.

> (My script generally "compensates" for git being fast by running a ton
> of them for each email...)

:)

Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/89415
