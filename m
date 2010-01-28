From: Mike Linck <mgl@absolute-performance.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 15:56:30 -0700
Message-ID: <69b754db1001281456k7c275550r5ffde67b254b510e@mail.gmail.com>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
	 <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
	 <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com>
	 <b4087cc51001281418m3f19d765rd9aab03a339f15a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu Jan 28 23:56:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NadHy-00016O-6N
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 23:56:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230Ab0A1W4f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 17:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755212Ab0A1W4d
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 17:56:33 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:56571 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab0A1W4b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 17:56:31 -0500
Received: by pwi21 with SMTP id 21so857891pwi.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 14:56:31 -0800 (PST)
Received: by 10.142.3.40 with SMTP id 40mr1701379wfc.74.1264719390793; Thu, 28 
	Jan 2010 14:56:30 -0800 (PST)
In-Reply-To: <b4087cc51001281418m3f19d765rd9aab03a339f15a4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138281>

On Thu, Jan 28, 2010 at 3:18 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> On Thu, Jan 28, 2010 at 3:17 PM, Mike Linck
> <mgl@absolute-performance.com> wrote:
>> On Thu, Jan 28, 2010 at 1:03 PM, Michael Witten <mfwitten@gmail.com>=
 wrote:
>>> On Thu, Jan 28, 2010 at 12:44 PM, Mike Linck
>>> <mgl@absolute-performance.com> wrote:
>>>> ...
>>>> It seems that after a topic or bug branch is merged back into its
>>>> parent, especially if it was fast forwarded, it becomes hard to
>>>> determine what changes were made in it, to resolve the problem tha=
t it
>>>> was created to address.
>>>> ...
>>>> I understand that there are mechanism kind of available to address
>>>> this problem. =A0If we (all developers in my company) remember alw=
ays to
>>>> rebase -i before they merge their topic branches back in, then it
>>>> could be squashed making it easier to identify and cherry pick ont=
o
>>>> other branches...
>>>
>>> For now, you should probably rely on graphical tools like gitk in
>>> order to visualize the various branches. There's also `git log
>>
>> Well, even gitk can't show me the information I'm looking for if the
>> parent branch ended up fast-forwarding to include the changes made i=
n
>> the topic branch....
>
> As Jens Lehmann pointed out, use something like:
>
> =A0 =A0git checkout master
> =A0 =A0git pull --no-ff . topic
>
>>> --graph'. You could also just keep your branches around for referen=
ce
>>> and use `git merge-base' as necessary.
>>>
>> ...
>> it seems that a branch is only useful for merging once and unless th=
e
>> branch was squashed in the process of mergin, good luck identifying
>> your change set for a particular topic.
>> ...
>
> I would think that you'd only care about the contiguous commits
> between merges anyway.
>
>> I just looked at merge-base. =A0It doesn't seem to address the probl=
em.
>> I grabbed an old topic branch from our repo which I knew was created
>> from master and at some point merged back into master via
>> fast-forward. =A0I checked it out, I called "git merge base topic-id
>> master", hoping that it would "output a commit which is reachable fr=
om
>> both A and B through the parent relationship." =A0Instead it seems t=
o
>> have modified the topic branch by fast forwarding it to the include
>> all the changes up to the tip of master. =A0Clearly not what I'm loo=
king
>> for.
>
> You incorrectly used `git merge' rather than `git merge-base'.
>
> This is kind of off the top of my head. Try something like this:
>
> =A0 =A0merged_commit_0=3D$(git merge-base master topic-id)
> =A0 =A0merged_commit_1=3D$(git merge-base master ${merged_commit_0}^)
>
> I think that should give you the range of commits between the last 2
> merges (for at least simple cases). Then:
>
> =A0 =A0git log $merged_commit_1^..$merged_commit_0
>
> or
>
> =A0 =A0gitk $merged_commit_1..$merged_commit_0
>
> to see them.
>
> You could, I suppose, keep looping until you find the oldest
> merge-base that is still in the topic-id branch. To do so, the
> following information may be of use:
>
> =A0 =A0http://marc.info/?l=3Dgit&m=3D126457707700573&w=3D2
>
> Anyway, it's probably best to use Nicolas Pitre's suggestion to use
> tags to mark commits yourself, but the above might be useful if you
> haven't.
>

Well, I'll be using tags more in the future and I'll look through some
more documentation about recommended workflows and see if I can work
out something that will do what we need to do.

Your example will work on non-FF branches if you make the second
merge-base use master~1 (else it just gives you the same commit sha
twice)

The tough thing to identify is the change sets that got fast-forwarded
in though.  I guess I'll just go ahead and erase those branches since
they won't do any of us any good anyway and I'll read up on the work
flow, and try to avoid having the same mistakes recur.

thanks again,

mike
