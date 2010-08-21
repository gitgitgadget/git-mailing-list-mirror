From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] format-patch: Update the `-3` example
Date: Sat, 21 Aug 2010 16:59:37 +0200
Message-ID: <201008211659.38608.jnareb@gmail.com>
References: <1282382819-25097-1-git-send-email-artagnon@gmail.com> <20100821103404.GB31130@kytes> <20100821105351.GC31130@kytes>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 16:59:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmpY0-0003cy-Kv
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 16:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab0HUO7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 10:59:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46670 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737Ab0HUO7r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 10:59:47 -0400
Received: by fxm13 with SMTP id 13so2289232fxm.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 07:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=pZw9psTobQGx8O4aKfRSidWL+aqmiKqxmZr2L5OnyOo=;
        b=JZDeYZUohiv1OFM90zmwxI/jK7GTkCJ2arHAJBRg1R+mloAVPmL2REy0fD1im2X4j/
         8jdrzIOIowH5C48obKAqKuyrKUDogpLej8zUfmIzxkCMf8y8h4OaVUzABbJZVueg5VVO
         5qIaP6fHHs7AiOlv7a1Xk6/yefE5ZtoQlW2SQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aONjGhaoCwmFPYexqEgZsGBBoiHTSanYeV2F6/6MA7oSI4eqenAQuc0FIy4oNLJvdz
         q4FBBgr7K7iQH54ExGI4UtsIEfZlCjlRTgzeT+BWqAr3DDem2vmMtQbGd59CxhNod7fH
         R0+aP4K0jfjnLZywmVVuuXD6Tvc2S0zhhybqM=
Received: by 10.223.119.10 with SMTP id x10mr2368622faq.1.1282402785803;
        Sat, 21 Aug 2010 07:59:45 -0700 (PDT)
Received: from [192.168.1.13] (aeho172.neoplus.adsl.tpnet.pl [79.186.196.172])
        by mx.google.com with ESMTPS id r4sm1643488faa.19.2010.08.21.07.59.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 07:59:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100821105351.GC31130@kytes>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154142>

On Sat, 21 Aug 2010, Ramkumar Ramachandra wrote:
> Ramkumar Ramachandra writes:
> > Jakub Narebski writes:
> > > Works for me:
> > > 
> > >   5031:[gitweb/split@git]# git format-patch -3
> > >   0001-gitweb-Prepare-for-splitting-gitweb.txt
> > >   0002-gitweb-Create-Gitweb-Git-module.txt
> > > 
> > >   5034:[gitweb/split@git]# git version
> > >   git version 1.7.2.1
> > > 
> > > 
> > > The -3 is git-log option:
> > > 
> > >   -<n>   Limits the number of commits to show.
> > > 
> > > and also git-format-patch option:
> > > 
> > >   -<n>   Limits the number of patches to prepare.
> > 
> > Hm, doesn't work on the `pu` Git, but works on `master` -- I'm
> > currently bisecting to find the problem. `git log -3` works
> > though.
> 
> :facepalm:
> 
> Scratch out what I just said -- I just realized that `git format-patch
> HEAD~3` handles merge commits, but `git format-patch -3` does
> not. `git format-patch -3 HEAD~3` is even more confusing- should we
> even advertise the `-<n>` option in format-patch?

It looks like there is a conceptual bug in how git-format-patch works, 
namely that '-<n>' is passed to rev-list / log generating machinery, 
and it limits number of *commits* to consider; if some of those commits 
are merge commits, which cannot be represented as patches, the number 
of patches it generates is less than specified <n> (as you can see in 
the example I have provided, where <n> == 3, and git-format-patch 
generated 2 patches, not 3).  In extreme case (like 'pu') it can 
generate no patch.

I am not sure what the solution should be.  We could either:

A. Update git-format-patch documentation to say 'commits' instead of
   'patches', and perhaps also be loud about commits we are skipping,
   so that my example would look e.g. like this:

     $ git format-patch -3
     0001-gitweb-Prepare-for-splitting-gitweb.txt
     0002-gitweb-Create-Gitweb-Git-module.txt
     Skipping merge commit: Merge branch 'maint'

or

B. Modify git-format-patch so that "git format-patch -<n>" would always
   generate <n> patches from specified commits, if there are that many.

But I think that option B.) it might be difficult, so perhaps A.) is 
"it". 
-- 
Jakub Narebski
Poland
