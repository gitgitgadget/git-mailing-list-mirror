From: Junio C Hamano <junkio@cox.net>
Subject: Re: describe fails on tagless branch
Date: Wed, 07 Feb 2007 01:58:02 -0800
Message-ID: <7vy7na8f2t.fsf@assigned-by-dhcp.cox.net>
References: <eqb660$ft7$1@sea.gmane.org> <45C92918.8010801@xs4all.nl>
	<7vr6t2g1dt.fsf@assigned-by-dhcp.cox.net>
	<200702070922.57163.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hanwen@xs4all.nl
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 10:58:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEjZ6-0007MU-R0
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 10:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030617AbXBGJ6F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 04:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030618AbXBGJ6F
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 04:58:05 -0500
Received: from fed1rmmtai17.cox.net ([68.230.241.42]:60809 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030617AbXBGJ6E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 04:58:04 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207095803.FEDS1343.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 04:58:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LZy21W0071kojtg0000000; Wed, 07 Feb 2007 04:58:02 -0500
In-Reply-To: <200702070922.57163.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 7 Feb 2007 09:22:54 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38904>

Andy Parkins <andyparkins@gmail.com> writes:

> On Wednesday 2007 February 07 02:14, Junio C Hamano wrote:
>
>> I do not think it a good idea to make "git-describe" itself do
>> the above, as the user of describe may want to fall back on
>> something other than "rev-parse --verify" after ||.
>
> Agreed - the "nearest tag" mode (--abbrev=0) would be broken in that it 
> git-describe would return a tag that doesn't exist.

"describe" is about giving a short name for public communication
to a commit in terms of well known tags.  If there is no tag,
then it is natural to say that the commit is indescribable.

In the case of "git-describe --abbrev=0 $indescribable", it
could return an empty string, since there is no nearest tag
after all.  But that would not apply to non --abbrev=0 case.

Really, people should not be afraid to script a few-liner.  Who
cares if "git describe HEAD" says "can't" in an interactive
session?  And if you are scripting, and if you want your script
to say something usable even for indescribable commits, then you
would want to have an easy way to tell if the commit is
describable or not.  Changing it not to fail like it currently
does means the script needs to do something more than just check
the return value from describe $? in order to fall back on
whatever alternative behaviour it wants to implement.

It might not be a bad idea to give '-q' option to make it silent
when it fails because the commit is indescribable.
