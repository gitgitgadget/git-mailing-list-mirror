From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Auto update submodules after merge and reset
Date: Mon, 12 Dec 2011 23:39:31 +0100
Message-ID: <4EE682A3.8070704@web.de>
References: <4ED57EED.4040705@qualcomm.com> <4ED5E9D2.4060503@web.de> <jbnadt$hf8$1@dough.gmane.org> <4EDFE75C.5050201@web.de> <4EE07FCD.8090702@ursus.ath.cx> <CABURp0rcT2FR3uOmhyPUV5W3pu7WuJzjXktmUq0eb4nOiUwDKA@mail.gmail.com> <4EE51D7B.7020806@ursus.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, git@vger.kernel.org
To: "Andreas T.Auer" <andreas.t.auer_gtml_37453@ursus.ath.cx>
X-From: git-owner@vger.kernel.org Mon Dec 12 23:39:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaEX5-0001o5-Rp
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 23:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754406Ab1LLWjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 17:39:35 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:43050 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab1LLWjf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 17:39:35 -0500
Received: from moweb002.kundenserver.de (moweb002.kundenserver.de [172.19.20.108])
	by fmmailgate02.web.de (Postfix) with ESMTP id AED391BB3B26F
	for <git@vger.kernel.org>; Mon, 12 Dec 2011 23:39:33 +0100 (CET)
Received: from [192.168.178.25] ([80.187.110.206]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0Lvk56-1Qg8Ge2B3c-017Tds; Mon, 12 Dec 2011 23:39:33
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <4EE51D7B.7020806@ursus.ath.cx>
X-Provags-ID: V02:K0:2Q8dv1KbTDcnTVaOz1Qkg6SRZrLkXjbxOPL/nupH4ZG
 EjzEzIFRMFH7MpyjgkWdeC+FXgmLpES3Mmbq6CIa6esyKnydqk
 E/NWMfC6I7LeEHm3LVxY1mb3o5/gPMX4dU1qyHukbLb3OW5zZl
 Ni908jgO5kN9n83qnHOw4QmZKsYVvpewht9GANHsAINv7/3kaV
 Koo6Fsa+6N2MUwH81sKLA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186969>

Am 11.12.2011 22:15, schrieb Andreas T.Auer:
> 
> 
> On 10.12.2011 00:57 Phil Hord wrote:
>>  On Thu, Dec 8, 2011 at 4:13 AM,
>>  <andreas.t.auer_gtml_37453@ursus.ath.cx> wrote:
>>
>>  Yes, but maybe you can update this information in the .gitmodules
>>  file easily with a command.  Maybe it could be something simpler
>>  than "git sync-gitmodules-branches", but that is essentially what it
>>  would do: it would save the current branch in each submodule as the
>>  "tracked" branch in the .gitmodules file.
> 
> Ok, I have read a better description of the "floating submodule" model now, so it is a different use case and somehow it makes sense. In that case there are probably just a few branches that you would like to follow, maybe an "unstable" for the newest development or "stable" for the current release or some maintenance branches.
> 
>>  Now this makes sense.  I want the same thing.  I want to preserve
>>  history on "old" commits, but I want to "advance to tip" on "new"
>>  commits.
>>
>>  The trouble, I think, is in telling the difference between "old" and
>>   "new".  I think it means there is a switch, like --auto-follow (or
>>  --no-auto-follow for the alternate if core.auto_follow is set).  But
>>   having a config option as the default is likely to break lots of
>>  scripts.
> 
> In my use case the branches on the submodules follow the superproject and (mostly) versions that are committed there, it just adds the possibility to keep on working without checking out a branch after an update and without colliding with existing branchnames in the submodule.

Using superproject branch names in the submodules make no sense for a
lot of use cases.

> The other use case wants to follow the commits of that other submodule without checking the corresponding gitlinks into the superproject. But wouldn't it also make sense here to define actually a mapping in the .gitmodule that says "if the branch 'develop' is checkedout in the supermodule then with every submodule update automatically pull the newest 'unstable' commit from the submodule"? Or for "master" follow "stable" or for the "maint" branch follow updates in the "bugfixes" branch.
> 
> For example
> 
> [submodule "commonlib"]
>     update = heads develop:unstable master:stable maint:bugfixes

Having that configured with "branch=unstable", "branch=stable" etc. in
.gitmodules on the superprojects branches would be simpler and achieve
the same functionality.

> So whenever a defined branch is checked out in the superproject the mapped branch will be checked out in the submodule ("new" commit), but if a (e.g. tagged) commit is checked out ("old" commit) then the gitlink in the superproject is used to check out the referenced commit in the submodule.

I think checkout should only use the submodule commit recorded in the
superproject and a subsequent "git submodule update" should be needed
to update the submodule to tip. Otherwise you record SHA-1 but still
won't be able to bisect ...

> In http://thread.gmane.org/gmane.comp.version-control.git/183837 was discussed whether the gitlink in the superproject should be set to all-zero if updates follow the tip or maybe use the SHA1 of the commit when the submodule was added. I think the gitlink should be updated everytime when a new commit in the superproject is created.

Nope, only when "git submodule update" is run. Otherwise you'll spray the
history with submodule updates totally unrelated to the commits in the
superproject, which is rather confusing.
