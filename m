From: Elijah Newren <newren@gmail.com>
Subject: Re: merge removed content back into current content
Date: Sat, 25 Sep 2010 17:43:03 -0600
Message-ID: <AANLkTimxHbCktv=kaq0UfV+u1kH1Pb2LYA2Xi=qkgduW@mail.gmail.com>
References: <i7jp1a$kc0$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sun Sep 26 01:43:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzeOj-0005RZ-1j
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 01:43:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab0IYXnH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 19:43:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43838 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab0IYXnF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 19:43:05 -0400
Received: by fxm3 with SMTP id 3so1282538fxm.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 16:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UjoxOcrJZXVTpew0mgs020sx61Wrh5TjFNDV/rdVHYk=;
        b=CGAbxolX80OS5GB64wxtgSLIHkFbKY9mn90kvy6wPWb8Np+dv8BrlU2o1V9OJjKKkb
         LoVzUqkOik9K7BItIsS31ZBUNQFe0SOBjIH3CsAYGGSCGSvqnm1rha7ZSjAhNNP1dSQs
         jzLa0SU1e3Ir48Kwk+7zcdu6BNuF82XsAl++8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QC4CFfXvDB7bK0sWnyL4aIRCN221XuL6QvsU22MnmKHea4o/CDmRfKAq1JErgNdJPz
         HaQYfcOWhhccjWZqyosQ2N8+NYkF/MdKKSDMrT4VbIAtLbWjyescbKYgxqCBsA3/XTph
         BQN5Ycd3t33tZKqcAmiGL4YYHCew2C55sAAKo=
Received: by 10.223.116.200 with SMTP id n8mr5420231faq.18.1285458183741; Sat,
 25 Sep 2010 16:43:03 -0700 (PDT)
Received: by 10.223.119.209 with HTTP; Sat, 25 Sep 2010 16:43:03 -0700 (PDT)
In-Reply-To: <i7jp1a$kc0$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157206>

On Fri, Sep 24, 2010 at 9:06 PM, Neal Kreitzinger <neal@rsss.com> wrote=
:
> How do I tell git to merge a single program from an old commit into t=
he
> current version of that program in the HEAD commit? =C2=A0In this sce=
nario, I
> want to get back some removed code but still keep the new code.
>
> e.g.
>
> Commit-1 =3D initial commit containing Program-A, and other programs
>
> Commit-2 =3D add Changeset-1 to Program-A , and make changes to other=
 programs
>
> Commit-3 =3D remove Changeset-1 from Program-A, then add Changeset-2 =
to
> Program-A, and make changes to other programs
>
> *desired* Commit-4 =3D only merge Program-A from Commit-2 into Progra=
m-A of
> Commit-3, and don't change any other programs
> (in other words, get my old changes from Commit-2 back, but don't loo=
se the
> new changes from Commit-3)

Does something like:
  git diff commit1 commit2 -- ProgramA | git apply
do what you need?

If diff+apply doesn't work[1], you can try
  git cat-file -p commit1:ProgramA > base
  git cat-file -p commit2:ProgramA > other
  git cat-file -p commit3:ProgramA > current
  git merge-file current base other

[1] e.g. would cause conflicts -- btw, does anyone know how to force
git apply to proceed and add conflict markers if necessary rather than
just bailing out?
