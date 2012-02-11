From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] pack-refs: remove all empty directories under $GIT_DIR/refs
Date: Sat, 11 Feb 2012 15:55:31 +0700
Message-ID: <CACsJy8Bh=FZ6kNN5hERK5_H7XnZ83BZ_EfsZ5XmJbrnn+CfgcQ@mail.gmail.com>
References: <1328891127-17150-1-git-send-email-pclouds@gmail.com>
 <1328946907-31650-1-git-send-email-pclouds@gmail.com> <7vhayxn5cg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 09:56:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw8ke-0008JX-2y
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 09:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975Ab2BKI4E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 03:56:04 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:48599 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab2BKI4C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 03:56:02 -0500
Received: by werb13 with SMTP id b13so2516653wer.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 00:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=uyAIQN8VRH7jAPczuGLqu63wF5CdqU9OWh48Vel4Bt4=;
        b=Zagvnc6cfYCTAAynBCZhDut1N4JJHaiAGLmhiM+l1OMWlC/yj+KiBmWbWxAA3/J0J5
         mhd0sLxQSOZRrb5A5y2rVFJAUXqTbP5nUN6t+RhmzhFWaCsP3XPA31bS0mX5r9JaOcCj
         GMVqWLcNK9O+Z0BLAsLuJvdaPqL7JOlgmWXRE=
Received: by 10.180.87.8 with SMTP id t8mr7835542wiz.15.1328950561207; Sat, 11
 Feb 2012 00:56:01 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Sat, 11 Feb 2012 00:55:31 -0800 (PST)
In-Reply-To: <7vhayxn5cg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190503>

2012/2/11 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Deleting refs does not remove parent directories if they are empty.
>> Empty directories add extra overhead to startup time of most of git
>> commands because they have to traverse $GIT_DIR/refs.
>
> Perhaps drop the first line and replace with the description of what =
you
> do differently from the first round?
>
> =C2=A0 =C2=A0"git pack-refs" tries to remove directory that becomes e=
mpty but it
> =C2=A0 =C2=A0does not try to do so hard enough, leaving a parent dire=
ctory full of
> =C2=A0 =C2=A0empty children directories without removing.

Sure.

> While I agree with Peff that people would expect doing other things w=
hile
> pack-refs is running would be much "riskier" and doing this inside
> pack-refs is far more preferable than doing so during normal read-onl=
y
> operation, I wonder why we would want a completely separate pass that
> scans the entire hierarchy

Less complex code. Doing it in one pass, I think get_ref_dir() needs
to learn read-only vs read-write mode and I haven't figured out a
non-ugly way to do it.

>=C2=A0Would it make more sense to note the
> directory for which rmdir() fails in try_remove_empty_parents(), and
> revisit only these directories, at least?

That would leave empty directories not sharing the ref's path until
the failed rmdir() unexamined, I think.

> Wouldn't we want to rmdir() the corresponding logs/ hierarchy while a=
t it
> to be consistent?

Good idea.

>> + =C2=A0 =C2=A0 subpath =3D xmalloc(pathlen + 257);
>
> What is this 257 about?

This function is a ripoff from get_ref_dir(). I think 257 is 255 below
plus '/' and NIL.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (namelen > 255)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 continue;
--=20
Duy
