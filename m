From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 01:27:07 +0200
Message-ID: <200805300127.10454.jnareb@gmail.com>
References: <483C4CFF.2070101@gmail.com> <200805281414.36141.jnareb@gmail.com> <483DA594.5040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, Lars Hjemli <hjemli@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 01:28:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1rXY-00024k-Kn
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 01:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbYE2X1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 19:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755125AbYE2X1U
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 19:27:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:21138 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963AbYE2X1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 19:27:18 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1625465nfc.21
        for <git@vger.kernel.org>; Thu, 29 May 2008 16:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=UIJpUGCaKejBfltbVgbod1cu/9MmBcWoytnY/dM6Uu8=;
        b=ODNET4w2thgTobdyE7lV0tSTEUueErO3upYA/ZvAOI5W0aeWeQPtanuLj/GVWqoOTfGcoLZBjivdlqGuNsdo7yr1QfAzrY0yKz+YnPPM62ede2o9kvfxvXWHJD8H8cm5utH2209wKybVEOcB9fvBRHWwssoGzEw4s0hxTBWD9Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rcRx+7aaDa3BiPIWfUF4OaSheU6RvmW1KW3DQkbMSqnrJH8/fshvDJ08aVQmiTJyclUbJ0pzLmbdeqk6KF1awit/bS1XYsrNPT4mwAMPllAAokZ5EhHVLqQ+qiG53LKNcsnbffL2V9ro/jsdd6Lj1ibq9gyBzNDu66gb0eQZHm4=
Received: by 10.210.51.10 with SMTP id y10mr575706eby.93.1212103637291;
        Thu, 29 May 2008 16:27:17 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.197.146])
        by mx.google.com with ESMTPS id 6sm11053863nfv.36.2008.05.29.16.27.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 16:27:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <483DA594.5040803@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83253>

On Wed, 28 May 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
> >
> > 1. Caching data
> >  * disadvantages:
> >    - more CPU
> >    - need to serialize and deserialize (parse) data
> >    - more complicated
> 
> CPU: John told me that so far CPU has *never* been an issue on k.org. 
> Unless someone tells me they've had CPU problems, I'll assume that CPU 
> is a non-issue until I actually run into it (and then I can optimize the 
> particular pieces where CPU is actually an issue).

True.

What you have to care about (although I don't think it would be
partilcularly difficult) is to not repeat bad I/O patterns with
cache...

> Serialization: I was planning to use Storable (memcached's Perl API uses 
> it transparently I think).  I'm hoping that this'll just solve it.

While Storable is part of, I think, any modern Perl installation, there
might be problem with memcached API, and memcached API wrappers such as
CHI one.  Namely you cannot assume that memcached API is installed, so
you have to provide some kind of fallback.
 
> It's true that it's more complicated.  It'll require quite a bit of 
> refactoring, and maybe I'll just back off if I find that it's too hard.

What's more, if you want to implement If-Modified-Since and
If-None-Match, you would have to implement it by yourself, while
for static pages (cahing HTML output) web server would do this
for us "for free".

> > I'm afraid that implementing kernel.org caching in mainline in
> > a generic way would be enough work for a whole GSoC 2008.
> 
> I probably won't reimplement the current caching mechanism.  Do you 
> think that a solution using memcached is generic enough?  I'll still 
> need to add some abstraction layer in the code, but when I'm finished 
> the user will either get the normal uncached gitweb, or activate 
> memcached caching with some configuration setting.

Thats good enough, although I think that current caching mechanism in
kernel.org's gitweb (your implementation follows more what repo.or.cz's
gitweb does) has some good ideas, like for example adaptive (depending
on load) expiry time.

By the way what do you think about adding (as an option) information
about gitweb performance to the output, in the form of
  "Site generated in 0.01 seconds, 2 calls to git commands"
or
  "Site generated in 0.0023 seconds, cached output, 1m31s old"
line somewhere in the page footer?

I hope you have some ideas in gitweb access statistics from kernel.org,
repo.or.cz, and perhaps other large git hosting sites (e.g.
freedesktop.org), and you plan on benchamrking gitweb caching using
average / amortized time to generate page, ApacheBench or equivalent,
load average on server depending on number of requests, I/O load (using
fio tool, for example) depending on number of requests etc.

> By the way, I'll be posting about gitweb on this mailing list 
> occasionally.  If any of you would like to receive CC's on such 
> messages, please let me know, otherwise I'll assume you get them through 
> the mailing list.

I read git mailing list via Usenet / news interface (NNTP gateway) from
GMane. 

-- 
Jakub Narebski
Poland
