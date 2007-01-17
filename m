From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Wed, 17 Jan 2007 09:51:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701170948420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701150144.56793.jnareb@gmail.com> <200701162337.32759.jnareb@gmail.com>
 <Pine.LNX.4.63.0701162352400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701170024.10640.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nikolai Weibull <now@bitwi.se>, Junio C Hamano <junkio@cox.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 17 09:51:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H76WF-0002Zo-Sl
	for gcvg-git@gmane.org; Wed, 17 Jan 2007 09:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbXAQIvn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 03:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbXAQIvn
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 03:51:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:41835 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932083AbXAQIvm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 03:51:42 -0500
Received: (qmail invoked by alias); 17 Jan 2007 08:51:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp008) with SMTP; 17 Jan 2007 09:51:39 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200701170024.10640.jnareb@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36990>

Hi,

On Wed, 17 Jan 2007, Jakub Narebski wrote:

> Dnia wtorek 16. stycznia 2007 23:56, Johannes Schindelin napisa?:
> > 
> > On Tue, 16 Jan 2007, Jakub Narebski wrote:
> 
> >> Well, the idea I had was to have --dump switch to git-repo-config to 
> >> dump init file as if it was created by git-repo-config invocations, 
> >> without any hand editing (canonical format).
> > 
> > My point still stands: if you already parse the user-friendly format, why 
> > not dump a parse friendly format? If it weren't for those darn non-alnums 
> > in the keys, out put of "git repo-config -l" would be perfectly 
> > acceptable.
> > 
> > So, how about a "git repo-config --dump" which outputs a stream of NUL 
> > separated keys and values? This should be really easy to "parse", and 
> > there are no ambiguities: No key or value can contain a NUL.
> 
> Good idea, although "\n" would work as well as NUL.

No it would not:

	[someSection]
		thisKey = has\na\nvalue\with\nseveral\nnewlines

> The only problem is with "key without value" case, i.e. something like
> 
>   [section]
>   	noval
> 
> which shows as
> 
>   section.noval

but is equivalent to

	[section]
		noval = true

Since it is by definition a boolean value.

> in "git repo-config -l" output (note missing '=' !), and I guess differs
> for some case from
> 
>   [section]
>   	noval = 

Yes, this is not a boolean. The difference is that the callback function 
is called with NULL in the former case, and with "" in the latter.

Hth,
Dscho
