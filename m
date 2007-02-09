From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: restriction of pulls
Date: Fri, 9 Feb 2007 16:19:20 +0000
Message-ID: <200702091619.23058.andyparkins@gmail.com>
References: <200702091149.12462.duelli@melosgmbh.de> <Pine.LNX.4.63.0702091554160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45CC941E.9030808@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christoph Duelli <duelli@melosgmbh.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 09 17:19:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFYTM-0003yx-IH
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 17:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946603AbXBIQTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 11:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946607AbXBIQTe
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 11:19:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:12646 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946603AbXBIQTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 11:19:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so820005uga
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 08:19:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jgJIyQ4xmbzoe3MBkivkK9dq/WBWDmqMYs/KLSp9MKR5s/tzTZaexs6zzxusqC1lAOt1a1D1capKeKCM2bDRfLqDXrBdBlswnbyUClTaR5dwthXiOmaR+zXTjGlHKfMwOGNc2iXx3cTzFiTLXl2ZKBm9SaDDYCgkrCfYN0g0XzE=
Received: by 10.67.19.17 with SMTP id w17mr11451013ugi.1171037969952;
        Fri, 09 Feb 2007 08:19:29 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id y1sm4409302uge.2007.02.09.08.19.26;
        Fri, 09 Feb 2007 08:19:26 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <45CC941E.9030808@dawes.za.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39184>

On Friday 2007 February 09 15:32, Rogan Dawes wrote:

> One obstacle to implementing partial checkouts is that one does not know
> which objects have changed or been deleted. One way of addressing this

Why would you want to do a partial checkout.  I used subversion for a long 
time before git, which does to partial checkouts and it's a nightmare.

Things like this

 cd dir1/
 edit files
 cd ../dir2
 edit files
 svn commit
 * committed revision 100

KABLAM!  Disaster.  Revision 100 no longer compiles/runs.  The changes in dir1 
and dir2 were complimentary changes (say like renaming a function and then 
the places that call that function).

I didn't even notice how awful it was until I started using git and had a VCS 
that did the right thing.

In every way that matters you can do a partial checkout - I can pull any 
version of any file out of the repository.  However, it should certainly not 
be the case that git records that fact.

I think what you're actually after (from your description) is a shallow clone.  
I believe that went in a while ago from Dscho.

 $ git clone --depth=5 <someurl>

Will fetch only the last 5 revisions from the remote.  The other half to that 
is a shallow-by-tree clone; that is anathema to git as there is no such thing 
as a partial tree.  Submodule support is what you want, but that's still in 
development.

The only piece that (I think) is missing to get the functionality you want is 
a kind of lazy transfer mode.  For something like, say, the kde repository 
you can do

 svn checkout svn://svn.kde.org/kde/some/deep/path/in/the/project

And just get that directory - i.e. you don't have to pay the cost of 
downloading the whole of KDE.  Git can't do that; however, I think one day it 
will be able to by choosing not to download every object from the remote.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
