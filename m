From: Bryan Jacobs <bjacobs@woti.com>
Subject: git-svn and mergeinfo
Date: Mon, 29 Aug 2011 13:20:52 -0400
Organization: White Oak Technologies
Message-ID: <20110829132052.0ad7a088@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 19:27:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy5cU-0000r7-Ma
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 19:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab1H2R13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 13:27:29 -0400
Received: from mail02.woti.us ([66.92.158.6]:44528 "EHLO roscoe.woti.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750948Ab1H2R12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 13:27:28 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Aug 2011 13:27:28 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by roscoe.woti.com (Postfix) with ESMTP id 978A7504D37EE
	for <git@vger.kernel.org>; Mon, 29 Aug 2011 13:20:53 -0400 (EDT)
X-Virus-Scanned: amavisd-new at woti.com
Received: from roscoe.woti.com ([127.0.0.1])
	by localhost (roscoe.woti.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1KbcZfdSCILz for <git@vger.kernel.org>;
	Mon, 29 Aug 2011 13:20:53 -0400 (EDT)
Received: from robyn.woti.com (robyn.woti.com [192.168.168.187])
	by roscoe.woti.com (Postfix) with ESMTPSA id 54FB1504D37EA
	for <git@vger.kernel.org>; Mon, 29 Aug 2011 13:20:53 -0400 (EDT)
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; x86_64-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180324>

Dear git Developers,

Apologies if this is not the right forum for bug reports. I was unable
to find a Bugzilla/Redmine/Flyspray instance for issue maintenance, nor
some "proper procedure" on the git web page.

I have been (ab)using git-svn for committing to a central SVN
repository while doing my work locally with git. To this end, I've
written a set of scripts and hooks which perform squash merges locally
and then dcommit them with proper svn:mergeinfo annotations. The final
result is the perfect appearance of having done a native SVN merge in
the central repository, while using only local git commands and
gaining the full benefit of git's conflict resolution and developer
convenience.

However, to make this work with git 1.7.6, I needed to make *one* change
to the git internals: --merge-info does not allow setting mergeinfo for
more than one branch. Because it's a complete overwrite operation
instead of an update, this is a serious issue preventing its use for
nontrivial branches.

Might I suggest adding a block like the following around line 552 of
git-svn?

    if (defined($_merge_info))
    {  
        $_merge_info =~ tr{ }{\n};
    }

This will replace any spaces in --merge-info with newlines, allowing
specification of an svn:mergeinfo that contains merges from more than a
singe branch. So the user can provide "--merge-info
'/branch1:r2323-3849,r8888 /branch2:r9999'" and the like.

Thank you for your consideration. I am not subscribed to this list, so
if there are any replies, please copy my address.

Bryan Jacobs
