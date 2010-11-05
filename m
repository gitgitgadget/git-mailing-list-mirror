From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Fri, 5 Nov 2010 10:55:10 -0400
Message-ID: <20101105145510.GA19087@sigill.intra.peff.net>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <201011040149.47968.johan@herland.net>
 <20101104145817.GA27580@sigill.intra.peff.net>
 <201011050229.15941.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Kenny Root <kroot@google.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 05 15:54:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PENgX-0001sB-0u
	for gcvg-git-2@lo.gmane.org; Fri, 05 Nov 2010 15:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032Ab0KEOy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Nov 2010 10:54:27 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47536 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355Ab0KEOy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Nov 2010 10:54:26 -0400
Received: (qmail 10098 invoked by uid 111); 5 Nov 2010 14:54:24 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (129.79.255.85)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 05 Nov 2010 14:54:24 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Nov 2010 10:55:10 -0400
Content-Disposition: inline
In-Reply-To: <201011050229.15941.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160815>

On Fri, Nov 05, 2010 at 02:29:15AM +0100, Johan Herland wrote:

> Actually, I don't have anything against auto-follow per se, and we could 
> easily enough extend the refspec to specify auto-follow behaviour: There is 

Yup, agreed. That would be sufficient to capture the current behavior
(and IMHO makes it much more transparent to the user).

> > This codifies that refs for remote $foo are in refs/remotes/$foo, which
> > is something we have avoided so far. For example, when finding the
> > "upstream" branch, we have the name of the remote and the merge branch,
> > look up the fetch refspecs in the config, and then figure out where that
> > branch would be fetched to. Which of course turns out as you say (as
> > remotes/$remote_name/$branch) in the default config, but we don't
> > restrict people to that.
> 
> We can do the same for "foo/bar" as well, although things become slightly 
> more fiddly:

Yeah, I don't think the problem is unsurmountable. But I do think it is
worth doing the more complex behavior, as it keeps things "right" with
respect to arbitrary config.

> When "foo" exists as a remote, look up its fetch refspec(s), and determine 
> possible mappings for name "bar". I.e. given the following (non-default) 
> refspecs for remote "foo":
> 
>   +refs/heads/*:refs/remotes/spam/heads/*
>   +refs/tags/*:refs/remotes/eggs/tags/*
>   +refs/notes/*:refs/remotes/bacon/notes/*
> 
> we know that the intersection between the left side of these refspec and the 
> ref disambiguation rules consists of "refs/tags/bar" and "refs/heads/bar" 
> (in that order). We can then map these to the right side of the refspec to 
> get "refs/remotes/eggs/tags/bar" and "refs/remotes/spam/heads/bar" (in that 
> order). We would then use the first match from these alternatives.

Yeah, that makes sense. If the remote side is storing tags somewhere
besides "refs/tags" you wouldn't find them, but that is probably a good
thing.

-Peff
