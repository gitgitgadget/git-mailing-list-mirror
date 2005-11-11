From: Becky Bruce <becky.bruce@freescale.com>
Subject: file descriptor leak? or expected behavior?
Date: Fri, 11 Nov 2005 16:58:39 -0600
Message-ID: <dd9dee136a573d72fc7332373cfd8ac1@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 11 23:59:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eahr1-0002Jf-0e
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 23:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbVKKW6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 17:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbVKKW6j
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 17:58:39 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:57774 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751305AbVKKW6i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 17:58:38 -0500
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id jABN8G43028564
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 16:08:16 -0700 (MST)
Received: from [192.168.1.101] (mvp-10-214-72-75.am.freescale.net [10.214.72.75])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id jABN5jtn023701
	for <git@vger.kernel.org>; Fri, 11 Nov 2005 17:05:45 -0600 (CST)
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.623)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11643>

Folks,

My apologies if this is a known issue/question - I've searched the list 
and haven't found anything about this, but given the volume of traffic, 
it's easy to miss things.....

I grabbed 0.99.9g this morning, and tried to clone Paul Mackerras' 
linux merge tree. The clone failed and reported errors in http-fetch 
with a bunch of messages of the form:

error: Couldn't create temporary file 
.git/objects/04/48fa7de8a416a48cd1977f29858be54e67c078.temp for .git
/objects/04/48fa7de8a416a48cd1977f29858be54e67c078: Error 24: Too many 
open files

I did some experimenting, and it looks like this crops up somewhere 
between git versions  0.99.8f and 0.99.9a.  My question is, is git 
expected to try to open huge numbers of files, or is this a fd leak? I 
cranked up my ulimit, and am still unable to successfully clone this 
tree, although it fails differently (tail end of output....):

progress: 22 objects, 56146 bytes
Also look at 
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
Getting pack list
error: The requested URL returned error: 404
Getting pack list
Getting index for pack e0d76ffe354ef5665028a6cb4506ea902f72e1d0
Getting pack e0d76ffe354ef5665028a6cb4506ea902f72e1d0
which contains 5014bfa48ac169e0748e1e9651897788feb306dc
progress: 1322 objects, 5736795 bytes
cg-fetch: objects fetch failed
cg-clone: fetch failed


The command I ran, and the tree I tried to clone are:

 > cg-clone 
http://www.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git 
linux-2.6.paul

Cheers,
-B
