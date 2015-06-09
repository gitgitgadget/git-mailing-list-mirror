From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/13] prune_remote(): use delete_refs()
Date: Tue, 9 Jun 2015 07:53:46 -0400
Message-ID: <20150609115343.GA2777@peff.net>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
 <2ce5b2c64d002ce649c2192bacdf505c4921caa6.1433763494.git.mhagger@alum.mit.edu>
 <CAGZ79kYcO95M6DsPa71uckOcOKs-mkz2P+NtEKx5qYfOcDw99g@mail.gmail.com>
 <20150608171202.GB6863@peff.net>
 <5576C4E5.4080107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 09 13:54:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2I6Y-0004OD-Kl
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 13:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933266AbbFILx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 07:53:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:43282 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933262AbbFILxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 07:53:51 -0400
Received: (qmail 1866 invoked by uid 102); 9 Jun 2015 11:53:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Jun 2015 06:53:50 -0500
Received: (qmail 13746 invoked by uid 107); 9 Jun 2015 11:53:53 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Jun 2015 07:53:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jun 2015 07:53:46 -0400
Content-Disposition: inline
In-Reply-To: <5576C4E5.4080107@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271166>

On Tue, Jun 09, 2015 at 12:50:13PM +0200, Michael Haggerty wrote:

> The new code (in delete_refs()) allows delete_ref() to emit its error,
> but then follows it up with
> 
>     error(_("could not remove reference %s"), refname)
> 
> The "could not remove reference" error originally came from a similar
> message in remove_branches() (from builtin/remote.c).
> 
> I *think* this is an improvement, because the error from delete_ref()
> (which usually comes from ref_transaction_commit()) can be pretty
> low-level, like
> 
>     Cannot lock ref '%s': unable to resolve reference %s: %s
> 
> where the last "%s" is the original strerror.
> 
> I would be happy to change the behavior if somebody has a concrete wish.
> At the same time I don't think we need to sweat the details too much,
> because these errors should only ever be seen in the case of a broken
> repository or a race between two processes; i.e., only in pretty rare
> and anomalous situations.

Thanks for the explanation. I agree it probably doesn't matter much
either way.

-Peff
