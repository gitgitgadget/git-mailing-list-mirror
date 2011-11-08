From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Tue, 8 Nov 2011 19:31:09 +0200
Message-ID: <CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
	<20111107172218.GB3621@sigill.intra.peff.net>
	<CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
	<20111107183938.GA5155@sigill.intra.peff.net>
	<CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
	<20111107210134.GA7380@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 18:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNpW0-0006x3-7E
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 18:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408Ab1KHRbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Nov 2011 12:31:11 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:33161 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab1KHRbL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2011 12:31:11 -0500
Received: by ggnb2 with SMTP id b2so788078ggn.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 09:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=E4QZ3wPK7kfBVYBDH0DriGwVNpn61x7sH3eB2hGbWIc=;
        b=byy7OVf9b5UI8+yzUFDVx5pP7aLsixpZ4u0VZWAyEW5FPxHQz8JYLVi0tTz5rlLPXT
         bI/BtSnUG9ijC4SRyPJTYKFMiRVZXk2iJRgSzCYD5Ajrc11Ws/MFajEmJAmlw/qCLrhH
         Z4eGxK9n+pS9tppS4/Ih4rpcF6GBQgeSsupeY=
Received: by 10.68.44.100 with SMTP id d4mr2164912pbm.110.1320773470246; Tue,
 08 Nov 2011 09:31:10 -0800 (PST)
Received: by 10.68.40.69 with HTTP; Tue, 8 Nov 2011 09:31:09 -0800 (PST)
In-Reply-To: <20111107210134.GA7380@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185098>

On Mon, Nov 7, 2011 at 11:01 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Nov 07, 2011 at 10:51:10PM +0200, Felipe Contreras wrote:
>
>> > What I don't understand is why it is not:
>> >
>> > =C2=A0git push --mirror <URL|remote>
>>
>> Because that pushes *everything*.
>
> Ahh, I think I see. It is doing --mirror, but only on a reduced refsp=
ec?
>
> In that case, is there a reason that:
>
> =C2=A0git push --prune <URL|remote> refs/heads/*
>
> would not do what you want (note that "--prune" does not exist, but I
> think it should).

I guess that should work.

>> > That's what I don't understand from your proposal. Your command is=
 just
>> > pushing something to the remote, right? Why isn't "push" the comma=
nd,
>> > and your sync options become options to push?
>>
>> How exactly? --sync-prune, --sync-new, --sync-all? But actually, I w=
as
>> thinking on adding an option to sync the other way around; to get al=
l
>> the remote branches and have them locally.
>
> If I understand correctly, you have three modes:
>
> =C2=A01. update remote refs with local values, prune anything remote =
that we
> =C2=A0 =C2=A0 don't have locally (--sync-prune)
>
> =C2=A02. update remote refs with local values, including pushing anyt=
hing
> =C2=A0 =C2=A0 new that we don't have locally (--sync-new)

Anything new that we don't have *remotely*.

> =C2=A03. push new and prune (i.e., 1 and 2 together)

Yeap.

> If we had "git push --prune" as above, those would be:
>
> =C2=A01. git push --prune <remote> :
>
> =C2=A0 =C2=A0 I.e., use the "matching" refspec to not push new things=
, but turn
> =C2=A0 =C2=A0 on pruning.

I guess so, but ":" seems a bit obscure.

> =C2=A02. git push <remote> refs/heads/*
>
> =C2=A0 =C2=A0 Turn off pruning, but use an explicit refspec, not just=
 "matching",
> =C2=A0 =C2=A0 which will push all local branches.

Isn't refs/heads/* the same as --all? BTW. I think --all is confusing,
should be --branches, or something.

> =C2=A03. git push --prune <remote> refs/heads/*
>
> =C2=A0 =C2=A0 Turn on both features.

Maybe 'git push' options should be reorganized (for 1.8.0):

--all -> --branches
--tags (same)
--mirror -> --all
--update =3D :
--prune (new)

In the meantime, we could add --update and --prune, which would not con=
flict.

>> Well, I usually have quite a lot of branches in my local repositorie=
s,
>> like a dozen of so. And I like to back them up in some remote
>> repository, however, not all the branches all the time. git push
>> --mirror not only pushes branches, but also tags (and I don't want
>> that), and even other refs. Does that clarifies things?
>
> That makes sense. But I think it fits in with git's current UI to do
> this via a combination of push options and refspecs. Even if we want =
to
> wrap it in some "git remote" command for convenience, I think what
> you're asking should be implemented as part of "git push".

Perhaps. I will give that a try, let's see how the code ends up.

But then, maybe similar options should be added to 'git fetch' to do
the same in the opposite direction, and that's where things get a bit
ugly:

--all -> rename to --all-remotes?
--prune -> rename to --prune-tracking?
--prune-local (new; prune local branches that don't exist on the remote=
)
--all (new; similar to 'git push --all' [--mirror])
--tags (same)
--update (new; similar to 'git push --update')
--branches (new; similar to 'git push --branches')

Somehow I fell there should be a 'sync' command somewhere to
differentiate these options from normal 'git fetch/push' commands.

Cheers.

--=20
=46elipe Contreras
