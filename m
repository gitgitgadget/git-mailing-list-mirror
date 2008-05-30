From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 12:02:23 +0200
Message-ID: <200805301202.25368.jnareb@gmail.com>
References: <483C4CFF.2070101@gmail.com> <200805300127.10454.jnareb@gmail.com> <483FABB4.1010309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, Lars Hjemli <hjemli@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 12:03:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K21SJ-0005zi-3F
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 12:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbYE3KCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 06:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbYE3KCf
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 06:02:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:15279 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYE3KCe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 06:02:34 -0400
Received: by ug-out-1314.google.com with SMTP id h2so277320ugf.16
        for <git@vger.kernel.org>; Fri, 30 May 2008 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=lDLBg/G2ixmmEYnS3qRRH4vx6pRVO4NoQtCEdUWsuus=;
        b=oFJZoSXqsx2zuHJ44WEkop8TZO71tEPCP87pdQAkKqP71GhlBkUmXnbAln4OkutOqKE6YYZS3QHPIAQkNCmqvVE9YoShgzHYC4ORdXKpORld+8iJDRQP/q0a4k+Ah2yw1Gh0L1rxmrIOpehqK11PQum+269OBNTBLdEJq3hfAW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=wCvIvkF84HgG73zTBRjlTqzJrBmWPzRVeMEHwq8SYzn6blAskQWPMkMhrd6KFqerNasnV+Nw+nR9KDxYZif2dcH+xyUplNAaAuM8Y1878spxO8kHiwpj/iz3JRwBRzSkHGD/eq6618oq55Ko7jZtbDSytem7oylYZPIDAeIJ74A=
Received: by 10.66.239.16 with SMTP id m16mr908671ugh.28.1212141751634;
        Fri, 30 May 2008 03:02:31 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.197.146])
        by mx.google.com with ESMTPS id b33sm2857670ika.2.2008.05.30.03.02.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 May 2008 03:02:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <483FABB4.1010309@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83284>

On Fri, 30 May 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
> >
> > you cannot assume that memcached API is installed, so
> > you have to provide some kind of fallback.
> 
> That fallback would be to have no caching.  I think that's acceptable 
> -- I'm not too willing to implement caching for two API's.

I hope that you would make a wrapper around memcached (caching engine)
API (it's a pity we cannot use CHI unified Perl caching interface),
so it would be easy for example to change to filesystem based cache,
or size aware filesystem based cache, or mmap, etc...  I mean here
that even if you don't implement two caching API's at least make it
possible to easy change caching backend.

Note also that memcached may not have sense for single machine
(single server installation), and does not make sense for memory
starved machines... and one can want gitweb caching even in that
situation.

> (Incidentally, memcached takes two shell commands to install and get 
> running on my machine; I think that's acceptably easy.)

As John 'Warthog9' said wrt. using additional Perl modules for gitweb
caching, most sites that are used as web servers (and gitweb servers)
have strict requirements on stability of installed programs, libraries
and modules.  IIRC the policy usually is that one can install packages
from main (base) repository for Linux distribution used on server, also
from extras repository; sometimes from trusted contrib package
repository.  Modules which are only in CPAN, and programs which require
compilation are out of the question, unfortunately.

I think there is no problem wrt. memcached itself, I'm not so sure
about Perl APIs: Cache::Memcached and/or Cache::Memcached::Fast (and
optionally appropriate CHI modules/backends).
 
> > What's more, if you want to implement If-Modified-Since and
> > If-None-Match, you would have to implement it by yourself, while
> > for static pages (cahing HTML output) web server would do this
> > for us "for free".
> 
> Are web servers doing anything that we can't easily reimplement in a few 
> lines (and, on top of that, more easily tailored to different actions, 
> projects, etc.)?

Can we reimplement it?  I think we can.  Easily?  I'm not sure.  
HTTP/1.0 If-Modified-Since should be failry easy; it would be harder
to support fully and correctly ETag (weak vs. strong tags),
If-None-Match (from web browsers I think), If-Match (from web caches)
it would take some work.

> > By the way what do you think about adding (as an option) information
> > about gitweb performance to the [HTML] output,
> 
> Definitely a good idea!

I'd try to add it when I'd have a bot more of free time; unless you
would do this first.

-- 
Jakub Narebski
Poland
