From: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
Subject: Re: Auto update submodules after merge and reset
Date: Sat, 10 Dec 2011 02:41:23 +0100
Message-ID: <4EE2B8C3.6000906@ursus.ath.cx>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de> <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de> <4EE07FCD.8090702@ursus.ath.cx> <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 02:49:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZC45-0004Kv-1s
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 02:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678Ab1LJBtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 20:49:19 -0500
Received: from brln-4dba6889.pool.mediaWays.net ([77.186.104.137]:1168 "EHLO
	here" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751166Ab1LJBtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 20:49:19 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Dec 2011 20:49:19 EST
Received: from [192.168.0.14] (unknown [192.168.0.14])
	by here (Postfix) with ESMTP id 42DF819AC59;
	Sat, 10 Dec 2011 02:42:12 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20111110 Icedove/3.0.11
In-Reply-To: <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186717>



On 10.12.2011 00:57 Phil Hord wrote:
> On Thu, Dec 8, 2011 at 4:13 AM,<andreas.t.auer_gtml_37453@ursus.ath.cx>  wrote:
>    
>> On 07.12.2011 23:23 Jens Lehmann wrote:
>>      
>>>> If you have tracking branches, the supermodule can just update the
>>>> corresponding branch. If this branch is currently checkedout and
>>>> the work area is clean, then the work area is updated, too. If
>>>> there is currently a local branch or a diffent super-branch
>>>> checked out then the working area should be considered "detached"
>>>> from the superproject and not updated.
>>>>          
>>>   This sounds a lot like the "follow branch tip" model we discussed
>>>   recently (which could be configured via .gitmodules), but I'm not
>>>   sure you really are in the same boat here.
>>>        
>> When I understood that correctly it was just a configuration to what branch
>> should be automatically checked out in the submodule. This seems to be too
>> complicated IMO, because when you have different branches in the
>> superproject then you may want to have different branches in the submodules,
>> too, but you would need to configure that submodule branch in .gitmodules
>> for each branch separately. I.e. in the master branch the .gitmodule may
>> contain "master", in the maint branch the .gitmodules may have "maint" as
>> the branch to follow.
>>      
> Yes, but maybe you can update this information in the .gitmodules file
> easily with a command.  Maybe it could be something simpler than "git
> sync-gitmodules-branches", but that is essentially what it would do:
> it would save the current branch in each submodule as the "tracked"
> branch in the .gitmodules file.
>
> The advantages to this, I think, are that
>
> 1. Your "submodule A follows branch X" information is explicit in the
> .gitmodules file and so it is not hidden when I examine your patch.
> (It sounds to me like the refs/super/* branches would necessarily be
> hard to find since the refs/ hierarchy is usually meta data about
> local and remote branches.  Maybe I should think about tags and notes
> more, though.)
>    
Branches can be seen as "dynamic data" that can easily be updated, 
renamed or even deleted, if a branch is merged into another.
On the other hand .gitmodules can be seen as "static data" because it is 
committed to the object database, so if you checkout an old revision, 
you could get a version of the .gitmodules that refers to a branch, 
which existed at that time, but was deleted meanwhile.

> 2. When you change to "submodule A now follows branch Y", this
> information can be unambiguously saved in the commit where it occurred
> rather than tucked away, again, in refs/super/*.
>    
If you place a reference in refs/super/ it will be displayed by gitk 
currently, so it is not really hidden.
> The disadvantage, maybe, are that you must now use 'git submodule
> sync' or something like that to put any .gitmodules changes into
> effect.
> Or maybe that is an advantage.  How often will this branch tracking change?
>    
It depends on your use case. In mine it will change quite often.
> For example, I have some repos like this:
>
> super
>     +--subA
>     +--subB
>
> I wish I could do this:
>     cd super&&  checkout master
>
> to get this:
>     super   (master)
>        +--subA  (master)
>        +--subB  (master)
>
> Or, if I have SubB on super/'master' tracking 'foo', I could get this:
>     super   (master)
>        +--subA  (master)
>        +--subB  (foo)
>    
No, the branch super/master always follows the master of the 
superproject. That's why it is called super/, because it contains the 
branchnames from the supermodule's namespace. The normal "local" 
submodule branches are in refs/heads/*. The references in refs/super can 
easily be created "on the fly" by the superproject, so they are not 
really properties of the submodules. It is a little bit like a cookie 
jar ;-).
>    
>> I do want to follow the tip of the branch, if the superproject has that
>> currently checked out. If the superproject checks out a tagged version for a
>> rebuild, then the submodule should not follow the tip, but should get a
>> detached HEAD of the corresponding commit, just as the superproject. When
>> the superproject goes back to the branch, the submodule should go back to
>> its tracking branch.
>>      
> Now this makes sense.  I want the same thing.  I want to preserve
> history on "old" commits, but I want to "advance to tip" on "new"
> commits.
> The trouble, I think, is in telling the difference between "old" and
> "new".
My approach says: Just like the superproject. If it checks out an old 
commit, do that, if it checks out the branch, follow.

> So maybe I need a new command that does this:
>      git checkout master&&  git submodule foreach 'git checkout master'
>
> Maybe it's called "git checkout master --recurse-submodules".  But I
> seem to recall this is already a non-starter for some reason, and
> anyway it doesn't solve the "variant branches in some submodules"
> problem.
>    
I don't know that problem, but maybe it is because the master branch of 
the submodule is not corresponding to the master branch of the 
superproject, which is a common use case, when external modules are used 
with different release cycles.
For that reason I chose to use a different namespace in 
refs/super/master instead of that maybe existing refs/heads/master of 
the submodule.
>
> You can commit to a detached HEAD.  I do it all the time.  The trick
> is in not switching away from a detached HEAD with your local commits
> still on it.  :-)
>    
Yes. And you can't push it, it can't be fetched, etc. So it really 
shouldn't be used that way, but you can do a lot of things you shouldn't 
do in git.
>> The first answer to my question was "yes, you need to transfer the refs or
>> you get unreferenced objects" and "no, you can't transfer the refs, because
>> they are owned by the superproject, not the submodule."
>> But binding a submodule to a superproject makes perfect sense if it is _one_
>> project that is split into submodules. In that case you only have one
>> superproject for a submodule and for that purpose it would be good workflow.
>>      
> This is not useful to me, though.  Sorry.
>
>    
It is useful in huge projects.
>> It is even nice to see which commits in the submodule belong to what
>> branches in the superproject or to what release version (so tracking
>> superproject tags would make sense, too). If you have a submodule that has
>> more than one superproject but these are well-defined, it could be solved
>> using refspecs (e.g. refs/super/foo/* for one and refs/super/bar/* for the
>> other superproject), but currently I can't think of a context where this
>> makes sense.
>>      
> I can, but this does put the cart before the horse.  The submodule is
> subservient to the super project in all my setups.  The submodule is
> not aware who owns him.  He is a bit like the DAG in reverse.  He
> knows one direction only (children), not the other (parents).
>
>    
In the setup I have in mind, the submodules are not subservient to the 
superproject, but a part of the whole project.
