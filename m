From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Mon, 23 Jan 2012 21:35:07 +0700
Message-ID: <CACsJy8AB-6b_PMvyM7hRV3b=5o0Cn4CtosygUQOevTzVJhU=hg@mail.gmail.com>
References: <20110607200659.GA6177@sigill.intra.peff.net> <CACsJy8BCGi3s8gXr4kk-u8tDWztV6ozg1Tap23Q=TxA5d9iL+g@mail.gmail.com>
 <CADo4Y9iH+J-X-TdqTN2Y9KhQnprnCVvC4Xy6qhVHwsBRmsZUrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Mon Jan 23 15:35:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpKzp-00043x-92
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 15:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954Ab2AWOfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Jan 2012 09:35:40 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43672 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317Ab2AWOfj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2012 09:35:39 -0500
Received: by bkas6 with SMTP id s6so2482760bka.19
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 06:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=b2MuawkHJXTB/rS9pe/sJ3/wBlx8+i33KkBDy5f35yI=;
        b=ng6JqAqqamKWVtL8Jo5zat0Obbu4VrHvNB/PtaiTQOrF0+KweGADLHHgmCNPHlh8Hi
         pR81l9yB9GY6o6+zcEDkc7m83hsT5JSRBYjE4fc1N1rlIYF2DuL7bseDUND2UwtCS4kG
         lE0g6wm9XqEYO1ytMw23ABFm3LtFAsgCFNARk=
Received: by 10.204.129.71 with SMTP id n7mr3215522bks.91.1327329338239; Mon,
 23 Jan 2012 06:35:38 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Mon, 23 Jan 2012 06:35:07 -0800 (PST)
In-Reply-To: <CADo4Y9iH+J-X-TdqTN2Y9KhQnprnCVvC4Xy6qhVHwsBRmsZUrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188993>

On Mon, Jan 23, 2012 at 8:53 PM, Michael Nahas <mike.nahas@gmail.com> w=
rote:
> "git put" is "git cp".=C2=A0 It copies from one filesystem (or a snap=
shot
> of a filesystem) to another filesystem.

Exactly.

> Without multiple working directories, a modifiable "stash", or a
> (useful) name for the filesystem referred to as
> "index"/"cache"/"staging area", there is only one filesystem that the
> command can write to: the (singular) working directory.

No there are two writable "filesystems": working directory and
"index/cache/staging area"

> So, "git put <src filesystem> -- <path>" is fine.=C2=A0 It will copy =
from
> the path in the src filesystem to the path in the current working
> directory.=C2=A0 I don't think the command "put" is a great name for =
that.
> Since we already have some strange double-usage commands like "git
> checkout --" and "git reset --", perhaps this should be "git
> cherry-pick --".

The "-- <path>" thing may save you a few keystrokes when you want to
copy from more than one path(spec). The two below commands are
equivalent

git put HEAD:a/ HEAD/b/ HEAD/c/ .
git put HEAD: . -- a/ b/ c/

But of course if you just need to copy from one pathspec to another
place, "--" syntax is redundant.

> <rant>
> But for my money, "git cp" is clearer and I'd love to get rid of the
> user-confusing double-usage commands.=C2=A0 I'd replace "git checkout=
 --"
> with "git cp NEXT WTREE -- <path>" and replace "git reset --" with
> "git cp HEAD NEXT --" where NEXT is the filesystem represented by the
> "index"/"cache"/"staging area" and WTREE is an alias for the working
> directory.
> </rant>

I thought of "cp" (naturally, I was driven by "scp" syntax as I said)
and maybe if we think this through, we may be able to enhance cp to
support "remote locations" (and --patch option). So "put" vs "cp" is
not important to me now. What I'd like to hear is whether the syntax
makes sense.

My "hidden" plan if this works out would be to deprecate (or
discourage) everything in git-checkout except branch switching. I
don't have anything against git-reset. It's a kind of dangerous
command from the start (while git-checkout is more user friendly) and
can stay that way. The new "git <cp, put or whatever name>" should
fill 90% the needs for git-reset.
--=20
Duy
