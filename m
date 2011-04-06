From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: blobs (once more)
Date: Wed, 6 Apr 2011 11:25:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1104061121000.2040@bonsai2>
References: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 11:26:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7P05-0003PS-7K
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 11:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285Ab1DFJ0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 05:26:03 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:35104 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755212Ab1DFJ0C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 05:26:02 -0400
Received: (qmail invoked by alias); 06 Apr 2011 09:25:58 -0000
Received: from pD9EB2A84.dip0.t-ipconnect.de (EHLO noname) [217.235.42.132]
  by mail.gmx.net (mp070) with SMTP; 06 Apr 2011 11:25:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3WFdwPSr3eGJNg7O3uqBcvH0UME3Esk1MNLK9zp
	UXLF7NnglrW/44
X-X-Sender: gene099@bonsai2
In-Reply-To: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170957>

Hi,

On Wed, 6 Apr 2011, Pau Garcia i Quiles wrote:

> Binary large objects. I know it has been discussed once and again but 
> I'd like to know if there is something new.
> 
> Some corporation hired the company I work for one year ago to develop a 
> large application. They imposed ClearCase as the VCS. I don't know if 
> you have used it but it is a pain in the ass. We have lost weeks of 
> development to site-replication problems, funny merges, etc. We are 
> trying to migrate our project to git, which we have experience with.
> 
> One very important point in this project (which is Windows only) is 
> putting binaries in the repository. So far, we have suceeded in not 
> doing that in other projects but we will need to do that in this 
> project.
> 
> In the Windows world, it is not unusual to use third-party libraries 
> which are only available in binary form. Getting them as source is not 
> an option because the companies developing them are not selling the 
> source. Moving from those binary-only dependencies to something else is 
> not an option either because what we are using has some unique features, 
> be it technical features or support features. In our project, we have 
> about a dozen such binaries, ranging from a few hundred kilobytes, to a 
> couple hundred megabytes (proprietary database and virtualization 
> engine).
> 
> The usual answer to the "I need to put binaries in the repository" 
> question has been "no, you do not". Well, we do. We are in heavy 
> development now, therefore today's version may depend on a certain 
> version of a third-party shared library (DLL) which we only can get in 
> binary form, and tomorrow's version may depend on the next version of 
> that library, and you cannot mix today's source with yesterday's 
> third-party DLL. I. e. to be able to use the code from 7 days ago at 
> 11.07 AM you need "git checkout" to "return" our source AND the binaries 
> we were using back then. This is something ClearCase manages 
> satisfactorily.

I understand. The problem in your case might not be too bad, after all. 
The problem only arises when you have big files that are compressed. If 
you check in multiple versions of an uncompressed .dll file, Git will 
usually do a very good job at compressing them.

If they are compressed, what you probably need is something like a sparse 
clone, which is sort of available in the form of shallow clones, but it is 
too limited still.

Having said that, in another company I work for, they hav 20G repositories 
and they will grow larger. That is something they incurred due to 
historical reasons, and they are willing to pay the price in terms of disk 
space. Due to Git's distributed nature, they had no problems with cloning; 
they just use a local reference upon initial clone.

> I have read about:
> - submodules + using different repositories once one "blob repository"  
>   grows too much. This will be probably rejected because it is quite 
>   contrived.

I would also recommend against this, because submodules are a very weak 
part of Git.

> - git-annex (does not get the files in when cloning, pulling, checking 
>   out; you need to do it manually)
> - git-media (same as git-annex)

Yes, this is an option, but a bit klunky.

> - boar (no, we do not want to use a VCS for binaries in addition to git)

I did not know about that.

> - and a few more
> 
> So far the only good solution seems to be git-bigfiles but it's still
> in development.

It has stalled, apparently, but I wanted to have a look at it anyway. Will 
let you know of my findings!

> Is there any good solution for my use case, where version = sources 
> version + binaries version?
> 
> Thank you.
> 
> If we suceed with git here, the whole corportation (150,000+
> employees, Fortune 500) may start to move to git in a year. Many
> people are fed up with CC there.

Ciao,
Johannes
