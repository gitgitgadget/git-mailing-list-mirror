From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: allow configurations that change with each request
Date: Mon, 2 Aug 2010 23:25:22 +0200
Message-ID: <201008022325.23670.jnareb@gmail.com>
References: <4C4D152A.7050505@gmail.com> <201008022135.58287.jnareb@gmail.com> <20100802210121.GA3072@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Julio Lajara <julio.lajara@alum.rpi.edu>,
	=?iso-8859-1?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 02 23:25:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og2WA-0005xZ-P6
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 23:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376Ab0HBVZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 17:25:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62855 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755049Ab0HBVZs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 17:25:48 -0400
Received: by fxm14 with SMTP id 14so1802731fxm.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 14:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=yVqdzSdUSrDd6ok6cMcsn/cmAbgruWzSlj8cAoct3Mo=;
        b=Wu0d6dFcZm58ytizkqg511DItyRQGJracWxyrk5aFV4t6WU2OWVzalyQ3vXEFdviFs
         8OsOFWup/FHvXoG2fIh62eybkEh4j4pGqAY8b+84j9GKVqnUP54jvfOdsL6BVGfdKNbI
         eYzkyLq9U55sD0O2TPDiiXMScMCMHMgFm5TI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VRKswiv9j0SQywM+jruDCsAKUIcwmSK2QH0T33Jawj6++FHiWumIdaNZhlX0EFldFZ
         dfIYJPo55IrkHYX6MftQdmp/ffL+KU8KAx0G1VLETvjGxEiKGnExnwSQ4Uxg0UGCthc4
         E7m5FrckdyMGIxeRO08aeZdIhr+NoPH2uzbcU=
Received: by 10.223.103.72 with SMTP id j8mr6497115fao.4.1280784347241;
        Mon, 02 Aug 2010 14:25:47 -0700 (PDT)
Received: from [192.168.1.13] (aeho67.neoplus.adsl.tpnet.pl [79.186.196.67])
        by mx.google.com with ESMTPS id y2sm2193678fau.12.2010.08.02.14.25.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 14:25:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100802210121.GA3072@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152463>

Jonathan Nieder wrote:
> Jakub Narebski wrote:
> 
> > One solution I can think of (still backwards incompatibile) would be to
> > provide $per_request_config variable, which would hold anonymous sub
> > with parts of config that need to be done per request (this should work
> > with global variables (our), but I think it wouldn't work with lexical
> > variables (my)).  For example gitolite's contrib/gitweb/gitweb.conf would
> > then include:
> > 
> >   $per_request_config = sub {
> >   	$ENV{GL_USER} = $cgi->remote_user || "gitweb";
> >   }
> 
> How would that interact with caching?  i.e., how would whatever caching
> engine is used learn that $cgi->remote_user is part of the key needed to
> uniquely determine a response?

Well, obviously caching itself, including generating cache key, would be
done per-request.  It is only *initializing* cache (i.e. require + 
+ $cache->new()) that should be done once per run and not once per 
request.

But nevermind, this might be not much of a problem.  I'll start with
cache re-initialized on each request for start.

-- 
Jakub Narebski
Poland
