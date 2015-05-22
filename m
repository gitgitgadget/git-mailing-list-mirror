From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Fri, 22 May 2015 18:00:22 +0530
Message-ID: <555F215E.2050607@gmail.com>
References: <555C88C2.8060902@gmail.com>	<1432127904-21070-2-git-send-email-karthik.188@gmail.com>	<CAPig+cTiYk_oGj98QttMMDjyJDFV256yOwu9b8_znOMnaMt7-A@mail.gmail.com>	<555E161C.1080504@gmail.com> <CAPig+cTT+MEUtRJ6=sf5x-q0S2neL=xeNq_gEQAEy4VSRZga7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 22 14:30:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvm5u-0007xB-TA
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 14:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935AbbEVMa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 08:30:27 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34998 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756032AbbEVMaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 08:30:25 -0400
Received: by pacwv17 with SMTP id wv17so18708321pac.2
        for <git@vger.kernel.org>; Fri, 22 May 2015 05:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=9nVcW0qdBtrQj03I+wAmFYxQVu7lL3iOJWcqlQcqDuM=;
        b=jgme951uko7Nymo2Ry3ldVCdeawdG1qsiNNG2VTIHV4MfhhYHWgtCXlLy0B0qTgkJ/
         /mSqKyuXb9Y9/82v/M45VBVCgjndfIc2JxPWZdUuCZIKloUO3sZbLnz6qf62PT5LD+Aj
         1Nl2iWqbzlSVYiM5DSNBEAaN0xZZQ+Ah494NHJlQ/rfVBMUHTgzx30nawrgLZxQgjy06
         8Bqwe7IwGT8DSnu/36YYpUo2nTHZRCwQSP85uogETiodSop+e/gSYJ4QWVyAwGZZdoHn
         Mr08AZWyLqpVcjOl0n9IadK/ZUgH50Unyi+6RmrWgeXA58vZbbpnK7j4uLK0bYOLnvVZ
         il8Q==
X-Received: by 10.70.129.17 with SMTP id ns17mr15423017pdb.12.1432297825445;
        Fri, 22 May 2015 05:30:25 -0700 (PDT)
Received: from [192.168.0.104] ([106.51.130.23])
        by mx.google.com with ESMTPSA id m4sm2058954pdo.78.2015.05.22.05.30.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2015 05:30:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cTT+MEUtRJ6=sf5x-q0S2neL=xeNq_gEQAEy4VSRZga7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269707>



On 05/22/2015 12:10 AM, Eric Sunshine wrote:
> On Thu, May 21, 2015 at 1:30 PM, karthik nayak <karthik.188@gmail.com> wrote:
>> On 05/21/2015 12:37 AM, Eric Sunshine wrote:
>>> On Wed, May 20, 2015 at 9:18 AM, Karthik Nayak <karthik.188@gmail.com>
>>> wrote:
>>>>    Makefile     |  1 +
>>>>    ref-filter.c | 73
>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>    ref-filter.h | 47 ++++++++++++++++++++++++++++++++++++++
>>>>    3 files changed, 121 insertions(+)
>>>>    create mode 100644 ref-filter.c
>>>>    create mode 100644 ref-filter.h
>>>
>>> A shortcoming of this approach is that it's not blame-friendly.
>>> Although those of us following this patch series know that much of the
>>> code in this patch was copied from for-each-ref.c, git-blame will not
>>> recognize this unless invoked in the very expensive "git blame -C -C
>>> -C" fashion (if I understand correctly). The most blame-friendly way
>>> to perform this re-organization is to have the code relocation (line
>>> removals and line additions) occur in one patch.
>>>
>>> There are multiple ways you could arrange to do so. One would be to
>>> first have a patch which introduces just a skeleton of the intended
>>> API, with do-nothing function implementations. A subsequent patch
>>> would then relocate the code from for-each-ref.c to ref-filter.c, and
>>> update for-each-ref.c to call into the new (now fleshed-out) API.
>>
>> Did you read Junio's suggestion on how I should re-order this WIP patch
>> series ?
>> That's somewhat on the lines of what you're suggesting. I'll probably be
>> going ahead with that, not really sure about how blame works entirely so
>> what do you think about that?
>
> Yes, Junio's response did a much better job of saying what I intended.
> Also, his response said something I meant to mention but forgot:
> namely that, to ease the review task, code movement should be pure
> movement, and not involve other changes.
>
> Anyhow, follow Junio's advice. He knows what he's talking about. ;-)
>

Alright, Thanks for clearing that out.

Regards,
Karthik
