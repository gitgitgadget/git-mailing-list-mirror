From: Jeff King <peff@peff.net>
Subject: Re: Error: unable to unlink ... when using "git gc"
Date: Tue, 6 Jan 2009 03:03:00 -0500
Message-ID: <20090106080300.GA10079@coredump.intra.peff.net>
References: <488807870901052300y57f59b90rdc03cc47c790b416@mail.gmail.com> <20090106072253.GA9920@coredump.intra.peff.net> <488807870901052352w585da727r6d4a1e4ca4238cab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johnny Lee <johnnylee194@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:04:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK6vP-00044q-J9
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbZAFIDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbZAFIDG
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:03:06 -0500
Received: from peff.net ([208.65.91.99]:34190 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709AbZAFIDF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:03:05 -0500
Received: (qmail 32474 invoked by uid 107); 6 Jan 2009 08:03:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 06 Jan 2009 03:03:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jan 2009 03:03:00 -0500
Content-Disposition: inline
In-Reply-To: <488807870901052352w585da727r6d4a1e4ca4238cab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104643>

[re-adding git@vger; please keep discussion on-list so everyone can
benefit from the result]

On Tue, Jan 06, 2009 at 03:52:12PM +0800, Johnny Lee wrote:

> Thanks Peff, I've checked the permission of .git/objects/16, it's
> created by another user and thus I have no permission to remove it.
> 
> In fact, this is coming from a previous bad practice on setting up a
> collaboration repository on a SSH server, here is what I've done so
> far:
> [...]
> 7. Then the user "git" has changed mode for all the files under .git
> to writable.
> 
> 8. This time, user "johnny" can push successfully.

If you are going to have multiple users sharing a repository, generally
they should be in the same group and the core.sharedrepository config
option should be set (see "git help config", or the "shared" option to
git-init).

I've never used that personally, though. I have always just used POSIX
ACLs, with a default ACL on each directory giving access to everyone.
E.g. (off the top of my head):

  for user in user1 user2 user3; do
    setfacl -R -m u:$user:rwX -m d:u:$user:rwX /path/to/repo
  done

-Peff
