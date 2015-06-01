From: Phil Susi <psusi@ubuntu.com>
Subject: Re: git-repack keeps running out of memory
Date: Mon, 01 Jun 2015 15:07:16 -0400
Message-ID: <556CAD64.8000208@ubuntu.com>
References: <556CA6C8.6000804@ubuntu.com> <xmqqlhg35ky2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 21:11:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzV7X-0005zd-0T
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 21:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbbFATLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 15:11:30 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36000 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbbFATIm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 15:08:42 -0400
Received: by qkx62 with SMTP id 62so88980313qkx.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 12:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bFekQY/Z52Mdpisf7EQDQu6ftkZnPOtuFln+JVqOdxo=;
        b=mL3Ds3asOQSS/K+cNsLzXwdeObmlde78Wo89cal79bNHx3ymV1rZOOZ12qlsyG7Rgm
         Bs5aJ/Ct5TfJWX7hVwF7aNeihxiPRKYsKgZkG7f1teZ6lqEBoysrSoxccrB3/KW7Jr21
         LHWU/QvYxegjj026o7mF1kLfmaivIOAA9Ve8cs8TLkjtEMTL6lmxaaX8kPq5aLU76W2R
         Ni1B+ffCWZoMbTRsvYVkGJz1Y700/okFU3y80wrkb+SoS+2dIHIpvuPQhYzROlKQdjCy
         h9ISguQp4D9OaMUjx5aswdOATi1LBanM1DPuesk3a/IbKI0vZlZFqTDLZfRPQK/21AAI
         yOWg==
X-Received: by 10.55.23.84 with SMTP id i81mr40475470qkh.90.1433185720275;
        Mon, 01 Jun 2015 12:08:40 -0700 (PDT)
Received: from [10.1.1.233] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id a70sm6482104qge.3.2015.06.01.12.08.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2015 12:08:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqlhg35ky2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270461>

On 6/1/2015 2:43 PM, Junio C Hamano wrote:
> Phil Susi <psusi@ubuntu.com> writes:
>
>> I keep having git-repack run out of virtual memory ( 32 bit system )
>> when trying to repack my linux kernel repo.  It keeps making it right
>> up to 99% then barfing saying mmap failed: Cannot allocate memory.
>>
>> I thought I could help this by limiting the pack size, and using
>> --window-memory to limit the memory usage, but it still happens with
>> this full command line:
>>
>> git repack -a -d --max-pack-size=500m -f -F --depth=20 --window=250
>> --window-memory=500m
>>
>> The key factor seems to be the --window... with 50 it works fine, but
>> with 100 or more, even with the very low --window-memory limit, it
>> crashes.
>
> Unfortunately, that is totally expected.  Window tells us to keep
> enough information to compare with that many objects in-core.  I do
> not think max-pack-size would affect much.

It's more the --window-memory argument that is important here: it is 
supposed to prevent exactly this problem.  I guess I tried adding the 
--max-pack-size as well on the off chance that it would help.
