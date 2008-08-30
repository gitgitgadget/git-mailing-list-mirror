From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] change Perl syntax to support Perl 5.6
Date: Sat, 30 Aug 2008 14:00:22 -0400
Message-ID: <20080830180022.GA14552@coredump.intra.peff.net>
References: <20080830173947.GF7185@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 20:01:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZUlO-0007x7-0t
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 20:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbYH3SAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 14:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753305AbYH3SAZ
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 14:00:25 -0400
Received: from peff.net ([208.65.91.99]:1706 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753266AbYH3SAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 14:00:24 -0400
Received: (qmail 24493 invoked by uid 111); 30 Aug 2008 18:00:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 30 Aug 2008 14:00:24 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Aug 2008 14:00:22 -0400
Content-Disposition: inline
In-Reply-To: <20080830173947.GF7185@schiele.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94397>

On Sat, Aug 30, 2008 at 07:39:47PM +0200, Robert Schiele wrote:

> git-add--interactive has one Perl command that was not yet present in
> Perl 5.6.  Changing this single command makes it compatible again.

Having read your other message, I know what it is about this command
that does not work with Perl 5.6. But probably it would be good to
mention "list form of three argument open with pipe".

>  git-add--interactive.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

What about the similar uses in cvsimport, cvsserver, and gitweb? How
about the scripts in contrib (a quick grep reveals some fast-import
scripts, blameview, cidaemon, continuous, and hooks/update-paranoid.

Most of those things are not as "core" as add--interactive, so I am not
opposed to changing just this one spot and documenting "core can use
5.6, but these other things need 5.8".

> -		open($fh, '-|', @_) or die;
> +		open($fh, '-|', join(' ', @_)) or die;

Won't this execute the command using the shell, which means that
metacharacters need to be escaped? I didn't try, but I'm pretty sure
this would break

  git add -i "file with space"

-Peff
