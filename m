From: Mike Linck <mgl@absolute-performance.com>
Subject: Re: Questions about branches in git
Date: Thu, 28 Jan 2010 14:17:26 -0700
Message-ID: <69b754db1001281317o69f8c3f9y412a8524407bacbf@mail.gmail.com>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
	 <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 22:17:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nabk8-0004v8-Cd
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 22:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176Ab0A1VR2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2010 16:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754694Ab0A1VR1
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 16:17:27 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:42448 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab0A1VR1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2010 16:17:27 -0500
Received: by pxi12 with SMTP id 12so906677pxi.33
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 13:17:26 -0800 (PST)
Received: by 10.142.62.34 with SMTP id k34mr1603381wfa.282.1264713446500; Thu, 
	28 Jan 2010 13:17:26 -0800 (PST)
In-Reply-To: <b4087cc51001281203q1f467480sdf848c9d3ced323b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138271>

On Thu, Jan 28, 2010 at 1:03 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> On Thu, Jan 28, 2010 at 12:44 PM, Mike Linck
> <mgl@absolute-performance.com> wrote:
>> ...
>> It seems that after a topic or bug branch is merged back into its
>> parent, especially if it was fast forwarded, it becomes hard to
>> determine what changes were made in it, to resolve the problem that =
it
>> was created to address.
>> ...
>> I understand that there are mechanism kind of available to address
>> this problem. =A0If we (all developers in my company) remember alway=
s to
>> rebase -i before they merge their topic branches back in, then it
>> could be squashed making it easier to identify and cherry pick onto
>> other branches...
>
> For now, you should probably rely on graphical tools like gitk in
> order to visualize the various branches. There's also `git log

Well, even gitk can't show me the information I'm looking for if the
parent branch ended up fast-forwarding to include the changes made in
the topic branch.  As far as I can tell there is *no way* to tell what
changes were made in a particular branch after a fast-forward has
taken place, which seems to make it hard to organize fixes for
specific topics/bugs/tickets.

> --graph'. You could also just keep your branches around for reference
> and use `git merge-base' as necessary.
>

Yeah, what concerns me is that there seems to be no point in keeping
your branches around "for reference" because even when you're looking
at them you can't tell what changes were made in them after they were
spawned, unless they haven't been merged into another branch yet.  So
it seems that a branch is only useful for merging once and unless the
branch was squashed in the process of mergin, good luck identifying
your change set for a particular topic.

I don't know if an uebercommit is necessary.  But it would help seem
like it would help if a branch knew about it's spawn point from its
parent, and if you could use that to get git log to only show you the
commits made to a branch after it was spawned.  And if there were
forms of operations like merge, or rebase that could act intelligently
based on that information like "merge this branch into that branch,
and by this branch I don't mean anything from this branch's parent
branch"  so that a fix that was developed on edge or master could be
safely merged into an old branch without importing every other change
on edge or master, and also the other way around.


I just looked at merge-base.  It doesn't seem to address the problem.
I grabbed an old topic branch from our repo which I knew was created
from master and at some point merged back into master via
fast-forward.  I checked it out, I called "git merge base topic-id
master", hoping that it would "output a commit which is reachable from
both A and B through the parent relationship."  Instead it seems to
have modified the topic branch by fast forwarding it to the include
all the changes up to the tip of master.  Clearly not what I'm looking
for.


Michael Linck
