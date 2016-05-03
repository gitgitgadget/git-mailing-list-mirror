From: Jeff King <peff@peff.net>
Subject: Re: avoid duplicate patches from git log ?
Date: Tue, 3 May 2016 18:00:39 -0400
Message-ID: <20160503220039.GB25133@sigill.intra.peff.net>
References: <712E44CFAD1A41A982AEF1540C1F9F80@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed May 04 00:00:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axiN4-0002RU-NK
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756521AbcECWAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 18:00:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:33472 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756177AbcECWAm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:00:42 -0400
Received: (qmail 30597 invoked by uid 102); 3 May 2016 22:00:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 18:00:42 -0400
Received: (qmail 2554 invoked by uid 107); 3 May 2016 22:00:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 18:00:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 18:00:39 -0400
Content-Disposition: inline
In-Reply-To: <712E44CFAD1A41A982AEF1540C1F9F80@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293464>

On Tue, May 03, 2016 at 09:11:55PM +0100, Philip Oakley wrote:

> However, as the G4W project (https://github.com/git-for-windows/git/)
> follows the main git repo and its releases, it needs to rebase it's fixup
> patches, while retaining their original series, so has repeated copies of
> those fix patches on the second parent path (a technique Dscho called
> rebasing merges).
> 
> for example:
> > bf1a7ff (MinGW: disable CRT command line globbing, 2011-01-07)
> > a05e9a8 (MinGW: disable CRT command line globbing, 2011-01-07)
> > 45cfa35 (MinGW: disable CRT command line globbing, 2011-01-07)
> > 1d35390 (MinGW: disable CRT command line globbing, 2011-01-07)
> > 022e029 (MinGW: disable CRT command line globbing, 2011-01-07)
> 
> 
> How can I filter out all the duplicate patches which are identical other
> than the commit date?
> 
> The --left --right and --cherry don't appear to do what I'd expect/hope. Any
> suggestions?

I don't think there's a good way right now. The option that suppresses
commits is --cherry-pick, but it wants there to be a "left" and "right"
from a symmetric difference, and to cull duplicates from the various
sides.

I think you really just want to keep a running list of all of the
commits you've seen and cull any duplicates. I guess you'd want this as
part of the history simplification step, so that whole uninteresting
side-branches are culled.

The obvious choice for matching two commits is patch-id, though it can
be expensive to generate. There have been patches playing around with
caching in the past, but nothing merged. For your purposes, I suspect
matching an "(author, authordate, subject)" tuple would be sufficient
and fast.

-Peff
