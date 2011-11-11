From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Fri, 11 Nov 2011 14:30:48 +0200
Message-ID: <CAMP44s2RjcFtdO2jft0Hg9RtqK-DRK47gX8By-dBFSBcSA+yFA@mail.gmail.com>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
	<20111107172218.GB3621@sigill.intra.peff.net>
	<CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
	<20111107183938.GA5155@sigill.intra.peff.net>
	<CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
	<20111107210134.GA7380@sigill.intra.peff.net>
	<CAMP44s089xbEo4VT8rqgS=BJMUu=qsb8Hm5z8bTR2akU8-5QhA@mail.gmail.com>
	<20111108181442.GA17317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 11 13:30:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROqFz-00055f-8s
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 13:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756499Ab1KKMau convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Nov 2011 07:30:50 -0500
Received: from mail-pz0-f42.google.com ([209.85.210.42]:64950 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab1KKMat convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2011 07:30:49 -0500
Received: by pzk36 with SMTP id 36so4211757pzk.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 04:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=pPlxv42C5giekof36sxJkrhcf4waAY36lwg5BDy/sfc=;
        b=RPsAwG52duvqavkR//Q7Y/2awW8sDpK3rJOfXObtJdR/RCf5upzefiDqHufxECT/qw
         GxSec9ETE+HLwIFRrX34kGxCfyxKtTXo9Faa/9MgGMGivNUKqNY6K5+NieAZRSkHzjDT
         cqKLnG1ohA7H8btI+AvU2b9Q3W4e5cqnmBLpU=
Received: by 10.68.38.8 with SMTP id c8mr23759510pbk.42.1321014648664; Fri, 11
 Nov 2011 04:30:48 -0800 (PST)
Received: by 10.68.58.38 with HTTP; Fri, 11 Nov 2011 04:30:48 -0800 (PST)
In-Reply-To: <20111108181442.GA17317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185264>

On Tue, Nov 8, 2011 at 8:14 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 08, 2011 at 07:31:09PM +0200, Felipe Contreras wrote:
>
>> > =C2=A01. git push --prune <remote> :
>> >
>> > =C2=A0 =C2=A0 I.e., use the "matching" refspec to not push new thi=
ngs, but turn
>> > =C2=A0 =C2=A0 on pruning.
>>
>> I guess so, but ":" seems a bit obscure.
>
> Yeah, it is. It's also the default, so you could just do:
>
> =C2=A0git push --prune <remote>

That would work only if not configured otherwise; remote.<foo>.push,
push.default

> Although some people have argued for changing the default in future
> versions. I don't know what the status of that is.

IMO the default doesn't matter, it should be easy for everyone.

>> > =C2=A02. git push <remote> refs/heads/*
>> >
>> > =C2=A0 =C2=A0 Turn off pruning, but use an explicit refspec, not j=
ust "matching",
>> > =C2=A0 =C2=A0 which will push all local branches.
>>
>> Isn't refs/heads/* the same as --all? BTW. I think --all is confusin=
g,
>> should be --branches, or something.
>
> Doesn't --all mean all refs, including tags and branches?

Nope, only branches, try it. I also found it strange. And what is
more, you can't use --all and --tags at the same time. Totally
strange.

Also, --all doesn't push other refs (say refs/foobar/test)

I think this area has been neglected.

> I thought that was the thing you were avoiding.

--all + --tags is not the same as --mirror (refs/foobar/* is pushed
only by --mirror).

And yes, in this particular use-case that's what I am trying to avoid,
but in other use-cases (like creating a new repo and pushing
*everything*), a *true* --all would be nice.

> We could add syntactic sugar to make
> --branches mean "refs/heads/*". But I do worry that pseudo-options li=
ke
> that just end up creating more confusion (I seem to recall there bein=
g a
> lot of confusion about "--tags", which is more or less the same thing=
).

But it's not, that could explain part of the confusion. I think these
would be totally intuitive.

 --branches
 --tags
 --other
 --all
 --update
 --prune

But what about 'git fetch'? You didn't comment anything. I think we
should try to be consistent in these imaginary future options, maybe
to devise a transition, or at least to identify good names for the new
options.

Cheers.

--=20
=46elipe Contreras
