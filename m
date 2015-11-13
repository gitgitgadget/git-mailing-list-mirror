From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Fri, 13 Nov 2015 09:46:42 +0100
Message-ID: <71B4BDE3-153C-4918-A23A-F45F0228A988@gmail.com>
References: <56428A6A.5010406@ramsayjones.plus.com> <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com> <CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com> <56437F96.2070209@ramsayjones.plus.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 09:46:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxA0S-0003Ld-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 09:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbbKMIqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 03:46:47 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33977 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbbKMIqq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Nov 2015 03:46:46 -0500
Received: by wmvv187 with SMTP id v187so70392960wmv.1
        for <git@vger.kernel.org>; Fri, 13 Nov 2015 00:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G2jxsT30T1y2vQLFizv+QBgqViqRrHaAOjqD5s6pIi8=;
        b=FYgAdkpMyGIE56Is0GnWHWQAm0eS32jS2eJ3WhX7Dw+K0doqbzZKCj6twliGS5xIiQ
         lbE1lc3GEVlO8VRUfG2cpUwnfdnPVYFHA1Jb1v4OyA95iRVvE6EYaY7DxiB3w4LFXM0s
         kxxxO4TCEMSPXbrYnSoBkyO2XYPV+2suY9GcRlmT9MbovLpAYqm95R8N/GwY2blCArpH
         V7NLnPkwRdnohPOAn023zarc+7PXs38d7sCzBpVRWFSIAfUllvwz0cGGLUIhho0roVEY
         QIrw7UmNHEpG9KTlJaWttzBFqacgRX941Uoj42gojNSqQJxxfvXEvKhyW1avGlwnxHnK
         nAHA==
X-Received: by 10.28.129.131 with SMTP id c125mr2223534wmd.21.1447404405082;
        Fri, 13 Nov 2015 00:46:45 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB532F.dip0.t-ipconnect.de. [93.219.83.47])
        by smtp.gmail.com with ESMTPSA id 71sm2837679wmm.24.2015.11.13.00.46.43
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 13 Nov 2015 00:46:44 -0800 (PST)
In-Reply-To: <56437F96.2070209@ramsayjones.plus.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281244>


On 11 Nov 2015, at 18:49, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:

> 
> 
> On 11/11/15 02:00, Stefan Beller wrote:
>> On Tue, Nov 10, 2015 at 5:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
>>> <ramsay@ramsayjones.plus.com> wrote:
>>>> Commit f8117f55 ("http: use off_t to store partial file size",
>>>> 02-11-2015) changed the type of some variables from long to off_t.
>>>> The 32-bit build, which enables the large filesystem interface
>>>> (_FILE_OFFSET_BITS == 64), defines the off_t type as a 64-bit
>>>> integer, whereas long is a 32-bit integer. This results in a couple
>>>> of printf format warnings.
>>>> 
>>>> In order to suppress the warnings, change the format specifier to use
>>>> the PRIuMAX macro and cast the off_t argument to uintmax_t. (See also
>>>> the http_opt_request_remainder() function, which uses the same
>>>> solution).
>>> 
>>> I just ran across the problem when building 'next' on my Mac and was
>>> about to investigate, so am happy to find that the work has already
>>> been done. Thanks.
>>> 
>>> My machine is 64-bit, though, so perhaps it's misleading to
>>> characterize this as a fix for 32-bit builds. In particular, off_t is
>>> 'long long' on this machine, so it complains about the "long" format
>>> specifier.
>> 
>> +Lars
>> 
>> I wonder if 32 bit compilation can be part of travis.
>> 
> 
> Did this warning show up on the OS X build?

Yes, I added CFLAGS="-Werror=format" to the my experimental TravisCI build and it breaks the build on OS X.
See here (you need to scroll all the way down):
https://travis-ci.org/larsxschneider/git/jobs/90899656

BTW: I tried to set "-Werror" but then I got a bunch of macro redefined errors like this:
./git-compat-util.h:614:9: error: 'strlcpy' macro redefined [-Werror]

Is this a known issue? Is this an issue at all?

Thanks,
Lars