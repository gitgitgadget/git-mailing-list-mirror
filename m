From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Sat, 14 Apr 2012 23:57:02 +0100
Message-ID: <4F8A00BE.6020409@pileofstuff.org>
References: <11292500.AVmZFUUvNi@flobuntu> <20120410171707.GA3869@burratino> <4F84B47D.1080301@pileofstuff.org> <1533147.bdVc1SQHSj@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 00:57:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJBu4-0005IH-QC
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 00:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754261Ab2DNW5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 18:57:08 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:38923 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755417Ab2DNW5G (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 18:57:06 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120414225704.YIJS23305.mtaout02-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Sat, 14 Apr 2012 23:57:04 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120414225704.CVMN10211.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 14 Apr 2012 23:57:04 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <1533147.bdVc1SQHSj@flomedio>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=Hd5Tmzg1rDkA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=TSbVqHtbAAAA:8 a=LJAMluM5aSseCL8-2msA:9 a=TVpr4iA2dod3dHT_adsA:7 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195529>

On 11/04/12 20:09, Florian Achleitner wrote:
> Furthermore the remote-helper has no way of asking the user something, right?
> So it can only fail if something is ambigous in the svn repository layout. So 
> I thought the SBL is exactly to describe these cases, and that's what I need.

Sorry, I missed this when it was first posted.

I'm not sure whether the remote helper is allowed to ask the user
things, but there can be times when that would be helpful.  The one that
jumps to mind is tag handling.

SVN considers tags and branches to be functionally identical, whereas
git likes to create "annotated tags" (commits with a special tag message
on top of the normal commit message) that can't be changed once they've
been created.  So if e.g. a tag is created then later committed to
again, what do you do?  Do you refuse to make annotated tags in case you
need to change them later?  Do you ignore later commits so that
annotated tags work nicely?

SBL can't provide much help here, as a tag could be created in one
update, then committed to again in another update.  Last time this was
discussed[1], the consensus seemed to be that there any clever solution
would drive straight past "it just works" into "why did it do that?"
territory, so the only sensible solution would be to ask what to do.

As I say, I don't really know anything about remote helpers, but I'd be
very surprised if you weren't allowed to at least fail with a message
like "Please set svn.tagStrategy, see `man git-config` for details".

	- Andrew

[1]http://thread.gmane.org/gmane.comp.version-control.git/192106/focus=192286
