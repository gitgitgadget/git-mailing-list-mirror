From: David Aguilar <davvid@gmail.com>
Subject: Re: Creating something like increasing revision numbers
Date: Wed, 21 Oct 2009 00:47:12 -0700
Message-ID: <20091021074711.GB67773@gmail.com>
References: <20091018144158.GA9789@gandalf.dynalias.org>
 <alpine.LNX.2.00.0910181727130.32515@iabervon.org>
 <20091019004447.GC11739@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Norbert Preining <preining@logic.at>
X-From: git-owner@vger.kernel.org Wed Oct 21 09:47:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Vun-0005V9-SQ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 09:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbZJUHrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 03:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753086AbZJUHrQ
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 03:47:16 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:56693 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbZJUHrP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 03:47:15 -0400
Received: by ewy3 with SMTP id 3so5723732ewy.17
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qapOkiDwh646NbE6CwA9kACksY4EmKo22gh/fa8lZfU=;
        b=d0n/NSXUHriMncETN0YmSyz4fI7dbeYmRaXytQVU9L5Ti/x/q/KD1RnOqhGhSZXjQ9
         rqyjJZCuoeza7wwdG9dW+vDtg4+fyjBaRYeD5TPBw97MW1npF0mB9kkjN5ZbzONkPPcK
         2ZvULYnhu5mbZIGP9HSRiz/R+aMEGQRhCb58U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Yax9P9YN3EM7AzpUSlVqgtMHTUFbTmWv5brEvbwU+CWHfBsLJuFfrw8bPaszUU0dlH
         +uK8jOyiH7isVya05R2wem8X0sO/S3/3VTPDLObfBBghVmwTLKfjDWaH25jxmZDrGI0r
         6bwppyGG0zywZmq4WopMLlZdzwotbV2T/9fvQ=
Received: by 10.216.87.11 with SMTP id x11mr2565302wee.16.1256111239143;
        Wed, 21 Oct 2009 00:47:19 -0700 (PDT)
Received: from gmail.com (cpe-76-94-197-182.socal.res.rr.com [76.94.197.182])
        by mx.google.com with ESMTPS id i35sm2006008gve.28.2009.10.21.00.47.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 00:47:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091019004447.GC11739@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130895>

On Mon, Oct 19, 2009 at 02:44:47AM +0200, Norbert Preining wrote:
> Hi all,
> 
> thanks everyone for the nice feedback!
> 
> On So, 18 Okt 2009, Daniel Barkalow wrote:
> > It's possible as long as you don't think of the "version number" as a 
> > property of the commit, but rather a property that some commits get by 
> > virtue of having been at some time the commit that's what would be found 
> > on that particular server at that particular time. Even though the history 
> 
> Right! That is a good point. In fact I don't care about (local) commits,
> but about the pushes to the central server.
> 
> > of the *content* is non-linear, the sequence of values stored in 
> > refs/heads/master on your central server is linear, local, and easy to 
> > enumerate.
> 
> That is exactely what I need.


If you have any control over how people will use git,
then you can give your constantly-incrementing revision number
more stability by ensuring that everyone uses
'git pull --rebase'.

That'll literally keep the history completely linear.
If someone forgets then it's not a big deal; you'll
just get a merge commit and the number will increment
by 2 instead of by 1.

> Now my follow-up questions:
> - how would one access this "sequence" number on the server

If you've done the "tag the initial commit" as suggested
elsewhere on this thread:

	git tag projectname $(git rev-list HEAD | tail -n1)

then you can do this with simply:

	git describe --tags


It should output something like:

	projectname-101-g20912df

> - is there a way to determine at which of this "sequence" numbers a specific
>   file has been changed last?

	commit=$(git log --pretty=%H -1 -- <filename>)
	git describe --tags $commit


> JAIST Japan Advanced Institute of Science and Technology   preining@jaist.ac.jp
> Vienna University of Technology                               preining@logic.at
> Debian Developer (Debian TeX Task Force)                    preining@debian.org


Just another happy Debian user here,

-- 
		David
