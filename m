From: Joachim Berdal Haga <cjbhaga@broadpark.no>
Subject: Re: [PATCH] git clean: Don't automatically remove directories when run
 within subdirectory
Date: Tue, 15 Apr 2008 08:33:23 +0200
Message-ID: <48044C33.20006@broadpark.no>
References: <85fxtvj6y8.fsf_-_@lupus.strangled.net>
 <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com>
 <7v8wzgaoqy.fsf@gitster.siamese.dyndns.org>
 <20080414170643.GA10548@mediacenter> <48039FE5.5060309@broadpark.no>
 <20080415034417.GA2882@lintop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 08:34:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlek9-0008M9-W3
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 08:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347AbYDOGd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 02:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbYDOGd2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 02:33:28 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:50053 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbYDOGd1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 02:33:27 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0JZC00AXKSVP4H80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 15 Apr 2008 08:33:25 +0200 (CEST)
Received: from pep ([80.203.45.22]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0JZC009V4SVOXL31@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 15 Apr 2008 08:33:25 +0200 (CEST)
Received: from localhost ([127.0.0.1])	by pep with esmtp (Exim 4.69)
	(envelope-from <cjbhaga@broadpark.no>)	id 1JlejM-0003GL-3P; Tue,
 15 Apr 2008 08:33:24 +0200
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
In-reply-to: <20080415034417.GA2882@lintop>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: cjbhaga@broadpark.no
X-SA-Exim-Scanned: No (on pep); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79569>

Shawn Bohrer wrote:
> On Mon, Apr 14, 2008 at 08:18:13PM +0200, Joachim Berdal Haga wrote:
>> I think that the best option would be to never remove a directory, even if
>> given explicitly, unless -d is given. Because my gut feeling is that when a
>> directory name is specified, it is most often meant as "clean inside the
>> given directory", ie. as a path delimiter.
> 
> If there are no tracked files the only difference between the dir/ and
> dir case is that the former will leave behind an empty directory.  So
> the difference between too much and too little is of little importance.

No, check this out; note that only in the very last case dir/subdir/subfile
would be removed.

$ git init; mkdir -p dir/subdir; touch dir/file dir/subdir/subfile
Initialized empty Git repository in .git/
$ touch dir/tracked-file; git add dir/tracked-file
$ ~/src/git/git-clean -n dir/
Would remove dir/file
Would not remove dir/subdir/
$ ~/src/git/git-clean -n dir
Would remove dir/file
Would not remove dir/subdir/
$ git rm -f dir/tracked-file
rm 'dir/tracked-file'
$ ~/src/git/git-clean -n dir/
Would remove dir/file
Would not remove dir/subdir/
$ ~/src/git/git-clean -n dir
Would remove dir/

> However,
> 
> git clean dir
> Would not remove dir/
> 
> is a little strange.

Yes, although it could be made less strange by adding a short explanation,
like "Would not remove dir/ (-d not given)". But I also think that the
difference between "dir" and "dir/" is very (too?) subtle in this case and
therefore should require explicit approval/action from the user.


-j.
