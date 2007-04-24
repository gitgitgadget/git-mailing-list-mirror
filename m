From: Johan Herland <johherla@online.no>
Subject: Re: bug with gitweb on kernel.org
Date: Tue, 24 Apr 2007 09:40:58 +0200
Message-ID: <200704240940.58948.johherla@online.no>
References: <alpine.LFD.0.98.0704192255180.4504@xanadu.home>
 <f0jkvm$31p$1@sea.gmane.org> <1177376808.5357.13.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 09:41:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgFeb-0007hm-JK
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 09:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161695AbXDXHle (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 03:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161696AbXDXHle
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 03:41:34 -0400
Received: from [84.208.20.33] ([84.208.20.33]:48821 "EHLO smtp.getmail.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1161695AbXDXHle (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 03:41:34 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JGZ0050FS0I2S00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 24 Apr 2007 09:41:06 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JGZ00E51S0BG1B0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 24 Apr 2007 09:40:59 +0200 (CEST)
Received: from alpha.herland ([84.210.6.109])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JGZ009L9S0BTO50@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 24 Apr 2007 09:40:59 +0200 (CEST)
X-Face: zAU=Aih\K"7{XrAB#g(N4\&nMswu9hikoybx8Q}+R"A37P=[.BX&Ncc#~jS#eq,C1k,]t@=?utf-8?q?=0A=09=3Dn9=3Bz=233?=,[.?2jV^>:!ie)?R4$jL5UUfn+>uzE-QU<I%oNdJr/AAf3EoW9ps@=?utf-8?q?D8T=60Tx9=5Ei=24=0A=09?=(P%sy[{tAd,&s\0$S$mdn.;]
In-reply-to: <1177376808.5357.13.camel@localhost.localdomain>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45423>

On Tuesday 24 April 2007, J.H. wrote:
> On Tue, 2007-04-24 at 03:06 +0200, Jakub Narebski wrote:
> > J.H. wrote:
> > > Well the only difference in the pages being served is the mime
> > > type application/html vs. application/xhtml+xml.  Does anyone
> > > know the original impetus to using application/xhtml+xml (despite
> > > the fact that it's technically the correct choice) vs. just using
> > > application/html for everything?  I'm sure there was a good
> > > reason behind it and I'd rather know what that reason was before
> > > I got changing things
> >
> > The idea was to serve application/xhtml+xml to browsers which
> > _explicitely_ support it. But coupled with the fact that gitweb on
> > kernel.org is modified gitweb with caching, and it looks like it
> > caches also HTTP headers... I think simplest solution would be to
> > remove complication, and always serve text/html (at least for
> > kernel.org gitweb with caching modifications).
>
> It's either that or store only the data not the headers and deal with
> the headers on each request - but that might have other unintended
> consequences I haven't thought of yet.  Anyway I think your right -
> short term solution if nothing else is serve out text/html and look
> more closely at the problem when I rebase.

Actually, if the caching mechanism supports the spec properly 
(specifically RFC 2616, section 14.44), you should be able to work 
around this, without disabling the cache:

You can return different responses to different clients as long as you 
use the HTTP Vary header (RFC 2616, section 14.44) to indicate the 
criteria for selecting which response to return.

Finally, you can use the client's HTTP Accept header to figure out 
whether the browser supports XHTML or not. Basically just check 
if "application/xhtml+xml" is listed with a greater (or equal, but 
non-zero) Q-value than "text/html". I have a simple snippet of python 
code that I use in my webapps for this purpose. It should be easily 
translatable to the language of your choice. However, The list's spam 
filter prevents me from attaching it here... :(

A similar solution using PHP is sketched out here: 
http://keystonewebsites.com/articles/mime_type.php


Have fun!

...Johan


-- 
Johan Herland, <johherla@online.no>
www.herland.net
