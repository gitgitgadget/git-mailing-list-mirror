From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Site dependent repositories
Date: Sun, 21 Aug 2011 00:21:16 -0400
Message-ID: <AA0C484C-FD80-4C76-9E45-4BAE51B87ED7@kellerfarm.com>
References: <4E507C05.2090700@sbcglobal.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 21 07:11:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qv0JR-0007Nx-6B
	for gcvg-git-2@lo.gmane.org; Sun, 21 Aug 2011 07:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901Ab1HUFLC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 01:11:02 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:45879 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab1HUFLB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Aug 2011 01:11:01 -0400
X-Greylist: delayed 2979 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Aug 2011 01:11:01 EDT
Received: from c-208-53-113-112.customer.broadstripe.net ([208.53.113.112] helo=[192.168.0.198])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1QuzX8-0002tl-0R
	for git@vger.kernel.org; Sun, 21 Aug 2011 00:21:14 -0400
In-Reply-To: <4E507C05.2090700@sbcglobal.net>
X-Mailer: Apple Mail (2.1084)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179794>

On Aug 20, 2011, at 11:31 PM, Stewart A. Brown wrote:

> I have git repositories at multiple sites.  At each site the git repository
> has site dependent sources.  Each repository is organised something
> like:
> 
> top/a/local
>      b
>      c/d/extensions
>      e
> 
> The directories top, a, b, c, d, and e have sources that need to be
> pushed or pulled between the repositories at all sites.  The directories
> 'local' and 'extensions' have sources that must be managed within sites
> but never pushed or pulled between sites.
> 
> The ignore mechanism will not suffice because the files in 'local' and
> 'extensions' must be source managed.  I have looked a bit into
> submodules, filters, and hooks.  None of these jumps out as obvious, but
> they are rich mechanisms with plenty of subtleties.
> 
> Does git have a way of letting me do this?

No.

Have you considered using a sort of configuration switch?  Include all local and extension files for every site in the repository, and devise some sort of a switch that detects which site you're in, and creates a link to the correct subfolder.

So, for example, when you first clone the repository, top/a/local would contain:

site1/
site2/
site3/

And so on.  Then, upon running a script of some sort (perhaps a make script), the site is detected (or inputted), and a symbolic link could be created to the correct folder.  At this point, top/a/local would contain:

active -> site2
site1/
site2/
site3/

where 'active' is a symbolic link pointing to the correct folder.  This symbolic link would be a candidate for a .gitignore file.

This way, any change you make in one of the site-specific folders is still tracked in the repository.  Of course, this has the disadvantage that each site has access to the files of every site.  Depending on your situation, that might be a show stopper.

HTH
~ Andrew Keller
