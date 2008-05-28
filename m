From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Wed, 28 May 2008 14:14:35 +0200
Message-ID: <200805281414.36141.jnareb@gmail.com>
References: <483C4CFF.2070101@gmail.com> <200805272353.34319.jnareb@gmail.com> <483C912F.6010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, Lars Hjemli <hjemli@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 14:15:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1KZE-0004hR-AZ
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 14:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbYE1MOu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 08:14:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYE1MOu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 08:14:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:29590 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbYE1MOt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 May 2008 08:14:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1765568fgg.17
        for <git@vger.kernel.org>; Wed, 28 May 2008 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=QwKh1AHdYYboIwoAGSI1+HYfQE3WmFk8yO9iQvVXOXE=;
        b=Ixvigyf1WR0KRZ5Gpy0K13PHYQWTVGGrYzu4jcHb5zr9otNO8sfAQQaHHpHk39EWucb7HlMmy+V0Zb0bZmzKc+z1c1VItJF+HeaEpm7qw3fy64H5oUg/+ULrtScKwzRFy0jfwEQgwUnu3Lnk51M9Q0/fWkaVAEMObthVIFa9Lwo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SM41ABZ7wwfrvVK994x5oasEN0WJ2IxE2Pwe8yONpuE36oqHMJ2Th5qgEaXoLsl5yVoxqhLZJNCcU5/WYMryU7jQr+PvZT9N/EgNHEHMgTlSUwajec8FJ5EytiuT0vw8dZtJo0VlwtJkFXuq3+nsI8HFayKEBjtSbKDEjip2L9g=
Received: by 10.86.33.10 with SMTP id g10mr340545fgg.15.1211976887526;
        Wed, 28 May 2008 05:14:47 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.223.245])
        by mx.google.com with ESMTPS id 3sm16623782fge.3.2008.05.28.05.14.43
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 May 2008 05:14:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <483C912F.6010802@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83088>

On Wed, 28 May 2008, Lea Wiemann wrote:
> Jakub Narebski wrote:
>>
>> Lately he posted a patch
>> implementing projects list caching, in a bit different way from how it
>> is done on kernel.org, namely by caching data and not final output:
> 
> Thanks for this and all the other pointers.
> 
> Caching data and not final output is actually what I'm about to try 
> next.

Caching data have its advantages and disadvantages, same as with
caching HTML output (or parts of HTML output). I have wrote about
it in
  http://thread.gmane.org/gmane.comp.version-control.git/77529

Let me summarize here advantages and disadvantages of caching data
and of caching HTML output.

1. Caching data
 * advantages:
   - smaller than caching HTML output
   - you can use the same data to generate different pages
     ('summary', 'shortlog', 'log', 'rss'/'atom'; pages or search
      results of projects list)
   - you can generate pages with variable data, such as relative dates
     ("5 minutes ago"), staleness info ("cached data, 5 minutes old"),
     or content type: text/html vs application/xhtml+xml
 * disadvantages:
   - more CPU
   - need to serialize and deserialize (parse) data
   - more complicated

2. Caching HTML output
 * advantages:
   - simple, no need for serialization (pay attention to that in mixed
     data + output caching solutions)
   - low CPU (although supposedly[1] gitweb performance is I/O bound,
     and not CPU bound)
   - web servers deals very well with static pages
   - web servers deals with support for HTTP caching (giving ETag and
     Last-Changed headers, responding to If-Modified-Since, 
     If-None-Match etc. headers from web browsers and caching proxies)
 * disadvantages:
   - large size of cache data (if most clients support compression, you
     can store it compressed, at the cost of CPU for non-supporting ones).
   - difficult to impossible variable output (for example you can still
     rewrite some HTTP headers for text/html vs application/xhtml+xml
     or store headers separately, you can use JavaScript to change
     visible times from absolute to relative dates)

I'm sure John, Lars and Petr can tell you more, and have more experience.

