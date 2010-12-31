From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 31/31] rebase -i: remove unnecessary state rebase-root
Date: Fri, 31 Dec 2010 06:41:46 +0100
Message-ID: <AANLkTikeUg-9Qik=Xuxo-dM08dg9=aa-mP7aJn8Yknht@mail.gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<1293528648-21873-32-git-send-email-martin.von.zweigbergk@gmail.com>
	<201012281740.52374.trast@student.ethz.ch>
	<alpine.DEB.1.10.1012292325220.7175@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 31 06:41:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYXkQ-0003Ph-DY
	for gcvg-git-2@lo.gmane.org; Fri, 31 Dec 2010 06:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab0LaFlt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 Dec 2010 00:41:49 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65072 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870Ab0LaFls convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Dec 2010 00:41:48 -0500
Received: by wyb28 with SMTP id 28so11527187wyb.19
        for <git@vger.kernel.org>; Thu, 30 Dec 2010 21:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/t02Iq5w0owt3BqeRbZaNTU2LonyQUaKkpR69pvLq7Q=;
        b=RECuCQIdBU/57sPR2NvCRHM8PMTlj327XjgnuIvcUOPwDmLY1OighQZLkR57QKcRVc
         XNN30artxdMURFRQe857K9m0HXH2I9l5C0smw6JT+IKqFRnECMRhrg5u3IVISubV9Og6
         US5nNi326G7tumlPAsYKeg3YygGcVWD4tJueY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CdMp3/aPUpJJ8Xa6SYmjezM2b8o9S3WrWJS7fiNwkw2qAY3SgWEp6qltfHzW4eO5NO
         GTp+dysCm7DFUzsWruHR13hysvAvlXa94C8im4WZ+EE+1iSDxd1m5Ow8NWxGQlwQ+Pte
         pjCMHjMx2I4SFwez2GXZr2FU/MYLQPU0tNLj4=
Received: by 10.216.173.7 with SMTP id u7mr1910243wel.50.1293774106961; Thu,
 30 Dec 2010 21:41:46 -0800 (PST)
Received: by 10.216.50.129 with HTTP; Thu, 30 Dec 2010 21:41:46 -0800 (PST)
In-Reply-To: <alpine.DEB.1.10.1012292325220.7175@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164379>

Hi,

On Wed, Dec 29, 2010 at 11:31 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> On Tue, 28 Dec 2010, Thomas Rast wrote:
>
>> Martin von Zweigbergk wrote:
>> > @@ -168,11 +168,6 @@ pick_one () {
>> > =A0 =A0 output git rev-parse --verify $sha1 || die "Invalid commit=
 name: $sha1"
>> > =A0 =A0 test -d "$REWRITTEN" &&
>> > =A0 =A0 =A0 =A0 =A0 =A0 pick_one_preserving_merges "$@" && return
>> > - =A0 if test -n "$rebase_root"
>> > - =A0 then
>> > - =A0 =A0 =A0 =A0 =A0 output git cherry-pick "$@"
>> > - =A0 =A0 =A0 =A0 =A0 return
>> > - =A0 fi
>> > =A0 =A0 output git cherry-pick $ff "$@"
>> > =A0}
>> [...]
>> > While factoring out the state writing code a few patches back, I w=
ent
>> > through each of the pieces of state that was written. I was a bit
>> > hesitant to include this patch since I'm not quite sure why the co=
de
>> > was introduced, but I thought I would include it anyway to hear wh=
at
>> > you have to say.
>> >
>> > There used to be bug when using --ff when rebasing a root commit. =
This
>> > was fixed in 6355e50 (builtin/revert.c: don't dereference a NULL
>> > pointer, 2010-09-27). Could this have been the reason for the chec=
k?
>> > Thomas, do you remember?
>>
>> I think this just ended up being such a strange test because of the
>> following hunk in 8e75abf (rebase -i: use new --ff cherry-pick optio=
n,
>> 2010-03-06):
>>
>> @@ -232,16 +232,7 @@ pick_one () {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 output git cherry-pick "$@"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return
>> =A0 =A0 =A0 =A0 fi
>> - =A0 =A0 =A0 parent_sha1=3D$(git rev-parse --verify $sha1^) ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "Could not get the parent of $sha1=
"
>> - =A0 =A0 =A0 current_sha1=3D$(git rev-parse --verify HEAD)
>> - =A0 =A0 =A0 if test -z "$no_ff" && test "$current_sha1" =3D "$pare=
nt_sha1"
>> - =A0 =A0 =A0 then
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 output git reset --hard $sha1
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 output warn Fast-forward to $(git rev-=
parse --short $sha1)
>> - =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 output git cherry-pick "$@"
>> - =A0 =A0 =A0 fi
>> + =A0 =A0 =A0 output git cherry-pick $ff "$@"
>> =A0}
>> --
>
> Yes, I saw that one as well, so it would probably have made more sens=
e
> to ask Christian instead (the author of 8e75abf). So do you remember,
> Christian?

Yeah, I must say that I did not try to understand why there was a
special case for $rebase_root above the code I was changing.
Perhaps I should have, and I would probably have sent a patch like your=
s...

> Anyway, thanks for your input, Thomas. That makes me feel a little
> less worried about this patch.

Yeah I think it's a good one.

Thanks,
Christian.
