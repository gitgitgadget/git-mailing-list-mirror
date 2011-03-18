From: =?UTF-8?Q?Carl_F=C3=BCrstenberg?= <azatoth@gmail.com>
Subject: Re: Git submodule update and the --merge flag when submodule is yet
 to be checked out
Date: Fri, 18 Mar 2011 22:06:31 +0100
Message-ID: <AANLkTi=PgB_QYoVip8_O1ga30KR7R8pJX_8KqsHLjAJV@mail.gmail.com>
References: <AANLkTikJo_pjSAmVV3wjWi04io4zWb-_P5p81TYj9tq6@mail.gmail.com>
	<7vipvgw3c1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Spencer E. Olson" <olsonse@umich.edu>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:06:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0gsY-0003oN-TP
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 22:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757442Ab1CRVGe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2011 17:06:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38901 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757399Ab1CRVGd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2011 17:06:33 -0400
Received: by wya21 with SMTP id 21so4241121wya.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 14:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iaVwvJvrZBvHuLZrukCgwnvpvaiYJ3JELK7J4c/wcek=;
        b=mhNyOFv6Mq/Q7n5KYsTJiJqhczIYB2KVfshmaQ7fN7O6QSWifSvw/7SUm9oYH+eJxa
         ji39Pw/euXV7EzKxz9jA7tBaWF58Uy6iqo/yqVFtYE2JjMA1qmkX3NhG2agV8iYEReWz
         IUdE3VsrgUInC8Nt4cK9+tUsCaPpQCOBxYSXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lZ9IWuITHg+bfgh8viXzX/wFSovaVe1biBpF/04y8ctPM6w+myTa5NxOfXKvpxIk1G
         ofP9izwo0i8vypt1Whk49P6pRRKYlag0NdQZlZqmsBbuvMDHcpUqVewGK99YV5br0iDK
         bzwYinLKa6FT9zjM2aS4Epqu+nH3AX0xZ4mO0=
Received: by 10.217.3.69 with SMTP id q47mr1792384wes.15.1300482391898; Fri,
 18 Mar 2011 14:06:31 -0700 (PDT)
Received: by 10.216.170.211 with HTTP; Fri, 18 Mar 2011 14:06:31 -0700 (PDT)
In-Reply-To: <7vipvgw3c1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169359>

2011/3/18 Junio C Hamano <gitster@pobox.com>:
> Carl F=C3=BCrstenberg <azatoth@gmail.com> writes:
>
>> Sorry for re-posting the question but I though I should explain the
>> issue better and to fix the subject line.
>> sub
>> When you are cloning repository containing submodules, and you are
>> using the --merge flag to "git submodule update" the first time, the=
n
>> the submodule instance in question will assume you want to delete al=
l
>> files present in the module.
>
> Is this something we fixed last month?
>
> commit 1b4735d9f3e0b7ea62c7c22f0afcb45e10c46c7e
> Author: Spencer E. Olson <olsonse@umich.edu>
> Date: =C2=A0 Thu Feb 17 09:18:45 2011 -0700
>
> =C2=A0 =C2=A0submodule: no [--merge|--rebase] when newly cloned
>
> =C2=A0 =C2=A0"git submodule update" can be run with either the "--mer=
ge" or "--rebase"
> =C2=A0 =C2=A0option, or submodule.<name>.update configuration variabl=
e can be set to
> =C2=A0 =C2=A0"merge" or "rebase, to cause local work to get integrate=
d when updating
> =C2=A0 =C2=A0the submodule.
>
> =C2=A0 =C2=A0When a submodule is newly cloned, however, it does not h=
ave a check out
> =C2=A0 =C2=A0when a rebase or merge is attempted, leading to a failur=
e. =C2=A0For newly
> =C2=A0 =C2=A0cloned submodules, simply check out the appropriate revi=
sion. =C2=A0There is no
> =C2=A0 =C2=A0local work to integrate with for them.
>
> =C2=A0 =C2=A0Signed-off-by: Spencer E. Olson <olsonse@umich.edu>
> =C2=A0 =C2=A0Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
> =C2=A0 =C2=A0Signed-off-by: Junio C Hamano <gitster@pobox.com>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>


Ah, I see, thank you, I was using 1.7.4 and I assume this is for next.

--=20
Carl F=C3=BCrstenberg
