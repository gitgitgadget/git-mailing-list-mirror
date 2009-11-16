From: Blair Zajac <blair@orcaware.com>
Subject: serf causing "temp file with moniker 'svn_delta' already in use"?
Date: Mon, 16 Nov 2009 13:55:23 -0800
Message-ID: <4B01CA4B.7040103@orcaware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 16 23:11:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA9n9-0002B5-OD
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 23:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbZKPWLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 17:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbZKPWLM
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 17:11:12 -0500
Received: from orca3.orcaware.com ([12.11.234.124]:43910 "EHLO
	orca3.orcaware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191AbZKPWLL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 17:11:11 -0500
X-Greylist: delayed 952 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2009 17:11:11 EST
Received: from orca3.orcaware.com (localhost [127.0.0.1])
	by orca3.orcaware.com (8.14.3/8.14.3/Debian-9ubuntu1) with ESMTP id nAGLtNf8013933;
	Mon, 16 Nov 2009 13:55:24 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133030>

I've seen some reports of the following error using git svn and encountered it 
myself with git 1.6.5.2 with Subversion 1.6.5:

Temp file with moniker 'svn_delta' already in use at 
/opt/local/lib/perl5/site_perl/5.8.9/Git.pm line 1022.

In Googling around I seen other people discussing the issue but with no real 
root cause.

I'm guessing that it may be due to an API violation of the Subversion RA editors 
when Serf is used:

http://subversion.tigris.org/issues/show_bug.cgi?id=2932
http://n2.nabble.com/git-svn-fails-to-fetch-repository-td2151475.html

I can generate the above error on demand with Serf but if I switch to Neon then 
everything works fine.  People may be using Serf because they compiled 
Subversion with Serf and without Neon or instructed Subversion to use Serf 
instead by this setting in their ~/.subversion/servers:

[global]
http-library = serf

I haven't looked at this issue beyond being able to reproduce it with Serf and 
without Neon, but hope this gives some direction to the issue.

This bug may get fixed in Subversion as we want to move to Serf as the default 
HTTP client away from Neon and this is one of the outstanding issues before 
making that switch.

Regards,
Blair
