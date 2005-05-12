From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] improved delta support for git
Date: Thu, 12 May 2005 10:16:11 -0700
Message-ID: <7vbr7gicv8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
	<7voebhkql5.fsf@assigned-by-dhcp.cox.net>
	<200505121027.01964.mason@suse.com>
	<2cfc403205051207467755cdf@mail.gmail.com>
	<2cfc403205051207471f6957e0@mail.gmail.com>
	<Pine.LNX.4.62.0505121110490.5426@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jon@blackcubes.dyndns.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 19:08:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWHAl-0006oL-Sx
	for gcvg-git@gmane.org; Thu, 12 May 2005 19:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262082AbVELRQP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 13:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262083AbVELRQP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 13:16:15 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:27793 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262082AbVELRQN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 13:16:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512171612.CGBM12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 13:16:12 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505121110490.5426@localhost.localdomain> (Nicolas
 Pitre's message of "Thu, 12 May 2005 11:18:17 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

>> On 5/13/05, Chris Mason <mason@suse.com> wrote:
>> > On Thursday 12 May 2005 00:36, Junio C Hamano wrote:
>> > > It appears to me that changes to the make_sure_we_have_it() ...
>> >
>> > If we fetch the named object and it is a delta, the delta will either depend
>> > on an object we already have or an object that we don't have.  If we don't
>> > have it, the pull should find it while pulling other commits we don't have.

NP> 1) If you happen to already have the referenced object in your local 
NP>    repository then you're done.

Yes.

NP> 2) If not you pull the referenced object from the remote repository, 
NP>    repeat with #1 if it happens to be another delta object.

Yes, that is the outline of what my (untested) patch does.

Unless I am grossly mistaken, what Chris says is true only when
we are pulling with -a flag to the git-*-pull family.  If we are
pulling "partially near the tip", we do not necessarily pull
"other commits we don't have", hence detecting delta's
requirement at per-object level and pulling the dependent
becomes necessary, which is essentially what you wrote in (2)
above.

