From: Gelonida N <gelonida@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Sun, 11 Dec 2011 20:58:18 +0100
Message-ID: <4EE50B5A.3000706@gmail.com>
References: <jbvj5o$skt$1@dough.gmane.org>	<20111211022218.GA22749@sita-lt.atc.tcs.com>	<jc2l2a$som$1@dough.gmane.org> <m3ehwbge8f.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4
Content-Transfer-Encoding: 7bit
Cc: Sitaram Chamarty <sitaramc@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 20:58:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZpXi-00005O-VQ
	for gcvg-git-2@lo.gmane.org; Sun, 11 Dec 2011 20:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752361Ab1LKT6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Dec 2011 14:58:35 -0500
Received: from lo.gmane.org ([80.91.229.12]:33302 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab1LKT6e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2011 14:58:34 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RZpXc-00004v-B9
	for git@vger.kernel.org; Sun, 11 Dec 2011 20:58:32 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 20:58:32 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Dec 2011 20:58:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <m3ehwbge8f.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186810>

On 12/11/2011 07:22 PM, Jakub Narebski wrote:
> Don't remove people from Cc, please.

OK,

> 
> Gelonida N <gelonida@gmail.com> writes:
>> On 12/11/2011 03:22 AM, Sitaram Chamarty wrote:

>>
>> In order to save time I'd like to avoid checking out local branches.
> 
> You can use 'upstream' field name in git-for-each-ref invocation,
> for example
> 
>   git for-each-ref '--format=%(refname:short) %(upstream:short)' refs/heads |
>   	grep -e ' [^ ]' |
>   	sed  -e 's/ .*$//
>  
Thanks



> This could probably be done using only sed -- grep is not necessary.
I think the equivalent would be:
sed '/ [^ ]/ s/ .*$//'


> 
>> Ideally I would even like to avoid checking out branches, which don't
>> need to be forwarded.
>  
> You can use git-update-ref plumbing, but you would have to do the
> check if it does fast-forward yourself, and provide reflog message
> yourself too.
>  

True this would probably be fastest. Will read the docs a little to
understand exactly what you're doing. I'm not that much used to all the
commands used in the script.

> Something like
> 
>   git for-each-ref '--format=%(refname) %(upstream)' |
>   while read refname upstream
>   do
>   	# there is upstream
>   	test -n "$upstream" || break
>   	# and if fast-forwards
>   	test $(git merge-base $refname $upstream) = $(git rev-parse $refname) || break
>   	git update-ref -m "$message" $refname $upstream
>   done
> 
>> I also had to remember on which branch I was in order to avoid, that I
>> am at a random branch after running the script.
>>

> 
> Don't use git-branch in scripting.  See __git_ps1 function in
> contrib/completion/git-completion.bash how it can be done:
> 
>   b="$(git symbolic-ref HEAD 2>/dev/null)" ||
>   b="$(git rev-parse --verify HEAD)"
> 
> Nb. the second part is here only if there is possibility that you are
> on detached HEAD (unnamed branch).
> 
> HTH (hope that helps)

It definitely helps. Thanks a lot.
It's always good to see how one can do better after some attempts o some
self made clumsy scripts not suing all the features of git.
