From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: cmd_cherry in builtin/log.c?
Date: Wed, 8 Dec 2010 09:57:59 -0200
Message-ID: <AANLkTik7+WAk0mx0G7b565eCihB5SGNBDuYLdfPzq7pr@mail.gmail.com>
References: <AANLkTikXmc-3BBkxy-D8GNLAMXUOPghp78GpStZ-_wBW@mail.gmail.com>
	<20101207173923.GA21483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, rene.scharfe@lsrfire.ath.cx
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 12:58:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQIev-00063P-Kn
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 12:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758Ab0LHL6C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 06:58:02 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:41881 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754557Ab0LHL6A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Dec 2010 06:58:00 -0500
Received: by bwz16 with SMTP id 16so1197252bwz.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 03:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=l23Vp+yIb9wqGE8fY8ZL2SLdUuDFk1GKs3oKHcJ+2OY=;
        b=WZ8qnw9mrEX4X40tE+Yrd6Y+w29wRyDA06MojzINeeUnaFFz5GxBr0zBb7kJaySBKY
         17jyj6bm0xf/9S7Oq5endchAveiFQ0ufL4fZXlFR3Pd+eDlAIa0VRG5QtccvnExN/ygR
         kh8Jjgh3Rmy7EpNhEV+1qudktHpgPD0m0qS98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iHnXu9dffBboKuTes5ETSRlo5TYEyg5QYjglFFl+Z9WOsmzylQrmtuL646gL5OsPOU
         o7zrKe1+KZ7Wpd4D+VyVaB7gyXlvNKgXQJpljGJsNC7Oz73naHMVVxueVYuKa4mMMXN9
         1xlyaD7wLnV6gXnd8yolOU8RD+3+9Ujvk928s=
Received: by 10.204.47.65 with SMTP id m1mr1697439bkf.202.1291809479355; Wed,
 08 Dec 2010 03:57:59 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Wed, 8 Dec 2010 03:57:59 -0800 (PST)
In-Reply-To: <20101207173923.GA21483@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163192>

On Tue, Dec 7, 2010 at 3:39 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Hi,
>
> Thiago Farina wrote:
>
>> I was looking into builtin/log.c to see how it does --reverse and I
>> saw that cmd_cherry is there.
>>
>> I'm wondering, why is it there?
>
> Good question. =C2=A0So let's check.
>
> =C2=A0$ git log --oneline -Scmd_cherry builtin/log.c
> =C2=A081b50f3 Move 'builtin-*' into a 'builtin/' subdirectory
>
> That wasn't too helpful. =C2=A0Okay, okay.
>
> =C2=A0$ git log --oneline -Scmd_cherry -- builtin-log.c
> =C2=A081b50f3 Move 'builtin-*' into a 'builtin/' subdirectory
> =C2=A0e827633 Built-in cherry
>
> Running "git show e827633" reveals that the core of the original
> script is
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for c in $inup
> =C2=A0 =C2=A0 =C2=A0 =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git-diff-tree =
-p $c
> =C2=A0 =C2=A0 =C2=A0 =C2=A0done | git-patch-id |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while read id name
> =C2=A0 =C2=A0 =C2=A0 =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo $name >>$=
patch/$id
> =C2=A0 =C2=A0 =C2=A0 =C2=A0done
>
> while the core of the builtin version is
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0get_patch_ids(&revs, &patch_id_opts, prefi=
x);
>
> The latter function is static, introduced by v1.4.1~12^2~5
> (format-patch: introduce "--ignore-if-in-upstream", 2006-06-25).
>
> So the answer is that "git cherry" is considered a variant on
> "git log" (like format-patch, show, and whatchanged) and that it uses
> "git log" internals.
>

Yup, thanks for digging into it. Now makes sense.
