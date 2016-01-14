From: Jeff King <peff@peff.net>
Subject: Re: Find main branch
Date: Thu, 14 Jan 2016 16:04:52 -0500
Message-ID: <20160114210452.GA10825@sigill.intra.peff.net>
References: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
 <20160114213113.c700484c7e3acddc467d0e75@domain007.com>
 <CAPMsMoBNzmK618NPP-VXP_70hTxTsa13O9f_usiCPJ-SUOUz_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: pedro rijo <pedrorijo91@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 22:05:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJp4l-0005V9-C4
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 22:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124AbcANVE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 16:04:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:53943 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755258AbcANVEz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 16:04:55 -0500
Received: (qmail 9829 invoked by uid 102); 14 Jan 2016 21:04:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 16:04:55 -0500
Received: (qmail 11658 invoked by uid 107); 14 Jan 2016 21:05:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 16:05:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 16:04:52 -0500
Content-Disposition: inline
In-Reply-To: <CAPMsMoBNzmK618NPP-VXP_70hTxTsa13O9f_usiCPJ-SUOUz_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284093>

On Thu, Jan 14, 2016 at 06:40:15PM +0000, pedro rijo wrote:

> Stefan Beller solution is based on the server, which may not be very
> easy to do when dealing with Github/Bitbucket/Gitlab and other God
> knows which provider.
> 
> Konstantin ls-remote solution is the one I'm already using, but if I
> have several branches on that commit, I will not be able to decide.

Right. Git used to guess, but that was not great exactly because of the
ambiguity you have seen. Servers started publishing the value of the
HEAD symref in git v1.8.4.3. I'd expect that to be available on any
modern server.

There's unfortunately not a plumbing command to directly access the
value, but "git remote set-head $remote -a" will query the remote and
update refs/remotes/$remote/HEAD appropriately. As a bonus, if it's an
older server that doesn't provide the HEAD value, it will fallback to
the "old" heuristics (see guess_remote_head for details).

-Peff
