From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: RFC: Making submodules "track" branches
Date: Tue, 08 Jun 2010 11:34:34 -0400
Message-ID: <4C0E630A.7020803@xiplink.com>
References: <AANLkTilBQPHgkCLJ7ppNo5TwC9Bdmqo-OMRpaDFwbQPd@mail.gmail.com> <201006080912.31448.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Jun 08 17:41:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM0vh-0005wj-WE
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 17:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab0FHPlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 11:41:25 -0400
Received: from smtp222.iad.emailsrvr.com ([207.97.245.222]:59793 "EHLO
	smtp222.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab0FHPlY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 11:41:24 -0400
X-Greylist: delayed 393 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2010 11:41:24 EDT
Received: from relay12.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay12.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id C6D0F1FF8E4;
	Tue,  8 Jun 2010 11:34:50 -0400 (EDT)
Received: by relay12.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 8B52F206EAF;
	Tue,  8 Jun 2010 11:34:45 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <201006080912.31448.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148680>

On 10-06-08 03:12 AM, Johan Herland wrote:
>=20
> There are probably more issues that escape me now...

Thanks for bringing this up!  I'm also very interested in this topic.

The main issue I see is that I don't always want my submodules to track=
 (or
not track) a branch.  What I want changes depending on the circumstance=
s.

One aspect I really like about submodules is the ease of tagging.  I ca=
n tag
the super-repo, and know that whenever I checkout that tag I'll always =
get
the corresponding versions of the submodules as they were when the tag =
was
made.  It would actually be disastrous, at least in my case, if the
submodules were at the latest HEAD of some branch instead.

This goes for almost any commit in the super-repo's history, not just t=
he
tagged ones:  Whenever I checkout a historical committish, I want to ge=
t the
submodules as they were when that commit was made.  Even if I'm working=
 at
the HEAD of some branch, often that branch is based on a historical com=
mit
and I want to use the submodules as they were when that historical comm=
it was
made.

All that said, I do think submodule branch tracking is useful.  Quite o=
ften a
development topic will change the super-repo and one or more submodules=
=2E  It
would be extremely helpful to do that work in a branch that spans the
super-repo and (a subset of) the submodules.  (In my mind this capabili=
ty is
one of the main benefits Google's "repo" tool has over submodules.)

So, back to the issue at hand: Sometimes I want static (non-tracking)
submodules, and sometimes I want dynamic (tracking) submodules.  IMO, t=
his
makes =C3=86var's proposed configuration-based approach impractical.  (=
Of course,
I'm not looking to replicate svn's externals...)

I'm not sure what the right approach is, but I have some thoughts:

 - Maybe "git branch" should be able to create submodule-spanning branc=
hes.

 - If so, then checkout, merge, pull and other branch-related commands =
should
honor submodule-spanning branches.  "checkout" in particular needs to
distinguish between when it's checking out an actual branch vs. some ot=
her
committish, and if the branch being checked out is submodule-spanning i=
t
should checkout the latest HEAD of that branch for the submodules as we=
ll.

 - It *may* be good enough to assume that matching branch names in the
super-repo and the submodules are in fact submodule-spanning branches.

 - Automating all this is tricky.  In my super-repo I almost never want=
 to
checkout the master HEAD of all my submodules.  In fact, many of my
submodules are big (e.g. they're different Linux kernels), and are only
needed when building particular things, so that checking all of them ou=
t at
once is almost always a huge waste of time.

All this is probably not the kind of feedback you were hoping for!  :)

		M.
