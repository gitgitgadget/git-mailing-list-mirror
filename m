From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] Add a test for a problem in "rebase --whitespace=fix"
Date: Mon, 8 Feb 2010 08:37:19 +0100
Message-ID: <6672d0161002072337r2ad002adq69f4c686da8cdf09@mail.gmail.com>
References: <4B6E7564.7040109@gmail.com>
	 <7vtytsevsd.fsf@alter.siamese.dyndns.org>
	 <6672d0161002071444lba0f751w3e7e33043e1ec2e8@mail.gmail.com>
	 <7vbpg060qx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 08:37:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeOBU-0005uv-5X
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 08:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684Ab0BHHhW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 02:37:22 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:57237 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab0BHHhV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 02:37:21 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1246134eyd.19
        for <git@vger.kernel.org>; Sun, 07 Feb 2010 23:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=v9zCljVCOoJ499Y2JhfE29MgBLE18eoUhwnx0ZvTnOg=;
        b=SLSGNqQc1SZSDUdDBcrpc9PvKdnbCWZ8KhsYgksa+m51ibsR3TDpxFu4KKmGObYSjf
         k28m4KUhzoZbeGShJXbT7+VD3gNcSKJnvwTgvpNWs+PW8jifnDr2XEL6VeMJ8ot09owI
         1BNbKdpl4H0T2VmHBBMzeUht/eKwE0HjXDK+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pu3Yk6U/RN32PxzKpZv/hmqXc+18jgn/724AiqZIvQ6tn+hiZwMExNuwoMEu1lrRAn
         R54rcshWbQnwtXV42yH0YhvotEiCxSkXddBX6wtFcAQN0IPoRIjlfjFlQUyaaKBqQml2
         m8QvsnVJ/SNJGsSPRZWOAtT5vWFqr2sOo2qAo=
Received: by 10.216.89.149 with SMTP id c21mr664065wef.224.1265614639809; Sun, 
	07 Feb 2010 23:37:19 -0800 (PST)
In-Reply-To: <7vbpg060qx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139279>

2010/2/8 Junio C Hamano <gitster@pobox.com>:

> You cannot go by the line numbers on the "@@ -l,k +m,n @@" header lin=
e you
> see in the second patch you received. =C2=A0On that line, only k and =
n are
> reliable numbers (the must match the patch text). =C2=A0l and m are u=
nreliable;
> being able to apply even if the text you have at hand does not exactl=
y
> match l and m is the whole point of transmitting the change in the pa=
tch
> format. =C2=A0The _only_ information you have usable at that point is=
 that
> there are _at least_ 3 blank lines before the addition, and perhaps t=
he
> fact that the hunk ends without post context lines. =C2=A0The latter =
tells you
> that it must apply at the end, but still doesn't tell you how many bl=
anks
> you need to add back at EOF before applying the patch.

I agree. The information is not enough if you apply one patch
at the time.

But my usage case that my test tries to demonstrate is different:

I already have a number of commits in my repository (received
either by pulling or applying a whole series of patches at once).

I then do, for example:

git rebase --whitespace=3Dfix HEAD~4

to clean up the existing commits.

That rebase uses "git apply" internally seems like an implementation
detail that I as a user of rebase don't care about. I just expect it
to work.

I see at least two possible ways to implement that:

1. Have "git rebase" give "git apply" a special option so that it
will apply patches beyond the end of file (and trusting the
line numbers in the chunks).

2. Having "git rebase" remember the number of blanks line that
was removed in each previous file in previous fixed commits
and add them back just before invoking "git apply".

It is possible that it is too much work to implement it to be
worthwhile (especially solution 2), but I do think it is possible.

If you don't agree, fair enough. In that case I will hold on
to the test case and only re-submit it if I can also include
a fix.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
