From: Peter Stuge <peter@stuge.se>
Subject: Re: [PATCH] gitweb: Add js=1 before an URI fragment to fix line
	number links
Date: Tue, 27 Sep 2011 01:17:03 +0200
Message-ID: <20110926231703.21696.qmail@stuge.se>
References: <1317060642-25488-1-git-send-email-peter@stuge.se> <7vaa9q29ag.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:17:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8KQT-0001ex-O3
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955Ab1IZXRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 19:17:06 -0400
Received: from foo.stuge.se ([212.116.89.98]:60844 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752917Ab1IZXRF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 19:17:05 -0400
Received: (qmail 21697 invoked by uid 501); 26 Sep 2011 23:17:03 -0000
Content-Disposition: inline
In-Reply-To: <7vaa9q29ag.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182185>

Junio C Hamano wrote:
> >  		var link = allLinks[i];
> > -		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01]$/;
> > -			link.href +=
> > -				(link.href.indexOf('?') === -1 ? '?' : ';') + 'js=1';
> > +		if (!jsExceptionsRe.test(link)) { // =~ /[;?]js=[01](#.*)?$/;
> 
> Let's not repeat the regexp in the comment (badness you inherited
> from the original).

I agree. I chose to follow style.


> Regarding the "we already have the js=0 or js=1 in the URL" check here...
> 
> > +var jsExceptionsRe = /[;?]js=[01](#.*)?$/;
> 
> ... I am wondering who guarantees that this js=[01] is the last parameter
> before the fragment identifier. The answer obviously is "the way the
> current code is written using replace() method on link.href", but that is
> somewhat disturbing, because it is not clear what should happen, short of
> total rewrite of the code around this, when somebody needs to include
> another variable, say xx=[01], just like the js=[01] you are fixing here,
> in the resulting URL. In other words, this fixLinks() logic does not seem
> to scale and also looks brittle.

At first glance indeed. But I think it might be fine, because the
purpose of this function is only to use javascript in order to
indicate to the server that the client supports javascript. This is
somewhat an odd case, the link rewriting is pretty much needed only
for this one value so it doesn't really have to scale. But I have
nothing against say removing (#.*)?$ and thus only matching
[?;]js=[01] in link.href.


> The patch itself looks correct as a short-term fix, though.

Thanks, I figured if it was OK before then at least it would be
better now.


//Peter
