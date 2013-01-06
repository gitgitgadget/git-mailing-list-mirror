From: Jeff King <peff@peff.net>
Subject: Re: Trying to understand the web dav details
Date: Sun, 6 Jan 2013 00:38:07 -0500
Message-ID: <20130106053807.GA8551@sigill.intra.peff.net>
References: <151C51E6FBD848739A43A2C17D78DD68@black>
 <20130106041942.GB4879@sigill.intra.peff.net>
 <871B6C10EBEFE342A772D1159D1320853A011871@umechphj.easf.csd.disa.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 'git' <git@vger.kernel.org>
To: "Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>
X-From: git-owner@vger.kernel.org Sun Jan 06 06:38:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TriwS-0000Jk-RN
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 06:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907Ab3AFFiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 00:38:10 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44959 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab3AFFiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 00:38:09 -0500
Received: (qmail 32504 invoked by uid 107); 6 Jan 2013 05:39:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 06 Jan 2013 00:39:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2013 00:38:07 -0500
Content-Disposition: inline
In-Reply-To: <871B6C10EBEFE342A772D1159D1320853A011871@umechphj.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212752>

On Sun, Jan 06, 2013 at 04:49:57AM +0000, Pyeron, Jason J CTR (US) wrote:

> > > How does the ?service=xxxx get translated in to the action
> > > performed on the web server?
> > 
> > If you are using the git-http-backend CGI, it will interpret the
> > service
> 
> No, using plain jane http and webdav. This server is not "allowed" to
> use cgi processes.

Then the service parameter should be ignored by your webserver, and it
should just serve the info/refs file from the repository on the
filesystem. And you are stuck using WebDAV for push.

> > GET /git/project-x/info/refs HTTP/1.1
> [...]
> * The requested URL returned error: 404 Not Found

Does the info/refs file exist in the project-x repository?

> fatal: https://server/git/project-x/info/refs not found: did you run git update-server-info on the server?

Did you?

If you can't run any git programs on the server at all (and it sounds
like that may be the case), you'll need to run it locally before putting
the repository data on the server.

Once you have WebDAV set up for pushing, it will update the info/refs
file for each push. But if you are initially seeding the server with
rsync or a tarfile, you'll want to make sure it has an up-to-date
info/refs file.

-Peff
