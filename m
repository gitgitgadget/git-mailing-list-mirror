From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: The final one
Date: Tue, 17 Aug 2010 22:11:27 +0530
Message-ID: <20100817164125.GE6947@kytes>
References: <20100817155933.GB6947@kytes>
 <27168737.115723.1282062015125.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Stefan Sperling <stsp@elego.de>,
	Bert Huijben <rhuijben@collab.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Will Palmer <wmpalmer@gmail.com>,
	Philip Martin <philip.martin@wandisco.com>,
	Jonas Gehring <jonas.gehring@boolsoft.org>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 18:43:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlPGF-00058i-KT
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 18:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406Ab0HQQne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 12:43:34 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58830 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0HQQnc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 12:43:32 -0400
Received: by gyd8 with SMTP id 8so95266gyd.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MNWShuTldAkpPCorxVkfVxBgeYJNI0kv+kRJT5LITOs=;
        b=iH1zc+orA/etYMbBDPYhtOzLdP5uOLIjH+tmY+20fwaMwG/AoLxF09jYvsC5AzBC/Z
         lqQw5ZW4B4k/ytSNCdVYXI3tIb8UKeZheIyezMSLT5WDIIkuGKqu/f0gNjhWBaSgKU/9
         Xg7mpOL8Qm8cWCGOS82P/2TxBONbMmgInvGZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PZRKuH3l/98rlHlpTfWXANHK6KvcuuosC00OYY3vGkk9D2++eRp7kAZNzqNMxy1ydf
         LWtRnvkGgNeWCTdaNBsCVdkpfn+kXGcSRuvGAmSIigTNZZnlT1/HAlSTq+8UmZaNEL2J
         rv54mXEnMZ5rfncNNdwb0FYI5Vvqx0WkkIbaA=
Received: by 10.100.11.1 with SMTP id 1mr7869069ank.93.1282063411548;
        Tue, 17 Aug 2010 09:43:31 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id j2sm6274469iba.6.2010.08.17.09.43.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 09:43:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <27168737.115723.1282062015125.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153761>

Hi Stephen,

Stephen Bash writes:
> > > So being selfish, what I care about is an improved method for
> > > converting SVN repos to git repos once and never going back. It
> > > sounds to me like the major hurdles remaining there are getting
> > > svn-fe to handle dumpfile v3 and handling branches/tags. Is that
> > > correct?
> > 
> > We're doing better than that- when the whole thing is complete, we
> > should have perfectly seamless two-way compatibility.
> 
> That makes complete sense.  It just happens I'm interested in a subset of the problem (the order has come down from on high that we will be using git for future development), so I'm curious if/how a one-time conversion simplifies things.

Thanks for bringing this up- it's quite interesting :)

A one-time conversion thing would have changed our priorities. Mainly,
I wouldn't have been able to justify the time I invested in building
svnrdump. I'd have probably settled for complete mirror + dump using a
combination of existing tools. The second difference:
svn-dump-fast-export is quite complex; although it was probably an
unconcious decision on David's part, it makes a really good generic
parser, and I suspect that it'll help us generate the dumpfile we need
for loading revision history data back into Subversion. Third, it
simplifies the branch/ tag mapper greatly- we'd only need to achieve a
perfect one-way mapping. A symmetric mapping is harder for several
reasons- consider preserving props for instance.

-- Ram
