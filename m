From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH v2 1/4] git-p4: Allow setting rename/copy detection threshold.
Date: Fri, 19 Aug 2011 00:43:12 +0100
Message-ID: <CAOpHH-VsoOSOH6ym2exCH=W4NmuKRw+f53HrwB47YD3u-iDe2w@mail.gmail.com>
References: <1313706054-11740-1-git-send-email-vitor.hda@gmail.com>
 <1313706054-11740-2-git-send-email-vitor.hda@gmail.com> <7vy5yq5nkb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 01:43:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuCFY-0006J2-G1
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 01:43:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab1HRXnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 19:43:43 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56608 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab1HRXnm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Aug 2011 19:43:42 -0400
Received: by ywf7 with SMTP id 7so1867663ywf.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=p5spOT+wcLdKGHYkEZVfCrrNGNNrRO8lOx30/EuQmiY=;
        b=OrOP33Po2WhlfGMHHyDsPqvmBvxOSOss0oEJxWF1M9GB3A8zuQwYJZYOCYKkG0ta4Z
         NdVIUZ1AF7GKLAhunMTIRX9bZmQAe5SCJ55UOyA6Ffu/TtiBPwPxJkIEi+6In3Uz0e0p
         KXz1GY8tBE+UFDMdt2JRKaz6ToiMtfv+W1QK4=
Received: by 10.42.150.66 with SMTP id z2mr1270570icv.383.1313711022089; Thu,
 18 Aug 2011 16:43:42 -0700 (PDT)
Received: by 10.231.19.8 with HTTP; Thu, 18 Aug 2011 16:43:12 -0700 (PDT)
In-Reply-To: <7vy5yq5nkb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179657>

On Fri, Aug 19, 2011 at 12:04 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> This is not a new problem you introduced with this patch, but unless =
you
> are invoking "git config --bool" in your gitConfig() (I didn't bother=
 to
> check), you will misunderstand different ways to say "Yes", e.g.
>
> =A0 =A0 =A0 =A0[git-p4]
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D on
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D yes
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D 1
>
> If you use --bool, you can rely on the values being either true or fa=
lse,
> and do not have to do the .lower() thing.
>

Now that I look at this carefully, Tor added the possibility to add arg=
uments to
gitConfig() exactly for that purpose. This is helpful for processing th=
e
detectCopiesHarder option I added.

=46or detectRenames and detectCopies it is a bit more complex. I think =
that if I
use --bool or --bool-or-int then it is possible that certain values wil=
l fail to
be processed. Let me give you some examples:

 =A0 =A0 =A0 =A0[git-p4]
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D true
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D 80%
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D 80
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D 1%
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0detectRenames =3D 1

It will be difficult for me to, for example, to understand if a 1 repre=
sents 1%
or true. Or am I overcomplicating this? :)

Thanks,

--=20
Vitor Antunes
