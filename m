From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] Teach git-add--interactive to accept a file path
	to patch
Date: Thu, 22 Nov 2007 04:13:57 -0500
Message-ID: <20071122091356.GD7153@sigill.intra.peff.net>
References: <1195648601-21736-1-git-send-email-win@wincent.com> <1195648601-21736-2-git-send-email-win@wincent.com> <1195648601-21736-3-git-send-email-win@wincent.com> <20071121152118.GG24108@sigill.intra.peff.net> <7vejejfi28.fsf@gitster.siamese.dyndns.org> <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <7vk5obb09a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 10:14:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv88l-0002U7-8J
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 10:14:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbXKVJOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 04:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbXKVJOE
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 04:14:04 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2485 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbXKVJOB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 04:14:01 -0500
Received: (qmail 21048 invoked by uid 111); 22 Nov 2007 09:13:58 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 04:13:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 04:13:57 -0500
Content-Disposition: inline
In-Reply-To: <7vk5obb09a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65762>

On Wed, Nov 21, 2007 at 04:18:57PM -0800, Junio C Hamano wrote:

> What I meant was that if "git add -i" (unrestricted) shows paths
> from a set A, "git add -i paths..." should show paths from a
> subset of the set A and that subset should be defined with the
> existing ls-files pathspec semantics.

Ah, I think that is definitely the right behavior. But it does raise one
more question: is going right into the 'add hunk' interface the correct
behavior, or is that an orthogonal issue?

IOW, do we actually want to support:

  # go to patch menu for each file
  git-add -i -p file1 file2 ...
  # add untracked for each file
  git-add -i -a file1 file2 ...

Which is of course tricky because the '-p' is contextually dependent on
the presence of '-i'.

But perhaps there is no need, since for just these two operations you
can do something like:

  foreach my $file (@ARGV) {
    if(tracked($file)) {
      patch_update_file($file);
    }
    else {
      add_tracked($file);
    }
  }

Are there any other per-file operations that would make sense to start
with? Or might somebody just want to path-limit _without_ starting the
hunk selector?

-Peff
