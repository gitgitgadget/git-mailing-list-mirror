From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intricacies of submodules
Date: Thu, 10 Apr 2008 22:20:00 -0700
Message-ID: <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
References: <47F15094.5050808@et.gatech.edu> <47FBB448.3060900@et.gatech.edu>
 <32541b130804081306q6e06af20u794357eba9d434e@mail.gmail.com>
 <47FBDA77.2050402@et.gatech.edu>
 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
 <1207859579.13123.306.camel@work.sfbay.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, stuart.freeman@et.gatech.edu,
	git@vger.kernel.org
To: Roman Shaposhnik <rvs@sun.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 07:21:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkBhA-0003Mo-7t
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 07:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbYDKFUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 01:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbYDKFUS
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 01:20:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbYDKFUR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 01:20:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 37B6A263F;
	Fri, 11 Apr 2008 01:20:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id DB9ED263D; Fri, 11 Apr 2008 01:20:06 -0400 (EDT)
In-Reply-To: <1207859579.13123.306.camel@work.sfbay.sun.com> (Roman
 Shaposhnik's message of "Thu, 10 Apr 2008 13:32:58 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79263>

Roman Shaposhnik <rvs@sun.com> writes:

> ... I'm very interested in getting this functionality
> right with git-submodule. And I can be either your guinea pig or
> a frenetic hamster. After all, you don't mind complete newcomers
> to the development process sending you code, do you? ;-)

Everybody starts out as a total stranger.  Linus has never worked with me
when I started, and many people who are the core members of git community
have never worked with me before either.

>> However, the way others will obtain a copy of the submodule repository
>> will be quite different from the way you access it (you already have it,
>> so you do not need to clone it from elsewhere to initialize it).  It may
>> not make much sense to record the URL that you tell others to use in your
>> own .git/config in the repository of the originator of such a superproject
>> vs submodule combination.  So in that sense, I am not sure if not mucking
>> with .git/config is even a bad thing.
>
> It is all about consistency as far as I see it. One huge advantage of
> Git is that it is a DSCM. It makes things totally symmetric. The
> paragraph that I quoted above hints at a possibility of treating the
> initial repo somewhat differently from its copies. That would break
> a nice symmetry. And it would do that unnecessarily.

I do not think being distributed is about such symmetry.

Being distributed is more about each repository being able to serve its
own purpose, being able to get configured suitably and individually,
without disturbing others, and allowing a workflow around it that
_potentially_ treats everybody as equals.

Not having the kind of symmetry you talk about is not anything new about
submodules, nor is it necessarily a bad thing.  You create a history here,
you push it into there.  Somebody else clones your history from there and
starts hacking.

The way that somebody's clone interacts with the intermediary and the way
your original repository interacts with the intermediary _are_ different,
and they ought to stay different if that intermediary is _your_ owned
publishing repository.  You can push into it, but that somebody else
should not be able to.  There should be no symmetry about that repository.

That somebody else may have his own publishing repository where he pushes
the result of his work into and you fetch from.  Taken together, each of
you and that somebody else having his own repository to allow others to
fetch from, makes you two the equals in the global picture.

You would only need the symmetry of your kind if there is a single
intermediary that is _the central location_, a shared repository where
everybody meets.  Only in that case, you _may_, after priming the process
by initially creating the superproject - submodule combination in the
originating repository and pushing it to the shared repository, want to
clone it back to a new work tree you will use as your usual working place
(and nuke the originating one, which is not needed anymore as the process
has been primed now).  At that point, your usual working place and
everybody else's working place would look symmetrical, as everybody
including you cloned from a single shared location.

I am not saying that is necessarily a bad thing to wish for.  I am only
saying that the kind of symmetry you talk about does not have much to do
with being distributed.  If anything, that symmetry is more closely tied
to using a centralized work flow, not distributed.

>> After working with the project for a while (i.e. you pull and perhaps push
>> back or send patches upstream), .gitmodules file changes and it now says
>> the repository resides at host B.xz because the project relocated.  You
>> would want the next "git submodule update" to notice that your .git/config
>> records a URL you derived from git://A.xz/project.git/, and that you have
>> not seen this new URL git://B.xz/project.git/, and give you a chance to
>> make adjustments if needed.
>
> I guess something like that could be implemented via Git hooks, right?

I do not see a reason to bring in hooks here.  To answer "Yes" to your
"right?" question, "git submodule update" ought to call out to a hook in
such a situation, which it doesn't right now.  So the answer for the
current implementation would be "no".  To make it "Yes", the command needs
to be modified to call out a hook, but should it be implemented as a hook,
when it is already so clearly specified what needs to happen?

>> Considered, yes, implemented, no.  Not because nobody bothered to, but
>> because it is unclear if it is a good thing to do in general to begin
>> with.  What's recorded in .git/config is pretty much personal (e.g. "who
>> you are known as to this project?", "what's the SMTP host, user and
>> password when sending out patches from here?", "do you want to use color
>> in diff?"), dependent on local needs (e.g. "what protocol a particular
>> remote repository should be reached via"), or what the repository (as
>> opposed to "project") is about (e.g. "is this a bare, shared distribution
>> point, or is this a developer repository with a work tree?").
>
> Some of it is personal, yes. But sometimes those personal preferences
> need to be enforced on a project level (of course, giving everybody
> a way to override the setting if they really want to). For a big
> software organization with a mix of senior and junior engineers I need
> a way to set up *my* workspace in such a way that everybody who
> clones/pulls from it get not only the source code, but also "Git best
> practices". That would simplify things a great deal for me, because
> I can always say: "just pull my latest .gitconfig, make sure you
> don't have any extra stuff in your .git/confing and everything 
> in Git will work for you".

I think the way you stated the above speaks for itself.  The issue you are
solving is mostly human (social), and solution is majorly instruction with
slight help from mechanism.  The instruction "Use this latest thing, do
not have anything in .git/config" can be substituted with "Use this latest
update-git-config.sh which mucks with your .git/config to conform to our
project standard", without losing simplicity and with much enhanced
robustness, as you can now enforce that the users do not have anything
that would interfere with and countermand your policy you would want to
implement.
