From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 01 Feb 2011 16:36:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102011542190.8580@xanadu.home>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:37:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkNuO-0001UU-8u
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751989Ab1BAVgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 16:36:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18910 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab1BAVgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 16:36:54 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFY00JINK0V79E0@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 Feb 2011 16:36:31 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <201102011451.17456.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165862>

On Tue, 1 Feb 2011, Jakub Narebski wrote:
> On Sun, 30 Jan 2011, Jonathan Nieder wrote:
> > Dmitry S. Kravtsov wrote:
> > 
> > > resumable clone/fetch (and other remote operations)
> > 
> > Jakub Narebski seems to be interested in this and Nicolas Pitre has
> > given some good advice about it.  You can get something usable today
> > by putting up a git bundle for download over HTTP or rsync, so it is
> > possible that this just involves some UI (porcelain) and documentation
> > work to become standard practice.
> 
> I wouldn't say that: it is Nicolas Pitre (IIRC) who was doing the work;
> I was only interested party posting comments, but no code.

No, I'm not working on that.  I provided suggestions on how to go about 
it in the past:

1) The git-archive based solution:
   http://article.gmane.org/gmane.comp.version-control.git/126431
   Relatively simple to implement, with questionable efficiency if you 
   care about the full history, but perfectly suited for shallow clones 
   which is what people with flaky connections should aim for anyway.

2) The bundle based solution:
   http://article.gmane.org/gmane.comp.version-control.git/164699
   (see towards the end of the message)
   This was about BitTorrent distribution, but any resumable transport 
   can be applied to the bundle.
   Extremely simple to implement, as this all can be scripted on top of 
   existing tools.  Good for the bulk of history, but there is always a 
   risk for problems during the update of the repository from the 
   bundle's state up to the most recent commits which has to fall back 
   to the non resumable smart Git protocol.

There is also some possibility that the cache pack work might be 
leveraged to provide a resumable clone solution similar to #2 above, but 
that would of course share the same flaws.

> Again, this feature is not very easy to implement, and would require 
> knowledge of git internals including "smart" git transport ("Pro Git"
> book can help there).

The two proposed solutions above require no prior knowledge of the smart 
Git protocol, and they should be pretty simple to implement. Certainly 
in the reach of a GSOC student.

> > > GitTorrent Protocol, or git-mirror
> > 
> > Sam Vilain and Jonas Fonseca did some good work on this, but it's
> > stalled.
> 
> There was some recent discussion on this on git mailing llist, but
> without any code.
> 
> One would need to know similar areas as for "resumable clone" feature.
> Plus some knowledge on P2P transport in GitTorrent case.

Again, please see 

http://article.gmane.org/gmane.comp.version-control.git/164699

This is simple, and with guaranteed results.  Why no one was interested 
in implementing that yet I don't know.


Nicolas
