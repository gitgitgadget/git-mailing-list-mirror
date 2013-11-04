From: Jeff King <peff@peff.net>
Subject: Re: error: unpack failed: unpack-objects abnormal exit
Date: Mon, 4 Nov 2013 15:03:21 -0800
Message-ID: <20131104230321.GA31503@sigill.intra.peff.net>
References: <CALK6XSgMA8KCJ1zBRpib6X-pUqwHFzh+uEj8OLm6OZfCi0wmDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sitesh Shrivastava <siteshshrivastava@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 05 00:03:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdTBC-0002zZ-Iy
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 00:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849Ab3KDXDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 18:03:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:33388 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751526Ab3KDXDY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 18:03:24 -0500
Received: (qmail 6118 invoked by uid 102); 4 Nov 2013 23:03:24 -0000
Received: from GITHUB-INC.bar1.SanFrancisco1.Level3.net (HELO sigill.intra.peff.net) (4.53.133.38)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 04 Nov 2013 17:03:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Nov 2013 15:03:21 -0800
Content-Disposition: inline
In-Reply-To: <CALK6XSgMA8KCJ1zBRpib6X-pUqwHFzh+uEj8OLm6OZfCi0wmDA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237311>

On Fri, Nov 01, 2013 at 04:02:10PM +0530, Sitesh Shrivastava wrote:

> I'm using a gitosis server. Suddenly I'm not able to push to the
> remote server. Everyone else is able to push to the same server. Btw I
> can't push to *any repo* on the server. This is the error I get:
> 
> Counting objects: 5, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (3/3), 353 bytes | 0 bytes/s, done.
> Total 3 (delta 1), reused 0 (delta 0)
> error: unpack failed: unpack-objects abnormal exit
> To git://git.srv.net/code-repo.git
>  ! [remote rejected] master -> master (n/a (unpacker error))
> error: failed to push some refs to 'git://git.srv.net/code-repo.git'

You are trying to push over the "git://" protocol. That isn't enabled by
default (because it has no authentication at all). Did you enable it? If
so, does the user running git-daemon have permission to write to the
repository?

The server notes that unpack-objects fails, but in older git versions
the stderr of unpack-objects does not get sent to the client. If your
git-daemon process is logging somewhere, you might check that log for
more details.

Since v1.7.12.3, that output is sent over the sideband channel to the
client. So another option is to upgrade the version of git on the
server.

> Can something be wrong with my git installation?
> git --version
> git version 1.8.3.2

That's your client version. The server version is older than that (in
v1.7.12.3, the unpacker error message also dropped the "n/a" bit, so the
output above comes from a server older than that).

-Peff
