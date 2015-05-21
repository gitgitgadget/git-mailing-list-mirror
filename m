From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/4] ref-filter: add ref-filter API
Date: Thu, 21 May 2015 23:00:04 +0530
Message-ID: <555E161C.1080504@gmail.com>
References: <555C88C2.8060902@gmail.com>	<1432127904-21070-2-git-send-email-karthik.188@gmail.com> <CAPig+cTiYk_oGj98QttMMDjyJDFV256yOwu9b8_znOMnaMt7-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Christian Couder <christian.couder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 21 19:30:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvUIR-0002NR-7X
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 19:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbbEURaK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 13:30:10 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:33059 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216AbbEURaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 13:30:09 -0400
Received: by pdbqa5 with SMTP id qa5so115058333pdb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cWgy3zzRZF03MMKHAN04GTkES9XE9QNffsF+22ZySMU=;
        b=0fHOb38dcLKyOjKdmiaO0TFPEXcZmrMs/V/UETQ52/dnXcK2sJlsH6DyHlXexH1kh2
         pvQychqd1NgvD+3n87rtuCWDo0bzPLD/9eqB2dero1sxDsidbJwK5fo0kzJsVKiB4306
         e5+HJNNtrav4w8iUVeesgoWpaLi1kyHqlty8wecVEcVs39sQe48S/88i5NR/x4a8L07J
         RBxK5LcxPWnPFlLsV5Dd92FVqzi3HSF/onCC2Sn+YjryXkruieAaAf+9NtF49Q5WiI/F
         QNYAevvdsD8EmNN981BWRKyYbe2ZhtYNdQqYRnbQV2uSogTeziogE7WbGszd6fZfywxQ
         ao5A==
X-Received: by 10.68.247.166 with SMTP id yf6mr7598246pbc.3.1432229408627;
        Thu, 21 May 2015 10:30:08 -0700 (PDT)
Received: from [192.168.0.104] ([103.227.98.178])
        by mx.google.com with ESMTPSA id jt2sm19799618pbc.21.2015.05.21.10.30.06
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2015 10:30:08 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAPig+cTiYk_oGj98QttMMDjyJDFV256yOwu9b8_znOMnaMt7-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269620>

On 05/21/2015 12:37 AM, Eric Sunshine wrote:
> On Wed, May 20, 2015 at 9:18 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> add a ref-filter API to provide functions to filter refs for listing.
>> This will act as a common library for commands like 'tag -l',
>> 'branch -l' and 'for-each-ref'. ref-filter will enable each of these
>> commands to benefit from the features of the others.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>   Makefile     |  1 +
>>   ref-filter.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   ref-filter.h | 47 ++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 121 insertions(+)
>>   create mode 100644 ref-filter.c
>>   create mode 100644 ref-filter.h
>
> A shortcoming of this approach is that it's not blame-friendly.
> Although those of us following this patch series know that much of the
> code in this patch was copied from for-each-ref.c, git-blame will not
> recognize this unless invoked in the very expensive "git blame -C -C
> -C" fashion (if I understand correctly). The most blame-friendly way
> to perform this re-organization is to have the code relocation (line
> removals and line additions) occur in one patch.
>
> There are multiple ways you could arrange to do so. One would be to
> first have a patch which introduces just a skeleton of the intended
> API, with do-nothing function implementations. A subsequent patch
> would then relocate the code from for-each-ref.c to ref-filter.c, and
> update for-each-ref.c to call into the new (now fleshed-out) API.
>

Did you read Junio's suggestion on how I should re-order this WIP patch 
series ?
That's somewhat on the lines of what you're suggesting. I'll probably be 
going ahead with that, not really sure about how blame works entirely so 
what do you think about that?
