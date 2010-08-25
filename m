From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 11/32] rev-list: support --narrow-tree
Date: Thu, 26 Aug 2010 08:11:11 +1000
Message-ID: <AANLkTimMGn9M9im2LdjYJkbg9QhUKq2a_4tRQEUoQM0c@mail.gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
	<1282688422-7738-12-git-send-email-pclouds@gmail.com>
	<AANLkTi=KBThiZ_FBUh0RfzLtP=YAtUPcx5PJW1q5OCd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 00:11:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoOBi-0006GN-6F
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 00:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab0HYWLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 18:11:14 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56976 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab0HYWLN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 18:11:13 -0400
Received: by eyg5 with SMTP id 5so785297eyg.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 15:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Vz5SIeC8/VT/Hpr3Hns+Wx/twYvFKT4l+JJ5VdFAAD0=;
        b=mLQ0Esuf/LHGOEB99Yr71N3QVzXCvTUbS5j/FwZAjP+7aTYoHMfbtdbZMQBYjLX0ZB
         L5ZK3TV+gxB88soIeRnYJcskcaZ/MtJ4oW3AlPo1PXYNcON+6tzUx0u5rOaX770UIIUB
         M+hmYJm4F56jQUXvRz41VA6bqKvpFWoya93Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YQXMotEew2d9Vd5htGR1vM+5D0+hv5KgAcvWK/P4tTzPJsVlzcp6rzf9N/zyxIAOKV
         2YADT/YmXtVJiXTtUgfKNfOgUAUqKVjqHvkoxQUEh1wKJWn0gCcJUQOnQQ01lof/cj3k
         HSFS7BDq1sjdjVtQ/x5VeBfnSWOR+uCN4Atgc=
Received: by 10.216.68.81 with SMTP id k59mr73576wed.33.1282774271661; Wed, 25
 Aug 2010 15:11:11 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Wed, 25 Aug 2010 15:11:11 -0700 (PDT)
In-Reply-To: <AANLkTi=KBThiZ_FBUh0RfzLtP=YAtUPcx5PJW1q5OCd4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154485>

On Wed, Aug 25, 2010 at 1:59 PM, Elijah Newren <newren@gmail.com> wrote=
:
> Hi,
>
> 2010/8/24 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>> These options allow plumbing to access narrow tree traverse modes.
>> As a consequence, tests can now be written to test these modes.
>>
> <snip>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!prefixcmp(arg, "--narrow-tree=3D")) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revs->narrow_prefix =3D arg + 14=
;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 revs->narrow_tree =3D 1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }
>
> Seems somewhat non-gittish. =C2=A0Why not 'git rev-list --objects HEA=
D --
> <subtree_path>' rather than 'git rev-list --objects
> --narrow-tree=3D<subtree_path> HEAD'? =C2=A0(Was it due to the curren=
t bug in
> rev-list when specifying both --objects and paths? =C2=A0If so, that'=
s
> addressed in the patch series I just sent.)

Yeah probably because of the --object bug that I did not know. Anyway
I still need "--narrow" signal because in my series, I would send all
trees that are not found in parents' trees for merge commits. A
requirement from remote merge.

>> +cat <<EOF >merge.expected
>> +0da28f8308e336bd4b2c26b61c7fc44e41a30e49
>> +7475cb8a389b36ce238b9ee6cbfdfa26a1b67e35
>> +af9c31c0e217154296d93d66b9a5a41892c7b321
>> +ba7a30916c792624a8372cb26da50f5594098222
>> +74a398027f0b59183db54ca8c67dc30b5aeed0ff t2
>
> Is this right? =C2=A0Do you expect to see a t2 entry when filtering f=
or t1/t12?

As I said above, if this "t2" is not seen in either parents, then it
must be sent/traversed, unfortunately.
--=20
Duy
