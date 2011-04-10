From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 5/5] grep: convert to use the new get_pathspec()
Date: Sun, 10 Apr 2011 14:26:31 +0700
Message-ID: <BANLkTim1u2gpcjwyg-kDp=oxC_3SzApNWg@mail.gmail.com>
References: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
 <1302368060-23827-6-git-send-email-pclouds@gmail.com> <7v7hb2zzxp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 09:27:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8p37-0000l0-9j
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 09:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab1DJH1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 03:27:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34343 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901Ab1DJH1C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Apr 2011 03:27:02 -0400
Received: by bwz15 with SMTP id 15so3768410bwz.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 00:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=i4FZekjDz7pVvyJ54jSThuZuO0Zz0cM54GNNU3CP82w=;
        b=LySqVLcPq4v7ADXy+XiCD43aXzjMuYoZewSbyRK5F8YOYczwYFszQ9+/Kp6OjI9FW0
         d+thlNQQtmRMUgT2DWnchMdEsoYPnmO9q67ZYbh8LDrE5yw59ZbN2nRQacAv918lHp5C
         HczH4+Hlf0LTroisDY4Mehwz+M3Eq33AM4G9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aQJxZOS0AVI8u1vu2WXtkuOszknQM9aPkrhTOwKB/emccAa5A6chqAXF6xcBuxS6DJ
         NQWHVVVO5tAjs1pMuBidsrKCvZZLZSjVoVxGQdfeDghzE7w/gloJ+/DRHBoKck0C1u+K
         Nw+t0GDw4v+59FxgkA9bkW/JF0PHwW1pCKQdw=
Received: by 10.204.17.11 with SMTP id q11mr3453863bka.131.1302420421213; Sun,
 10 Apr 2011 00:27:01 -0700 (PDT)
Received: by 10.204.139.210 with HTTP; Sun, 10 Apr 2011 00:26:31 -0700 (PDT)
In-Reply-To: <7v7hb2zzxp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171240>

2011/4/10 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
> This assumes that the new API function will default to "if run withou=
t
> pathspec, the calling command wants to limit to cwd", doesn't it?

Yes, I was blindly reimplementing get_pathspec() behavior...

> That is why I mentioned that the caller would need to pass a hint as =
to
> what should happen in that case in my earlier message. =C2=A0Probably=
 the new
> API function should be something like:
>
> =C2=A0 =C2=A0setup_pathspec(&pathspec, prefix, argc, argv, opts)
>
> where opts is a bitmask to carry that hint (or a pointer to a structu=
re
> that caller to carry a set of hints richer than a bitmask can express=
),
> and "add -u" and "grep" should set PATHSPEC_DEFAULT_LOCAL in the bitm=
ask.
> The call to setup_pathspec() from the log family would not want "no u=
ser
> specified pathspec means limited to local" semantics.
>
> Then when somebody wants to flip the "add -u" default in future versi=
ons,
> the call from "add -u" codepath can instead use PATHSPEC_DEFAULT_TREE=
WIDE
> (or perhaps the lack of PATHSPEC_DEFAULT_LOCAL bit may mean tree-wide=
)
> there.

=2E.. and forgot about this.
--=20
Duy
