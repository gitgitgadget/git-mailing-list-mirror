From: Joachim Berdal Haga <cjbhaga@broadpark.no>
Subject: Re: [PATCH] git clean: Don't automatically remove directories when run
 within subdirectory
Date: Mon, 14 Apr 2008 20:18:13 +0200
Message-ID: <48039FE5.5060309@broadpark.no>
References: <85fxtvj6y8.fsf_-_@lupus.strangled.net>
 <1208130578-24748-1-git-send-email-shawn.bohrer@gmail.com>
 <7v8wzgaoqy.fsf@gitster.siamese.dyndns.org>
 <20080414170643.GA10548@mediacenter>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 20:27:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlTJP-00025o-75
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 20:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbYDNSSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 14:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbYDNSSW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 14:18:22 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:60918 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932523AbYDNSSV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 14:18:21 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0JZB0054FUUJN390@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 20:18:19 +0200 (CEST)
Received: from pep ([80.203.45.22]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0JZB00MPJUUEL6H0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 14 Apr 2008 20:18:19 +0200 (CEST)
Received: from localhost ([127.0.0.1])	by pep with esmtp (Exim 4.69)
	(envelope-from <cjbhaga@broadpark.no>)	id 1JlTFu-0005Fb-90; Mon,
 14 Apr 2008 20:18:14 +0200
User-Agent: Mozilla-Thunderbird 2.0.0.9 (X11/20080110)
In-reply-to: <20080414170643.GA10548@mediacenter>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: cjbhaga@broadpark.no
X-SA-Exim-Scanned: No (on pep); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79522>

Shawn Bohrer wrote:
> Agreed I'll send an updated patch later tonight.  One additional thought
> though.  2 is MATCHED_FNMATCH which worries me a little because I think
> this would mean 'git clean -f *' will also remove directories (I haven't
> tried though).  Perhaps this should really be 3 MATCHED_EXACTLY just to
> be safe.  Does anyone have opinions either way?

I don't have strong opinions on this since I don't use this form of the
command, but still:

I think that the best option would be to never remove a directory, even if
given explicitly, unless -d is given. Because my gut feeling is that when a
directory name is specified, it is most often meant as "clean inside the
given directory", ie. as a path delimiter. Indeed, if the directory has
tracked files inside of it,
  git clean dir
and
  git clean dir/
have the same effect. If there are no tracked files inside, the current
patch gives the path-delimiting effect on this form
  git clean dir/
but removes the whole directory irrespective of "-d" for this form
  git clean dir
I think that a "honor (lack of) -d even if pathspec matches" would reduce
the consequences of this particular kind of user error (by deleting too
little instead of too much).

-j.
