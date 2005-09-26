From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 10:41:54 -0400
Message-ID: <433808B2.3070508@didntduck.org>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org> <20050926133204.GB21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Coxall <quasi@cream.org>,
	Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 16:43:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJu9w-0002gO-8I
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 16:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVIZOkp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 10:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVIZOkp
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 10:40:45 -0400
Received: from quark.didntduck.org ([69.55.226.66]:26570 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932137AbVIZOkp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 10:40:45 -0400
Received: from [172.21.26.77] (ip-2.provia.com [208.224.1.2])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j8QEeOI05088;
	Mon, 26 Sep 2005 10:40:24 -0400
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050926133204.GB21019@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9306>

Petr Baudis wrote:
> Dear diary, on Sun, Sep 25, 2005 at 09:06:37PM CEST, I got a letter
> where Martin Coxall <quasi@cream.org> told me that...
> 
>>On 25 Sep 2005, at 17:32, Zack Brown wrote:
>>
>>>Hi folks,
>>>
>>>When I use cogito, it gives a warning saying the rsync method is 
>>>deprecated and
>>>will be removed in the future. But when I visit kernel.org/git, the 
>>>page says to
>>>use an rsync URL with cg-clone.
>>>
>>>Maybe kernel.org should be updated?
>>>
>>
>>It does seem to be sending out a confusing message to us users too, 
>>since an initial clone of Linus's tree with rsync is on my machine 10x 
>>faster than an http clone, so it seems to be sending out something of a 
>>confused/confusing message re: rsync.
>>
>>Am I right in thinking it's because rsync didn't originally have pack 
>>support, but now it does, Petr has simply forgotten to deprecate the 
>>deprecation message?
> 
> 
> Nope. rsync always did packs, I actually un-deprecated it for the time
> period when HTTP didn't. The thing is, rsync is bad - it will happily
> put duplicate, redundant, and especially unwanted data to your
> repository, especially when the shared GIT repositories happen. HTTP and
> git-daemon are much better access methods in this regard - actually, I
> still like HTTP the most:
> 
> + Works everywhere - no special setup, no dedicated service, firewalls
> and proxies won't stop it
> + Works properly, i.e. only getting stuff you want, unlike rsync
> + Replicates packs setup - would be even better if it would kill objects
> and packs which the new pack makes redundant
> 
> 	It would be best to have some smarter git-prune-packed, which
> 	would process just a single pack. The other alternative would be
> 	that it would prune packs being subsets of other packs as well,
> 	but that scaled bad. I will write another mail about that.
> 
> - It is slow. Actually, I think it should be much faster for incremental
> fetches, and the initial fetch should take about the same time if you
> use packs. But the question is, did we already hit the limit? Are we
> using HTTP keepalive connections, do we parallelize the requests?
> 

The current HTTP fetch doesn't do asynchronous requests (using 
curl_multi_*).  This means that no transfers occur while processing 
received objects.

The other problem with HTTP vs. rsync is that the HTTP fetch will walk 
the entire tree down to the root to verify it has every object.  While 
this isn't a bad thing it's usually unnecessary when it's all in one big 
pack file.

--
				Brian Gerst
