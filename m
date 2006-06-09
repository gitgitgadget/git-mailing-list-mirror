From: "Post, Mark K" <mark.post@eds.com>
Subject: RE: Git-daemon messing up permissions for gitweb
Date: Fri, 9 Jun 2006 16:08:15 -0400
Message-ID: <5A14AF34CFF8AD44A44891F7C9FF41050795787F@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 09 22:08:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FonHI-00078m-H7
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 22:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030240AbWFIUIR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 16:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbWFIUIR
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 16:08:17 -0400
Received: from ahmler7.mail.eds.com ([192.85.154.81]:24248 "EHLO
	ahmler7.mail.eds.com") by vger.kernel.org with ESMTP
	id S1030471AbWFIUIR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 16:08:17 -0400
Received: from ahmlir4.mail.eds.com (ahmlir4-2.mail.eds.com [192.85.154.134])
	by ahmler7.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59K84bY011185;
	Fri, 9 Jun 2006 16:08:09 -0400
Received: from ahmlir4.mail.eds.com (localhost [127.0.0.1])
	by ahmlir4.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59K7jma005627;
	Fri, 9 Jun 2006 16:07:45 -0400
Received: from usahm011.amer.corp.eds.com ([130.175.214.152])
	by ahmlir4.mail.eds.com (8.13.6/8.12.10) with ESMTP id k59K7jMD005622;
	Fri, 9 Jun 2006 16:07:45 -0400
Received: from usahm236.amer.corp.eds.com ([130.175.214.169]) by usahm011.amer.corp.eds.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 9 Jun 2006 16:08:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Git-daemon messing up permissions for gitweb
Thread-Index: AcaL/maMQZjCqmwDQ5GHizRYdSI3JwAADEcg
To: "Junio C Hamano" <junkio@cox.net>
X-OriginalArrivalTime: 09 Jun 2006 20:08:15.0951 (UTC) FILETIME=[718BBDF0:01C68C00]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21546>

Martin is using git over SSH.  I have git-shell in /etc/passwd for his
account.

Mark Post 

-----Original Message-----
From: Junio C Hamano [mailto:junkio@cox.net] 
Sent: Friday, June 09, 2006 3:51 PM
To: Post, Mark K
Cc: git@vger.kernel.org
Subject: Re: Git-daemon messing up permissions for gitweb

"Post, Mark K" <mark.post@eds.com> writes:

> I'm trying to set up a git repository for mainframe Linux developers
to
> use at git390.osdl.marist.edu.  Everything _seemed_ to go well, until
> Martin Schwidefsky started actually pushing changes back to the
> repository.  When he does that, the projects disappear from the web
page
> that gitweb.cgi is generating.

> As far as I can tell, the problem is happening because these files are
> being written out with file permissions of 640, and since Apache is
> running as user wwwrun, it can't read them:
> -rw-r-----  1 sky git  5490 Jun  9 03:35 ./linux-2.6.git/info/refs
> -rw-r-----  1 sky git    54 Jun  9 03:35
> ./linux-2.6.git/objects/info/packs
> -rw-r-----  1 sky git    41 Jun  9 03:35

First of all, it is not git-daemon that is updating these refs.
The daemon is a read only facility.

And you have checked the suggestion by Linus to set the umask to
world readable, which brings me to the next question.  

How did Martin actually "push changes back"?

Was it over git protocol over SSH, or the webdav thing over http
push?  The comment by Linus is about the former and I do not
know offhand who webdav thing runs as or how it handles the
permissino bits.

It could be that your ssh daemon installation bypasses .bashrc
and uses its own .ssh/environment, in which case your user would
may need to do umask there as well.
