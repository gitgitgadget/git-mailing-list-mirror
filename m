From: Jeff King <peff@peff.net>
Subject: Re: RFH: gitk equivalent of "git log -p --full-diff file.cpp"
Date: Mon, 6 Oct 2008 22:27:05 -0400
Message-ID: <20081007022705.GA4496@coredump.intra.peff.net>
References: <279b37b20810061904n4f50f650l81590cb6fd239282@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>, paulus@samba.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 04:29:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kn2KN-0005Nd-Tf
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 04:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbYJGC1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 22:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbYJGC1J
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 22:27:09 -0400
Received: from peff.net ([208.65.91.99]:2311 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754311AbYJGC1I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 22:27:08 -0400
Received: (qmail 26979 invoked by uid 111); 7 Oct 2008 02:27:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 06 Oct 2008 22:27:07 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Oct 2008 22:27:05 -0400
Content-Disposition: inline
In-Reply-To: <279b37b20810061904n4f50f650l81590cb6fd239282@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97657>

On Mon, Oct 06, 2008 at 07:04:14PM -0700, Eric Raible wrote:

> Anyway what I'm looking for is the gitk equivalent of:
> 
>     git log -p --full-diff file.cpp

Try turning off the option "Limit diffs to listed paths" in the
preferences menu (or adding "set limitdiffs 0" to your ~/.gitk).

> That is to say: I want to see all commits which touch a given
> file along with all of the other files changed by that commit.
> 
>     gitk -p --full-diff EntryPoints.cpp

You definitely don't want the "-p" here, which is what is causing the
extra diffs as part of the commit message. What happens is that gitk
actually gets the diff separately from the history (since it gets each
diff on the fly as you highlight it). The command line arguments go
towards getting the history; so gitk isn't expecting parse any diff (and
you will make gitk startup a _lot_ slower as it waits for git to
generate the diffs for every revision).

The "--full-diff" is simply ignored, since the actual diff happens
during a later command.  In theory, gitk could remember your --full-diff
and use it later. But I think for your use, the preference setting
is probably good enough.

> PS - Aside from aliases, am I missing a simpler spelling of the above
>      git log command?

Nope, it looks right to me. At one point, we discussed a "full-diff"
config option (and I think I maybe even posted a patch), but nobody
really cared.

-Peff
