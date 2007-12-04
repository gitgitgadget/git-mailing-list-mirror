From: Reid Barton <rwbarton@MIT.EDU>
Subject: git-add--interactive works only in top level
Date: Mon, 3 Dec 2007 22:19:32 -0500
Message-ID: <058EB5A2-1EFE-43B9-9886-7272A955CE51@mit.edu>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 04 04:41:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzOeg-0004Lf-AU
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 04:41:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbXLDDkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 22:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbXLDDkO
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 22:40:14 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:49882 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751355AbXLDDkN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Dec 2007 22:40:13 -0500
X-Greylist: delayed 1316 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2007 22:40:12 EST
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id lB43IFBX020131
	for <git@vger.kernel.org>; Mon, 3 Dec 2007 22:18:15 -0500 (EST)
Received: from [192.168.1.153] (pool-96-233-67-106.bstnma.fios.verizon.net [96.233.67.106])
	(authenticated bits=0)
        (User authenticated as rwbarton@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id lB43IDhI027035
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 3 Dec 2007 22:18:14 -0500 (EST)
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67001>

When the working directory is not the top of the working tree, git- 
add--interactive fails silently and confusingly.  In this example,  
the working tree is rooted at ~/sandbox/foo and ~/sandbox/foo/bar/x  
is a file that's been edited.

rwbarton@homothety:~/sandbox/foo/bar$ git-add--interactive
            staged     unstaged path
   1:    unchanged        +1/-0 bar/x

*** Commands ***
   1: status       2: update       3: revert       4: add untracked
   5: patch        6: diff         7: quit         8: help
What now> 5
            staged     unstaged path
   1:    unchanged        +1/-0 bar/x
Patch update> 1

*** Commands ***
   1: status       2: update       3: revert       4: add untracked
   5: patch        6: diff         7: quit         8: help
What now>

Rather than returning to the main menu, git-add--interactive should  
have showed me a list of chunks.  It seems that the list of files is  
relative to the working tree root (which is sensible) but when git- 
add--interactive invokes git-diff-files it does not take this into  
account.  Perhaps git-diff-files should also complain when invoked as

git-diff-files -- non-existent-file-name

so it wouldn't have taken me half an hour to track this down.

Regards,
Reid Barton
