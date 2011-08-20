From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v4 4/4] Accept tags in HEAD or MERGE_HEAD
Date: Sat, 20 Aug 2011 23:37:11 +0700
Message-ID: <CACsJy8CLb-PrMdt05HEV-sHWwWbsu9MaC7-khAoT43O8vfkSDg@mail.gmail.com>
References: <1313674994-22902-1-git-send-email-pclouds@gmail.com>
 <1313765407-29925-1-git-send-email-pclouds@gmail.com> <1313765407-29925-4-git-send-email-pclouds@gmail.com>
 <7vaab52m2r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 18:37:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuoYR-0004U0-EA
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 18:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533Ab1HTQhn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Aug 2011 12:37:43 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61965 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab1HTQhn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 Aug 2011 12:37:43 -0400
Received: by bke11 with SMTP id 11so2842788bke.19
        for <git@vger.kernel.org>; Sat, 20 Aug 2011 09:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Pxbj7yys47PP/fojDnZ5Td0shGiYXr72C1RA6e/ckOw=;
        b=Cx3fzEWWyFGXVoV9VwJurRBprc2ibl9K0rBlSNdTo0z/OVjmSMKZ3PipfwjdiUWyHI
         ZeN/GdT6J+8pt0YU+oopORmaBPV61Z1Lwt4cLAOydxQO5FLpp5uni3I9VJmCAsRU6W1O
         Cm3NOTry2IbmA3FVEsz5+BTGnatyNufLrPiQQ=
Received: by 10.204.150.193 with SMTP id z1mr230067bkv.123.1313858261288; Sat,
 20 Aug 2011 09:37:41 -0700 (PDT)
Received: by 10.204.156.19 with HTTP; Sat, 20 Aug 2011 09:37:11 -0700 (PDT)
In-Reply-To: <7vaab52m2r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179763>

2011/8/20 Junio C Hamano <gitster@pobox.com>:
> That's de-reference, not deference ;-). You may want to be more expli=
cit
> about what kind of de-reference you are talking about.
>
> /*
> =C2=A0* Get a commit object for the given sha1, unwrapping a tag obje=
ct that
> =C2=A0* point at a commit while at it. ref_name is only used when the=
 result
> =C2=A0* is not a commit in the error message to report where we got t=
he sha1
> =C2=A0* from.
> =C2=A0*/
>
> I actually was hoping that you would have this comment in commit.h to=
 help
> people who want to add callers of this function, not next to the
> implementation.

OK. It's because I tend to go straight to implementation instead of
the declaration when I want to know how to use it.

> As I said earlier, I do not think updating sha1[] here is necessary. =
The
> caller should be updated to use c->object.sha1 instead.

The usual pattern is

get_sha1(ref, sha1);
commit =3D lookup_commit_or_die(sha1, ref);

=46rom a quick look, it's very easy to assume "sha1" is safe to use
afterwards while it may be different from commit->object.sha1. I'm
tempted to make lookup_commit_or_die() resolve ref to sha1 internally,
no temporary sha1 variable will be hanging around, the pattern becomes

commit =3D lookup_commit_or_die(ref);

The only problem is MERGE_HEAD is not usual ref and cannot be treated t=
his way.
--=20
Duy
