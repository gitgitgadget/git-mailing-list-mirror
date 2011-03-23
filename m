From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git cherry improvements suggestions
Date: Wed, 23 Mar 2011 15:43:36 +0100
Message-ID: <AANLkTin7Du5RYt946hNjP-y53puNykebCjiKk5Ju_igr@mail.gmail.com>
References: <AANLkTimk0bkOGVy2W+XddHRuf-1xw+d0RwzPhnk40vi8@mail.gmail.com>
	<4D89CF8E.4070100@drmicha.warpmail.net>
	<AANLkTinXh_Y9ft5Pd5SxOEXvKNm3HLmsiut8WrvFZrdQ@mail.gmail.com>
	<4D89F6BC.2040902@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 15:43:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2PHi-0003sm-MK
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 15:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097Ab1CWOnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 10:43:37 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58745 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab1CWOnh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 10:43:37 -0400
Received: by gxk21 with SMTP id 21so3382249gxk.19
        for <git@vger.kernel.org>; Wed, 23 Mar 2011 07:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DOzvv3ykS9+MToDZU0dH/8i353r2YM3fR9RDSVp1i04=;
        b=h8hzQ5CKbZJ6/XIljobT+tCq4hrchr5nb/iUlhgl0uQtfWyvJ6kXTu22nzPXva5Qek
         f53sIlMP3axH/sEgCTKx506zMYRT+GUVcalUQXWPRe2hdk/o45k9Y0QIMA71Q8ZXgw6Q
         4oElhuRPq1SuQNhxf1eeswLjaBc0IVA6dQn4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lXT7lAQHGW1M+QpGjuga96FT18yqqgSht2FmI8CODAJAUoL6RbU6fZSc4ifyr8Z0lN
         oX4uVkZNCXbclqeCE2GQO7h1ZxwPpEOYTiNmawnzqFQPJk7ZwmJ7+CYx7WaFszP6y2QT
         GlJ5lOgq+21fS1Zz8TVePn2yMEFbpwo+0Tel4=
Received: by 10.52.70.116 with SMTP id l20mr842123vdu.13.1300891416387; Wed,
 23 Mar 2011 07:43:36 -0700 (PDT)
Received: by 10.220.210.16 with HTTP; Wed, 23 Mar 2011 07:43:36 -0700 (PDT)
In-Reply-To: <4D89F6BC.2040902@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169836>

On Wed, Mar 23, 2011 at 2:33 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Piotr Krukowiecki venit, vidit, dixit 23.03.2011 14:23:
>> Just some stats:
>>
>> =A0 =A0git log --cherry-mark --left-right --oneline --date-order bra=
nch...trunk
>>
>> lists 1004 commits, takes about 20s and memory peaks to about 670MB
>> twice during the run (I'm on linux with AMD Phenom II X4 945)
>>
>> With limit it prints X last commits (the limiting seems to take plac=
e after all
>> work, on the output list only).
>>
>> branch..trunk is 551 commits, the other way is 453 commits.
>> 710 commits are found to be "=3D", 98 "<", 196 ">".
>>
>> Note, I'm not saying it's too slow, or that it's working incorrectly=
, I'm just
>> giving real-life stats if anyone was interested.
>> I suspect such checks won't be done frequently.
>
> You don't need to say it's slow - I've said so already :(
>
> http://permalink.gmane.org/gmane.comp.version-control.git/169725

In the link above:
  git cherry A B: 0.4s
  git rev-list --cherry A...B: 1.7s

So rev-list is 4.25x slower.

In my case it's only 1.23x slower:

   $ time git rev-list --cherry branch...trunk  > /tmp/rev-list
   real	0m18.627s
   user	0m17.710s
   sys	0m0.900s

   $ time git cherry  branch trunk  > /tmp/cherry
   real	0m15.345s
   user	0m14.310s
   sys	0m1.020s


--=20
Piotr Krukowiecki
