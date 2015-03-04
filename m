From: Anton Trunov <anton.a.trunov@gmail.com>
Subject: Re: [PATCH] xmerge.c: fix xdl_merge to conform with the manual
Date: Wed, 04 Mar 2015 12:55:33 +0300
Message-ID: <54F6D695.7030109@gmail.com>
References: <1425404233-89907-1-git-send-email-anton.a.trunov@gmail.com>	<54F616DD.8040904@web.de> <CAPig+cQSNLH2poz-gtrsTd5XWpUgDh6a9APfj3K7TC78trf6xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>, charles@hashpling.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXI=?= =?UTF-8?B?c2hhdXNlbg==?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 04 10:55:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT618-0006ri-2R
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 10:55:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760996AbbCDJy4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2015 04:54:56 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:43589 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758337AbbCDJyw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 04:54:52 -0500
Received: by labgf13 with SMTP id gf13so18745554lab.10
        for <git@vger.kernel.org>; Wed, 04 Mar 2015 01:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hrERG4ZZKD4aYMkh64QT+ulHaGK4RGPZCR3OASnWyYc=;
        b=joKgv5U6f6I8rC2HcGduu1r3GsMaGKIHWWYeN8FXpU3MLiGZ6xqfAKLMKPcJSr0VXw
         pnC6gUFpet2vJxCfU5whI8DDsNyo56uZvu/tg6ozfJP1Wb3MxXWaC2udia8Iu+G4t+Ij
         XYya8WNoVe2NafAytQHicRKOSD3LBjUYe9mNe3hW7y9yLgdWBaS8HCSHg45xOJ5WDwxx
         D/3vyVW60PxN1s39kIjRxZ94vfl3a8vpO2t3zns9o8wj3p0TticDPvbN6bsogFouCOyV
         ROiDd1m6shjg6nomA9nCopQ68Mtfd1ewECek+77SZycyL1pUoNnpgOvMFsKq9rYjOHGD
         LS5w==
X-Received: by 10.152.1.1 with SMTP id 1mr2510519lai.63.1425462891129;
        Wed, 04 Mar 2015 01:54:51 -0800 (PST)
Received: from [192.168.1.185] ([195.191.146.16])
        by mx.google.com with ESMTPSA id aj6sm674431lbc.13.2015.03.04.01.54.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2015 01:54:50 -0800 (PST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAPig+cQSNLH2poz-gtrsTd5XWpUgDh6a9APfj3K7TC78trf6xA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264742>

On 04/03/15 10:07, Eric Sunshine wrote:
> On Tue, Mar 3, 2015 at 3:17 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
>> On 2015-03-03 18.37, Anton Trunov wrote:
>> []
>>> Signed-off-by: Anton Trunov <anton.a.trunov <at> gmail.com>
>> Should we use the "real email" here (with the '@') ?
>>> ---
>>> diff --git a/t/t3032-merge-recursive-options.sh b/t/t3032-merge-rec=
ursive-options.sh
>>> index 4029c9c..4cbedb4 100755
>>> --- a/t/t3032-merge-recursive-options.sh
>>> +++ b/t/t3032-merge-recursive-options.sh
>>> @@ -204,4 +204,47 @@ test_expect_success '--ignore-space-at-eol' '
>>>       test_cmp expected actual
>>>  '
>>>
>>> +# Setup for automerging with whitespace-only changes
>>> +# on both sides and in *all* lines
>>> +
>>> +test_expect_success 'setup: w/s only changes in all lines on both =
sides' '
>>> +     git rm -rf . &&
>>> +     git clean -fdqx &&
>>> +     rm -rf .git &&
>>> +     git init
>> missing &&
>>> +
>>> +     echo " two words" >text.txt &&
>>> +     git add text.txt &&
>>> +     test_tick &&
>>> +     git commit -m "Initial revision" &&
>>> +
>>> +     git checkout -b remote &&
>>> +     echo " \t\ttwo     words  " >text.txt &&
>=20
> Use of echo "\t" is not portable. Either embed literal tab characters
> or use printf "\t".
OK.
Shouldn't it be printf "\t\n" for exact substitute for echo "\t"?

>>> +     git commit -a -m "remote: insert whitespace only" &&
>>> +
>>> +     git checkout master &&
>>> +     echo "    two words" >text.txt &&
>>> +     git commit -a -m "master: insert whitespace only"
>>> +'
>>> +
>>> +test_expect_success 'w/s only in all lines: --ignore-space-change =
preserves ours' '
