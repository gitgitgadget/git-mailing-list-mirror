From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Mon, 19 Mar 2012 02:05:22 +0100
Message-ID: <4F668652.5090705@gmx.net>
References: <loom.20120318T083216-96@post.gmane.org> <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 02:05:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9R29-0001sN-Mt
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 02:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab2CSBFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Mar 2012 21:05:06 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:50401 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754043Ab2CSBFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2012 21:05:05 -0400
Received: (qmail invoked by alias); 19 Mar 2012 01:05:02 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.174.114]
  by mail.gmx.net (mp032) with SMTP; 19 Mar 2012 02:05:02 +0100
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX19cmSNYtZlcocftfY43hOpv+4qhJ5WAnU3vzy6/3y
	DdSjQdpjiHudji
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120318190659.GA24829@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193405>

On 18.03.2012 20:07, Jeff King wrote:
> Nor would you want to have multiple invocations of fetch-pack, since
> that would mean multiple http requests and multiple pack responses
> (which could not delta between themselves).

Sure, but if fetch-pack is called with so many refs that it overflows 
the command line, it's looking at a lot of work ahead of it anyway, it's 
not going to be a fast operation. So the overhead of multiple HTTP 
requests and lack of delta compression between huge batches of refs 
wouldn't be all that significant in practice.

That said, I really like your temp file idea below. It's the best 
solution so far. Simple, efficient, non-intrusive.


> I think the only sane solution is to write the values to a temporary 
> file, and do something like:
> 
> git fetch-pack --stateless-rpc --refs-from=$tmpfile
> 
> Even if you put the tmpfile in $GIT_DIR, I don't think this should
> run afoul of any read-only repositories, since by definition you are 
> fetching into the repository (but you could also just put it in
> /tmp).

OK, if nobody beats me to it I will try to code this next weekend. Maybe 
sooner, but I don't usually have much free time over the week (day job, 
family, etc.).
