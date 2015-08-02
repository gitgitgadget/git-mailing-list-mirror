From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the presentation layer
Date: Sun, 02 Aug 2015 10:58:19 -0700
Message-ID: <xmqqa8u9a7yc.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
	<vpqbnewxwcx.fsf@anie.imag.fr>
	<CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
	<vpqk2tjmgeg.fsf@anie.imag.fr>
	<CAOLa=ZRUnF12gO=AKg3E373XETqoykqOXSkPvr7DHCVrOeggAA@mail.gmail.com>
	<vpq4mkmejsh.fsf@anie.imag.fr>
	<CAOLa=ZRq7zowwse7OGeU_AwJe_Z0WDn1qoYaH_A6AD5g92e_GQ@mail.gmail.com>
	<CAPig+cTyK=xDbtsK+q0eL=wmZ87xWue8SMJm=DQOzX22R1AOtQ@mail.gmail.com>
	<CAOLa=ZREZ2M_txEQR9jPET5_+MXx0D6cfW0X7SS4-TP9MShVrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 02 19:58:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLxWo-0002tN-UF
	for gcvg-git-2@plane.gmane.org; Sun, 02 Aug 2015 19:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbbHBR61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2015 13:58:27 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35908 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbbHBR6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2015 13:58:25 -0400
Received: by pdjb10 with SMTP id b10so2819677pdj.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2015 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JKmEujXL4bXTIzv5DQD+EfPIXJgvogxQJTdOBpY68OY=;
        b=FU1drG+emDCUzjSP54oRMfaSOUANmg4AuB6sp2cji4BmKRS/BR6cwJyPbI/65kdack
         UvSAMh0+yt7X69XI/afiv5h2SZBFsPNKieyE49bhGzB8ZzDRsVyS3Bm8Ff5sh5ZsDrkz
         /9w6gXBvKo3oMd+LJePMjW6nNiw1gX/vs2wXn2FhiRI6eJDF7X/lmd1s7bOpMYRGrd+1
         lZR5lSmXbFfwdpTATpUEF9nQozFnKicOyzRbGvJZbe/tHnBS4AoTY3TaARUvZxOz1OX+
         RkijK6he6edCRM4c5Lk3JY0C8aJgm8sfGLsWpx4unxontQplkc+0TwM3ZRCvqFDWoLNX
         yA3g==
X-Received: by 10.70.88.37 with SMTP id bd5mr28667637pdb.159.1438538304623;
        Sun, 02 Aug 2015 10:58:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:9922:d65f:3652:1a73])
        by smtp.gmail.com with ESMTPSA id c5sm14842818pds.87.2015.08.02.10.58.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 02 Aug 2015 10:58:21 -0700 (PDT)
In-Reply-To: <CAOLa=ZREZ2M_txEQR9jPET5_+MXx0D6cfW0X7SS4-TP9MShVrA@mail.gmail.com>
	(Karthik Nayak's message of "Sun, 2 Aug 2015 18:29:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275146>

Karthik Nayak <karthik.188@gmail.com> writes:

>> Even more generic would be an %(ifeq:x:y) conditional and a
>> %(currentbranch) atom:
>>
>>     %(ifeq:refname:currentbranch)*%(endif)
>>
>> Those are just a couple ideas. Other variations are possible and
>> likely preferable to the specialized %(starifcurrent).
>
> This makes sense, thanks. But implementing something like
> "%(if:<atom>)" seems to not be as easy as I thought it would be.
>
> First we need to parse that inner atom, but the used_atom_cnt is based
> on how many atoms there are initially, which doesn't count this inner atom.
>
> Although we could have a way around that, we'd need to again call populate_value
> from itself to get that inner atom's value. This causes more problems.
> Either ways
> I'm looking at ways around this.
> A simple solution would be to do :
>
> %(if)%(atom)%(then).....%(endif)
>
> or just
>
> %(if)%(atom).....%(endif)

My knee-jerk reaction to the former was "Eeww, the users is forced
to keep verbosely typing unnecessarily '%(', ')%(then)' forever,
only because the implementor was too lazy to do the job properly in
parse_atom()".  I do not think the latter a good idea at all.

But I think the former is worth considering, as it will later allow
us to extend it to various forms, e.g.

    %(if:notempty)%(atom)%(then)...%(end)
    %(if)%(atom)%(then)...%(elif)%(atom1)%(atom2)%(then)...%(end)

Two points being

 (1) the default "string is not empty" does not have to be the only
     test criteria, by leaving the door to add %(if:<condition>)
     later;

 (2) what is tested does not have to be a single atom (that is why
     I do not think the one without %(then) good at all) but can be
     a string that can later be interpreted.

And syntactically, something like this even may want to be
introduced later:

    %(if:expr)master == %(refname:short)%(then)...%(end)
