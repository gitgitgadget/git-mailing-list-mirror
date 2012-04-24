From: <dag@cray.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 24 Apr 2012 12:17:12 -0500
Message-ID: <nnghaw93v8n.fsf@transit.us.cray.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com>
	<CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:20:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMjPq-0005gZ-Dm
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 19:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756753Ab2DXRUd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Apr 2012 13:20:33 -0400
Received: from exprod6og111.obsmtp.com ([64.18.1.27]:37588 "EHLO
	exprod6og111.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755771Ab2DXRUd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2012 13:20:33 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob111.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT5bg3/fS0fkycZRTsZADNNZCbZ2TL2TQ@postini.com; Tue, 24 Apr 2012 10:20:32 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 24 Apr
 2012 12:17:16 -0500
In-Reply-To: <CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
	(Hilco Wijbenga's message of "Tue, 17 Apr 2012 14:43:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196226>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> I'm assuming that if you have subproject S in umbrella project U and =
a
> branch "topic" in U then that same branch should exist in S.=20

No, I think that is actually very rare.  If topic branches really shoul=
d
be mirrored then U and S should be one repository.  They are too closel=
y
coupled to be separated.  But see the but about git-subtree and topic
branches below.

=46or release tags, etc. I agree that this kind of mirrored tag/branch
behavior is the common case.

>> If you want the behavior you describe, a post-receive hook on the
>> component repositories is easy to implement.
>
> [1] Would such a post-receive hook be something that the user has to
> set up? Or would that be automatically set up after git clone?

The user/admin would have to set this up, at least for now.

> The main problem with the current submodule support is that there is
> so much manual work needed. It is too easy to forget a step. Moreover=
,
> it's not easy to determine *that* you forgot a step or which step you
> forgot.

I agree.  We can certainly make things more user-friendly.

>> Of course, this is entirely driven by git-subtree's model of actuall=
y
>> incorporating subproject history into one big umbrella repository.
>> There is no separation between the subprojects and umbrella projects=
=2E
>> It's one giant history. =C2=A0Therefore, push/pull to/from subprojec=
ts are
>> explicit operations. =C2=A0That's probably not the best model for ev=
ery
>> situation but I find it very nice.
>
> I do not have enough (okay, any) experience with subtree to comment o=
n
> that. The first part seems just what I want. I'm not sure about the
> explicit pushing/pulling part. That sounds too much like asking for
> the sort of problems that scared us away from submodules. Hopefully,
> I'm dead wrong. :-)

With subtrees, a topic branch in the umbrella project WILL be reflected
in the subproject because it is really one big repository.  It's a
little inconvenient to subtree push a new tag at the moment.  You have
to do a subtree split to a new branch and then push the branch to the
original component repository.  That's one thing I want to improve in
the short term.  I have found a need for then when creating release
tags.

But still, it seems odd to me that you'd create a topic branch in U and
then want to push it to a separate S repository.  Topic branches are by
nature ephemeral and I have never had a need to do something like that.
It just seems to go against the grain of what a topic branch is.  As I
said above, release tags and such are in a different category and that
is the main target of the subtree push enhancements I want to make.

>> But I don't agree
>> that we'll be able to design one model that works for everyone. =C2=A0=
svn
>> externals are just one model to aggregate projects but it is not the
>> only one. =C2=A0It just happens that no one working on Subversion bo=
thered to
>> implement anything else.
>
> :-) I think I made it pretty clear that I was listing what *I* want.
> What *I* am looking for is something that is as invisible and
> automatic as possible.

Absolutely.

> That all sounds good. As long as the hooks are automatic (I'm hopeful
> you said "no" and "yes" to [1] above). If so, then I can promise you
> I'll be taking a look at subtree. :-)

I think at the very least we can provide setup scripts in contrib.  To
be honest I haven't thought deeply enough about this to determine if
there's a way to make it more convenient.

                                      -Dave
