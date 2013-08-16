From: =?UTF-8?B?U2HFoWEgVG9tacSH?= <tomic80@gmail.com>
Subject: Re: git undo # last command
Date: Fri, 16 Aug 2013 16:21:59 +0200
Message-ID: <CAAUyY9DqCrpMJPKKmzLGWVkoJRPfA5URLQz0uyTLZCPe6QKe5w@mail.gmail.com>
References: <CAAUyY9ADW2iHVWhTGcTF8j0hrdumpBcLv_mLo0y8VDAyBpftJQ@mail.gmail.com>
 <20130816132612.GF20138@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 16 16:22:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAKvK-0004Bu-Da
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 16:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab3HPOWW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 10:22:22 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:64753 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab3HPOWW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Aug 2013 10:22:22 -0400
Received: by mail-qe0-f50.google.com with SMTP id q19so1212476qeb.37
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=21THWKLHztMtyntTc/rXMBEzgfKrc1ftClFNVlb0NIo=;
        b=Vlp64/M/vQQ093d3sSA0CpaV/bo9kklNiR5Ok3/Kd/66Wi0738s7uPJ3fh5J6qvW4z
         z2yUwGF2wJKDMNIVW06rjHiFAbfR6kkR0DA/Wr2t/98exHCkOC1jLrEwGBQIHSto3dP1
         ubdDFFbGBVAgoK3cOQ1jfTvZAR7G0DWZYUcIHvbsjgqhMaNSWbCrP1FhZ87x1kl59vgW
         c0AV8A9wNadCUMTpTw65TRBDk6lm/P/YhPgoG+nwt2tSsq57GZloyFaR+2YJ/x6uAapg
         4sO84J2hlfSmDhEFe4JgIXnYAlHv/F0zcdY/AawhnjJlRVqbXHQsnDv8cLUo4RUex4mu
         uvYw==
X-Received: by 10.224.76.71 with SMTP id b7mr3717700qak.48.1376662939338; Fri,
 16 Aug 2013 07:22:19 -0700 (PDT)
Received: by 10.49.29.134 with HTTP; Fri, 16 Aug 2013 07:21:59 -0700 (PDT)
In-Reply-To: <20130816132612.GF20138@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232431>

On Fri, Aug 16, 2013 at 3:26 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 16, 2013 at 10:55:06AM +0200, Sa=C5=A1a Tomi=C4=87 wrote:
>
>> it just occurred to me -- the command that I would REALLY like to ha=
ve
>> is simple:
>>
>>   git undo
>>
>> which 'undo'es the last action that has not been pushed yet --
>> whichever the action is. Similarly to the 'back' button in the
>> browser.
>
> One problem with such simplicity is that you need to define what an
> "action" is. If I make a commit, the undo is probably "reset HEAD@{1}=
".
> If I fetch a ref, would undo move backwards? What if I fetch multiple
> refs with one command; do we undo all of them? How about during a
> multiple-command operation, like a rebase? Does an undo affect the la=
st
> commit, or the whole rebase?
>
> I think these questions can be answered (though I am not sure of the
> best answer for most of them, nor even if there is a single answer th=
at
> covers all situations), but I think a starting point for any "undo"
> command would be coming up with a list of what constitutes an action,
> how we record the list of actions, and then an appropriate "undo"
> reaction for each action.
>
> -Peff


Simplicity rarely comes for free. But simplicity may not mean the same
to a new git user, and to an experienced git user or developer.

The beauty of "undo" operation/action is that there is only one
command to be learned. Whatever you do, you can "undo".
git commit =3D=3D> git reset --soft HEAD^
git add <file> =3D=3D> git reset HEAD <file>
git add <directory> =3D=3D> git rm -r --cached <directory>

However, the command that you have to do may not be easy to find in
documentation or online.

A simple workaround, that I several times employed, is to make a
backup of the repo, and to play with the repo after that. If anything
goes wrong, I restore the backup.

But git should not force me to do this. Git clearly can do more and bet=
ter.

Anyway, I believe that "undo" should revert the *last* command typed
in and executed by the user, even if it's a multi-step operation such
as rebase. Of course, it would be of great help even if a user has to
run "git undo" several times for one "git rebase". You're certainly
more experienced with git under the hood, so you know which one is
easier to implement.

I would be happy to help in making a list of actions and corresponding
undo "reactions".

-- st
