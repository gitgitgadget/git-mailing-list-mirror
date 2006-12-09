X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sat, 9 Dec 2006 14:37:00 +0100
Message-ID: <200612091437.01183.jnareb@gmail.com>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org> <200612091251.16460.jnareb@gmail.com> <457AAF31.2050002@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 9 Dec 2006 13:34:57 +0000 (UTC)
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gB62HFdW5h6fQC4rqua36PQjbLWe1IaPpvPXLixoydNTZJjmcOXfZ3xUY8z+h3SwgWHBuctKlj5BCR3dYreV8RdbPnNzEXXQwgyn8o3SJj0vFpClGQ/tGipdNu+ZeJfFI/lC8BFaf46JzSk6kqgKvMAQPcsJ3HYHI3RiSz+H2BE=
User-Agent: KMail/1.9.3
In-Reply-To: <457AAF31.2050002@garzik.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33814>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gt2Lr-0008UG-Q8 for gcvg-git@gmane.org; Sat, 09 Dec
 2006 14:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761219AbWLINes (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 9 Dec 2006
 08:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761247AbWLINes
 (ORCPT <rfc822;git-outgoing>); Sat, 9 Dec 2006 08:34:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:46338 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1761219AbWLINer (ORCPT <rfc822;git@vger.kernel.org>); Sat, 9 Dec
 2006 08:34:47 -0500
Received: by ug-out-1314.google.com with SMTP id 44so959188uga for
 <git@vger.kernel.org>; Sat, 09 Dec 2006 05:34:45 -0800 (PST)
Received: by 10.67.20.3 with SMTP id x3mr6840397ugi.1165671285491; Sat, 09
 Dec 2006 05:34:45 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id 34sm3465900uga.2006.12.09.05.34.44; Sat, 09 Dec
 2006 05:34:44 -0800 (PST)
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org

Jeff Garzik wrote:
> Jakub Narebski wrote:

>> In addition to setting either Expires: header or Cache-Control: max-age
>> gitweb should also set Last-Modified: and ETag headers, and also 
>> probably respond to If-Modified-Since: and If-None-Match: requests.
>> 
>> Would be worth implementing this?
> 
> IMO yes, since most major browsers, caches, and spiders support these 
> headers.
 
Sending Last-Modified: should be easy; sending ETag needs some consensus
on the contents: mainly about validation. Responding to If-Modified-Since:
and If-None-Match: should cut at least _some_ of the page generating time.
If ETag can be calculated on URL alone, then we can cut If-None-Match:
just at beginning of script.
 
>> For some pages ETag is natural; for other Last-Modified: would be more
>> natural.
> 
> Yes, a good point to note.
> 
>> Usualy you can compare ETags base on URL alone.
> 
> Mostly true:  you must also consider HTTP_ACCEPT

Well, yes, ETag is HTTP/1.1 header. 

>> Wouldn't it be simplier to just set Last-Modified: header (and check
>> it?)
> 
> That would be a good start, and suffice for many cases.  If the CGI can 
> simply stat(2) files rather than executing git-* programs, that would 
> increase efficiency quite a bit.

As I said, I'm not talking (at least now) about saving generated HTML
output. This I think is better solved in caching engine like Squid can
be. Although even here some git specific can be of help: we can invalidate
cache on push, and we know that some results doesn't ever change (well,
with exception of changing output of gitweb).

> A core problem with cache hints via HTTP headers (last-modified, etc.) 
> is that you don't achieve caching across multiple clients, just across 
> repeated queries from the same client (or caching proxy).
> 
> At least for the RSS/Atom feeds and the git main page, it makes no sense 
> to regenerate that data repeatedly.
> 
> Internally, gitweb would need to do a stat() on key files, and return 
> pre-generated XML for the feeds if the stat() reveals no changes.  Ditto 
> for the front page.

I'm not sure if it is worth implementing in gitweb, or is it better left
to caching engine. With the projects list page and summary page there is
additional problem with relative dates, although this can be solved using
Jonas Fonseca idea of using absolute dates in the page and using ECMAScript
(JavaScript) to convert them to relative: on load, and perhaps on timer ;-)


What can be _easily_ done:
 * Use post 1.4.4 gitweb, which uses git-for-each-ref to generate summary
   page; this leads to around 3 times faster summary page.
 * Perhaps using projects list file (which can be now generated by gitweb)
   instead of scanning directories and stat()-ing for owner would help
   with time to generate projects lis page

What can be quite easy incorporated into gitweb:
 * For immutable pages set Expires: or Cache-Control: max-age (or both)
   to infinity
 * Calculate hash+action based ETag at least for those actions where it is
   easy, and respond with 304 Not Modified as soon as it can.
   This might require some code reorganization to not begin writing output
   before calculating ETag and ETag comparison (If-Match, If-None-Match).
 * Generate Last-Modified: for those views where it can be calculated,
   and respond with 304 Not Modified as soon as it can.

What can be easily done using caching engine:
 * Select top 10 of common queries, and cache them, invalidating cache on push
   (depending on query: for example invalidate project list on push to any
   project, invalidate RSS/Atom feed and summary pages only on push to specific
   project) - can be done with git hooks.
-- 
Jakub Narebski
