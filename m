From: Jeff King <peff@peff.net>
Subject: Re: git push [rejected] question
Date: Tue, 19 Feb 2008 10:21:54 -0500
Message-ID: <20080219152154.GB24499@sigill.intra.peff.net>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com> <20080219043353.GA23239@sigill.intra.peff.net> <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com> <E7DE807861E8474E8AC3DC7AC2C75EE50542F62D@34093-EVS2C1.exchange.rackspace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jason Garber <jgarber@ionzoft.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 16:23:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRUIj-0006Wq-M8
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 16:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758227AbYBSPV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 10:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758274AbYBSPV5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 10:21:57 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2762 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752977AbYBSPV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 10:21:56 -0500
Received: (qmail 21708 invoked by uid 111); 19 Feb 2008 15:21:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 19 Feb 2008 10:21:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 10:21:54 -0500
Content-Disposition: inline
In-Reply-To: <E7DE807861E8474E8AC3DC7AC2C75EE50542F62D@34093-EVS2C1.exchange.rackspace.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74416>

On Tue, Feb 19, 2008 at 08:45:32AM -0600, Jason Garber wrote:

> ### Push from Issue/1 with non-fast-forward Issue/3 k###
> 
>   [jason@neon wc1]$ git push
>   Counting objects: 5, done.
>   Writing objects: 100% (3/3), 242 bytes, done.
>   Total 3 (delta 0), reused 0 (delta 0)
>   Unpacking objects: 100% (3/3), done.
>   To /var/var-home/jason/Code/test/git/repo/.git
>      142e136..c85b3dc  Issue/1 -> Issue/1
>    ! [rejected]        Issue/3 -> Issue/3 (non-fast forward)
>   error: failed to push to '/var/var-home/jason/Code/test/git/repo/.git'
> 
> 
> The issue with the above error message is that it indicates to the
> user that the push failed - even though the push was partially
> successful.

Yes, the final line is somewhat ambiguous if read by itself. The
transport mechanism is abstracted, and we don't pass back to "git push"
the number of successful and error refs, so we know only that there was
an error.

However, the idea is that the detailed status information on each ref
has _already_ been output, and the user should look at that. And indeed,
in your example, we can see that Issue/1 was pushed successfully, while
Issue/3 was not.

So I think it is a matter of:

  1. The table's terseness did not make clear to you that Issue/1 was
     not only attempted for push, but was successfully pushed. This
     should probably be dealt with by a documentation update to
     git-push.

  2. The error message implies that the push failed, and a user might
     expect an all-or-nothing behavior. It might be enough to change
     this to just "error: failed to push some refs to ..." without
     actually counting the refs (as you suggested).

>   [jason@neon wc1]$ git push
>   To /var/var-home/jason/Code/test/git/repo/.git
>      c85b3dc..c85b3dc  Issue/1 -> Issue/1 (Everything up-to-date)
>    ! [rejected]        Issue/3 -> Issue/3 (non-fast forward)
>   error: some errors encountered during push to '/var/var-home/jason/Code/test/git/repo/.git'.  See above for detail.
> 
> (it would be nice to see the status of each attempted branch if --all
> was specified or implied as the default behavior)

Try "git push -v". We explicitly don't show up to date branches by
default because they tend to clutter the output.

-Peff
