From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Tue, 17 Apr 2012 14:43:37 -0700
Message-ID: <CAE1pOi38krwXZuiYxtpLwm92N=NvWkP30V_=6cnHw=sdyk6QhA@mail.gmail.com>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com>
	<m3hawjagw9.fsf@localhost.localdomain>
	<nng3983phhc.fsf@transit.us.cray.com>
	<CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com>
	<201204171837.q3HIbbcW013784@no.baka.org>
	<CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com>
	<nng1unmnksx.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: dag@cray.com
X-From: git-owner@vger.kernel.org Tue Apr 17 23:45:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKGDF-0002hV-9B
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 23:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab2DQVpS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 17:45:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60659 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874Ab2DQVpR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 17:45:17 -0400
Received: by yenl12 with SMTP id l12so3396094yen.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SZArB6NcfG22Z4x76bpiXQg5exXnNabj52pmNQgE3Jk=;
        b=di1vyjBbEbb0aD8QnI5vDn60Vv7EmcEtTliLVJ5CzhR34EeTr/XJzaflamyaWbK5Sk
         GBkHBI+bCZYs87qzR+pVHbfgsq/XlTvgfB8nTgkiEA6V8i69M2srsUj5RgqfrefnBmqi
         C+GJIfuon/MPIDZYWspR2DkLbLB3H5AUE/zANxqJVwPPmGLFn1lBv9+qNJ9EiRNQYO4S
         rmjgzReDoqboYcKndH7l6RLs3daltUjNMGMSUioZFfttDDFeLAibUp3T/dKpS5BaEWnb
         8JjX2OLnv4omWKfAThlvr+H/duKsLQisre9VbQPLJruz9vAcUgB44QwLhplAtRPU1mBa
         hYPA==
Received: by 10.236.175.202 with SMTP id z50mr3293121yhl.123.1334699017340;
 Tue, 17 Apr 2012 14:43:37 -0700 (PDT)
Received: by 10.236.79.98 with HTTP; Tue, 17 Apr 2012 14:43:37 -0700 (PDT)
In-Reply-To: <nng1unmnksx.fsf@transit.us.cray.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195809>

On 17 April 2012 13:51,  <dag@cray.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>
>> If you work on a subproject (in its own repo) then a subsequent pull
>> in the umbrella project should bring this new code into the umbrella
>> project (assuming that would make sense given the branches involved)=
=2E
>
> I don't necessarily think this is always what should happen. =C2=A0I =
can't
> comment on git-submodule since I haven't used it in its more recent
> incarnation, but one thing I like about git-subtree is that it's
> explicit. =C2=A0I have to do a "git subtree pull" on the umbrella pro=
ject to
> pull in the new changes from a subproject. =C2=A0That gives me some d=
egree of
> control over when to update sources. =C2=A0I suspect one can do the s=
ame by
> using "git pull" in submodule directories.

I'm assuming that if you have subproject S in umbrella project U and a
branch "topic" in U then that same branch should exist in S. Any
changes in S's topic should show up in U's topic (probably after some
sort of update command like git fetch/pull). This should be unusual,
though, you should be working in U, not S. If you want to work on
something in S that you don't want to see in U, then you should not be
working in S's topic.

> If you want the behavior you describe, a post-receive hook on the
> component repositories is easy to implement. =C2=A0I just did that a =
couple
> of weeks ago for a subtree-aggregated repository. =C2=A0When a compon=
ent
> receives something it immediately does a "git subtree pull" on a
> workarea on the server and then does a push from that workarea to the
> subtree-aggregated repository.

[1] Would such a post-receive hook be something that the user has to
set up? Or would that be automatically set up after git clone?

The main problem with the current submodule support is that there is
so much manual work needed. It is too easy to forget a step. Moreover,
it's not easy to determine *that* you forgot a step or which step you
forgot.

> Of course, this is entirely driven by git-subtree's model of actually
> incorporating subproject history into one big umbrella repository.
> There is no separation between the subprojects and umbrella projects.
> It's one giant history. =C2=A0Therefore, push/pull to/from subproject=
s are
> explicit operations. =C2=A0That's probably not the best model for eve=
ry
> situation but I find it very nice.

I do not have enough (okay, any) experience with subtree to comment on
that. The first part seems just what I want. I'm not sure about the
explicit pushing/pulling part. That sounds too much like asking for
the sort of problems that scared us away from submodules. Hopefully,
I'm dead wrong. :-)

>> After rereading my earlier reply I felt that it might be interpreted
>> as being disparaging of submodules/subtree/gitslave.
>
> I didn't interpret it that way at all. =C2=A0I agree with you that
> subproject/superproject support could be much better.

Good. I just wanted to be extra clear because you (and others) are
working on something that is very important to me. The last thing I
want to do is discourage you. :-)

> But I don't agree
> that we'll be able to design one model that works for everyone. =C2=A0=
svn
> externals are just one model to aggregate projects but it is not the
> only one. =C2=A0It just happens that no one working on Subversion bot=
hered to
> implement anything else.

:-) I think I made it pretty clear that I was listing what *I* want.
What *I* am looking for is something that is as invisible and
automatic as possible.

(I find working with Git really quite enjoyable but it has a very
steep learning curve. E.g., I have (literally) spent hours explaining
rebase and merge to our new developers. Surprisingly, some come from
college/university without having ever used an SCM tool but even for
those that have learning Git is quite a challenge. And Git's API isn't
always particularly helpful. The "checkout" command is a perfect (bad)
example in that regard. Even those that haven't used SVN/CVS before do
not associate "checkout" with switching branches. And using git
checkout to go back to the HEAD version of a file you've changed?
Sure, it can be explained and learned but it doesn't make automatic
sense. What does switching branches have to do with undoing changes?
[Yes, it makes sense given Git's implementation but *not* from the
user's point of view.]

Given that, I really do *not* want to pile on more just to accommodate
subprojects.)

> Perhaps a good way to go would be to provide the basic operations (I
> think we have most of that) and some hooks in contrib/ or elsewere to
> implement various models. =C2=A0Just like git imposes no particular w=
orkflow
> model I don't think git should impose one particular aggregation mode=
l.
> What we do need is better documentation of what the various models an=
d
> tools are. =C2=A0For example, I would find a subtree/submodule compar=
ison
> highly valuable. =C2=A0It would help people decide which model is bes=
t for
> them.

That all sounds good. As long as the hooks are automatic (I'm hopeful
you said "no" and "yes" to [1] above). If so, then I can promise you
I'll be taking a look at subtree. :-)
