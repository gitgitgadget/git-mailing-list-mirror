From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [RFC/PATCH 5/6] revert: add --ff option to allow fast forward when cherry-picking
Date: Tue, 2 Feb 2010 06:13:47 +0100
Message-ID: <201002020613.48067.chriscool@tuxfamily.org>
References: <20100201074835.3929.11509.chriscool@tuxfamily.org> <c07716ae1002010443p4e0443feke14e5f877584640f@mail.gmail.com> <4B66E53D.8050204@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 06:14:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcB5e-0000lZ-Dh
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 06:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810Ab0BBFKp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Feb 2010 00:10:45 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:59430 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757Ab0BBFKo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Feb 2010 00:10:44 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 14AEC818036;
	Tue,  2 Feb 2010 06:10:35 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8F78B818052;
	Tue,  2 Feb 2010 06:10:32 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <4B66E53D.8050204@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138677>

On lundi 01 f=E9vrier 2010, Paolo Bonzini wrote:
> On 02/01/2010 01:43 PM, Christian Couder wrote:
> > Maybe it could be the default, but in this case it should be made
> > compatible with -n option (and perhaps other options) for backward
> > compatibility, and this would probably need more involved changes.
>
> A better objection is that GIT_COMMITTER_* is respected by |git
> cherry-pick" but not by "git cherry-pick --ff",=20

Yes, indeed! Good catch!

> and that even without=20
> setting the variables, "git cherry-pick" will pick a new commit date =
but
> "git cherry-pick --ff" wouldn't.  The latter, I think is the only
> difference that is worth pondering further.

Because --no-ff could be used when the GIT_COMMITTER_* and GIT_AUTHOR_*=
 env=20
variable should be respected? Or because we should check if one of thes=
e=20
env variable is set and, if that is the case, we should not fast forwar=
d?

As I think it would be a big backward incompatibility to force people t=
o=20
update their scripts to add --no-ff, I think you probably suggest the=20
latter. This mean that we could have both --ff and --no-ff. --ff could=20
force fast forward even if some of the above env variables are set. --n=
o-ff=20
would disable fast forward even if none of the above env variable is se=
t.

> My impression is that a user would never have any problem with
> fast-forwarding.  For scripts probably the same is true (the typical
> scenario for scripts is probably very similar to what "git rebase -i"
> does), but it can still be a potential backwards-incompatibility in c=
ase
> the script is *expecting* cherry-picking to generate a new SHA1.  How
> broken can we consider this expectation?

I am not too worried by this expectation, but I think that, as it looks=
 like=20
we will need --ff anyway, it is safer to start by implementing --ff lik=
e I=20
did and then later we can implement --no-ff and change the default (whe=
n=20
neither --ff nor --no-ff is used) to look at env variables (or config=20
variables) to decide if we will fast forward or not.

> That said, to reply to your question, of course -n would disable it, =
and
> so would -x, -s and possibly -e.  But then, the same applies to --ff:
> your patch forbids "-n --ff", but -x, -s and -e would need the same
> treatment.

Yeah, I will add the same treatment for these options.

> Note that "-e --ff" would error out; however if --ff would be the
> default, "-e" would probably choose between fast-forward and
> non-fast-forward depending on whether the commit message was edited.

Yeah, but let's change the default later please.

Thanks,
Christian.
