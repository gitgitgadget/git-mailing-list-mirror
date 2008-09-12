From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 10:50:21 +0200
Message-ID: <20080912085021.GC15391@cuci.nl>
References: <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org> <20080911192356.GC1451@cuci.nl> <alpine.LFD.1.10.0809111534300.23787@xanadu.home> <20080911195516.GE1451@cuci.nl> <alpine.LFD.1.10.0809111604040.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 10:52:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke4OA-0004lC-1j
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 10:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbYILIuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 04:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbYILIuX
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 04:50:23 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:60540 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbYILIuW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 04:50:22 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 358FE5465; Fri, 12 Sep 2008 10:50:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809111604040.23787@xanadu.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95693>

Nicolas Pitre wrote:
>On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
>> Nicolas Pitre wrote:
>> >On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
>> >> when doing things with temporary branches.  The origin field is meant to
>> >> be filled *ONLY* when cherry-picking from one permanent branch to
>> >> another permanent branch.  This is a *rare* operation.

>> >... and therefore you might as well just have a separate file (which 
>> >might or might not be tracked by git like the .gitignore files are) 
>> >to keep that information?  Since this is a rare operation, modifying the 
>> >core database structure for this doesn't appear that appealing to most 
>> >so far.

>> For various reasons, the best alternate place would be at the trailing
>> end of the free-form field.  Using a separate structure causes
>> (performance) problems (mostly).

>Did you try it?

No.

>  I don't particularly buy this performance argument, and 
>the bulk of my contributions to git so far were about performances.  It 
>is quite easy to load a flat file with sorted commit SHA1s, and given 
>that origin links are the result of a rare operation, then there 
>shouldn't be too many entries to search through.  Hell, doing 213647 

True.

>lookups (and many other things like inflating zlib deflated data)  with 
>each of them for commit objects in my Linux repository which has 1355167 
>total entries takes only 6 seconds here, or about a quarter of a 
>milisecond for each lookup.  I doubt doing an extra lookup in a much 
>smaller table would show on the radar.

Maybe you're right.  The reason why my first knee-jerk reaction is
"performance problem" is because:
- The field is rarely present.
- When it is used, we look for it on every commit we traverse.
- This means that finding out the field does *not* exist is the most
  common operation, and that effort rises linearly with the number of
  commits visited.

Whereas if the information is present in the header or trailer of the
commit, finding out that the field does not exist there is rather
cheap.  But you could very well be right, that the absolute extra time
spent might be negligible for all intents and purposes.

Nonetheless, the data-integrity argument still holds, i.e. placing it in
the commit (header or trailer) automatically protects it.  External
files need extra care if you want the same integrity protection.
-- 
Sincerely,
           Stephen R. van den Berg.

"Father's Day: Nine months before Mother's Day."
