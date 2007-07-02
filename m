From: "David Frech" <nimblemachines@gmail.com>
Subject: challenges using fast-import and svn
Date: Mon, 2 Jul 2007 12:26:17 -0700
Message-ID: <7154c5c60707021226k3a7b82fcl7558cfc66d61dde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 02 21:26:26 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5RXR-00063P-RP
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 21:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbXGBT0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 15:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753437AbXGBT0T
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 15:26:19 -0400
Received: from nz-out-0506.google.com ([64.233.162.231]:63107 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbXGBT0T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 15:26:19 -0400
Received: by nz-out-0506.google.com with SMTP id s18so987390nze
        for <git@vger.kernel.org>; Mon, 02 Jul 2007 12:26:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IBWkIgaImr0KMZzdqWCNyzwbFCBVGlEPKBHnoh8j/5vWps7FulwKY11Poyt6jrju496gnyXjXZ0bLM/XGNc9aXVQxAC6uXSzsjQXaYsv/cUSl/W7LOwS/rMLObegf1QfvALSd9EGbcWDMJE7HwTbP7A5qb+ngvPcxsKWDYGpz5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s1BualyMgoNwOpa8B2bHRgxwFKyRimB8xfA1u71l6DIeGWlVIi6KiwlL3GUh6jQJOLhy9/NmZ3LiGCNh44pIsvs3NYbUmE6tYwRMutLG8biGwII6s7QJ5qbDUd+bnRJ1QtJ+T9trBjjOiL7sFYzbmoC6Lfa9YlvnNJPBmAYeKbg=
Received: by 10.115.108.1 with SMTP id k1mr5430668wam.1183404377417;
        Mon, 02 Jul 2007 12:26:17 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Mon, 2 Jul 2007 12:26:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51394>

I have an svn repo containing several small projects that is an odd
"shape" (in terms of directories) because of its history;
git-svnimport doesn't like the directory structure, and I wasn't able
to coax it to work.

I looked around for other options, and discovered fast-import (thanks
Shawn!). I decided that the "easiest" approach would be to parse the
svn dump file and feed the commits into fast-import.

So I wrote, in Lua, a parser for the (terrible) svn dump file format
that feeds commands into fast-import. The parser took a day and a half
to write; the fast-import backend took about an hour. ;-)

However, there are issues. I don't currently track branch copies
correctly, so branches start out with no history, rather than the with
the history of the branch they are copied from; and handling deletes
is tricky.

This last thing is my main "question" to the list, although I'm
curious if anyone else has played with svn dump files, and whether my
approach makes sense.

Here is the problem: if a file or directory is deleted in svn, the
dumpfile shows simply this:

Node-path: trunk/project/file-or-directory
Node-action: delete

In the case of a file, I can simply feed a "D" command to fast-import;
but if I'm deleting a whole directory, my code knows nothing about
what files exist in that directory. Is fast-import smart about this?
Will it barf if given a directory argument rather than a file for "D"
commands?

I could cache the directory contents in my code, but isn't that partly
what fast-import is good for?

Any thoughts are welcome.

Cheers,

- David

-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
