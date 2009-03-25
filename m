From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [BUG] Infinite loop in git send-email if ran non-interactively.
Date: Wed, 25 Mar 2009 12:03:17 -0400
Message-ID: <76718490903250903t530983abi8a641e6b7aee6c0@mail.gmail.com>
References: <vpqiqlyj64o.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Mar 25 17:05:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmVb2-0007K4-4N
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 17:04:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbZCYQDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 12:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754295AbZCYQDU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 12:03:20 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:65496 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbZCYQDT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 12:03:19 -0400
Received: by yx-out-2324.google.com with SMTP id 31so95687yxl.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Yxxr+K2/tqEl//DCAqUj1iwUG5GZcbzPdY+yGX78kdA=;
        b=Hwk2PrT/sJjJE1h5rBIfqtMsolnh9N/G0cNu4QMJqSgHqXzdSipGijsCJCiNnGKYSG
         Fp3YMMTuFMylTClQKtHmGP7sLElIEvm8TOhZR+7Rg8qsARJcRomQm4H5uqmHSM5stmx+
         PZggN4CQSKYerxb1ig6CcdQeeIGaSXeSPHnzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ykl80odJyvxAvkAI7za7jtyPS70lMPCAtfz5mWHorkfAuI4MgSU3bVvLZVQY/fgk4j
         DWl97ttD2zD/oP1BXzg9+4LwGtqRRzPvmvNCqgt2OgX5aBDIzWj3DFwpaqD2uRf4Gz2v
         Uv3+F51uVYRcmZOu5X8Chcna3LGYrCa7MAamA=
Received: by 10.150.215.16 with SMTP id n16mr123382ybg.159.1237996997228; Wed, 
	25 Mar 2009 09:03:17 -0700 (PDT)
In-Reply-To: <vpqiqlyj64o.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114612>

On Wed, Mar 25, 2009 at 5:36 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wr=
ote:
> I think, non-interactive runs of send-email should assume "yes"

Hmm, probably.

> instead of prompting. In any case, it should not do infinite loop (I
> guess I don't have to argue for this ;-) )

Right, I'll followup with a fix.

> Can someone more fluent in perl than me add a
>
> if(session-is-interactive) {
> ...
> }
>
> around this confirmation prompt?
>
> (side-note : there is indeed some code to handle the cases where the
> terminal doesn't work with readline, added by Junio in 280242d1, but
> the FakeTerm part doesn't seem to be executed in my case:
>
> my $term =3D eval {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ENV{"GIT_SEND_EMAIL_NOTTY"}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0? new Term::Re=
adLine 'git-send-email', \*STDIN, \*STDOUT
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: new Term::Re=
adLine 'git-send-email';
> };
> if ($@) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$term =3D new FakeTerm "$@: going non-inte=
ractive";
> }
> )
>
> (in the meantime, I'll add --confirm never to my script)

Actually, FakeTerm is only triggered if Term::ReadLine is not
available. The "going non-interactive" message is misleading in this
case, as it has nothing to do with whether stdin is a tty or not.

j.
