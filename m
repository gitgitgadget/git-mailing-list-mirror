From: Chris Packham <judge.packham@gmail.com>
Subject: Re: Separate default push/pull?
Date: Thu, 11 Feb 2010 13:57:34 -0500
Message-ID: <a038bef51002111057l382ed55fy6b4042d1115a830c@mail.gmail.com>
References: <m2zl3fg26j.fsf@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 19:58:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfeEf-0007cP-1N
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 19:57:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826Ab0BKS5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Feb 2010 13:57:38 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:40888 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756146Ab0BKS5f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Feb 2010 13:57:35 -0500
Received: by pzk2 with SMTP id 2so988671pzk.21
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 10:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=A3CwMdCVQCSWnHnh5fsdrHa0C+QonmxtAjg/bCX13Nw=;
        b=F38QabGDuxYzJIIy3U+G5+1Vcmh/temx4ZOFO8wy8wMUfwWgZ7kvDx2LJONHc7a5iB
         3YPf9ENLaTMn5pStNmKvVu6YfZ8U4lT24w5FKj+Dz9IBK1YGYbG304WtImIEy455AXvb
         MCTbI7bmva3rwsDDcBbwDpQVspzHCQMOFryJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Wp2U20g+T34fI5+cm5zZr1ZqV2DMAtpB79WeDKUitRw8f4v7Ki79/l13YdPUaRGTE3
         w+ccyxAq8kpYK5v/Z41U8JTuzTbTyl8f5p/vEA9QFTiSqTZ6m1iLlMMv0A9FRXvw2CGK
         vUB/ShjyWJoyD6emlHMO97Dexiqghg16reDu4=
Received: by 10.115.87.4 with SMTP id p4mr153601wal.202.1265914654191; Thu, 11 
	Feb 2010 10:57:34 -0800 (PST)
In-Reply-To: <m2zl3fg26j.fsf@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139617>

On Thu, Feb 11, 2010 at 11:36 AM, David Abrahams <dave@boostpro.com> wr=
ote:
>
> If I am collaborating mostly with one other person, I typically want =
to
> pull from his publicly-readable repo and push to mine (on which I hav=
e
> write permission). =C2=A0Is there any way to set things up so =E2=80=9C=
git pull=E2=80=9D and
> =E2=80=9Cgit push=E2=80=9D without additional arguments will do this =
by default?
>
> Thanks,
>
> --
> Dave Abrahams =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Meet me at BoostCon:=
 http://www.boostcon.com
> BoostPro Computing
> http://www.boostpro.com
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

Yes there is a way. I haven't used it myself but search this list and
you'll find plenty of references.

(disclaimer: the following is what I think you can do based on some
vague recollection and some man pages)

Taking a quick look at the git push --help you'll see the following
snippet of configuration.

                   [remote "<name>"]
                           url =3D <url>
                           pushurl =3D <pushurl>
                           push =3D <refspec>
                           fetch =3D <refspec>

so I think if you just add the pushurl to your .git/config should do
what you've asked

[remote "origin"]
        fetch =3D +refs/heads/*:refs/remotes/origin/*
        url =3D git://git.kernel.org/pub/scm/git/git.git
        pushurl =3D git://git.example.com/yourrepo.git

=46or your own sanity I suggest doing this by adding your repository as
a separate remote.

e.g.

  git remote add yourrepo git://git.example.com/yourrepo.git
  git push yourrepo master:refs/heads/master  # the first time
  git push yourrepo # subsequent times

There probably is a way to tell push to use something other than
"origin" by default but I don't know/can't find it.
