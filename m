From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git-svn: .git/svn disk usage
Date: Wed, 5 Dec 2007 13:30:10 -0800
Message-ID: <6D1288C9-8FD7-40CB-BA0B-0032F8D2DA6A@midwinter.com>
References: <65dd6fd50712022217l5f807f31pf3f00d82c3dccf5c@mail.gmail.com> <loom.20071203T182924-435@post.gmane.org> <20071205085451.GA347@soma>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: David Voit <david.voit@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Dec 05 22:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J01pC-00047e-0T
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 22:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbXLEVaN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 16:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbXLEVaN
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 16:30:13 -0500
Received: from tater.midwinter.com ([216.32.86.90]:57638 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751755AbXLEVaL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 16:30:11 -0500
Received: (qmail 15703 invoked from network); 5 Dec 2007 21:30:10 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=dkKdwQ2x/gOGuWVSDgAAGbq9tNoGWjwqqQU40AXu5rGug6mGf2swFIxD9Lmu5Mvt  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 5 Dec 2007 21:30:10 -0000
In-Reply-To: <20071205085451.GA347@soma>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67197>

How about using git itself to keep some of this information? I'll just  
throw this idea out there; might or might not make any actual sense.

Create a new "git-svn metadata" branch. This branch contains a fake  
directory (never intended for checkout, though you could do it) that  
has a "file" for each svn revision. The filename is just the svn  
revision number, maybe divided into subdirectories in case you want to  
check the branch out for debugging purposes or whatever. The contents  
are the git commit SHA1 and whatever other metadata you want to keep  
in the future.

The advantage of doing it this way? You can pass around svn metadata  
using the normal git fetch/push tools, query the metadata using "git  
show", etc. In terms of data integrity, it's as secure as anything  
else in a git repository, much more so than a separately maintained db  
file under .git.

Along similar lines, a separate branch where the filenames are commit  
SHA1s and the file contents are the stuff that currently gets written  
into the git-svn-id: lines would mean no more need to rewrite history  
when doing dcommit, and thus easier mixing of native git workflows and  
interactions with an svn repository.

It would be great if you could clone a git-svn repository and then do  
"git svn dcommit" from the clone, secure in the knowledge that things  
will stay consistent even if the origin gets your changes via "git svn  
fetch" rather than from you.

-Steve
