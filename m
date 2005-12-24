From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Possibility of a MinGW version?
Date: Sat, 24 Dec 2005 13:07:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512241250520.27703@wbgn013.biozentrum.uni-wuerzburg.de>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se>
 <20051224101849.GY1279MdfPADPa@greensroom.kotnet.org> <43AD21D7.5060306@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, Rob McDonald <robm@asdl.gatech.edu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 15:45:20 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EqX7f-00070w-JY
	for gcvg-git@gmane.org; Sun, 25 Dec 2005 15:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVLYOpQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Dec 2005 09:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVLYOpP
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Dec 2005 09:45:15 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:58332 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750834AbVLYOpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2005 09:45:14 -0500
Received: by wrzx28.rz.uni-wuerzburg.de (Postfix, from userid 51)
	id C59DE140372; Sun, 25 Dec 2005 15:45:12 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3C072140B01; Sat, 24 Dec 2005 13:07:41 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43AD21D7.5060306@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14047>

Hi,

On Sat, 24 Dec 2005, Andreas Ericsson wrote:

> Sven Verdoolaege wrote:
> > On Sat, Dec 24, 2005 at 11:09:39AM +0100, Andreas Ericsson wrote:
> > 
> > > The worst trouble you're likely to run into is all the hardcoded paths.
> > > They are everywhere and ofcourse use the / for path entity separation.
> > 
> > 
> > AFAIR, '/' is a valid path separator on Windows.
> > It's just command.com (does that still exist?) that insisted on '\\'
> > separators.
>
> Are you sure? I've seen lots of porting patches that transliterate those to
> '\\'. Perhaps those who wrote those patches just took for granted that it was
> needed, the same as I did.

I tried it (IIRC even on Win98) and it worked with '/'. If not, it is 
relatively easy to introduce compat_mkdir and compat_open.

(We need compat_mkdir anyway, because the good MinGW people thought it a 
good idea to change the signature from standard mkdir(path, mode) to 
mkdir(path); a major annoyance when porting things to MinGW).

A bigger obstacle is the ubiquitous "c:/blabla". While you can make sure 
that git internally never uses such a rubbish (would be "/c/blabla" in 
MinGW), there are always the users.

> > > The fact that there are 39 bash'ish shell-scripts does little to help a
> > > native port, and although they can be fairly easily replaced by "real"
> > > programs it still means quite a bit of work with little real value for the
> > > unix-version, so I'm guessing you'll have to write those up for yourself.
> > 
> > 
> > Or just use MinGW's bash.

That is correct. MinGW comes with a current bash.

The biggest stoppers, however, are the absence of fork() and of ssh.

I don't know how many times fork() is used just to call another program, 
and then return the the original program. I believe there are some other 
cases, where there is bidirectional communication between the two. This is 
not so easy.

Without ssh, you have only http-push left to do the push, which in turn 
needs a WebServer set up with DAV. Furthermore, you can only fetch via 
HTTP or the git protocol, which both means setting up a server, i.e. you 
have no way to move your data directly between two private repositories.

Yes, there are other SSH's out there. But in order to communicate with the 
other side, MinGW would have to fork() with bidirectional communication. 
Bummer.

I can understand that people would prefer a MinGW version to a cygwin one, 
because of the performance hit, but unfortunately it is probably not worth 
the trouble. I, for one, would not do the work without getting paid very 
well for the job.

Ciao,
Dscho
