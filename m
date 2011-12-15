From: Miles Bader <miles@gnu.org>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Thu, 15 Dec 2011 13:20:17 +0900
Message-ID: <buoipli8nzy.fsf@dhlpc061.dev.necel.com>
References: <4EDBF4D5.6030908@pcharlan.com>
 <7vbormn8vk.fsf@alter.siamese.dyndns.org> <4EE8782A.9040507@elegosoft.com>
 <7vhb13qbs6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Schubert <mschub@elegosoft.com>,
	Pete Harlan <pgit@pcharlan.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 15 05:20:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rb2ny-0001yT-Ps
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 05:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758659Ab1LOEUW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 23:20:22 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:46613 "EHLO
	relmlor2.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874Ab1LOEUW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 23:20:22 -0500
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor2.idc.renesas.com ( SJSMS)
 with ESMTP id <0LW80099M9DWUNB0@relmlor2.idc.renesas.com> for
 git@vger.kernel.org; Thu, 15 Dec 2011 13:20:20 +0900 (JST)
Received: from relmlac3.idc.renesas.com ([10.200.69.23])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LW8009389DWHWD0@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Thu, 15 Dec 2011 13:20:20 +0900 (JST)
Received: by relmlac3.idc.renesas.com (Postfix, from userid 0)
	id 845731807C; Thu, 15 Dec 2011 13:20:20 +0900 (JST)
Received: from relmlac3.idc.renesas.com (localhost [127.0.0.1])
	by relmlac3.idc.renesas.com (Postfix) with ESMTP id 7B41F18077; Thu,
 15 Dec 2011 13:20:20 +0900 (JST)
Received: from relmlii1.idc.renesas.com [10.200.68.65]	by
 relmlac3.idc.renesas.com with ESMTP id PAM00716; Thu,
 15 Dec 2011 13:20:20 +0900
X-IronPort-AV: E=Sophos;i="4.71,356,1320591600";   d="scan'208";a="59578161"
Received: from unknown (HELO relay41.aps.necel.com) ([10.29.19.9])
 by relmlii1.idc.renesas.com with ESMTP; Thu, 15 Dec 2011 13:20:20 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.98.108])
	by relay41.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id pBF4KJgC007839;
 Thu, 15 Dec 2011 13:20:19 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id 1B01D52E1F5; Thu,
 15 Dec 2011 13:20:18 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <7vhb13qbs6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187189>

Junio C Hamano <gitster@pobox.com> writes:
>> builtin/checkout.c: In function =E2=80=98cmd_checkout=E2=80=99:
>> builtin/checkout.c:210:5: warning: =E2=80=98mode=E2=80=99 may be use=
d uninitialized
>> in this function [-Wuninitialized]
>> builtin/checkout.c:160:11: note: =E2=80=98mode=E2=80=99 was declared=
 here
>
> Isn't this just your gcc being overly cautious (aka "silly")?
>
> The variable "mode" is assigned to when we see an stage #2 entry in t=
he
> loop, and we should have updated threeway[1] immediately before doing=
 so.
> If threeway[1] is not updated, we would have already returned before =
using
> the variable in make_cache_entry().

Maybe that is actually guaranteed (I dunno), but it's certainly not
obvious from the code here, even to a human... any guarantee would
have to come from external invariants that the compiler doesn't know
about.

Given that, I think it's a fair warning, certainly not "silly."  This
aspect of the code doesn't seem easy to understand...

-Miles

--=20
`To alcohol!  The cause of, and solution to,
 all of life's problems' --Homer J. Simpson
