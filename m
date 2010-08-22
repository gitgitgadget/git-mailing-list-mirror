From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] {fetch,upload}-pack: allow --depth=0 for infinite depth
Date: Mon, 23 Aug 2010 08:51:39 +1000
Message-ID: <AANLkTi=2rYmFutiPU3ZuBbEEivPy4g_1kzzc_QYuMgvN@mail.gmail.com>
References: <1282269067-5527-1-git-send-email-pclouds@gmail.com>
	<1282269067-5527-3-git-send-email-pclouds@gmail.com>
	<201008210011.40236.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mikachu <mikachu@gmail.com>,
	computerdruid <computerdruid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 23 00:51:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnJOE-0007LJ-Ot
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 00:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404Ab0HVWvm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Aug 2010 18:51:42 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53221 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab0HVWvk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Aug 2010 18:51:40 -0400
Received: by wyb32 with SMTP id 32so6109250wyb.19
        for <git@vger.kernel.org>; Sun, 22 Aug 2010 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xjBv3L0Qhgk8oevY56HWlL8Jwa919zq3zhZXNqkln8Y=;
        b=ZQ4tT0k6Rd0Bd4fkj2GPhIYRcuYzmH4o/BtF0NyhoqS6LWb3iIvlj6oE/BiJAB/sUK
         uaJkAEBB5JQUvT/OfgKXpCqZEERBwr2SQN+n01IHg5BtQ2xtaGYgCb4WHWQKvEM6RtAD
         egmoeEj9N4snhzbuZpuLjmZ94L39Ls37psybI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vA75Qjk2JkyBW/FegFJGToi2huzGEVr1ofdFMvfPHprn8P4/T6yEKLImfUAQZo8po8
         W7OOXxBQuAJ09JX9DxFX4JCHX3mlQJb53ifcJBcG8cMfgDtS9md3GyrJSD2w7MOAbd0O
         W+llzoeRBNdligeuz3bLrB6/w9xznhVv8iVdY=
Received: by 10.216.11.205 with SMTP id 55mr3797864wex.51.1282517499093; Sun,
 22 Aug 2010 15:51:39 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Sun, 22 Aug 2010 15:51:39 -0700 (PDT)
In-Reply-To: <201008210011.40236.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154199>

On Sat, Aug 21, 2010 at 8:11 AM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Fri, 20 Aug 2010, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> diff --git a/Documentation/fetch-options.txt
>> b/Documentation/fetch-options.txt
>> index 9333c42..a22d839 100644
>> --- a/Documentation/fetch-options.txt
>> +++ b/Documentation/fetch-options.txt
>> @@ -10,7 +10,8 @@
>> =C2=A0--depth=3D<depth>::
>> =C2=A0 =C2=A0 =C2=A0 Deepen the history of a 'shallow' repository cr=
eated by
>> =C2=A0 =C2=A0 =C2=A0 `git clone` with `--depth=3D<depth>` option (se=
e linkgit:git-clone[1])
>> - =C2=A0 =C2=A0 by the specified number of commits.
>> + =C2=A0 =C2=A0 by the specified number of commits. Specify "inf" fo=
r
>> + =C2=A0 =C2=A0 infinite depth.
>
> It should probably be 'Specify 0 or "inf" for infinite (unlimited) de=
pth',
> which means making repository non-shallow.

It would say "... which _may_ make the repository non-shallow". Or I
have to redo the patch and make sure tags are fetched automatically
too. Hmm..

>> =C2=A0ifndef::git-pull[]
>> =C2=A0--dry-run::
>> diff --git a/Documentation/git-fetch-pack.txt
>> b/Documentation/git-fetch-pack.txt
>> index 4a8487c..75e4669 100644
>> --- a/Documentation/git-fetch-pack.txt
>> +++ b/Documentation/git-fetch-pack.txt
>> @@ -70,6 +70,7 @@ OPTIONS
>>
>> =C2=A0--depth=3D<n>::
>> =C2=A0 =C2=A0 =C2=A0 Limit fetching to ancestor-chains not longer th=
an n.
>> + =C2=A0 =C2=A0 Specify 0 for infinite depth.
>
> Again '0 or "inf"'.

OK. "inf" was intented for user pleasure, which was the reason I did
not implement it in git-fetch-pack (a plumbing). But Jonathan was
brave enough to make OPT_INT_INF, I'll rebase this series on that
patch.
--=20
Duy
