From: Jeff King <peff@peff.net>
Subject: Re: Any way to edit the file in index directly?
Date: Tue, 7 Apr 2009 22:10:41 -0400
Message-ID: <20090408021041.GB18244@coredump.intra.peff.net>
References: <46dff0320904071803k68fddff4j226760392e0c5bcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:12:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrNH0-0004Hi-3J
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 04:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767AbZDHCKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 22:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbZDHCKp
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 22:10:45 -0400
Received: from peff.net ([208.65.91.99]:52637 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755816AbZDHCKo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 22:10:44 -0400
Received: (qmail 11627 invoked by uid 107); 8 Apr 2009 02:10:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 22:10:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 22:10:41 -0400
Content-Disposition: inline
In-Reply-To: <46dff0320904071803k68fddff4j226760392e0c5bcc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116017>

On Wed, Apr 08, 2009 at 09:03:03AM +0800, Ping Yin wrote:

> There seems to be a patch for this ( add -e?), but i forget where to
> find it.

"add -p" has an "e"dit option for editing the patch. I don't recall any
way of directly editing the content.

> For a big change, instead of "add -p", it may be easier to edit the
> index directly ( with the corresponding worktree file alongside)

I'm not sure what you mean by "alongside". If you mean "by editing a
temporary file that corresponds to the index file without munging your
worktree file", then you can do:

  FILE=foo.c
  git show :$FILE >$FILE.tmp
  $EDITOR $FILE.tmp
  object=`git hash-object -w $FILE.tmp`
  git update-index --cacheinfo 100644 $object $FILE

And obviously you could make a script for that if you wanted (but at the
very least, you would need quotes to handle files with spaces, and
probably some magic to handle smudge/clean filters and CRLF properly for
the tempfile).

-Peff
