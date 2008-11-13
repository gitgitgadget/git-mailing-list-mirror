From: James Pickens <jepicken@gmail.com>
Subject: Re: hosting git on a nfs
Date: Thu, 13 Nov 2008 18:32:53 +0000 (UTC)
Message-ID: <loom.20081113T174625-994@post.gmane.org>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 19:34:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0h1M-0005am-0I
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 19:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbYKMSdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 13:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbYKMSdH
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 13:33:07 -0500
Received: from main.gmane.org ([80.91.229.2]:48984 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751268AbYKMSdG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 13:33:06 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1L0h00-0001Xp-OV
	for git@vger.kernel.org; Thu, 13 Nov 2008 18:33:00 +0000
Received: from jfdmzpr01-ext.jf.intel.com ([134.134.139.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 18:33:00 +0000
Received: from jepicken by jfdmzpr01-ext.jf.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Nov 2008 18:33:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.134.139.70 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.3) Gecko/2008092417 Firefox/3.0.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100895>

Linus Torvalds <torvalds <at> linux-foundation.org> writes:
> Doing an 'lstat()' on every single file in the tree would tend to do that 
> to you, yes. Even with a fast network and a good NFS server, we're talking 
> millisecond-range latencies, and if your tree has tens of thousands of 
> files, you're going to have each "git diff" take several seconds.

Is there any way to improve 'git status' performance on nfs?  I know nothing
about how that code works, but if it's strictly serial, i.e. it waits for the
result of each lstat() before doing the next lstat(), then perhaps it could be
sped up by overlapping the lstat() calls via multi threading.

Reason I ask is that at my work place, using only local disks would be
difficult.  We run lots of long running tests in a server farm, and working on
nfs allows the compute servers to access our data transparently.
