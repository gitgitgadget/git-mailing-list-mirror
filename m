From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 17:02:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
 <45B7818F.6020805@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 17:02:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9kZy-00019M-Ko
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 17:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbXAXQC1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 11:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbXAXQC1
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 11:02:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:55310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751401AbXAXQC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 11:02:26 -0500
Received: (qmail invoked by alias); 24 Jan 2007 16:02:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 24 Jan 2007 17:02:24 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45B7818F.6020805@zytor.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37647>

Hi,

On Wed, 24 Jan 2007, H. Peter Anvin wrote:

> Jakub Narebski wrote:
> > H. Peter Anvin wrote:
> > 
> > > Would it be an incompatible change to add the commit date (and perhaps the
> > > author date) to .git/info/refs?  I believe that would make it possible to
> > > dramatically (orders of magnitude) speed up the generation of the gitweb
> > > index page, which is easily the most expensive gitweb page to generate.
> > 
> > With new gitweb and new git it is not that expensive. It is now one call
> > to git-for-each-ref per repository.
> 
> That IS hugely expensive.  On kernel.org, that is 24175 calls to git.
> 
> > Besides, we can't rely that .git/info/refs is up to date, or even exists.
> > It is for dumb protocols, not for gitweb.
> 
> Well, SOMETHING needs to be done for this page, since it can take 15 
> minutes or more to generate.  Caching doesn't help one iota, since it's 
> stale before being generated.

To me, it seems like all boils down to caching parsed data structures. 
I.e. parse the config, then serialize the parsed data to a file. Don't 
reparse the config unless it is 1 hour older than the config.

Likewise, run for-each-ref, and serialize the parsed data into a file. 
Don't rerun for-each-ref if that file is younger than 15 minutes.

Maybe the same for the first 200 commits of each branch.

(I made those times up, but you get the idea.)

Ciao,
Dscho
