From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Mon, 26 Sep 2005 17:55:34 -0400
Message-ID: <43386E56.8000208@didntduck.org>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz> <20050926212536.GF26340@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 26 23:55:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK0vT-0006nH-7M
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 23:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbVIZVyQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 17:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbVIZVyQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 17:54:16 -0400
Received: from quark.didntduck.org ([69.55.226.66]:62110 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932316AbVIZVyP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 17:54:15 -0400
Received: from [172.21.26.77] (ip-2.provia.com [208.224.1.2])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j8QLs3I22919;
	Mon, 26 Sep 2005 17:54:03 -0400
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050926212536.GF26340@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9338>

Petr Baudis wrote:
> Dear diary, on Sat, Sep 24, 2005 at 03:18:33AM CEST, I got a letter
> where Petr Baudis <pasky@suse.cz> told me that...
> 
>>Dear diary, on Sat, Sep 24, 2005 at 12:24:06AM CEST, I got a letter
>>where "H. Peter Anvin" <hpa@zytor.com> told me that...
>>
>>>Packed tag objects breaks Cogito when using git+ssh:// transport.
>>>
>>>Example:
>>>
>>>cg-clone -s git+ssh://master.kernel.org/pub/scm/libs/klibc/klibc.git
>>
>>I changed the code to use the git-*-fetch tools to fetch the objects
>>referenced by tags, so this works properly now. Thanks for the report.
> 
> 
> And now thanks to "walt" I realized that this is a completely wrong way
> to go. The problem is that the tags don't have to tag anything on your
> branch, and if you are fetching a given branch, you want only commits
> from that branch. But fetching the tags will cause all the commits
> connected to the tags getting slurped too, and we didn't want that.
> 
> So the strategy I'm thinking of now is to manually (I think no GIT tool
> can do that for me) dereference the possible tag chain until I end up at
> some non-tag object. Now, if it is a commit and I don't have it yet, it
> means that it is not interesting to me because it does not belong to a
> branch I'm following, so I will just ignore the tag (won't download
> anything else and won't record it in the refs/tags directory).

I think this is the right idea.

> If it's NOT a commit, well, that's a question.  On the assumption that
> it won't be a great deal of data and it's likely to be assumed that we
> have it, I would be inclined to fetching it, but I don't feel strongly
> about it.

It could point to a tree (ie. the kernel's v2.6.11 tag), which may end 
up being a large pull.  I think it's best to not care what type of 
object the tag references.

--
				Brian Gerst
