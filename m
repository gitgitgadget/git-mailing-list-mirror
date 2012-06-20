From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] Try harder to find a remote when on a detached HEAD or
 non-tracking branch.
Date: Tue, 19 Jun 2012 22:49:22 -0400
Message-ID: <CABURp0oF8YE2f_a-xLdzM4x5XFdoaJtKCFd-njSdv9g9N_TEzA@mail.gmail.com>
References: <1340038866-24552-1-git-send-email-marcnarc@xiplink.com>
 <7vaa004j9f.fsf@alter.siamese.dyndns.org> <4FDFA030.7080408@xiplink.com>
 <7vmx402rru.fsf@alter.siamese.dyndns.org> <4FE08797.50509@xiplink.com>
 <4FE0D5D5.3020408@web.de> <4FE0F264.1040703@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 04:49:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShAzM-0007E4-Ch
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 04:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754421Ab2FTCtn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 22:49:43 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:63302 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab2FTCtn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2012 22:49:43 -0400
Received: by obbtb18 with SMTP id tb18so10916843obb.19
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 19:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bMD2DngKzpxdSOemCIJZZ/nuNGKcN7BV7gEYt6rGhkk=;
        b=vSHGMN+DdtYZ5mP7OARNFXgh9gBU5SElNZpxGz5LMyyRWmWwjQGZnlk78iTRY7FNiZ
         hNDAPT8Jy25nO+ajxELVdb9OTEVpCvmv0cJJbbM+2uiigelaCxVI/EvmAKV4NXZM1iNG
         iqlD35o6lSIz5xssCvqkZzsotAXoznSvAMMPujSlew1TMHGHHkSsaKhaSxUW9RV1Vme+
         Q9L4sCCDh7UjfLCbrkevdcxDrU1VuPSAJKJAsOsnAuRanclKo/fkBfhvO2YZipkjWCr9
         43UUniiP0dXOWEGNg7TmWmwu09CSAi2FEvI550G4geTTfYNWESzstmIIDm1kzEp0ITha
         4WLA==
Received: by 10.60.27.134 with SMTP id t6mr21782318oeg.70.1340160582706; Tue,
 19 Jun 2012 19:49:42 -0700 (PDT)
Received: by 10.182.111.99 with HTTP; Tue, 19 Jun 2012 19:49:22 -0700 (PDT)
In-Reply-To: <4FE0F264.1040703@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200283>

I mostly want to say "Amen, brother", so if you are not interested in
a me-too, then feel free to skip this reply.

On Tue, Jun 19, 2012 at 5:43 PM, Marc Branchaud <marcnarc@xiplink.com> =
wrote:
>
> On 12-06-19 03:41 PM, Jens Lehmann wrote:
> > Am 19.06.2012 16:07, schrieb Marc Branchaud:
> >> On 12-06-18 06:12 PM, Junio C Hamano wrote:
> >>> Marc Branchaud <marcnarc@xiplink.com> writes:
> >>>> That would be bad for our situation. =A0As I said, our automated=
 build
> >>>> system
> >>>> uses detached HEADs a lot. =A0Erroring-out in this case would br=
eak us.
> >>>> =A0It's
> >>>> really only the near-ubiquity of the name "origin" that has kept
> >>>> things
> >>>> working so far.
> >
> > And the "submodule add" documentation clearly talks about relative
> > submodule URLs being relative to the superproject's origin.
>
> This whole thing seems a bit weird...
>
> So user A adds a submodule with <repository> "../others/thing.git".
> =A0Clearly
> user A has some remote in mind when they added this submodule.
>
> But consider user B, who cloned the super-repo from the same remote t=
hat
> user
> A had in mind when creating the submodule. =A0If user B then checks o=
ut a
> non-tracking branch (or a branch that tracks a different remote) and =
then
> tries to initialize/update the submodule, user B will get an error.

This specific situation is what makes me think that picking any
arbitrary remote should work in most cases.  I think this is why
picking 'origin' works just fine now, except in the special case of
"no remote named origin and no tracking branch".  If I'm using
relative urls, I've got to have my associated submodules available at
each remote I might push to or clone from.  Otherwise I'm just
shooting my feet for fun.

> To me this is clearly wrong. =A0It's also wrong to error-out and expe=
ct the
> user to fix it. =A0Should the user temporarily set their branch's rem=
ote to
> the
> right place, initialize the submodule, then undo the branch setting?
> =A0Should
> the user check our a branch that tracks the correct remote, initializ=
e the
> submodule, then check out their branch? =A0Both of those "solutions" =
look
> pretty weak to me.
>
> I'm starting to think that maybe "git submodule init" (and "update")
> should
> learn a --remote option. =A0That way at least user B could tell git w=
hat to
> do.

I like this one.

> > Your buildbot could also check if an origin is configured and use t=
he
> > magic in your patch to configure one to the URL of the first remote=
 it
> > finds if it isn't before initializing the submodules.
>
> Yes, it seems my assumptions about how to determine the default remot=
e
> shouldn't be coded into git. =A0But dang it, the current fallback to
> "origin"
> is really lame.

Amen!

I also think the assumption of "same as the current tracking branch"
is lame, too.  (But I have to admit, it works better than 95% of the
time, and it's easier than erroring out.  If it works for Apple, it
should work here.)

>
> >>> That reliance of "origin" is what made me think that "not guessin=
g
> >>> and blindly assuming" a wrong thing to do.
> >>
> >> I think git can do better than erroring out, though.
> >
> > Hmm, but guessing and using the first remote it finds (which might =
or
> > might not be the one used in the initial clone) doesn't sound like =
a
> > terribly good idea.
>
> Fair enough, but I still think it's better than guessing that the rig=
ht
> remote is "origin". =A0:)
>
> >> Sure, but I feel it did that already when it cloned. =A0It seems
> >> reasonable for
> >> the submodules to default to using the remote specified when the
> >> super-repo
> >> was cloned.
> >
> > Is there a way to reliably tell that remote without relying e.g. on
> > the implementation details of git config (e.g. it could sort remote=
s
> > alphabetically some day)? What happens if someone changes the confi=
g
> > later? A lot of ambiguity here ...
>
> Yes, I agree.
>
> Should there perhaps be some kind of "cloned from this remote" settin=
g in
> the
> config?

I'm not sure I like the "give preference to my original clone source"
idea.  Who said it could be king? What if it was temporary and I've
since moved on to a new server? Well, yeah, I can reconfigure my
default.  So I guess I do like it a little.

>
> > And I think origin should always be the second choice if it exists,
> > the first being the remote configured for the checked out branch.
>
> Do you mean "the origin(al) remote repository" or just "the remote na=
med
> 'origin'"?
>
> > This gives the user the opportunity to say "Oh, I screwed up using
> > 'git clone -o', let's set origin to the upstream repo". But should =
we
> > try to guess the remote the superproject was cloned from as third
> > option? I am not convinced.
>
> Maybe I'm misinterpreting you. =A0Are you attaching a special meaning=
 to a
> remote named "origin"?
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0M.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
