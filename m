From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/6] git-p4: retry kill/cleanup operations in tests
 with timeout
Date: Tue, 17 Nov 2015 03:35:14 -0500
Message-ID: <CAPig+cR8igO1bWNgma_yZqrcru_jnKchpRH+i2_AaNj8Atcb9g@mail.gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
	<1447592920-89228-4-git-send-email-larsxschneider@gmail.com>
	<CAPig+cQkNB3VzbC_R_T=ppkgvmTbOWnK22hFxyMzJH1DZ_iVhQ@mail.gmail.com>
	<52A9F66D-12C4-4BB5-A2D4-C476A1E12DC5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:35:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZybjX-0007qu-8o
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 09:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752670AbbKQIfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 03:35:16 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35655 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940AbbKQIfP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 03:35:15 -0500
Received: by vkas68 with SMTP id s68so945580vka.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 00:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DlTtfNIEnmcT+41ztoYvK001ogdEGp7AOwvb7vR2lqU=;
        b=RjuL4fjiRv7spkJTUMq+CznhBQevgU1MQmngLWkwIIIv56ZUQLZLV/cDVOhkczEVT7
         rRLM1eKFxXViQ5UJdN+ZodjYSubNFzCojBUXARCrQShM190Fz2Pv1nzoYOQbnGxniJKR
         1loXfgl/DFShLEefW6QxeAey3if7UwplqEXjMdiIKrhumQHQcwqe1Tx4BSo7snunxAQH
         zCD+t48PHP1ws18dCntutlVEVw7kKbcRimOWw5dfBXunUkGepsTvYLN3le8ZBP4YyJ/o
         jFGE2JCqVlxyEW0+IwwUkbOu2v1bmd5wPAtN0KEUgX7Jd/wpofxfmTqHfJ/4hHvMhxbn
         fLpA==
X-Received: by 10.31.159.137 with SMTP id i131mr2431386vke.151.1447749314805;
 Tue, 17 Nov 2015 00:35:14 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Tue, 17 Nov 2015 00:35:14 -0800 (PST)
In-Reply-To: <52A9F66D-12C4-4BB5-A2D4-C476A1E12DC5@gmail.com>
X-Google-Sender-Auth: nUM_uVpALZbctloof_Urfvyj9bI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281391>

On Tue, Nov 17, 2015 at 3:28 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> On 16 Nov 2015, at 22:14, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Sun, Nov 15, 2015 at 8:08 AM,  <larsxschneider@gmail.com> wrote:
>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>
>>> In rare cases kill/cleanup operations in tests fail. Retry these
>>> operations with a timeout to make the test less flaky.
>>>
>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>> ---
>>> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
>>> @@ -121,22 +125,33 @@ p4_add_user() {
>>>        EOF
>>> }
>>>
>>> +retry_until_success() {
>>> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
>>
>> There was some discussion previously[1] about detecting dynamically
>> whether 'date +%s' was supported. Was this something that you intended
>> to do, or did you decide against it since p4 is not supported on such
>> platforms?
>>
>> Same question also applies to patch 4/6.
>
> While implementing it I thought more about it. P4D is only
> supported on platforms that support the date function. That means
> these tests will only run on platforms that support the date
> function. Consequently I wondered if this would justify the
> slightly more complicated code. However, if you think this change
> would help the patch to get accepted then I will add it.

I don't feel strongly about it, and it's not my call anyhow. Opinions
of Junio, Peff (as interim maintainer), and Luke weigh much more
heavily than my own. Punting on dynamic detection of "date +%s" may be
perfectly acceptable with the attitude that it can be implemented
later if someone runs across a case where it's actually needed.
