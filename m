From: David Mansfield <david@cobite.com>
Subject: new cvsps version fixes issues for cvs2git
Date: Thu, 26 May 2005 00:02:53 -0400
Message-ID: <42954A6D.6020503@cobite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
X-From: git-owner@vger.kernel.org Thu May 26 06:02:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db9Ym-0005i5-Vd
	for gcvg-git@gmane.org; Thu, 26 May 2005 06:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVEZEDS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 00:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVEZEDS
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 00:03:18 -0400
Received: from ms-smtp-03-smtplb.rdc-nyc.rr.com ([24.29.109.7]:29312 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261184AbVEZEDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 00:03:13 -0400
Received: from [192.168.0.101] (cpe-66-65-159-236.nyc.res.rr.com [66.65.159.236])
	by ms-smtp-03.rdc-nyc.rr.com (8.12.10/8.12.7) with ESMTP id j4Q434Gi008479;
	Thu, 26 May 2005 00:03:04 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I just put out the 2.1 tarball on 
http://www.cobite.com/cvsps/cvsps-2.1.tar.gz.  I tested it out with the 
syslinux, mutt, and a bunch of my own repos.  It fixes the following 
issues that were causing some of the problems with cvs2git:

1) proper detection and reporting of branch ancestry, with the -A 
option.  This patch was sent under separate cover, but now I also 
explicitly disallow the bogus 'import' branch from being an ancestor. 
The ancestor will only be reported when a new branch appears.

2) patchset ordering problems.  actual revision ancestry is considered 
when ordering the patchsets.  this mainly affects the 'patchset 1 and 
patchset 2 are swapped' problem, but could be others

3) patchset 'globbing' problems.  previously, cvsps would allow the same 
file into a patchset more than once.  this is clearly bogus, and now it 
isn't allowed, combined with #2 and some minor date tweaking, the 
ordering should be 'more perfect than ever.'

4) patchset date/time problems.  the date/time handling was bogus.  some 
of it was patched for some time in my tree, but not released.  also we 
now report all dates in LOCALTIME.  use the TZ variable to get a 
different time.  Note: 'cvs log' format is always UTC.

Linus, based on #4, you may want to set 'export TZ=UTC' before running, 
and handle date/time conversion in cvs2git counting on that.  otherwise, 
I think problems may occur with daylight savings (apr/oct).

If there are any remaining issues, let me know.

David
