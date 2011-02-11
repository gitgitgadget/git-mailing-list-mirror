From: skillzero@gmail.com
Subject: Re: Using Origin hashes to improve rebase behavior
Date: Fri, 11 Feb 2011 02:02:52 -0800
Message-ID: <AANLkTikrVPCr92XHirn1u=73eM--T190V-7nbE6fo8ng@mail.gmail.com>
References: <m21v3fvbix.fsf@hermes.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Wiegley <johnw@boostpro.com>
X-From: git-owner@vger.kernel.org Fri Feb 11 11:03:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnpq8-0005Mq-6x
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 11:03:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab1BKKCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Feb 2011 05:02:55 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38422 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291Ab1BKKCy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Feb 2011 05:02:54 -0500
Received: by wwa36 with SMTP id 36so2382761wwa.1
        for <git@vger.kernel.org>; Fri, 11 Feb 2011 02:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GAmwvPVUDEek1BbZvfK2qEGum8g1xLsr+LK1I8UFszk=;
        b=DDBr2/D36faWqaavcHO83lE79RHd76rFqXgO6L62C9nNn9YwL/C7sN3/PxuqUg6ujq
         LGRoPPvQaXVCP26ja9Or9/HY21IdRfm1Y35v3hu2ncbDaxNfsgFxB9ND3EcXtyOJ2vnY
         eawfc0cnZ/ijfa+7GHLVBFv711VYbinW3cJ2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sYtiaUPD9XP9vJsjrnohJPCMNtHXpERRp5dJrHtYd1yyTACSpWclFGdfT5jTqfio8n
         nUN9bHyLGWlpmbT5LHuCPTqVQUE9xXJ8ITB/gEiSFqGaExERcFocAqGyuk0YYF8p4wlf
         uZQSW69BponuWQP/wkV0Hlgkh+3n8vK/vIBMg=
Received: by 10.216.51.130 with SMTP id b2mr261255wec.42.1297418572772; Fri,
 11 Feb 2011 02:02:52 -0800 (PST)
Received: by 10.216.13.79 with HTTP; Fri, 11 Feb 2011 02:02:52 -0800 (PST)
In-Reply-To: <m21v3fvbix.fsf@hermes.luannocracy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166548>

On Thu, Feb 10, 2011 at 1:13 PM, John Wiegley <johnw@boostpro.com> wrot=
e:
> The following proposal is a check to see if this approach would be sa=
ne and
> whether someone is already doing similar work. =C2=A0If not, I offer =
to implement
> this solution.
>
> THE PROBLEM
>
> Say I have a master from which I have branched locally, and that this=
 private
> branch has four commits:
>
> =C2=A0 =C2=A0a =C2=A0 b =C2=A0 c
> =C2=A0 =C2=A0o---o---o
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o---o---o---o
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 2 =C2=A0 3 =C2=
=A0 4
>
> I then decide to cherry pick commit 3 onto master. =C2=A0Please belie=
ve that my
> situation is such that I cannot immediately rebase the private branch=
 to drop
> the now-duplicated change. =C2=A0I end up with this:
>
> =C2=A0 =C2=A0a =C2=A0 b =C2=A0 c =C2=A0 3'
> =C2=A0 =C2=A0o---o---o---o
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o---o---o---o
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 2 =C2=A0 3 =C2=
=A0 4
>
> Later, there is work on master which changes the same lines of code t=
hat 3'
> has changed. =C2=A0The commit which changes 3' is e*
>
> =C2=A0 =C2=A0a =C2=A0 b =C2=A0 c =C2=A0 3' =C2=A0d =C2=A0 e* =C2=A0f
> =C2=A0 =C2=A0o---o---o---o---o---o---o
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o---o---o---o
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01 =C2=A0 2 =C2=A0 3 =C2=
=A0 4
>
> At a later date, I want to rebase the private branch onto master. =C2=
=A0What will
> happen is that the changes in 3 will conflict with the rewritten chan=
ges in
> e*. =C2=A0However, I'd like Git to know that 3 was already incorporat=
ed at some
> earlier time, and *not consider it during the rebase*, since it doesn=
't need
> to.

I don't know very much about how git really works so what I'm saying
may be dumb, but rather than record where a commit came from, would it
be reasonable for rebase to look at the patch-id for each change on
the topic branch after the merge base and automatically remove topic
branch commits that match that patch-id? So in your example, rebase
would check each topic branch commit against 3', d, e*, and f and see
that the 3' patch-id is the same as the topic branch 3 and remove
topic branch 3 before it gets to e*?
