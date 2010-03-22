From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Mon, 22 Mar 2010 11:36:08 -0300
Message-ID: <55bacdd31003220736u72ea6453pd59d8fa82a3ed12@mail.gmail.com>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com> 
	<20100321171431.GE2557@m62s10.vlinux.de> <7vd3yxqxdj.fsf@alter.siamese.dyndns.org> 
	<55bacdd31003211415k79b7a039n3f19eb95eefcad43@mail.gmail.com> 
	<953BEDE2-1A17-49EA-BEC5-D198DBB1FF23@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 22 15:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ntik6-00034R-Gy
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 15:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325Ab0CVOg3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Mar 2010 10:36:29 -0400
Received: from mail-yx0-f182.google.com ([209.85.210.182]:63897 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab0CVOg2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 10:36:28 -0400
Received: by yxe12 with SMTP id 12so1816774yxe.33
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=KZrYXPX6hEh0cDgnRpj09IWdTL8FYBzzl5hnT88eY/c=;
        b=fOkuV3SHJsbC+cqbWUtW2uLJ7LhT6vDHXOHYVWiXyZ8x+dIadDqX2cpmiHoR9bcdQp
         7tyAea/jeNveNBQ8b8vgvETcSWBCNfsyS0OmEuHHnP8/P57PBrAhHElDeXH8pvwF6FE+
         BwmuMSfEO+JWpuF+NA778RldgRxUkKBMy57oo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=GpjZYbpg3hH+OvmIhK7F15vRkqnv8dnfAnKesIrVTn2IFyWOEO9LEEYCwB9Pya4H7Z
         9WkMf4JqbkSy32PHylqWzefQMN738szGC11E+KKxfxm9dU8te036FW5KOaWOwY8J00NX
         XS6u/vSZUii4U1Ed/E3FuFTBMsiGFcH5lLyy0=
Received: by 10.150.31.5 with SMTP id e5mr9753089ybe.45.1269268588129; Mon, 22 
	Mar 2010 07:36:28 -0700 (PDT)
In-Reply-To: <953BEDE2-1A17-49EA-BEC5-D198DBB1FF23@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142934>

Hi again,

2010/3/22 Chris Johnsen <chris_johnsen@pobox.com>:
> The existing uses of --root are close to, but not identical to this p=
roposed
> usage. The existing uses all relate to handling the already created r=
oot
> commit(s) of a commit/branch/repository. This proposed usage relates =
to the
> yet to be created first commit on the new branch. It is possible to u=
se the
> "already created" interpretation in this context (create a new branch=
 based
> on the root commits of the specified commits), but it really does not=
 make
> much sense. Still, qualifying "root" might help prevent some confusio=
n:
>
> =C2=A0 =C2=A0--new-root
> =C2=A0 =C2=A0--fresh-root
> =C2=A0 =C2=A0--root-branch?
>
> =C2=A0 =C2=A0--new-history
> =C2=A0 =C2=A0--fresh-history
> =C2=A0 =C2=A0--fresh-branch
>
> Logically, both --orphan and --root are descriptions of the commit th=
at will
> _eventually_ be stored under the branch, but not descriptions of the
> transient state of the branch itself. This state is described in a fe=
w
> error/warning messages as "not yet born" or "unborn" (checkout, pull,=
 fsck).
> It seems to be an unofficial term though (or maybe just unimportant) =
since
> it is not otherwise documented (it is not in the glossary, but it doe=
s
> appear in the release notes a few times). So with some weight of exis=
ting
> terminology behind it:
>
> =C2=A0 =C2=A0--unborn
>
> --no-parent was mentioned elsewhere in the thread, but it suffers fro=
m
> looking like a negation of a potential --parent option. Though much l=
onger,
> --without- does not suffer this same problem.
>
> =C2=A0 =C2=A0--without-parents
> =C2=A0 =C2=A0--without-history
> =C2=A0 =C2=A0--ahistorically =C2=A0 =C2=A0(probably the non-standard =
prefix is too "native")
>
> =C2=A0 =C2=A0--ex-nihilo =C2=A0 =C2=A0 =C2=A0 =C2=A0(just kidding?)
>
> --
> Chris
>

2010/3/22 Michael J Gruber <git@drmicha.warpmail.net>:
> [Disclosure: non-native speaker but having lived with natives ;)]
>
> I'd favour "root" for several reasons:
>
> - "root" is the correct technical term in graph theory
> - "root" is used the same way in other (Git) places
> - "orphan" is someone who used to have parents, so with "orphan" I wo=
uld
> rather associate the process of removing parents from the picture
> (removing parentship information from an existing commit)
>
> Just my two Euro-cents :)
> Michael

I really don't care about names as long as I will be able to create
the 'orphan' branches.

Whatever you people decide is good to me.

Regards
