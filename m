From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Mon, 20 Feb 2006 01:47:29 -0800
Message-ID: <7vd5hicqfi.fsf@assigned-by-dhcp.cox.net>
References: <7v3bieea32.fsf@assigned-by-dhcp.cox.net>
	<43F97F0D.9080500@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 20 10:47:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FB7dn-0002YY-21
	for gcvg-git@gmane.org; Mon, 20 Feb 2006 10:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWBTJrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Feb 2006 04:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbWBTJrb
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Feb 2006 04:47:31 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56000 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932423AbWBTJrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2006 04:47:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060220094605.QCJW20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Feb 2006 04:46:05 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43F97F0D.9080500@op5.se> (Andreas Ericsson's message of "Mon, 20
	Feb 2006 09:34:21 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16473>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>>
>> The updated pack-object series is now in "next" branch, and
>> seems to be cooking nicely.  The "reuse from existing pack"
>> change seems to be a huge win and I haven't found problems in
>> there.
>
> Wonderful news. I'll cherry-pick them and do some further testing.

BTW, the point of "next" is that you do not have to necessarily
cherry pick.  The topic branches in there are supposed to be in
testable shape.

Having said that, you could disect them out if you wanted to:

$ git log --pretty=oneline next | grep jc/pack- | head -n 8
5be4eabf90a4f6d14d3ae16772e6b2e063d71587 Merge branch 'jc/pack-thin' into next
bb837eccf42e5e8bbd4fe0927e7fa2afcfd2b564 Merge branch 'jc/pack-thin' into next
416b3cb4303e1a13ed05413bef7a0c1b9f7fc09e Merge branch 'jc/pack-reuse'
07e8ab9be913bd50595707f21a896ac15c4f5a89 Merge branch 'jc/pack-reuse'

The tip of jc/pack-reuse (that is the "reuse data from existing
packs" topic branch) jc/pack-thin ("thin packs") are at 416b3c^2
and 5be4ea^2 respectively.

So to check out the "reuse", you would:

$ git branch -f jc/pack-reuse 416b3c^2
$ git pull . jc/pack-reuse

If you want to try out "thin packs", you would need both
pack-objects change and rev-list change (the tip of jc/rev-list
is at 8c0db2^2).

$ git branch -f jc/rev-list 8c0db2^2
$ git branch -f jc/pack-thin 5be4ea^2
$ git pull . jc/pack-thin
$ git pull . jc/rev-list
