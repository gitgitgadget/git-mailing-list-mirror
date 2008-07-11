From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH 0/3] Git::Repo API and gitweb caching
Date: Fri, 11 Jul 2008 16:07:26 +0200
Message-ID: <4877691E.1010000@gmail.com>
References: <4876B223.4070707@gmail.com> <200807111133.11662.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	John Hawley <warthog19@eaglescrag.net>,
	Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 16:09:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHJIl-0002FK-9I
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 16:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903AbYGKOHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 10:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752738AbYGKOHs
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 10:07:48 -0400
Received: from gv-out-0910.google.com ([216.239.58.191]:19333 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbYGKOHr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 10:07:47 -0400
Received: by gv-out-0910.google.com with SMTP id e6so717956gvc.37
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 07:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=KutoyrxYG3/QcaP7T0lF7i84ZMnaDpDlwWp7lNk6O1o=;
        b=HpNHCrloHGI+s/ng0Bew3tD0G2ZHB3Qb57gy2mW0y8EdmWGhm82btyRWEbXMxcW3k2
         DwdfqsIHJVvJWdJHr+oETPjPJFCc4gpm6BlnLzKjBBM5QSTEsnP8y+/X3pKaVrGvMeoV
         3x66V4nV/wMALVzg41Y+Abgv3ZkU6ZN/6mW9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=gf2+vkkLl8q2hyNT5Vq10sp92gax7ByUbOSwUlai9U7GIEVD9AaT/ZyJMrV2Gcmewc
         JNvCVXBREDPUto6xJqj3KyB1pFa9Ns+KBRRX4DIsK6m0N7nHj1mxdl+hHr9dx3k62Nym
         iE8nVPVL66JR+GSSaibdua9yLjnYe//nINVr4=
Received: by 10.125.101.11 with SMTP id d11mr2995994mkm.110.1215785250979;
        Fri, 11 Jul 2008 07:07:30 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.219.252])
        by mx.google.com with ESMTPS id 11sm144780hug.62.2008.07.11.07.07.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Jul 2008 07:07:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <200807111133.11662.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88121>

Jakub Narebski wrote:
> On Fri, 11 July 2008, Lea Wiemann wrote:
>> 1) adding the Mechanize tests,
> 
> Somehow I didn't get Cc-ed this patch...

Yup, nobody got Cc'ed; apologies.

> If I remember correctly Mechanize tests detected some bugs in gitweb
> (nice!), but there were swept under the rug, i.e. put as TODO.
> 
> Does that mean that those errors were corrected, or that refactoring
> "just" didn't break anything more?

Refactoring really just didn't break anything more; it could be that
something got corrected accidentally, but I'd be surprised.

>> - Benchmarks.
> 
> Do you plan to compare other gitweb caching implementations? [k.org, repo.or.cz]

Yup, sure.

>> - Implementing support for Last-Modified or ETags [...] will require
>> mod_perl, since CGI doesn't allow for accessing arbitrary request headers
> 
>               $requested_language = http('Accept-language');
> 
>   the header lines received from the client, if any, are placed into the
>   environment with the prefix HTTP_ followed by the header name.

Right, you'd think the request headers should be accessible this way,
but apparently not all of them are.

If you take this script, ...

#!/usr/bin/perl
use CGI qw(http);
print "Content-type: text/plain\n";
print "Last-Modified: Thu, 03 Jul 2008 22:39:42 GMT\n\n";
print "Header: ", http('If-Last-Modified');

... then my browser (according to LiveHTTPHeaders) sends an
If-Last-Modified header, but it doesn't get through to the CGI script.
It does work if you test Accept-Language.  (Try print `env` to get an
idea of what gets through.)  It happens on Apache and thttpd.
Apparently this part somehow applies:

>   'The server may exclude any headers which it has already processed,'

I honestly have no idea why the If-Last-Modified headers gets eaten (and
googling didn't help), but I assume that at least it'll be possible to
access all headers with mod_perl.

> 'If-Not-Modified-Since', 'If-Match' (by caches)

Wait, are you sure caches would use those headers (I believe only the
latter actually exists BTW), or did you fall prey to a thinko? ;)

> one "shortcut" is that gitweb respects HEAD request
> (returning only HTTP headers) for feeds

Yes, and I think it does help performance-wise, but only a really small
fraction of the RSS/Atom requests actually use HEAD.  Most use GET.

> I think that ls_tree and git-ls-tree output parsing should be
> generalized into Git::Tree API as well.

True, though I'm still not sure how to make element access work pretty
and fast.  I'll keep pondering it for a while.

> I'll try to review the rest of patches by tomorrow...

Thanks!

Johannes Schindelin wrote:
> FWIW there are a few reasons why splitting up (3) might be the thing
> you really want to do

I've put splitting it on my list; I'm not sure though if I'll get around
to doing it today.  Everyone, comments on patch (3) are still
appreciated in the meantime. ;-)  I'll integrate any suggestions/patches
when I split it up.

-- Lea
