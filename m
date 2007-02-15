From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Thu, 15 Feb 2007 09:40:59 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070215084059.GA5428@informatik.uni-freiburg.de>
References: <17875.13564.622087.63653@lisa.zopyra.com> <7vhctor78j.fsf@assigned-by-dhcp.cox.net> <17875.17647.74882.218627@lisa.zopyra.com> <7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net> <17875.30187.289679.417079@lisa.zopyra.com> <17875.30687.661794.512124@lisa.zopyra.com> <Pine.LNX.4.64.0702141314440.20368@woody.linux-foundation.org> <17875.33204.413186.355557@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Transfer-Encoding: 8bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 09:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHcBB-0005lx-CW
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 09:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320AbXBOIlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 03:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965277AbXBOIlV
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 03:41:21 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:36547 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965320AbXBOIlU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Feb 2007 03:41:20 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HHcB4-0000W8-Ng; Thu, 15 Feb 2007 09:41:18 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l1F8fEbC005657;
	Thu, 15 Feb 2007 09:41:14 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l1F8ex6Q005656;
	Thu, 15 Feb 2007 09:40:59 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	Bill Lear <rael@zopyra.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <17875.33204.413186.355557@lisa.zopyra.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39800>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Bill Lear wrote:
> WAAAAAIAMINIT ... I think I see it:
> 
> % perl -pi -e 's/.*\$Id.*//sx' $(xgrep -l '[$]Id')
> 
> Could I have corrupted the pack file?  I'll bet $50 I did:
> 
> % [yet another clone]
> % xgrep -l '[$]Id'
> ./.git/objects/pack/pack-23d1a9af78b4b78d1f3750cf70f83cb91a20ba64.pack
> [...]
> 
> %!@#$&$%(@@@!!!
I suffered from something like that, too.  Since then I have a script
"ufind".  It's a wrapper around find that ignores CVS, Subversion, Git
and hg metadata.  Then "my" command would be:

	$ ufind -type f -print0 | xargs -0 -r grep -lZ '[$]Id' | xargs -r perl -p -i -e 's/.../'


Where ... is something more restrictive that your .*\$Id.*

For the interessted the script is attached.

-- 
Uwe Kleine-König

cat /*dev/null; echo 'Hello World!';
cat > /dev/null <<*/ 
() { } int main() { printf("Hello World!\n");}
/* */

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ufind

#! /usr/bin/env python
# Copyright (C) Uwe Zeisberger

import itertools, os, sys

ignoreexpr = ['-type', 'd', '(', '-name', 'CVS', '-o', '-name', '.svn', '-o', '-name', '.git', '-o', '-name', '.hg', ')']
paths = list(itertools.takewhile(lambda x: x[0] not in '-(),!', sys.argv[1:]))

args = sys.argv[1 + len(paths):] or ['-true']

os.execvp('find', ['find'] + paths + ['('] + ignoreexpr + [')', '-prune', '-false', '-o', '-not', '('] + ignoreexpr + [')', '('] + args + [')'])


--M9NhX3UHpAaciwkO--
