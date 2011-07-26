From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC 0/9] bisect: allow git bisect to be used with repos containing damaged trees.
Date: Tue, 26 Jul 2011 00:43:40 -0700 (PDT)
Message-ID: <m3ei1dsd1x.fsf@localhost.localdomain>
References: <1311487074-25070-1-git-send-email-jon.seymour@gmail.com>
	<7v1uxfwmq3.fsf@alter.siamese.dyndns.org>
	<CAH3AnrrVwodvtwWfaJCJqjuHThtv75jaWeDjvwRgdFbgXA3ziA@mail.gmail.com>
	<4E2DBA84.3090405@kdbg.org>
	<CAH3AnrrOdduUG_rS97fR_PRZAWb6y3uPa_oKDZenEX2gG-AvAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 09:44:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlcJ4-0003y1-Vo
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 09:43:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab1GZHnp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 03:43:45 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:52159 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab1GZHnn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 03:43:43 -0400
Received: by ewy4 with SMTP id 4so157045ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 00:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=2Y+Y8VZMrit/8+2VUBaaVffAGVQ4yFa+BJdqEq71sWE=;
        b=KR1+Z1jjmh7cknnwm6jEVsftqDhz1Ub6eYG5xAKeG88sWw5nT1oWT1zrqWkfwJuagA
         DRRzFf0tUZta82z+u3T5UCLA0Lsr0sTs/DQ9POGt8Zluo+qmqSeMfEv6DAioKrr7FZwW
         rYYzndFfivRFMZSL/F6CoMUSDt2xqGzsR++1M=
Received: by 10.213.108.78 with SMTP id e14mr652938ebp.123.1311666222023;
        Tue, 26 Jul 2011 00:43:42 -0700 (PDT)
Received: from localhost.localdomain (abvw23.neoplus.adsl.tpnet.pl [83.8.220.23])
        by mx.google.com with ESMTPS id g6sm152252eea.17.2011.07.26.00.43.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 00:43:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6Q7gxnY015029;
	Tue, 26 Jul 2011 09:43:10 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6Q7gaNP015018;
	Tue, 26 Jul 2011 09:42:36 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAH3AnrrOdduUG_rS97fR_PRZAWb6y3uPa_oKDZenEX2gG-AvAQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177846>

Jon Seymour <jon.seymour@gmail.com> writes:
> On Tue, Jul 26, 2011 at 4:48 AM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Am 25.07.2011 11:28, schrieb Jon Seymour:
>>> On Mon, Jul 25, 2011 at 4:35 AM, Junio C Hamano <gitster@pobox.com>=
 wrote:
>>>> Jon Seymour <jon.seymour@gmail.com> writes:
>>
>> The fundamental preconditions of bisection are: that there is a sing=
le
>> event in the sequence, and that the effects of the event propagate t=
o
>> the end of the sequence.
>=20
> More correctly: the fundamental pre-condition of a single round of
> bisection finding an event of interest is as you say.
>=20
> There is nothing that prevents multiple rounds of bisection being
> used, if required.

No, it is not true.  Think of bisection as in original application, as
numerical methods used to find root of one dimensional function.  It
works if there is single root between starting endpoints, or rather if
endpoints have different signs.

Which means that it works in this case:


                        bad bad bad
                   BAD
   good good good


but won't work in this case:



   good good good               good good good
                   bad bad bad

--=20
Jakub Nar=EAbski
