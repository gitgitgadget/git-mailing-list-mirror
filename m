From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: Git Bug - diff in commit message.
Date: Mon, 24 Oct 2011 16:24:15 -0700
Message-ID: <CAOeW2eG_muSdbWUaPG36=1-Ay6h6-4qHgWPNdjqY5Zpb52XisQ@mail.gmail.com>
References: <1315493353942-6772145.post@n2.nabble.com>
	<CAMOZ1BtbpbG+19G6Hfau_2_F5L3Ad+x-Payd9aKajJxU_V_tyA@mail.gmail.com>
	<7vpqj9vh87.fsf@alter.siamese.dyndns.org>
	<7v62jvdthi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Witten <mfwitten@gmail.com>,
	anikey <arty.anikey@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 01:24:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RITsU-00034w-Li
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 01:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab1JXXYR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 19:24:17 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36983 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441Ab1JXXYQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2011 19:24:16 -0400
Received: by yxl42 with SMTP id 42so3690354yxl.19
        for <git@vger.kernel.org>; Mon, 24 Oct 2011 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CWKLiGOoDBNyvYVdZd4aICvP/qv93p197unKSNhdwPs=;
        b=C0bT35loaaIgGa+p1giQo9iXcmozXjrxh342mejK1xouR45CBuJLdMtKrmiX+tWq3F
         8U+RQ0uX42uZzVOFcFDIygeHvvJUJHSMJFRkqJgVgWyyJze4fL2ynhVyHPA9MsJi+KdS
         FlED6q8iGrpcNAYS3fRyStuD0Q8SbZ1tZkD0s=
Received: by 10.68.12.138 with SMTP id y10mr50963989pbb.70.1319498655523; Mon,
 24 Oct 2011 16:24:15 -0700 (PDT)
Received: by 10.142.237.14 with HTTP; Mon, 24 Oct 2011 16:24:15 -0700 (PDT)
In-Reply-To: <7v62jvdthi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184192>

Hi,

On Tue, Oct 11, 2011 at 4:00 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> In the longer term, I think "git-rebase--am.sh" should be rewritten =
to
>> have format-patch avoid the cost of actually generating the patch te=
xt,

I'm (slowly) working on this.

> And here is a quick hack to do that using "log --cherry-pick --right-=
only".

Thanks. I had done something similar. I have now adopted most of your
changes into my patches, but  I have a few questions.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test -f "$dotes=
t/rebasing"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0commit=3D$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-e q "$dotest/$msgnum") &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 test "$(git cat-file -t "$commit")" =3D commit || {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 stop_here $this
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }

Are these braces needed?

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 git diff-tree -p --root "$commit" >"$dotest/patch"

In your previous mail in this thread, this was

+                       git diff-tree --root --binary -m
--first-parent "$commit" >"$dotest/patch"

I see why you dropped "-m --first-parent"; we should simply never
receive such patches to "git-am --rebasing". But why isn't --binary
necessary?

> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
>
> [...]

Why was this part left out? Did you get it to work using 'git log
--cherry-pick --right-only'? I'm asking because I did not get it to
work with except for the case where $onto=3Dupstream (basically when
--onto is not given).

Martin
