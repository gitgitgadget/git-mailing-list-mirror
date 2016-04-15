From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 2/2] xdiff: implement empty
 line chunk heuristic
Date: Fri, 15 Apr 2016 14:15:17 -0700
Message-ID: <CA+P7+xqe4ng9-gn1DRqhjebRXuHXbqZ6f3QsJ798k6DRo3bYyQ@mail.gmail.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
 <20160415165141.4712-3-jacob.e.keller@intel.com> <CAGZ79ka7h25=rHun_hPv1qjqeghXt1UwUU3Q6xT0aj4+OW87fg@mail.gmail.com>
 <xmqq8u0ebpru.fsf@gitster.mtv.corp.google.com> <CA+P7+xoWbrSaONH5xq=w5W190Jknk0Qsc5brS4UKFAs2_dTceg@mail.gmail.com>
 <xmqqzisuaa3t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 23:15:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arB5j-0006Ja-Cn
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 23:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbcDOVPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 17:15:40 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36664 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbcDOVPi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 17:15:38 -0400
Received: by mail-ig0-f181.google.com with SMTP id f1so30136587igr.1
        for <git@vger.kernel.org>; Fri, 15 Apr 2016 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CcHZ7NSEJpxd/1s7j9MHp+EnTue5wA95wTgmAa30Kiw=;
        b=nfzCx6vcH50pTZvLA7qpWPY7iPd+8nIBxDgZhrV2sNPwzvweBqXBIx1sQqHJbPwRF2
         rEp0mKgBbynrNglUasvj85CR5Vxhi+8pXpq7N+ZiSHmnJvZi9v1/4FriZyh9FCdHkGgJ
         upEcTQvtzX59TyFKKA0kXUSUdXk1IoW0/0kMWJeW87LluEZKCjiUFLSTEFJzRPHL9g19
         Lb28fSWZ5Js6624dF84zQ9LTNRzqJ1kL14DJS8mm5QrRAEYkH8pjgq7NQjnCmAZICQ/r
         FH57sEOAeyP/+5HeYgRbPZRl0KCX0yBggXM6QbMv5rlUQ1riHbX+tBm8lMWrBRxNzE8a
         JWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CcHZ7NSEJpxd/1s7j9MHp+EnTue5wA95wTgmAa30Kiw=;
        b=LB1Ymo83XURT2icjJ8HCICna3V4GHv/dKkXHBvnc0Fjqqwi2D8czgHHT+DG1oVkxCl
         ZkToiUrcwJd+vTnd2t8uZA4WwBZhOC++Ea1CSNpKpdSnlf7bFbGVgsFo2OtjQI7L0rEr
         yvq+BM4FCx7ghgGhn6cVLb+ZrZvzQgSgweRWucn5RVr2ynmIWGUZQQ5zQI2RwkwCzuSD
         lfD+GiZOdjtJdgeNsLBtcfcFtzxvy5eCIpdW+k0VN2BeF+4vvRIaKwDZddKH9Oe0JiBf
         aK7bAh+CgS3MByqMtBqvfS9PtAwMoCQVRwVOTPWuEsRgA935kfjvE1gjHQVW9NF2W9oS
         jzcg==
X-Gm-Message-State: AOPr4FWTQPrUi+ON33CUJQXg4cIfiIu/px1G6+fg/XjSY/Wi0ZlB8VFAKggMfcaEe8AeUFd8srCl2Rf+EXl5NA==
X-Received: by 10.50.123.132 with SMTP id ma4mr7471886igb.92.1460754937305;
 Fri, 15 Apr 2016 14:15:37 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Fri, 15 Apr 2016 14:15:17 -0700 (PDT)
In-Reply-To: <xmqqzisuaa3t.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291664>

On Fri, Apr 15, 2016 at 1:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> On Fri, Apr 15, 2016 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> I actually do not think these knobs should exist when the code is
>>> mature enough to be shipped to the end users.
>>>
>>> Use "diff.compactionHeuristics = <uint>" as an opaque set of bits to
>>> help the developers while they compare notes and reach consensus on
>>> a single tweak that they can agree on being good enough, and then
>>> remove that variable before the code hits 'next'.
>>>
>>> Thanks.
>>
>> I was under the impression that we would want a longer lived
>> configuration until we had enough data to say whether it was
>> helpful to make it default. I guess i had thought it would need to
>> be longer lived since there may be cases where it's not optimal
>> and being able to turn it off would be good?
>
> Once you start worrying about "some cases this may misbehave", a
> configuration variable is a wrong mechanism to do so anyway.  You
> would need to tie this to attributes, so the users can say "use this
> heuristics for my C code, but do not apply it for my AsciiDoc
> input", etc.
>

I think this makes perfect sense to apply this as an attribute,
however.. why isn't the current diff algorithm done this way?

Thanks,
Jake

> What you have is a pure developer support; aim to come up with "good
> enough" way, giving developers an easier way to experiment with, and
> remove it before the feature is shipped to the end user.
