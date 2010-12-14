From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 12/19] tree_entry_interesting(): support wildcard matching
Date: Tue, 14 Dec 2010 22:04:36 +0700
Message-ID: <AANLkTimwFw+ZjqKzbL0yNEC3Pw8RMW9Yr1KKpPFOOa4u@mail.gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-13-git-send-email-pclouds@gmail.com> <7vaak935ob.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 16:05:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSWRG-00084O-7J
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 16:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757219Ab0LNPFI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 10:05:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52555 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab0LNPFH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 10:05:07 -0500
Received: by wwa36 with SMTP id 36so585521wwa.1
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 07:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0inNWC/YfD4kSHr/KNxrK53tnalDrBQyJmR0/tvhxCI=;
        b=egeHu45JnAhYsNQ1S+s+p+VdZHDN7BJW6LfaYcWuiI0OyrTbbfEgz1+Nus7gEmtu/b
         UVSZDGIooVn3PXsBLdvqYtBYNaq3VRL+acn+UAof6XzPFIkVlDHKE5R69/itXExcBWWr
         xSWgKXQmUx5p/V9FO4Q+ULh6oWNarNkp46tOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YnOKAScDwoawtf44y1CvyiRTMth7DLpwws1CBPQUDgArjH0du+7cjSSNnxaqmyvXWL
         pM4JWgZtMkkJFWK3l+4HTmJvrH/PhAk6RCnrmL/HThKx57wgWoYbby1fFaWxHB7Yx096
         B2rwT5JtIzJp7SWHWMiytFGZYawqLEGuk3pB4=
Received: by 10.216.177.9 with SMTP id c9mr6444112wem.34.1292339106287; Tue,
 14 Dec 2010 07:05:06 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 14 Dec 2010 07:04:36 -0800 (PST)
In-Reply-To: <7vaak935ob.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163652>

2010/12/14 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0tree-walk.c | =C2=A0 33 ++++++++++++++++++++++++++++++---
>> =C2=A0tree-walk.h | =C2=A0 =C2=A02 +-
>> =C2=A02 files changed, 31 insertions(+), 4 deletions(-)
>
> ;-) =C2=A0Looks almost too easy.

Much better, yes. I went the wrong way and allowed wildcards in
directory matching too. It turned tree_entry_interesting() into hell.

>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 never_interesting =3D 0;
>
> When we have wildcard we would want to disable the never-interesting
> optimization, but I wonder if doing so only when we do not have exact=
 hit
> is what we want. =C2=A0If a sick person had a path "a?b" tracked, and=
 asked to
> match a pathspec "a?b", don't we still want to say "'a?b' of course
> matches, but 'a1b' ('1' comes earlier than '?' in the sort order) and
> 'aAb' ('A' comes later) also match"?

Heck, yeah. Easier for me though, just put this at top :-)

int never_interesting =3D ps->has_wildcard ? 0 : -1;
--=20
Duy
