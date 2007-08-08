From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: git-write-tree strangeness
Date: Wed, 8 Aug 2007 18:16:20 -0400
Message-ID: <20070808221620.GA3120@dervierte>
References: <20070808154211.GA25015@dervierte> <81b0412b0708080910u3aee166fo92ea73a4a0a78ccf@mail.gmail.com> <7vabt14y08.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 00:16:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IItpU-0000nN-Br
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 00:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbXHHWQ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 18:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbXHHWQ2
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 18:16:28 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:1216 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713AbXHHWQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 18:16:27 -0400
Received: by py-out-1112.google.com with SMTP id d32so499206pye
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 15:16:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=ek5oL0GqIUhFYJJ4w2f0Q5DoJ7Ky5cXrsLti69kMuSAfyXZtMouLJLhi0SB8eetwXSqonsleuLZ1sjy/tzPZHXxNJx/HxOam6v3ABnm42aAMprGsd6cCZlItJ5M7SLvHpkykc7or5BeIJxevRe9k+oVzo4GBIT6b1lDKd+XbLwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=AaqBLFGeraSIgTxLVZYNzvZSO70TZDhyZB0EZKOksWoQAEY3HYuWYfewfJ2Jb0f5/HwtE/X6naFyHD8mvoiVlq4y8tZ39sTSj4ZPAQGMWkN84h3oDlN5HWRwOnYqQvcb+9Hhlnabk45cUEilcOmWTveNHOPca7qHT1dtOv/3Pos=
Received: by 10.35.109.2 with SMTP id l2mr2178701pym.1186611385849;
        Wed, 08 Aug 2007 15:16:25 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [74.131.26.80])
        by mx.google.com with ESMTPS id f51sm1207637pyh.2007.08.08.15.16.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Aug 2007 15:16:22 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 908857C01A2; Wed,  8 Aug 2007 18:16:20 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vabt14y08.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55380>

On Wed, Aug 08, 2007 at 12:39:03PM -0700, Junio C Hamano wrote:
> "Alex Riesen" <raa.lkml@gmail.com> writes:
> 
> > On 8/8/07, Steven Walter <stevenrwalter@gmail.com> wrote:
> >> I'm importing a large repository from svn into git with a custom tool,
> >> and I noticed a strange issue with one of the commits.
> >>
> >> Upon investigating further, I found that when I ran "git-write-tree"
> >> followed immediately by "git-diff-index <tree>" I had differences.  Does
> >> that mean that git-write-tree incorrectly recorded the index, or do I
> >> misunderstand things?
> >
> > What kind of differences? Different sha1 of content?
> > I can't simply reproduce it.
> 
> Isn't this simply just a dirty worktree and missing --cached
> option?

It doesn't happen everytime; I haven't found a set procedure to cause
the problem.  Your remark, Junio, combined with my later testing, lead
me to believe that this is not a write-tree problem, but a git-add
problem.

The entire procedure I was following was:

    <change working copy by svn>
    git add .
    git add -u
    git write-tree
    git diff-index <tree>

It seems to me that my expectation that diff-index show no changes was
reasonable, but I misunderstood the implication; I expected diff-index
to always compare the given tree to the index, regardless of the
presence or absence of a '--cached' option.

If I rebuilt git from v1.5.2 and repeated the above commands, diff-tree
showed no differences, as I would expect.  Further, if I then re-ran
write-tree/diff-index from v1.5.3-rc4, I still received no differences.
I believe this result exculpates write-tree.

Was there not a thread recently about a missing optimization in git-add?
If this change was included in v1.5.3-rc4, could it be the cause of my
discrepency?  Suggestions for testing this theory, if it is reasonable?
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
   -Robert Heinlein
