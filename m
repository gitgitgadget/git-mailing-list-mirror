From: "Korzynski, Aleksander" <aleksander.korzynski@hp.com>
Subject: underscore in Subversion branch name
Date: Wed, 23 Mar 2011 12:12:55 +0000
Message-ID: <4D89E3C7.6060302@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 23 13:13:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2Mw2-0007TS-L0
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 13:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754896Ab1CWMNF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 08:13:05 -0400
Received: from g4t0016.houston.hp.com ([15.201.24.19]:5987 "EHLO
	g4t0016.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab1CWMNE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 08:13:04 -0400
Received: from g4t0018.houston.hp.com (g4t0018.houston.hp.com [16.234.32.27])
	by g4t0016.houston.hp.com (Postfix) with ESMTP id 469D114C32
	for <git@vger.kernel.org>; Wed, 23 Mar 2011 12:13:03 +0000 (UTC)
Received: from [16.25.172.53] (dhcp-172-53.hpl.hp.com [16.25.172.53])
	by g4t0018.houston.hp.com (Postfix) with ESMTP id E5F141029B
	for <git@vger.kernel.org>; Wed, 23 Mar 2011 12:13:02 +0000 (UTC)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110222 Red Hat/3.1.8-4.el6_0 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169823>

Dear Git Support,

I'm cloning a Subversion repository to Git. A bug in Git is triggered by 
an underscore in the name of one of the Subversion branches.

I use the following command (note: some names are changed):

$ git svn clone https://AAA.FFF.com/svnroot/BBB -s

The process dies with the following error (names changed):

> Found possible branch point: https://AAA.FFF.com/svnroot/BBB/trunk/CCC => https://AAA.FFF.com/svnroot/BBB/branches/DD_EEEEEEE, 100
> fatal: Not a valid object name refs/remotes/DD EEEEEEE
> cat-file commit refs/remotes/DD EEEEEEE: command returned error: 128

Note that in the top line, the name of the branch contains an 
underscore: "DD_EEEEEE". However, in the middle line, the branch name 
contains a space: "DD EEEEEE". Apparently, Git at some point translates 
the underscore in the name of the Subversion branch into a space.

I've had a look at the source code and the process dies inside 
resolve_local_globs() in the git-svn script. A command at the beginning 
of that subroutine is:

command(qw#for-each-ref --format=%(refname) refs/#)

When I run the following by hand:

$ git for-each-ref --format='%(refname)' refs

one of the output lines is:

refs/remotes/DD%20EEEEEEE

So it has a sanitised space (%20) at that point already, instead of an 
underscore.

Git version: 1.7.1

Best regards,
Aleksander Korzynski
