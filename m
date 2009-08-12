From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Implementing $Date$ substitution - problem with git status
Date: Wed, 12 Aug 2009 07:54:44 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0908120751500.30907@ds9.cixit.se>
References: <alpine.DEB.2.00.0908092127420.17141@perkele.intern.softwolves.pp.se> <200908092252.58363.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 08:55:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb7jh-00034D-PI
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 08:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618AbZHLGyu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 02:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbZHLGyu
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 02:54:50 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:55070 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752498AbZHLGyu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 02:54:50 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n7C6sijT031124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 12 Aug 2009 08:54:44 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n7C6sisv031120;
	Wed, 12 Aug 2009 08:54:44 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <200908092252.58363.j6t@kdbg.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 12 Aug 2009 08:54:45 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125672>

Johannes Sixt:

>> Doing "git reset --hard" or "git checkout master filename" does not 
>> help, the file is still believed to be modified by git.

> Now, that's an entirely different problem, and I think that there is a 
> bug. I have observed this as well with my own clean filter sometimes, but 
> not always. I haven't found a recipe that reliably exhibits the problem.

After som examination, it seems to be caused by the way I imported the CVS 
history: I kept all the $ keywords expanded in history (so that if I check 
out an old version from Git, it looks like it did in CVS). This means that 
still in the latest revision of several files, I have "$Id$" lines checked 
in in CVS format.

However, as I have set the "ident" attribute, Git wants to expand it itself 
and check in files with "$Id$". When I do a reset, it seems it records the 
entry as clean against a version stored with just "$Id$", but the record in 
history has an expanded "$Id$", and the entry is thus never deemed clean.

I can probably work around this by removing the "$Id$" attributes, or by 
removing the "ident" rule.

-- 
\\// Peter - http://www.softwolves.pp.se/
