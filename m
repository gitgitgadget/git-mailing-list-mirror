From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC/PATCH 1/5] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Tue, 9 Nov 2010 11:38:17 +0100
Message-ID: <AANLkTik5vmgx6RFHavVVkJLfEDvZFRRkmAMTfQpCo5Z4@mail.gmail.com>
References: <AANLkTikOgMGqw5fc95c2VGwXxKu9rmsA+=z5_jykD92=@mail.gmail.com>
 <1288524860-538-2-git-send-email-avarab@gmail.com> <4CCFCCC8.7080603@viscovery.net>
 <AANLkTimjRwSxkemMffASvHCxK009b1fnvNRs05_T_1DF@mail.gmail.com>
 <4CD8F965.6050402@viscovery.net> <AANLkTinKYJtaDjwEk0OqebBnL6+wvVO4wfWg7G-VYh7d@mail.gmail.com>
 <4CD918AB.6060206@viscovery.net> <AANLkTi=23MXbZeBF=eJLRnQycx4Bdg_an2aa_3oGWR66@mail.gmail.com>
 <4CD9241F.6070807@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 11:38:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFlbB-0007fu-Aq
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 11:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335Ab0KIKil convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 05:38:41 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37788 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab0KIKij convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 05:38:39 -0500
Received: by fxm16 with SMTP id 16so4806361fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 02:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=BkDkThFRqoEYlhWBvkiiEnutDGMnfEhtZAI+r5eI/2Y=;
        b=o1nPPIayH5Or5/LaZB9rhK+2OLyhe44siQVfCBI8uyhDGF1IwrAfgj+qOkYCqmEt6+
         CGknHq+8Lh0gy6c5SrHA+5TocLMAUBlHf/os9imu2Lg9Om2ZW4Di7f+bXrLV8NPMMJRx
         mlZa0dCuHMqJ20vzIqXfh+Ng+d2mZS0k2xYBY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=xZbiOHqxz8afNhpWtafQOmO0a8fFlL/FIo6fBzbaHNQKhwKkfOqCb4DX/i1JToUdyV
         LwHkzXlrzFA914+tIHPUbdYZLwzro9SzSGqvuEVuGBav4Xdm5rUwfnZl636e61omo9af
         wxzZEU4ApfQTWh6hKR3daOvRjQ15k44cNOUxY=
Received: by 10.223.83.196 with SMTP id g4mr4972571fal.63.1289299118075; Tue,
 09 Nov 2010 02:38:38 -0800 (PST)
Received: by 10.223.96.66 with HTTP; Tue, 9 Nov 2010 02:38:17 -0800 (PST)
In-Reply-To: <4CD9241F.6070807@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161032>

On Tue, Nov 9, 2010 at 11:36 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 11/9/2010 10:49, schrieb =C6var Arnfj=F6r=F0 Bjarmason:
>> On Tue, Nov 9, 2010 at 10:47, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
>>> Am 11/9/2010 10:35, schrieb =C6var Arnfj=F6r=F0 Bjarmason:
>>>> Why is that a "*must*"?
>>> ...
>>>> But maybe you have reason to think otherwise? I haven't noticed an=
y
>>>> noticable slowdowns from doing it this way, but maybe I've been
>>>> looking at the wrong thing.
>>>
>>> You didn't do your timings in Windows, did you? Every fork() that y=
ou can
>>> avoid is a win.
>>
>> What's the result of timing it on Windows?
>
> I do not have gettext, hence, I test 'git version' as a reference:
>

Try this branch if you're interested:

git://repo.or.cz/msysgit/kusma.git work/gettext
