From: <dag@cray.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 18:33:08 -0500
Message-ID: <nngd36w1z9n.fsf@transit.us.cray.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com>
	<CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
	<nnghaw93v8n.fsf@transit.us.cray.com>
	<CAE1pOi2KgeLPg7UVRP7dbqLFJErsKUx22Mi5aSkphy7KMJhoUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 01:33:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMpEU-00071W-RH
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 01:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521Ab2DXXdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Apr 2012 19:33:14 -0400
Received: from exprod6og103.obsmtp.com ([64.18.1.185]:52927 "EHLO
	exprod6og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756636Ab2DXXdN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 19:33:13 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob103.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT5c4NwbIuWEZx3iwDmSFlRlNADGKsR+A@postini.com; Tue, 24 Apr 2012 16:33:13 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 24 Apr
 2012 18:33:11 -0500
In-Reply-To: <CAE1pOi2KgeLPg7UVRP7dbqLFJErsKUx22Mi5aSkphy7KMJhoUQ@mail.gmail.com>
	(Hilco Wijbenga's message of "Tue, 24 Apr 2012 11:54:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196290>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

>>> I'm assuming that if you have subproject S in umbrella project U an=
d a
>>> branch "topic" in U then that same branch should exist in S.
>>
>> No, I think that is actually very rare. =C2=A0If topic branches real=
ly should
>> be mirrored then U and S should be one repository. =C2=A0They are to=
o closely
>> coupled to be separated. =C2=A0But see the but about git-subtree and=
 topic
>> branches below.
>
> Too closely coupled? I do not think breaking up a project into a set
> of libraries makes everything tightly coupled. I would argue the
> opposite. :-) Anyway, you answer my concern below.

If you need the same topic branch for each component they would indeed
seem to be very tightly coupled, even if the code is "physically"
separated.  I can't think of a situation where I would need to implemen=
t
the same or similar features in multiple components where those
components are not tightly coupled in some way.

> What would happen if you had a bunch of commits in the umbrella
> project and then did a push? Would that error out? Are there
> protections in place to prevent developers from making silly mistakes
> like that?

It would push to the remote/origin of the umbrella project, maintaining
the same "whole project" history.  It's an explicit operation to split
the commits on any subproject out and push them to the subproject's
origin.

So let's say you want to branch each subproject for release.  You could
do something like this (off the top of my head so don't copy/paste
verbatim):

branch U release_X  # Create the branch in the umbrella project
work, work, work
git subtree split S1 S1_release_X  # Split commits to S1 made on
                                   # release_X branch
git subtree split S2 S2_release_X
git subtree split S3 S3_release_X
git checkout S1_release_X          # Send commits to S1 to origin,
git push origin_S1 release_X       # creating branch release_X
git checkout S2_release_X
git push origin_S2 release_X
git checkout S3_release_X
git push origin_S3 release_X

It's the split/checkout/push sequence that I'd like to optimize and mak=
e
simpler.

                             -Dave