[1] Some evidence both from warthog9 and pasky, but no hard data[2]
[2] I think it would be good to start with analyse of gitweb statictics,
    e.g. from Apache logs, from kernel.org and repo.or.cz.

> If I'm not mistaken, the HTML output is significantly larger than  
> the source (repository) data; however, kernel.org still seems to benefit 
> from caching the HTML, rather than letting Linux' page cache cache the 
> source data.

I don't think kernel.org caches _all_ pages, only the most requested
(correct me if I'm wrong here, John, please).

> That leads me to think that the page cache somehow fails  
> to cache the source data properly -- I'm not sure why (wild speculation: 
> perhaps because of the pack format).

>From what I remember one of most costly to generate pages is projects
list page (that is why Petr Baudis implemented caching for this page
in repo.or.cz gitweb, using data caching here).  With 1000+ projects
(repositories) gitweb has to hit at best 1000+ packfiles, not to
mention refs, to generate "Last Changed" column from git-for-each-ref
output (accidentally, also to check if it is truly git repository).
In kernel.org case with gitweb working similar to mod_userdir module
but for git repositories (as a service, rather than as part of repo
hosting), gitweb has to hit 1000+ 'summary' files...  That is
interspersed with other requests.

How page cache and filesystem buffers can deal with that?

BTW I'm not sure if kernel.org use CGI or "legacy" mod_perl gitweb;
curently there is no support for FastCGI in gitweb (although you can
find some patches in archive).

(But I'm not an expert in those matters, so please take the above
with a pinch of salt, or two).


By the way using pack files besides reducing repository size also
improved git performance thanks to better I/O performance and better
working with filesystem cache (some say that git is optimized for
warm cache).

> Anyway, I'd hope that I can  
> encapsulate the 30-40 git_cmd calls in gitweb.perl and somehow cache 
> their results (or, to save memory, the parts of their results that are 
> actually used) and cache them using memcached.  If that works well, we 
> can stop bothering about frontend (HTML) caching, unless CPU becomes an 
> issue, since all HTML pages are generated from cacheable source data.

I don't think caching _everything_, including rarely requested pages,
would be a good idea.

> I'm *kindof* hoping that in the end there will be only few issues with 
> cache expiry, since most calls are uniquely identified through hashes. 
> (And the ones that are not, like getting the hash of the most recent 
> commit, can perhaps be cached with some fairly low expiry time.)

The trouble is with those requests which are _not_ uniquely identified
by hashes requested, such as 'summary', 'log' from given branch (not
from given hash), or web feed for given branch.  For those which are
not-changing you can just (as gitweb does even now) give large HTTP
expiry (Expires or max-age) and allow web browser or proxies to cache
it.

> So that's what I'll try next.  If you have any comments or warnings off 
> the top of your heads, feel free to send email of course. :)

I'm afraid that implementing kernel.org caching in mainline in
a generic way would be enough work for a whole GSoC 2008.  I hope
I am mistaken and you would have time to analyse and implement wider
reange of caching solutions in gitweb...
 
>> the main culprit of [the fork] was splitting gitweb into many, many
>> files.  While it helped John in understanding gitweb, it made it
>> difficult to merge changes back to mainline.
> 
> Interesting point, thanks for letting me know.  (I might have gone ahead 
> and tried to split the mainline gitweb myself... ^^)  I think it would 
> be nice if gitweb.perl could be split at some point, but I assume there 
> are too many patches out there for that to be worth the merge problems, 
> right?

On one hand gitweb.perl in single file makes it easy to install; on the
other hand if it was split into modules (like git-gui now is) it would
I think be easier to understand and modify... I think however that it
would be better to first make gitweb use Git.pm, adding improving Git.pm
when necessary (for example adding eager config parsing used in gitweb,
i.e. read whole config into Perl hash at first request, then access hash
instead of further calls to git-config).

-- 
Jakub Narebski
Poland
