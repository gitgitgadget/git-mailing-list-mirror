From: jean-luc malet <jeanluc.malet@gmail.com>
Subject: Re: git svn : some feedback and wonder...
Date: Tue, 12 May 2009 13:52:13 +0200
Message-ID: <1de9d39c0905120452n167a8de2w378f39140946559d@mail.gmail.com>
References: <1de9d39c0905110852v65b07bebl47cc9a58046c5288@mail.gmail.com>
	 <4A08560F.8030800@drmicha.warpmail.net> <4A08A294.1060100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 12 13:52:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3qX3-0000Ax-GG
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 13:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759021AbZELLwP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 07:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758229AbZELLwP
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 07:52:15 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:51063 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419AbZELLwN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 07:52:13 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2002613ywb.1
        for <git@vger.kernel.org>; Tue, 12 May 2009 04:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OhDzmGa+0eyzA3tckE6LegPRyHTSW4vms051QzpKE5I=;
        b=jhj8quusj+88/dhx71SJfRekgVA6AS0hNcTpAOoD5EWPHiboeAQigBKG84mzav9Euq
         7UmtAY/spEqd6ML1064ezn2tc3esBE+G/0blfuxSaNHTDlGcJXF/BPK9yHSQY+0lVjGQ
         gBe3D30GKkg1Qv8tG2yzULpGan16Kwww9OOCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OCBwH2Dggn3pFSLMOKvM6Cc8RbC8DxsoJjM9sc9w9Vg7nf3P2wVH5QNXD2U2t50eWS
         m7dDEvPzsgxUoA4TFKa/VCbeRMWacaRR1jJpvbVFvz2WCsG3ul5coXG/D3F10w42uL7o
         2i/RTxpmYUohCgr8yIfNDy00MF161YpC7Udhw=
Received: by 10.90.86.9 with SMTP id j9mr6817465agb.28.1242129133982; Tue, 12 
	May 2009 04:52:13 -0700 (PDT)
In-Reply-To: <4A08A294.1060100@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118890>

ok now I get it... I understand what is happening

here is what I perform :
$git svn clone http://myurl/git-svn-test --prefix=3Dsvn/ -s
$git svn branch againnewtest

1) at the end of clone step the local tree is in the same state than
the last revision of svn repository
2) git's master branch isn't linked to the trunk (thus if you do a git
svn dcommit at this step after adding / modifying local files the
result is unexpected)
3) the git svn branch againnewtest perform a branch on the lastest
revision of svn repository (in my case a work on a branch) and not a
branch on the trunk

what I would have expected :
either the master branch created to track svn/trunk, or the master
branch to contain no file at all (thus obliging the user to create a
local traking branch on trunk) but not the current state that is
confusing (the user do an ls and see that there are file, do a git
branch and see that he is on master, then think that he's working on
the trunk, and that when do the git svn branch newbranch he think it
will branch the trunk, but in fact he branch the lastest revision
which can be anything according to the time the clone was performed
and the user commits)

best regards
JLM


On Tue, May 12, 2009 at 12:11 AM, MALET Jean-Luc
<jeanluc.malet@gmail.com> wrote:
> Michael J Gruber wrote:
>>
>> jean-luc malet venit, vidit, dixit 11.05.2009 17:52:
>>
>>>
>>> hi
>>> I'm just toying with git svn....
>>> so I have an svn repository and I do a git svn clone -s
>>> http://path.to/my/repository
>>> here all is fine it checkout my trunk into master branch
>>>
>>> 1) when I do a git branch -a, it show 2 branches : master and trunk=
,
>>> shouldn't it be master and svn/trunk?
>>>
>>
>> No. Not unless you said --prefix=3Dsvn during clone.
>>
>>
>>>
>>> 2) when I create a branch using git svn branch it create an empty
>>> directory and not as expected a branch from the current revision of
>>> trunk
>>>
>>
>> I get a branch as you expect. Can you repeat the commands which
>> generated an unexpected result for you?
>>
>>
>>>
>>> 3) the branch appears in git branch -a without a remote
>>> information.... not easy to track
>>>
>>
>> See 1)
>>
>>
>>>
>>> 4) you can't do git branch --track newbranch (where new branch is t=
he
>>> svn branch), since the branch name isn't prefixed by svn/ you can't
>>> reuse the same name
>>>
>>
>> You certainly can create a local branch with the same name. I just d=
id.
>> I always do. If b is that name, say
>>
>> git branch --track b remotes/b
>>
>> unless you have used --prefix, of course.
>>
>>
>>>
>>> 5) why having called dcommit instead of push? it would have been mo=
re
>>> understable (more coherent) git svn push would have pushed current
>>> branch on corresponding svn branch and git svn push somebranch woul=
d
>>> have do a git svn branch followed by the commits...
>>>
>>
>> The latter would be inconsistent with git push as well.
>>
>> Dcommit may be for historical reasons, but keep in mind that dcommit=
 is
>> not simply pushing. It involves rebasing and a whole git-svn-git
>> roundtrip. It really is "do the commits" on the svn side.
>>
>>
>>>
>>> 6) why having called rebase instead of pull? git svn pull would hav=
e
>>> fetched svn/trackedbranch and merged into current branch, git svn p=
ull
>>> somebranch would have merged into current branch the svn/somebranch
>>> (without traking info)
>>>
>>
>> Because pull does not rebase by default, it uses merge!
>>
>> Let me just add that with some more git experience, which includes
>> reading man pages and trying things out, there certainly will be mor=
e
>> insight into the why's and why not's of git-svn ;)
>>
>> Cheers,
>> Michael
>>
>
> hi,
> can't do it from here, will retry tomorrow
> I'll try 1) =C2=A02) and 3) again tomorrow, however why --prefix=3Dsv=
n isn't the
> default? that's odd behaviour and not really consitent with other rem=
ote
> operation I find
> for 4) I think that push works more like dcommit, the underlying proc=
ess
> isn't the same because svn and git don't share the same tree, but if =
we look
> at the result we have the same : all commit made on host are visible =
on
> repository, git do it by transfering the content because all blob/tre=
e are
> sha1 name and then can't conflict, on svn we can't because there are =
no
> uniqueness so you have to replay the commits one by ones... git just
> optimize the process because of the nature of the filetree...
> for rebase.... well I know that some people prefer it to merge, as we=
ll as
> some people prefer that a merge to be fast forward... I prefer to kee=
p the
> branch information... it's hard to restart a dev from a branch that i=
sn't
> visible anymore... fast forward merge and rebase sadely do lose those=
 branch
> information... however I agree that in case of svn a rebase looks mor=
e like
> an svn update...
> and yes, sorry I forgot that the opposite of push is... fetch ;) so y=
es it's
> more clear now in my mind....
> thanks
> JLM
>
>



--=20
KISS! (Keep It Simple, Stupid!)
(garde le simple, imb=C3=A9cile!)
"mais qu'est-ce que tu m'as pondu comme usine =C3=A0 gaz? fait des chos=
es
simples et qui marchent, esp=C3=A8ce d'imb=C3=A9cile!"
-----------------------------
"Si vous pensez que vous =C3=AAtes trop petit pour changer quoique ce s=
oit,
essayez donc de dormir avec un moustique dans votre chambre." Betty
Reese
http://www.grainesdechangement.com/citations.htm
