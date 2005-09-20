From: Brian Gerst <bgerst@didntduck.org>
Subject: Re: GIT - breaking backward compatibility
Date: Tue, 20 Sep 2005 00:12:35 -0400
Message-ID: <432F8C33.5080603@didntduck.org>
References: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 06:13:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHZUw-0008AN-Fg
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 06:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVITEMi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 00:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbVITEMi
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 00:12:38 -0400
Received: from quark.didntduck.org ([69.55.226.66]:42177 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S964873AbVITEMh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 00:12:37 -0400
Received: from [192.168.1.2] (24-236-201-214.dhcp.aldl.mi.charter.com [24.236.201.214])
	(authenticated)
	by quark.didntduck.org (8.11.6/8.11.6) with ESMTP id j8K4CQI21859;
	Tue, 20 Sep 2005 00:12:27 -0400
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8968>

Junio C Hamano wrote:
> I raised the following issues in my previous messages but did
> not hear many opinions [*1*].  I do not want to take it as a
> blank check from the community to do whatever I please.  So here
> is a recap.
> 
>  * Tools renaming plan calls for removal of the backward
>    compatible command names (e.g. git-fsck-cache and
>    git-update-cache) sometime in the future.  This is scheduled
>    for 0.99.8 around beginning of October.  If somebody wants
>    extended amnesty period, this can be pushed back but unless I
>    hear otherwise...
> 
>  * After reviewing the current set of commands, the following do
>    not seem to be useful anymore; Linus said he feels they can
>    go, and nobody else objected:
> 
>    git-diff-helper git-diff-stages git-export git-rev-tree
> 
>    I'd like to remove them before 1.0, and planning to do it
>    within the 0.99.8 timeframe unless I hear otherwise.
> 
>  * After Brian Gerst posted a patch to show 'modified' files in
>    ls-files [*2*], there was a brief discussion to change the
>    tagged output markings to make them more readable, but
>    neither Cogito nor StGIT seems to use tagged output.  I am
>    currently thinking about removing '-t' altogether.
> 
>    Again, unless I hear otherwise, I'd like to remove it within
>    the 0.99.8 timeframe.
> 
> 
> BTW, independent from any of these I'll be doing a 0.99.7a
> soonish for "fixes only" on top of 0.99.7.
> 
> 
> [Footnote]
> 
> *1* Well, Pasky indicated he does not like some of the terms in
> the glossary in his recent Cogito release announcement, but that
> was unfortunately after the fact.
> 
> *2* I haven't taken this patch not because I do not think
> showing 'modified' file is a bad idea but because showing cache
> dirty files as 'modified' did not feel right to me.  I think
> doing what 'git-update-index --refresh' does without actually
> refreshing the cache status bits would be the right way to go.

Essentially what I want to do is:

git-ls-files --others | xargs git-update-index --add --
git-ls-files --deleted | xargs git-update-index --remove --
git-ls-files --modified | xargs git-update-index --

This will completely resync the index and cache to the working tree 
state after applying a patch.  git-update-index --refresh only updates 
the stat info in the index.  It does _not_ write a new cache object if 
the file contents have actually changed.

Cogito would benefit from this too.  It currently uses git-diff-index 
and some ugly sed expressions in cg-commit to detect modified files.

If your objection is to calling the files modifed, then call it dirty or 
something else.

--
				Brian Gerst
