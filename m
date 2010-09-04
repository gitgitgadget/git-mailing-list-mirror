From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: Workflow question: Topic -> Next w/ frequent API changes
Date: Sun, 5 Sep 2010 09:38:53 +1000
Message-ID: <AANLkTikT6R4-HMLNebwwsF0pxP_uBTdi=+QkAL2m1EL=@mail.gmail.com>
References: <4C827535.9040907@shatow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bryan Drewery <bryan@shatow.net>
X-From: git-owner@vger.kernel.org Sun Sep 05 01:39:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os2K5-0006vm-42
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 01:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754498Ab0IDXiz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 19:38:55 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54001 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754281Ab0IDXiy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 19:38:54 -0400
Received: by qwh6 with SMTP id 6so2940589qwh.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 16:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=L8r2N4e5iQANcZR9Zg1e0TH4GNqzi372kbr12J8zR5U=;
        b=H0eEd3nBfDxlfazNXjLbJoztN8RzTHp9LfSnjOmyjZJB726nVoWk8tUbo3opp/WC0q
         zXis5OIHtt733mRVGHeusP6HMn3fCtR+CrCqCmxRsucIg97qiL1BZmVBvxPmvASuhga1
         u9QU1a3f/iA53kwpS0uiHraOqXIPpzZQvSbaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Kvus+gEF03272f76nJh2Sova/cEC8CJmKKClsgYed217J7g0sdiSDc9C0Fvgpxhyzz
         Kt3Ja3mk+l0tifCBesXrGklzNv+zS/PAMreKpnCUdg5KSm2SkXjCkEsDLLWcOq3q8Sbr
         zoVUVRiULF5dNSaRLuMlD2F9CbggW2JLYD+Fc=
Received: by 10.224.60.205 with SMTP id q13mr1311663qah.265.1283643533688;
 Sat, 04 Sep 2010 16:38:53 -0700 (PDT)
Received: by 10.229.96.7 with HTTP; Sat, 4 Sep 2010 16:38:53 -0700 (PDT)
In-Reply-To: <4C827535.9040907@shatow.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155386>

On Sun, Sep 5, 2010 at 2:35 AM, Bryan Drewery <bryan@shatow.net> wrote:
> =C2=A0Hi,
>
> I maintain a project at work using a similar workflow as git.git with=
 6
> developers; I've
> read gitworkflows(7) and several of Junio's emails regarding his
> workflow. The project
> is still maturing so we have frequent API/DB changes and do not maint=
ain
> backwards
> compatibility very well.
>
> Developers base their topics off of Next, due to the frequent API/DB
> changes not in Master, and
> are able to merge their topic branches into Next themselves once
> completed. They rebase
> their topic on top of Next at this point. They can't necessarily reba=
se
> on Master here because
> they may hit conflicts due to code not existing in Master yet.
>

Basing on next is fine, provided you never rebuild next. But if you
never rebuild next, then
it isn't really acting like a next branch - it really is master.If you
do rebuild next occasionally,
then you are asking for trouble because changes you thought were
reverted out of
next will flow back via branches that were forked from the earlier
version of next (unless you are rigourous about
which changes you accept into next)

If you can do team-wide daily or twice daily builds, tag those, and
ask your developers
to base all their work on those tags. Tags are inherently stable and
well specified. A branch
is inherently unstable and ill-specified [ When you say you based on
next, what commit do you mean exactly? Next on which machine? Next at
what time? What is the pull history of that machine and the machine it
pulled from? ].

> This is my first problem, once the branch is ready to merge into Mast=
er,
> I have to rebase
> it on top of Master, then merge in, merge Master down into Next;
> polluting the history in
> Next with duplicated commits.
>

The first problem is the rebase onto master. If you are doing this,
you are guaranteeing a world of pain. You should be merging into
master. If a topic's base is a previous tag from master plus a
selected number of other fixes, then merging such topics into master
should be a no-brainer. Of course, if people are basing their work on
something unstable like next, then their work will contain all measure
of untested nastiness and a merge into master won't be practical. This
is another reason to encourage developers to base their work on a
well-known, stable tag, and not the bleeding tip of some integration
branch like next.

Rule of thumb: never rebase anything that has been shared with anyone
else. If you are merging a change into next and then
rebasing it onto master, you are breaking this rule. Rebasing is great
and I do it often, but I keep such things to myself.

> The other problem is that once their topic has been merged into Next,
> and before it has
> been merged into Master, it may be found that another commit is neede=
d
> on their topic
> to fix an issue. Due to frequent API/DB changes, they might 'git pull
> Next' into their topic
> branch, so they can properly test the new fix. Obviously this makes
> things difficult once
> the topic is ready for Master, and I have to manually cherry-pick the=
ir
> commits into a
> new branch to get rid of the 100s of Next commits they merged in.
>
> What's the best solution for handling this? Should we just be resetti=
ng
> Next after releases
> to remove the pollution?

If the topic is based on a well known tag, the topic does not contain
merges from anything other than
the well known tag and a handful of other topics, then the answer is
to simply update the topic with the fix
and then remerge the topic into master (and into next and into any
other dependent work).

>
> I'm thinking that we need to incorporate subsystem maintaining/branch=
ing
> as well, and
> group up like subsystem changes into the same releases. Though we sti=
ll
> run into problems
> where every file in the system needs updating for new API. Perhaps ou=
r
> workflow is just completely
> wrong?
>
> Any input would be appreciated.
>

I also wrote a post a little while back about maintaining a private
working branch:

   http://permalink.gmane.org/gmane.comp.version-control.git/153168

The idea is that each developer maintains a base branch, all
dependencies are merged into that base branch
and all their work is performed ontop of that base. As the work is
stabilised, it is rebased onto topic branches based
on well known tags and these topics are then published. The basic
ideas is always merge into the _base_ of the working branch
, never merge into the _tip_  and never publish the tip of the working =
branch.

jon.
