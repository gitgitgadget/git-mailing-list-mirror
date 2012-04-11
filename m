From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Wed, 11 Apr 2012 23:43:43 +0100
Message-ID: <4F86091F.7010800@pileofstuff.org>
References: <11292500.AVmZFUUvNi@flobuntu> <1421035.yALBSXSHGd@flomedio> <20120410171707.GA3869@burratino> <2866164.rI5svgrW1x@flomedio> <20120411195351.GG4248@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:44:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI6GY-0002zg-Mv
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 00:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760287Ab2DKWnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 18:43:50 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:58683 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757252Ab2DKWns (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Apr 2012 18:43:48 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120411224345.FRT23305.mtaout02-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Wed, 11 Apr 2012 23:43:45 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120411224345.UIHP23925.aamtaout04-winn.ispmail.ntl.com@[192.168.0.2]>;
          Wed, 11 Apr 2012 23:43:45 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <20120411195351.GG4248@burratino>
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=Hd5Tmzg1rDkA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=Me8FAtEY4-VqwR6Mxp0A:9 a=fqPvrK6eljnRLMAmrlsA:7 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195278>

On 11/04/12 20:53, Jonathan Nieder wrote:
> [...]
>> Additionally the remote-helper will read a configuration file containing 
>> additional information about branch-mapping, this should be closely related to 
>> Andrew's SBL.
> 
> That sounds reasonable to me.  I am somewhat unconvinced (but
> convinceable) about the need to use a configuration scheme that
> handles all the edge cases right away.  Shouldn't it be enough to tell
> the importer the following?
> 
>  - the path to the repository (from which it can deduce $SVNROOT
>    and the path within there to the subproject of interest)
> 
>  - a single bit of information on top of that: "this repository uses
>    the standard layout"
> 
> Once that works, the tools could easily be tweaked to respect a
> configuration file that describes more complex situations, and as a
> bonus the SBL tools for making sense of those situations would have
> time to become more mature in the meantime.

SBL itself is just a plain text description of which directories are
branches etc. - there are a handful of tricky bits on Florian's side of
the fence, but it shouldn't be that hard to add everything necessary to
parse any arbitrary SBL file.  For example, if he gets an SBL action
that looks like this:

In r105, create branch "/foo" as "foo-bar" from "/bar/baz" r25

... then the logic that produced that line doesn't really matter, so
long as he can convert it to a series of fast-import commands.

I started work on exporting branches from SVN a few months ago, and
happened to be polishing off SBL when GSoC got going, so my work ties
nicely into Florian's.  I've been keen to talk about edge cases lately
because that's the point I'm at in my work - to make a long story short,
I know how to do the easy cases now, and need to veer off into some
weird edge cases for a month or two, before swinging back by the
standard layout and optimising for that.  If Florian needs something
that generates SBL before I'm ready, I'd be happy to cobble a basic
"standard layout only" script from the modules I've got.

	- Andrew
