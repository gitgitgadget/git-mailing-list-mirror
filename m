From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] pre-commit: check .topdeps for valid branches
Date: Thu, 4 Jun 2009 14:18:04 +0200
Message-ID: <36ca99e90906040518h4bb92638y4d63fb5507b500a6@mail.gmail.com>
References: <1243592316-10820-1-git-send-email-bert.wesarg@googlemail.com>
	 <1243976962-10486-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090604093456.GA14548@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Jun 04 14:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCBtg-0005jP-II
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 14:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbZFDMSI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 08:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbZFDMSG
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 08:18:06 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:39690 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbZFDMSF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2009 08:18:05 -0400
Received: by bwz9 with SMTP id 9so683560bwz.37
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f1A1O7sXR2x/j/hHOSesTXAjHIXIAjP978VIrtiRj5A=;
        b=jJSJxSG/b2SvJTEtYLoGTQYTracMtmbjXUkJmnbB7SWkJl81Q0l2PyNKMntA5nyXXJ
         LU2H6oYVvNf/6/4EXC83O034Ag1Bjet18BrkDftoyGfVso4C7WoKFo0H3Jsu2Yyu3Jx+
         HZ7tPK5nHz1xQhuJtT1nypg3o2knSktfP9jk0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FOmkWYkSsNX0yxIYR+Dl6ZFRbwRABU9b6spAomg2RpCMPLeZqN2YxUnNLqR82WDK7Q
         Se+tLv6KhsHTkyLMRDXITzdo/gKUag540PKXJKulpK/emHlQDQrsuRcUZNmWPg1qzK5B
         JlKOCW3DL4z73jUDnRb41O0fs1P2U7pmYpsjI=
Received: by 10.223.117.194 with SMTP id s2mr1199474faq.83.1244117884142; Thu, 
	04 Jun 2009 05:18:04 -0700 (PDT)
In-Reply-To: <20090604093456.GA14548@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120693>

2009/6/4 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> Hi Bert,
>
>> diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
>> index 8e05a4e..1eae2e8 100644
>> --- a/hooks/pre-commit.sh
>> +++ b/hooks/pre-commit.sh
>> @@ -52,6 +52,9 @@ BEGIN =C2=A0 =C2=A0 =C2=A0{ in_hunk =3D 0; }
>> =C2=A0/^[^@ +-]/ { in_hunk =3D 0; }
>> =C2=A0' |
>> =C2=A0 =C2=A0 =C2=A0 while read newly_added; do
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref_exists "$newly_added=
" ||
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die "Invalid branch as dependent: $newly_added"
>> +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # deps can be non-t=
gish but we can't run recurse_deps() on them
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref_exists "refs/to=
p-bases/$newly_added" ||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue
>> --
>> tg: (0f8cd77..) bw/check-valid-deps (depends on: bw/check-for-dep-cy=
cle)
> this patch doesn't apply to my branch. =C2=A0I'd say you didn't send =
out
> bw/check-for-dep-cycle (or I oversaw it).
I have forwarded it to you, but you may also want to clone my topgit tr=
ee at:

http://kgb2.thruhere.net/git/?p=3Dbertw/topgit.git;a=3Dsummary

Now that repo.or.cz is up again, I will put this repo on this server ne=
xt week.

Regards,
Bert

>
> Best regards
> Uwe
