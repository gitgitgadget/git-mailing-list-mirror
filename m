From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: thoughts on a possible "pre-upload" hook
Date: Fri, 25 Sep 2009 17:24:36 +0530
Message-ID: <2e24e5b90909250454s7ed35b9ch10b954b0b1a40cfe@mail.gmail.com>
References: <2e24e5b90909220320rbd5fd1l40c7898656445232@mail.gmail.com>
	 <867hvr2cms.fsf@blue.stonehenge.com> <vpqd45jvub6.fsf@bauges.imag.fr>
	 <20090922161725.GS14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 13:54:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr9Ns-0006QX-Sh
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 13:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbZIYLyd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2009 07:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbZIYLyd
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 07:54:33 -0400
Received: from mail-iw0-f178.google.com ([209.85.223.178]:58235 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbZIYLyc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2009 07:54:32 -0400
Received: by iwn8 with SMTP id 8so1495956iwn.33
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RhGaowkK03m2gW4C7zDi96DcVABZigVoEYcFPqw6ovA=;
        b=o8vqjKv0asid9alS4ttWfKdpcsua5NRKaaCYaJqZV6KQ8tHvjuSIC0AVgxygdG19eH
         luR3e12iklqyzdxV0UO//ho+3uGm8lilnBnSNhRU97rF6M/gm660U0t96gqEeHPRv0+w
         NnfDNSSVck8S+suiUAE6OP+vX76wNR9O6Slt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BSY8+Pay2lewtWSj4C/eNu89jVXZlhz9CMFAXJqzZ7FeS4/SkvqA7TPzacL4KCQlJt
         nkwLFhazl7ztg7x1SedpNiJ4qIHP+ZCcsINFsAXvUoHPPh3j4Tbb/B/vZudASMrA9M6Q
         zuFiG2itapF7e6RKgb+miQ+JWHuww1yIaMIV0=
Received: by 10.231.123.26 with SMTP id n26mr74078ibr.41.1253879676241; Fri, 
	25 Sep 2009 04:54:36 -0700 (PDT)
In-Reply-To: <20090922161725.GS14660@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129077>

sorry I couldn't reply till now...

On Tue, Sep 22, 2009 at 9:47 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>> >>>>>> "Sitaram" =3D=3D Sitaram Chamarty <sitaramc@gmail.com> writes=
:
>> > Sitaram> As git is used more and more in corporate-type environmen=
ts, at some
>> > Sitaram> point it becomes convenient to have *branches* (or more a=
ccurately,
>> > Sitaram> refs) that are not readable.
>>
>> But that alone would make it rather painfull for the user : "git
>> clone" would fail if any branch in the repository is not readable, f=
or
>> example.
>
> No, what Sitaram is asking for is to have upload-pack not advertise
> the hidden branches. =A0By not advertising them, the client cannot
> send a "want" request for them, and they won't appear in the list
> that clone believes exists when it creates the new local repository.
> Thus, clone would succeed.

yes that would be precisely what I meant.  The hook would (somehow) be
able to influence which, among the available ones, get advertised.

>> Also, don't forget that branches are just references, which means th=
at
>> if you prevent reference A from being uploaded, then another referen=
ce
>> B may point to the same commits as A, and then you can bypass the
>> safety hook on A by using B.
>
> Yes. =A0But this is no different than having two different git
> repositories, A.git and B.git. =A0Pushing commits from A.git into B.g=
it
> allows someone to bypass A.git's filesystem read access control by
> instead reading those commits from B.git.

yes indeed -- if someone were to foolishly merge a "secret" branch
into a "normal" branch, so that it is now reachable from a "normal"
branch, that's his problem -- that cannot be within the scope of this
check.

It's the user's job to make sure that *only* his "secret" branch can
reach the secret stuff, other branches cannot reach it, and all git
has to do is ensure that no one can "want" that branch if they're not
supposed to see it.

--=20
Sitaram
