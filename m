From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 4/5] cvsserver: Make the database backend configurable
Date: Fri, 23 Mar 2007 16:17:58 +0100
Message-ID: <20070323151757.GH8017@planck.djpig.de>
References: <11743197614111-git-send-email-frank@lichtenheld.de> <11743197611364-git-send-email-frank@lichtenheld.de> <46a038f90703191247y6b70c272s2473ab28acd63682@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 16:18:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUlWp-0003bL-VR
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 16:18:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945909AbXCWPSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 11:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945911AbXCWPSE
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 11:18:04 -0400
Received: from planck.djpig.de ([85.10.192.180]:36610 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934081AbXCWPSB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 11:18:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 76EB888136;
	Fri, 23 Mar 2007 16:17:59 +0100 (CET)
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (smtp.lichtenheld.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22561-08; Fri, 23 Mar 2007 16:17:58 +0100 (CET)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 3020088137; Fri, 23 Mar 2007 16:17:58 +0100 (CET)
Mail-Followup-To: Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46a038f90703191247y6b70c272s2473ab28acd63682@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lichtenheld.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42939>

On Tue, Mar 20, 2007 at 07:47:12AM +1200, Martin Langhoff wrote:
> On 3/20/07, Frank Lichtenheld <frank@lichtenheld.de> wrote:
> >Make all the different parts of the database backend connection
> >configurable. This adds the following string configuration variables:
> 
> Nice. I guess the hard part of this is going to be creating DB schemas
> that are reasonably portable. The SQL we use is as vanilla as it gets
> ;-)

I've now actually made a quick test to see how we do when using other
backends (with PostgreSQL 8.2, will also do one with MySQL later).

Some problems that I saw:

 - It would probably cool to be able to tell git-cvsserver that it
   should use only one database for all modules (i.e. git branches)
   This way one doesn't need to give the users database creation
   privileges. Of course pre-creating all databases possibly ever needed
   is possible but somewhat cumbersome.
 
 - DBI->tables seems to be a portability problem. e.g. with SQLite
   it returns "head", "commitmsgs", etc; with PostgreSQL it returns
   public.head, public.commitmsgs, etc. The output of MySQL might
   be different, too.

> >Both dbname and dbuser support dynamic variable substitution where
> >the available variables are:
> >%m -- the CVS 'module' (i.e. GIT 'head') worked on
> >%a -- CVS access method used (i.e. 'ext' or 'pserver')
> >%u -- User name of the user invoking git-cvsserver
> >%G -- .git directory name
> >%g -- .git directory name, mangled to be used in a filename,
> >      currently this substitutes all chars except for [\w.-]
> >      with '_'
> 
> It's missing from the POD though ;-)

You mean the asciidoc, right?

And yeah, I know. Writing English documentation is not actually one of my
preferred occupations :/ Will do it, though.

[...]
> with those 2 in place, we'd have a means of applying a "vampire tap"
> to an existing cvs server and take over without anyone noticing. But
> tehy are both hard, hard hard.

Indeed.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
