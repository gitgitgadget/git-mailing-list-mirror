From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Trying to understand the web dav details
Date: Sun, 6 Jan 2013 01:20:56 -0500
Organization: PD Inc
Message-ID: <A18DA90EFF3743E5B580CBC68F1C9F7C@black>
References: <151C51E6FBD848739A43A2C17D78DD68@black> <20130106041942.GB4879@sigill.intra.peff.net> <871B6C10EBEFE342A772D1159D1320853A011871@umechphj.easf.csd.disa.mil> <20130106053807.GA8551@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'git'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 07:24:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trjf7-0002Ci-C4
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 07:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004Ab3AFGYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 01:24:31 -0500
Received: from projects.pdinc.us ([67.90.184.26]:48650 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750858Ab3AFGY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 01:24:29 -0500
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id r066NuPV012879
	for <git@vger.kernel.org>; Sun, 6 Jan 2013 01:23:56 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20130106053807.GA8551@sigill.intra.peff.net>
Thread-Index: Ac3rz/aAqPLH1KepTNeRI6KV7tOj5wAAStvg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212776>

Ignore everything below, it was a case sensitive typo. It always worked it.

> -----Original Message-----
> From: Jeff King
> Sent: Sunday, January 06, 2013 0:38
> 
> On Sun, Jan 06, 2013 at 04:49:57AM +0000, Pyeron, Jason J CTR 
> (US) wrote:
> 
> > > > How does the ?service=xxxx get translated in to the action 
> > > > performed on the web server?
> > > 
> > > If you are using the git-http-backend CGI, it will interpret the 
> > > service
> > 
> > No, using plain jane http and webdav. This server is not 
> "allowed" to 
> > use cgi processes.
> 
> Then the service parameter should be ignored by your 
> webserver, and it should just serve the info/refs file from 
> the repository on the filesystem. And you are stuck using 
> WebDAV for push.
> 
> > > GET /git/project-x/info/refs HTTP/1.1
> > [...]
> > * The requested URL returned error: 404 Not Found
> 
> Does the info/refs file exist in the project-x repository?

Yes.

> 
> > fatal: https://server/git/project-x/info/refs not found: 
> did you run git update-server-info on the server?
> 
> Did you?
> 

Many times.

> If you can't run any git programs on the server at all (and 
> it sounds like that may be the case), you'll need to run it 
> locally before putting the repository data on the server.
> 
> Once you have WebDAV set up for pushing, it will update the 
> info/refs file for each push. But if you are initially 
> seeding the server with rsync or a tarfile, you'll want to 

Seeding it seems to work, it is the bare init that seems to be failing. Might be
on to something there.

> make sure it has an up-to-date info/refs file.

Here is the create script:

#!/bin/bash

if [ $# != 1 ]; then
exit 1;
fi

if [ -e "$1" ]; then
exit 2;
fi

mkdir "$1"
cd "$1"
git init --bare
cp hooks/post-update.sample hooks/post-update
chmod +x hooks/post-update
git update-server-info




--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.

 
