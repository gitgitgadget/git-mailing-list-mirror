From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Tue, 22 Apr 2014 07:55:49 +0100
Message-ID: <20140422065549.GA11224@hashpling.org>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
 <1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
 <20140422045951.GA60610@gmail.com>
 <20140422060120.GA10198@hashpling.org>
 <53560b09bbe96_2400128531085@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:55:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcUcX-0001Pj-K6
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 08:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbaDVGzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 02:55:52 -0400
Received: from avasout06.plus.net ([212.159.14.18]:49904 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbaDVGzv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 02:55:51 -0400
Received: from turing.int.hashpling.org ([212.159.69.125])
	by avasout06 with smtp
	id suvo1n0012iA9hg01uvptE; Tue, 22 Apr 2014 07:55:49 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=Rp1LLUWK c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=Ew9TdX-QAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=FaVzYAwi6lUA:10 a=mSBy96HJJ2wA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=Ff0MX83EbsmlfcLaZjcA:9 a=CjuIK1q_8ugA:10
Received: from charles by turing.int.hashpling.org with local (Exim 4.82)
	(envelope-from <charles@hashpling.org>)
	id 1WcUcP-0002y7-ME; Tue, 22 Apr 2014 07:55:49 +0100
Content-Disposition: inline
In-Reply-To: <53560b09bbe96_2400128531085@nysa.notmuch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246703>

On Tue, Apr 22, 2014 at 01:24:09AM -0500, Felipe Contreras wrote:
> 
> This is what I get when a tool is not working:
> 
>   Documentation/config.txt seems unchanged.
>   Was the merge successful? [y/n]

Does this happen now even with merge tools for which we do trust the
exit code? If so, my original concern is addressed.

> > Personally, I leave mergetool.prompt unset (default true) because one
> > extra click in a complex merge resolution is relatively low overhead and
> > to catch myself when I forget that I'm in a no-X environment.
> > 
> > I glanced at the patch and it seems to subvert this intent for users
> > who have  configured a merge tool. Is my understanding correct?
> 
> Yes, that's correct. If the user has *manually* configured a tool, why would
> you ask him again? We are annoying the overwhelming the vast majority of users
> who already configured the right tool in order to avoid issues with a minute
> minority that might potentially but unlikely have a problem once or twice.
> 
> That's not productive.

We're asking to user to signal that he's happy to launch the mergetool
and implicitly giving him an opportunity to break out of the session.
I don't see anything wrong with having this behaviour.

So long as we don't hit the loop-with-lots-of-error-trace for users who
haven't set mergetool.prompt I've no strong objections to changing the
default so long as an explictly set mergetool.prompt is respected.

Ideally, I think I'd like the prompt to accept a "launch/skip/abort"
range of options but that's a wider scoped thing. Sometimes when I'm
resolving a lot of things and not specifying any paths I come across
something that know I don't want to attempt a resolve with my currently
configured tool and I just want to skip it for now. Currently, I have to
either abort the session or let the mergetool fire up and close it again
neither of which are optimal.
