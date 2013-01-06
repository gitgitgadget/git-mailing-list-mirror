From: Jeff King <peff@peff.net>
Subject: Re: Trying to understand the web dav details
Date: Sat, 5 Jan 2013 23:19:42 -0500
Message-ID: <20130106041942.GB4879@sigill.intra.peff.net>
References: <151C51E6FBD848739A43A2C17D78DD68@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 'git' <git@vger.kernel.org>
To: Jason Pyeron <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Sun Jan 06 05:35:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trhx2-0000yc-Fc
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 05:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab3AFETq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 23:19:46 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44933 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755578Ab3AFETp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 23:19:45 -0500
Received: (qmail 32062 invoked by uid 107); 6 Jan 2013 04:20:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 05 Jan 2013 23:20:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2013 23:19:42 -0500
Content-Disposition: inline
In-Reply-To: <151C51E6FBD848739A43A2C17D78DD68@black>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212748>

On Sat, Jan 05, 2013 at 08:32:09PM -0500, Jason Pyeron wrote:

> When doing a clone by https (reverse proxied to http) the first request is
> 
> GET /git/project/info/refs?service=git-upload-pack
> 
> How does the ?service=xxxx get translated in to the action performed on the web
> server?

If you are using the git-http-backend CGI, it will interpret the service
tag and start smart-http. See "git help http-backend" for details on
plugging it into Apache.

Cloning/fetching does not use DAV at all; it is only for non-smart
pushing (and I would not recommend setting it up; the smart protocol
spoken by git-http-backend does pushing much more efficiently, and is
better maintained).

> I ask because I have 2 projects, one works the other does not.
> 
> I am using httpd-2.0.52-49.ent.centos4 and git-1.7.9.6-1.
> 
> I am not even sure what to tell more about or where to look next.

If you haven't set up git-http-backend, then git is just going to fetch
the remote repo's data directly over http. So the usual advice for
accessing something via http would apply (check the server's access and
error logs, try hitting it with a web browser, etc).

If you set GIT_CURL_VERBOSE=1 in your environment, git will spew a lot
of debugging information about what http requests it is making. That
might give you a clue (you haven't said anything about what does not
work, so I can't be more specific).

-Peff
