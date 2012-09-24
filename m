From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: GIT_DIR vs. --git-dir
Date: Mon, 24 Sep 2012 16:54:58 +0200
Message-ID: <50607442.3040906@drmicha.warpmail.net>
References: <5060097F.9050203@drmicha.warpmail.net> <20120924144929.GA10349@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 24 16:55:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGA3z-0007vI-Sc
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 16:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147Ab2IXOzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 10:55:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43935 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754805Ab2IXOzA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 10:55:00 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DE5DF20976;
	Mon, 24 Sep 2012 10:54:59 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 24 Sep 2012 10:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=C2xARmTIxmKCbQFrNw7u/i
	Wele4=; b=deE8mokGfZCin6DlOvhiq++Mvm2G+9WfadblsNbKkeqUKEncQcbRng
	R1BwtIjoXgO8s7CbEsBdEeqUpl0kEVMCEi0DS1q4+P+zGRJVnX+OGUfP2ZlDYUUp
	lUBwBinGOP/q4EhLIbUU/g9YmnUeqQh+xr+4a3IB9SipA5oRCGahI=
X-Sasl-enc: 8b2Rs2MunKheDlKHl2Ci6TW5OXP0A8qzXtlK7J6XzHiJ 1348498499
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4596F4827D8;
	Mon, 24 Sep 2012 10:54:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <20120924144929.GA10349@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206280>

Jeff King venit, vidit, dixit 24.09.2012 16:49:
> On Mon, Sep 24, 2012 at 09:19:27AM +0200, Michael J Gruber wrote:
> 
>> [mjg@localhost ~]$ GIT_DIR=~/.githome git rev-parse --show-toplevel
>> /home/mjg
>>
>> [mjg@localhost ~]$ git --git-dir=~/.githome rev-parse --show-toplevel
>> fatal: Not a git repository: '~/.githome'
>>
>> Huh? Ok, so most users probably would not try further and blame git, but:
>>
>> [mjg@localhost ~]$ git --git-dir=/home/mjg/.githome rev-parse
>> --show-toplevel
>> /home/mjg
>>
>> (All this is with core.worktree set to /home/mjg.)
>>
>> So, while I do understand that we don't expand '~' in any of these cases
>> and it's only a matter of bash tilde expansion kicking in or not, we
>> might want to do something about it. (--git-dir=$HOME/.githome gets
>> expanded, as well, and --git-dir=.githome works from the appropriate cwd
>> only).
> 
> Bash is even weirder than you might think. Try this:
> 
>   $ echo ~/foo
>   /home/peff/foo
> 
>   $ echo arg=~/foo
>   arg=/home/peff/foo
> 
>   $ echo --arg=~/foo
>   --arg=~/foo
> 
> That is, it expands on the right-hand side of an "=" (which, from my
> reading of the bash manual, means it considers it a word split), but
> refuses to expand after an "=" that is part of a long option.
> 
> The first one is definitely correct. It would be convenient for your use
> case to expand the third one, and it logically follows from the second
> one. However, dash does not expand the second one. I'm not sure if this
> is a bug in bash, or simply a grey area where the two shells do not
> agree.
> 
> But it makes me wonder if the world would be better served by a bash
> option to always enable tilde expansion after an "=". That would solve
> your issue, and it would make the same feature work for every other git
> long option, as well as for other programs.

Yes, in some sense this is working around a bash "feature". I don't
really care too much personally.

Note that we also have "git -c "config.var=value" which, again "works"
because we expand config vars.

So, technically there are no surprises if you know the shell's expansion
rules. But still...

Michael
