From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Possible bug with branch names and case sensitivity
Date: Tue, 22 Nov 2011 12:31:33 -0500
Message-ID: <CAG+J_DxREbykWggrD49L7qvR9M36wKL7+_kOYbvcWmLBCF2Gog@mail.gmail.com>
References: <D144F6C9-C6A3-4516-BC88-B9EB50890EF4@bitart.com>
	<CAG+J_Dz6nK5fPhBRmoojmgYSv5OviN7pfgNKnRy9_9WmDS1_2w@mail.gmail.com>
	<4ECB315F.4080701@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gerd Knops <gerti@bitart.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 22 18:31:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSuC3-0003vg-6p
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 18:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642Ab1KVRbe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Nov 2011 12:31:34 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42850 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753186Ab1KVRbd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2011 12:31:33 -0500
Received: by ggnr5 with SMTP id r5so455024ggn.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 09:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=1M7I6crpSmlE5SzbRxNG/9e16RXnanX7Ry9r+wK6uLA=;
        b=lET6WCURvhhfeXPUqXsZe6ro2kViCU4qWRNzRcxr610a3OU6u1MR34ahlwZj/4C4Bb
         2CjICr7wRZ8cKPAsF/jKcIjeGCwBZSM/zJQpgWrwtqzJU095r4HNSMm7ZuUESq5f5bJq
         Sc+4UAoVp9EhLNUzb3O9keHwgPs2rM15giGQ8=
Received: by 10.236.183.133 with SMTP id q5mr28817435yhm.38.1321983093170;
 Tue, 22 Nov 2011 09:31:33 -0800 (PST)
Received: by 10.146.135.20 with HTTP; Tue, 22 Nov 2011 09:31:33 -0800 (PST)
In-Reply-To: <4ECB315F.4080701@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185801>

On Tue, Nov 22, 2011 at 12:21 AM, Michael Haggerty <mhagger@alum.mit.ed=
u> wrote:
> Is it obvious how references *should* be handled on case-insensitive
> filesystems? =C2=A0It's certainly not obvious to me (has it been disc=
ussed
> elsewhere?) =C2=A0I don't think it is a good idea to "fix" this one p=
roblem
> without defining an overall policy.

Indeed, I hadn't thought this through very well at all. My initial
take was just that if I were on a case-insensitive file system, I
don't get to have references that differ only in case. This is of
course quite short-sighted in a distributed VCS. :-(

> Currently git handles references names case-sensitively and allows
> multiple reference names that differ only in case. =C2=A0If this beha=
vior is
> to be preserved on case-insensitive filesystems, then either loose
> references must be stored differently (e.g., multiple references in t=
he
> same file) or ambiguous references need always to be packed. =C2=A0Mo=
reover,
> given a refname, we would need to be careful not to just try to open =
a
> file with that name and assume that it is the correct reference; rath=
er,
> we would have to ask the filesystem for the name of the file in its
> original case and make sure that it agrees with the case of the refna=
me
> that we seek.

I wonder what the downside would be of always using packed refs on
case-insenstive file systems. This would seem analogous to how git no
longer uses symlinks.

> By the way, this could have ramifications for the recently-added test
> that top-level refnames should be in ALL_CAPS.
>
> If we want to consider bending git's behavior, there are a number of
> ways we could go:
>
> 1. Remain case-sensitive but prohibit refnames that differ only in ca=
se.
>
> 2. Remain case-sensitive but prohibit refnames that differ only in ca=
se
> *when running on a case-insensitive filesystem*.
>
> 3. Change the handling of refnames to be case-insensitive but
> case-preserving.
>
> The above all assumes a case-insensitive filesystem that is
> *case-preserving*. =C2=A0If we want to support filesystems that do no=
t
> preserve case, things get even more complicated.
>
> And if we want to pretend to support non-ASCII refnames, then the iss=
ue
> of encodings is another nasty can of worms...

These all seem like sub-optimal things to do if we can just always
used packed refs.

j.
