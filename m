From: "J.H." <warthog9@kernel.org>
Subject: Re: [PATCH 0/6] Gitweb caching changes v2
Date: Fri, 11 Dec 2009 10:26:27 -0800
Message-ID: <4B228ED3.3030901@kernel.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org> <m3hbrxcxuu.fsf@localhost.localdomain> <4B226D56.7000004@kernel.org> <200912111901.35781.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 19:26:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJACJ-0003BN-Ix
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 19:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757948AbZLKS0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 13:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756983AbZLKS0X
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 13:26:23 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:39306 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683AbZLKS0X (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 13:26:23 -0500
Received: from voot-cruiser.eaglescrag.net (76-10-145-13.dsl.ncf.ca [76.10.145.13] (may be forged))
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nBBIQR0m008439
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Dec 2009 10:26:28 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <200912111901.35781.jnareb@gmail.com>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/10149/Thu Dec 10 14:26:20 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Fri, 11 Dec 2009 10:26:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135098>

Jakub Narebski wrote:
> On Fri, 11 Dec 2009, J.H. (John 'Warthog9' Hawley) wrote:
>> Jakub Narebski wrote:
>>> "John 'Warthog9' Hawley" <warthog9@kernel.org> writes:
> 
>>>> John 'Warthog9' Hawley (6):
>>>>   GITWEB - Load Checking
>>>>   GITWEB - Missmatching git w/ gitweb
>>>>   GITWEB - Add git:// link to summary pages
>>>>   GITWEB - Makefile changes
>>>>   GITWEB - File based caching layer
>>> This patch didn't made it to git mailing list.  I suspect that you ran
>>> afoul vger anti-SPAM filter.
>>>
>>> Does this "File based caching layer" have anything common with GSoC
>>> 2008 project, available at git://repo.or.cz/git/gitweb-caching.git ?
>> Yeah, it does seem that way (like I said eaten by a grue), it 
>> *currently* has nothing to do with Lea's GSoC code but it is still my 
>> intention, long term, to integrate the two.
>>
>> The patch, in all it's glory can be viewed at: 
>> http://git.kernel.org/?p=git/warthog9/gitweb.git;a=commitdiff;h=42641b1e3bfae14d5cc2e0150355e89cb87951db
>>
>> It is anything but a small patch to gitweb, the patch is 117K and 
>> comprises 3539 lines (including git header commit information).  There's 
>> not any real good way to break it up as it's a bit of an all or nothing 
>> patch.
> 
> First, why do you reinvent the wheel instead of using one of existing
> caching interfaces like CHI or Cache::Cache (perhaps creating a custom
> backend or middle layer which incorporates required features, like being
> load-aware)?

Well for starters this isn't exactly a reinvention of the wheel, and 
this isn't something "new" per-se.  This code has been actively running 
on git.kernel.org for something like 3 - 4 years so there's something to 
be said for the devil we know and understand.  As well using the other 
caching strategies involves adding dramatically more complex 
interactions with caching layer.  The caching layer is actually quite 
specific to how git + gitweb works and solves more than just "caching" 
on the surface.  Specifically it solves the stampeding herd problem 
which would have to be solved either way even if I didn't implement my 
own caching, and since I had to do that caching was barely a step beyond 
that to implement.

>  This way changing from file-based cache to e.g. mmap based
> one or to memcached would be very simple.

True but these are *VERY* different caching strategies than the one I've 
got here, yes it's using files as a backend but it's doing so with 
specific goals in mind.  As I've said I plan to integrate Lea's 
memcached based caching into this in the future and that has different 
advantages and disadvantages.

At the end of the day the "normal" caching engines aren't as efficient 
as mine and there is the case the very high performance sites are going 
to have to investigate a number of different solutions to see what works 
best for them.  Mine is also *dramatically* simpler to setup as well, 
turn it on, point it at a directory and your done.

>  And you would avoid pitfals
> in doing your own cache management.  perl-Cache-Cache should be available
> package in extras repositories.

There's pitfalls if I do it myself, or I use one of the other "common" 
perl modules.  I did it this way years ago, I've maintained it and it 
works pretty well.  I won't admit that it's the smartest caching engine 
on the planet, far from it, but it has evolved specifically for gitweb 
and that itself saves me a lot of pitfalls from cache engine + gitweb 
integration.

> If module is no available this would simply mean no caching, like in many
> (or not so many) other cases with optional features in gitweb.

Yes, but as can be seen from how you enable various other caching 
engines the setup of those is non-trivial, this is and either way 
caching *HAS* to be explicitly turned on by the admin/user since they 
are going to have to do *some* configuration, or at least be aware that 
their webapp is going to chew up some sort of resource.

> Second, if you can't use CGI::Cache directly, you can always steal the
> idea from it, then the change to gitweb itself would be minimal:
> 
>   "Internally, the CGI::Cache module ties the output file descriptor
>   (usually STDOUT) to an internal variable to which all output is saved."

I thought about that 3 years ago, and decided it wasn't a good option 
for gitweb.  Why?  There's too many assumptions throughout the code that 
when you do a print it will go immediately out.  Things like error 
messages and such.  Breaking out the prints into prints (which will do 
what is expected) and passing around the output in the $output variables 
makes it a lot simpler easier to differentiate about how / what your 
looking at and a *LOT* easier to debug.

> P.S. I'll postpone critique of the patch itself for now.  The above issues
> are much more important.

That's fine.  The issues your raising aren't new though, and stem back 
to before I created gitweb-caching, got rehashed with Lea's patches and 
not surprisingly are back on the table now.  Like I said above, there is 
no one caching strategy that's perfect in all cases here and that's 
again why I eventually plan to merge Lea's changes (which uses 
memcached) in as well, I'm just trying to get code that I'm getting 
considerable demand for, that's proven, upstream.

- John 'Warthog9' Hawley
