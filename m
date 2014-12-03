From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Deprecation warnings under XCode
Date: Wed, 3 Dec 2014 13:16:21 -0500
Message-ID: <CAPig+cQHjAtBBGMJGFj6YH1dmW+akY0eg_i+jbOz-khirwa2bA@mail.gmail.com>
References: <CAO2U3Qg4DVxSk2u1eJwGqYoxVZTbWRV69J9HTo1rnjFCxSyi2g@mail.gmail.com>
	<547BFD42.3040104@web.de>
	<xmqqoarnp7p2.fsf@gitster.dls.corp.google.com>
	<CAPig+cRvGaFJQZZ8CDeMMB6u1NKtqUrfe1aWC0OUG3xF9Nu34g@mail.gmail.com>
	<CAO2U3QiwJ=EZBModED6jR2YuF5NMVvrUkzj1iOGMLAqwKNbw3A@mail.gmail.com>
	<CAPig+cRj5bLrkperGiDHG78KghiGgkMAT=Qihia2FR8psEQxvQ@mail.gmail.com>
	<20141203100415.GA4893@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Blume <blume.mike@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git List <git@vger.kernel.org>,
	Bernhard Reiter <ockham@raz.or.at>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 19:16:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwETS-0003v0-O7
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 19:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbaLCSQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 13:16:23 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:44470 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173AbaLCSQW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 13:16:22 -0500
Received: by mail-yk0-f180.google.com with SMTP id 9so7202153ykp.11
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 10:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=kHXfEScQWSyhz5W+UarkA4eK2xbafLSRGEXS+SF3VHg=;
        b=P0HV2BPNTYqIW+KQPSN2Bjc3ef0vBdtIPpNPS9lhQKvSxRY16dj6pYQZbhj24twmA0
         u903qotW33gQ5wWKrUBYFixn81KoX98qJuVtDE4S3xzZ+N/kPDM48XcLHg1VZ1v242ev
         kKA7PTUo5KAipPYGeeqYOde360huThVzgixHHbr0wVKR/WCU1ZVWKubGNkunNW2mwlTg
         +mRNXhSBiT/3UIU/HHfy9r7Can44WmBiZRuWYOS9FDLTZTMVML0RPJuxWWfiYORoJJss
         FoJCN9KENsLLn79ONm2WuHBTNZovAebWG4YPk8w14FcvdZdkQRF822YR1o50IoqCCBQW
         sr1A==
X-Received: by 10.170.41.131 with SMTP id 125mr8716699ykj.85.1417630581455;
 Wed, 03 Dec 2014 10:16:21 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Wed, 3 Dec 2014 10:16:21 -0800 (PST)
In-Reply-To: <20141203100415.GA4893@gmail.com>
X-Google-Sender-Auth: ECGA3RQCD0BW0ulGNiVztcodA4U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260675>

On Wed, Dec 3, 2014 at 5:04 AM, David Aguilar <davvid@gmail.com> wrote:
> On Tue, Dec 02, 2014 at 10:09:35PM -0500, Eric Sunshine wrote:
>> The potentially lesser evil would be this small patch (minus Gmail
>> whitespace damage) which disables the deprecation warnings only for
>> Apple's headers:
>>
>> ----- >8 -----
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 400e921..709e84f 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -211,6 +211,8 @@ extern char *gitbasename(char *);
>>  #endif
>>
>>  #ifndef NO_OPENSSL
>> +#define __AVAILABILITY_MACROS_USES_AVAILABILITY 0
>> +#define MAC_OS_X_VERSION_MIN_REQUIRED MAC_OS_X_VERSION_10_6
>>  #include <openssl/ssl.h>
>>  #include <openssl/err.h>
>>  #endif
>> ----- >8 -----
>>
>> Considering that Mac OS X is now at 10.10 and these deprecations
>> commenced with Mac OS X 10.7 in July 2011 (3.5 years ago), and Apple
>> still has not provided drop-in CommonCrypto equivalents, it seems
>> unlikely that they will do so any time soon. Consequently, suppressing
>> these otherwise unavoidable warnings may be the best we can do.
>>
>> I'm willing to formalize and submit this as a proper patch if it's not
>> considered too disgusting by the powers-that-be.
>
> Tweaking those internal #defines can only come back to bite us
> in the future when the functions are finally ripped out.

If Apple ever does remove those deprecated functions, the build will
break badly regardless of whether or not the Apple-specific
deprecation warnings are suppressed. This patch does not make the
situation any worse, so I don't understand the argument.

If a full set of drop-in equivalents was available, on the other hand,
then your argument would make perfect sense, but it does not seem
apply to the current situation since there is no evidence that Apple
will be providing those replacements any time soon (or ever).
