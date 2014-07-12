From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH v3] http: Add Accept-Language header if possible
Date: Sun, 13 Jul 2014 03:52:39 +0900
Message-ID: <CAFT+Tg8HfoFO8T+EJ6DiMj6kRO8h0P7tO2PHTK9BFMMe+Ld_Vg@mail.gmail.com>
References: <1405097573-19239-1-git-send-email-eungjun.yi@navercorp.com>
	<20140711173544.GB7856@sigill.intra.peff.net>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Yi EungJun <eungjun.yi@navercorp.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Peter Krefting <peter@softwolves.pp.se>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 20:52:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X62Pc-0006Q9-1U
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 20:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbaGLSwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2014 14:52:40 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:44706 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbaGLSwj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2014 14:52:39 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so2026937iec.30
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=YlWa1XuJmFgdGI952plAsFwyIfmCcmjQvUSb/IOilBc=;
        b=MNPYV810zb0hjoVc1MRKm334sOxvJM0cnf6CwbPzyRRlokNwyuMSLNVu3jO5Ex7gcn
         /wENioNtPgzDaZqZsiXkTJY2Lfv10lp3jXffvM92IYNOGIsUfdIazGwc669wq9Eysehj
         xglwq5wkT9MaRMoZZmNPDtKXSw3Q2a9gwjaQFLZWUoPPwWEDp5H+N8IYwa9HawTf5bPi
         6TnXrr1D+R3RFQOIcbT7xF4FzxO9kcdHwgXvlYePRDMJhbiHGJyODIA9mwTTRSQFtnDC
         GyX2CFCnZuPBSLqHCIyo5vWjvjrvRrpL8opuznNzxsAkQvFmBVGduIdXZAYiNGdbtzVM
         7e5A==
X-Received: by 10.50.33.16 with SMTP id n16mr10892567igi.15.1405191159118;
 Sat, 12 Jul 2014 11:52:39 -0700 (PDT)
Received: by 10.50.153.110 with HTTP; Sat, 12 Jul 2014 11:52:39 -0700 (PDT)
In-Reply-To: <20140711173544.GB7856@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253398>

Thanks for your detailed review and nice suggestions. I will accept
most of them.

2014-07-12 2:35 GMT+09:00 Jeff King <peff@peff.net>:
>> +     /* Decide the precision for q-factor on number of preferred languages. */
>> +     if (num_langs + 1 > 100) { /* +1 is for '*' */
>> +             q_precision = 0.001;
>> +             q_format = "; q=%.3f";
>> +     } else if (num_langs + 1 > 10) { /* +1 is for '*' */
>> +             q_precision = 0.01;
>> +             q_format = "; q=%.2f";
>> +     }
>
> I don't mind this auto-precision too much, but I'm not sure it buys us
> anything. We are still setting a hard-limit at 100, and it just means we
> write "0.1" instead of "0.001" sometimes.

It means we use "0.1" if possible.

>From my observation, many major web browsers doesn't or didn't send
q-factor of 2 or 3 decimal places. Google chrome doesn't currently and
Mozilla firefox also didn't before 2012 [1]. I think it means some old
and naive web servers may not support q-factor of 2 or 3 decimal
places because major web browsers don't send it. So I think we should
use "0.1" if possible for interoperability with the buggy servers.

But, quite frankly, it is just a possibility and I have no evidence
which proves that such kind of buggy servers really exist. Please let
me know if anybody know about it.

[1]: http://hg.mozilla.org/integration/mozilla-inbound/rev/b0b07ef904ea
