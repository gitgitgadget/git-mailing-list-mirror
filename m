From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v3 2/2] blame: use a helper to get suitable blame_date_width
Date: Tue, 22 Apr 2014 20:25:36 +0800
Message-ID: <CANYiYbGjyEHD_VC4jWVt5dvb6x2aCwpydmvKO9kwh5OW26iAMg@mail.gmail.com>
References: <cover.1398059411.git.worldhello.net@gmail.com>
	<17454bdfbd4e0e1516a64f75deabddb427792e99.1398059411.git.worldhello.net@gmail.com>
	<xmqqfvl6a9ar.fsf@gitster.dls.corp.google.com>
	<xmqq38h6a3sk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Brian Gesiak <modocache@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 14:25:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcZlf-0008N7-5x
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 14:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbaDVMZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 08:25:39 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:53921 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932195AbaDVMZh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 08:25:37 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so3150093wiv.3
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=j0pUno8NiHh4gvjsjmUaLe4DcSSNaAUcCY+BmxTZkmU=;
        b=x7Q/4JojrQFEI+rH+cEfZY9RVbNWmX6Bdy54qbJxMilTbyd185PQrr/0g1xLSbP3fb
         cjzDR3w4vgY74MbUmRWwa/0TIUDNpJyEVYqN1Eltc1q9J1lQdFxccBFIwtTzYSZ4Lcok
         LMvQVpERc+IYKjJL7kc2bSE/P0TdKVOBUqGFvrjz2yxq/7KQiBBwfGFu9zaw2i9w8bLU
         wjU+yqnc6ka1muOw5Y4rouD5SDTzhgu429RtWzZDQTjUkpOXtJ85u+16p/5BN3YqXJ6y
         5XSTfxdANzg20IxQRxDbbj7ybg5dvUEYhvRuMIK2VBUgQ0qK94tU8/mgLkuNykTeLcC9
         KbBA==
X-Received: by 10.181.9.65 with SMTP id dq1mr18514856wid.51.1398169536729;
 Tue, 22 Apr 2014 05:25:36 -0700 (PDT)
Received: by 10.217.58.65 with HTTP; Tue, 22 Apr 2014 05:25:36 -0700 (PDT)
In-Reply-To: <xmqq38h6a3sk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246734>

2014-04-22 3:19 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> What I am wondering is if we can do something
>> like this:
>> ...
>
> Nah, that is a lot more stupid than just doing
>
>>     In code:
>>
>>         blame_date_width = strtoul(_("4 years, 11 months ago"), NULL, 10) + 1;
>>
>>     In git.pot:
>>
>>         #. This string is used to tell us the maximum display width for a
>>         #. relative timestamp in "git blame" output.  For C locale, "4 years,
>>         #. 11 months ago", which takes 22 places, is the longest among various
>>         #. forms of relative timestamps, but your language may need more or
>>         #. fewer display columns.
>>         msgid "4 years, 11 months ago"
>>         msgstr ""
>>
>>     In de.po:
>>         #. This string is used to tell us the maximum display width for a
>>         #. relative timestamp in "git blame" output.  For C locale, "4 years,
>>         #. 11 months ago", which takes 22 places, is the longest among various
>>         #. forms of relative timestamps, but your language may need more or
>>         #. fewer display columns.
>>         msgid "4 years, 11 months ago"
>>         msgstr ""vor 4 Jahren, und 11 Monaten"
>
> which is essentially how your very original looked like (modulo the
> comments).  So let's not try to be clever or cute, and just have a
> good instruction in the TRANSLATORS comments.
>
> Sorry for flipping and flopping on this one.

I will send patch v4 tonight, and I think all l10n team leaders should
pay attention
to this thread:

 * http://thread.gmane.org/gmane.comp.version-control.git/246464

-- 
Jiang Xin
