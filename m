From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] GIT paths
Date: Wed, 26 Oct 2005 10:56:55 +0200
Message-ID: <435F44D7.2030406@op5.se>
References: <7vhdb7qown.fsf@assigned-by-dhcp.cox.net>	<435E259D.3040701@op5.se> <7vmzkwajrv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Oct 26 11:01:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUh5f-0001gO-6n
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 10:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbVJZI44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 04:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVJZI44
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 04:56:56 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:15492 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932602AbVJZI44
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 04:56:56 -0400
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 6A7286BD01
	for <git@vger.kernel.org>; Wed, 26 Oct 2005 10:56:55 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vmzkwajrv.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10656>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>>
>>The userdir is (with my previous patch) only expanded if the path starts 
>>with a tilde.
> 
> 
> I do not necessarily consider that a feature; see next item.
> 
> 
>>It must remove the leading slash for this syntax:
>>
>>	ssh://host.xz/~junio/repo
>>
>>Otherwise it would be passed as /~junio/repo to the remote end and no 
>>~user interpolation would be done.
> 
> 
> Not necessarily.  Having the remote end interpret "/~user" and
> "~user" the same way might make things more consistent;


Except that the shell interprets ~ and /~ differently, so "consistent" 
would depend on what we're consistent with.

There's also the fact that shell-scripts won't work on the remote end if 
  git_connect() maintains the leading slash. This doesn't matter at 
present, but I think it'd be better to keep all doors open. Having the 
trivial addendum on the client side also helps keeping the server-side 
nice and simple.

> in other
> words, "http://host/~user" is not spelled "http://host~user".
> 

True. I meant for this to be invisible to the users ofcourse, with 
git_connect() having some snippet such as this.

if(use_ssh || use_git && (*path == '/' && *(path + 1) == '~')
	*path++ = '\0';
else
	copy_path();

> 
>>I'd say make it invoke the programs with the canonicalized path. As you 
>>say, git-daemon has to verify that it's a proper git repo and in the 
>>whitelist anyway so I think it would be silly to add extra complexity to 
>>upload-pack and receive-pack.
> 
> 
> Yeah, I tend to agree here.
> 
> 
>>> - Give --server-root=/path/to/root flag to programs...
>>
>>If we stick with canonicalized paths I suppose this can be dropped.
> 
> 
> Sounds good.
> 
> 

I'll get busy then.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
