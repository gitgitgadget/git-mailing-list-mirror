From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] i18n: Not add stripped contents for translation
Date: Mon, 5 Mar 2012 11:01:30 +0800
Message-ID: <CANYiYbGdJ0yFmPnsK_JdABwmFraVdNi08QgFKRmGzJt-DA9tBw@mail.gmail.com>
References: <1330910494-17216-1-git-send-email-worldhello.net@gmail.com>
	<7v7gyz7pei.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 04:01:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4OB6-0008R1-7N
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 04:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981Ab2CEDBb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 22:01:31 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52017 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335Ab2CEDBb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2012 22:01:31 -0500
Received: by gghe5 with SMTP id e5so702271ggh.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 19:01:30 -0800 (PST)
Received-SPF: pass (google.com: domain of worldhello.net@gmail.com designates 10.236.180.193 as permitted sender) client-ip=10.236.180.193;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of worldhello.net@gmail.com designates 10.236.180.193 as permitted sender) smtp.mail=worldhello.net@gmail.com; dkim=pass header.i=worldhello.net@gmail.com
Received: from mr.google.com ([10.236.180.193])
        by 10.236.180.193 with SMTP id j41mr24312182yhm.55.1330916490602 (num_hops = 1);
        Sun, 04 Mar 2012 19:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kQThzR+Vnj3MTxpM/m0ypQ4AdQPvIUx15lcZq6yRGVE=;
        b=yqG7ZpIAIe2NNEEJl3ZtGmuZlHCG7OpUDPo9RE4TK80mzfrD2bEVMSqiWxH3v5CPMK
         Qrk6DoOMYxga4KQYdjog4t3jvsgKfwlP9ovmV3BHP3DK/+9ay7NGYBJ4wlkfKfcCyVvk
         cW4aEVwPE2GDqXMthtlWjtLiqAOeF3LmAa4it6vXBLjRodZH9pu+EYwCYhQ9rHT+hfUJ
         D9ZAtVEMqb339It1QkWCUs15cQaMI4zDXAmYZJbeYBvKG0ozi/xqOySEMczQHTTllleY
         uyPF2i0sNooY3eTmFTeiBoUN/9tBRpU2lOxxRPBxb/qSSwHVqcsnxEKAT/jZctdVNHaZ
         2cNw==
Received: by 10.236.180.193 with SMTP id j41mr19257959yhm.55.1330916490556;
 Sun, 04 Mar 2012 19:01:30 -0800 (PST)
Received: by 10.236.182.5 with HTTP; Sun, 4 Mar 2012 19:01:30 -0800 (PST)
In-Reply-To: <7v7gyz7pei.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192190>

2012/3/5 Junio C Hamano <gitster@pobox.com>:
>> If the translations won't end with COMMA+SPACE, will break the integ=
rity
>> of the concatenate string. As for Chinese, COMMA+SPACE may translate=
d to
>> "=A3=AC" -- a 3-byte UTF-8 Chinese comma character.
>
> Hmph.  Why would that be a bad thing in the first place?

Orignal source code:

244   case WT_STATUS_CHANGED:
245     if (d->new_submodule_commits || d->dirty_submodule) {
246       strbuf_addstr(&extra, " (");
247       if (d->new_submodule_commits)
248         strbuf_addf(&extra, _("new commits, "));
249       if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
250         strbuf_addf(&extra, _("modified content, "));
251       if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
252         strbuf_addf(&extra, _("untracked content, "));
253       strbuf_setlen(&extra, extra.len - 2);
254       strbuf_addch(&extra, ')');
255     }

The bad thing is strbuf_setlen() at line 253. We can not asume the tran=
slation
of ", " must be 2 characters.

If we change line 253 like the following, it may work but introduce ano=
ther
string ", " for translation, and it looks weird.

253       strbuf_setlen(&extra, extra.len - strlen( _(", ") ));

It is because I translate the ", " to "=A3=AC" (chinese comma), the tra=
nslated
chinese comma is 3 bytes long, striped two of them cause the output
looks weird.

It is also a bug hard to detect, If a careless translater lost the end =
space
in translation.


--=20
Jiang Xin
