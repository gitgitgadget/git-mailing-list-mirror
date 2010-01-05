From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Tue, 05 Jan 2010 21:01:10 +0100
Message-ID: <4B439A86.3020500@web.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org> <4B43292C.5060106@web.de> <7vd41oz9mp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 21:01:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSFal-0005R5-4s
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 21:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab0AEUBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 15:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109Ab0AEUBS
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 15:01:18 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:33603 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268Ab0AEUBO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 15:01:14 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id B604814B4E66B;
	Tue,  5 Jan 2010 21:01:12 +0100 (CET)
Received: from [80.128.61.137] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NSFaY-0000NN-00; Tue, 05 Jan 2010 21:01:10 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vd41oz9mp.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+3zW72+VpHcT4u2OUTDN3B0N8nLKlCO+fwfz1o
	rIjG2R5AWMi9jcnaCVsYXuWZbzW5a3JHOjcd/F/2q+H3mMdZdZ
	wAenDMq9PDoAXum3pyyg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136205>

Am 05.01.2010 19:31, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>   b) new unignored files
>>      IMO these files should show up too (the superproject doesn't show
>>      ignored files, the submodule state shouldn't do that either). But
>>      OTOH i don't see a possibility for loss of data when this state is
>>      not shown.
> 
> I don't know if we are talking about the same scenario.  What I had in
> mind was:
> 
>     cd sub
>     edit new-file
>     tests ok and be happy
>     git commit
>     cd ..
>     git status
>     git commit
> 
> forgetting that only you have sub/new-file in the world.  It is not loss
> of data, but still bad.  Forgetting to add a new-file and committing in a
> project without submodule doesn't lose data, but the resulting commit will
> be seen as broken by other people.

I'm not quite sure, i was rather thinking about something like this:

    cd sub
    edit new-file
    cd ..
    <use sub/new-file here, test ok and be happy>
    git status
    git commit
    git push

git status won't show you that sub has any new files and so you won't be
reminded that you still have to add, commit and push it in the submodule
before you should even commit, let alone push in the superproject.

It is a possible breakage for other people if sub/new-file stays unnoticed.
That's IMO a good point for showing these files too.


>>   c) a detached HEAD not on any local *or* remote branch
>>      This can be fatal when doing a reset, revert or checkout, so it
>>      should be shown. Alternatively when applied on a submodule, forcing
>>      could be disabled to let the command fail instead of throwing stuff
>>      away.
> 
> Sorry, I am lost.  Are you worried about "reset/revert/checkout" in the
> superproject?  What destructive things do these operations do that you
> consider "fatal"?  I am especially puzzled by "revert", as "commit",
> "cherry-pick", and "merge" would have the same "fatal" effect as "revert",
> but I don't get what "fatality" you are talking about here.

Sorry, that was an incomplete description on my part.

My mind had already been warped into in the - hopefully not too distant -
future where these commands will be able to recurse into submodules too
(I ran into this issue recently while trying to teach git gui to revert
submodules). Right now we are blind for this state of the submodule unless
you go inside and use "git status" and friends there. And if you use e.g.
"git reset --hard" there, you can loose the commits on HEAD which aren't
on any branch.


>>   d) a detached HEAD not on any remote branch
>>      AFAICS this is only important for a push, and could just error out
>>      there.
> 
> Likewise.

This can be bad in the same way that new unignored files can be (and
there is no time travel involved this time ;-). With HEAD i meant the
submodule commit committed and about to be pushed in the supermodule
(which happens to be the HEAD of the submodule most of the time, but
not always). So you committed sub/new-file but didn't push it anywhere.
This can lead to breakage for other people even with current git. I
think push could check for this and error out, as pushing out a
referenced submodule commit which is not pushed anywhere makes no sense.

But right now i don't believe we would have to show that in the output
of git diff-files and git status, because it is only relevant at the
time when you actually want to push the superproject.


>> Yes, we can leave it that way for now (first "clone" and then "submodule
>> init <the submodules you need>"). We can migrate to the "group mapping"
>> functionality later (which would then allow to force certain submodules
>> to always be populated because they appear in every group).
> 
> Even with group mapping, you need to clone the superproject first, before
> seeing the mapping (which I would assume comes in the superproject).  And
> you need to see the mapping to decide what group you belong to.  After
> that you can finally drive sub-clone to continue (e.g. I work in the
> documentation area, and the group mapping has 'docs' that lets me pull in
> submodules for doc/ and common/ directories, without src/ submodule --- I
> can only learn that the submodules I am interested in are called 'docs' by
> group name or doc/ and common/ subdirectories _after_ I get the clone of
> the superproject).

I think we agree here.
