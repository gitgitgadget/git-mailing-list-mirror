From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] traverse_trees(): allow pruning with pathspec
Date: Mon, 10 Oct 2011 08:35:34 +1100
Message-ID: <CACsJy8D9sJOtXj_jkVSyoAJ9TC4wmKNAD5YwsFXTYkpvM4e13w@mail.gmail.com>
References: <7vty9054qr.fsf@alter.siamese.dyndns.org> <1314653603-7533-1-git-send-email-gitster@pobox.com>
 <1314653603-7533-2-git-send-email-gitster@pobox.com> <4E91C031.9030205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Oct 09 23:36:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD12i-0002g8-TK
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 23:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841Ab1JIVgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Oct 2011 17:36:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54842 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab1JIVgF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Oct 2011 17:36:05 -0400
Received: by bkbzt4 with SMTP id zt4so7621108bkb.19
        for <git@vger.kernel.org>; Sun, 09 Oct 2011 14:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VvuvyTpNbQq06pjyDk4bosklsBB+BGb6EuYVITNpKaE=;
        b=d+y3qlpwNyBdPZr5qn9nTXH2aOIm4cZayd70wRzhTFOOw3PjRkgdwM2ihinu+7BLrg
         6rvX5dUiXXwvb5T+Wy3c/BkTGwe/PKmB4rFplxeapZqAr66acVnNdgVtpL5Tdux8Hjt5
         LzOKGDwiuSWUs5DwSXoEDi9DkkgDs+TP6uSOY=
Received: by 10.204.128.78 with SMTP id j14mr4083581bks.42.1318196164147; Sun,
 09 Oct 2011 14:36:04 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Sun, 9 Oct 2011 14:35:34 -0700 (PDT)
In-Reply-To: <4E91C031.9030205@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183212>

On Mon, Oct 10, 2011 at 2:39 AM, Michael Haggerty <mhagger@alum.mit.edu=
> wrote:
> On 08/29/2011 11:33 PM, Junio C Hamano wrote:
>> diff --git a/tree-walk.c b/tree-walk.c
>> index 33f749e..808bb55 100644
>> --- a/tree-walk.c
>> +++ b/tree-walk.c
>> [...]
>> @@ -376,16 +396,22 @@ int traverse_trees(int n, struct tree_desc *t,=
 struct traverse_info *info)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mask |=3D 1ul << i;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (S_ISDIR(entry[i].mode))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dirmask |=3D 1ul << i;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 e =3D &entry[i];
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!mask)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D info->fn(n, mask=
, dirmask, entry, info);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret < 0) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 error =3D ret;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!info->show_all_errors)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 interesting =3D prune_tr=
aversal(e, info, &base, interesting);
>
> According to gcc 4.2.4 (though, strangely, not gcc 4.4.3):
>
> tree-walk.c: In function =E2=80=98traverse_trees=E2=80=99:
> tree-walk.c:347: warning: =E2=80=98e=E2=80=99 may be used uninitializ=
ed in this function

=46alse alarm. If e is not initialized in the for loop, mask would be
zero and therefore prune_traversal(e, info, &base, interesting), which
would use uninitialized "e", would never be called.
--=20
Duy
