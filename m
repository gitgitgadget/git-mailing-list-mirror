From: tolga ceylan <tolga.ceylan@gmail.com>
Subject: Re: [PATCH] git-p4: format-patch to diff-tree change breaks binary
 patches
Date: Sat, 26 Apr 2014 14:12:24 -0700
Message-ID: <535C2138.3050400@gmail.com>
References: <20140425044618.GA7058@olive> <20140426124307.GB4767@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, cdleonard@gmail.com
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sat Apr 26 23:13:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1We9u9-0004Av-Pf
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 23:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbaDZVM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2014 17:12:28 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:60307 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaDZVM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2014 17:12:27 -0400
Received: by mail-pb0-f48.google.com with SMTP id md12so4406580pbc.7
        for <git@vger.kernel.org>; Sat, 26 Apr 2014 14:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=b3eRBj7CZ+bJZ9qiLd5rCaeHvNZ9yHq18oVjfAIrC9w=;
        b=ad9gticAE4QhLHddGoqI5GFM1meLovrutsdhk3pOCu/A8dx3c1p8ecY8Ehcd+6HacA
         Uavl3bH8T5fQBm16qTBqelcVTPKt4uCQ+tDfdjt1XkJInPkTaXjxFRS1d4ZKp5c+S4Xa
         TsIDWoz1yLft6ODWDWCbMzJXdp0IyKicuUaLlVMMIgqhBzsApnPOYkAZXWOEwgHm7cGA
         0NDa+TPyWB0fAOq2IXuNERQnr5lL4A9c/Cjsq+SogKvOGQKWzXX29Ve/0TgA8MSTWKlG
         nS1nIK+lNbVyPGSMeghwN6zA/degNFC5Z6nLfQ+Bv0vzPHO0JQs4IT8oBiT7+KqWRN62
         WO5w==
X-Received: by 10.68.170.66 with SMTP id ak2mr19628717pbc.5.1398546746854;
        Sat, 26 Apr 2014 14:12:26 -0700 (PDT)
Received: from [192.168.1.100] (c-98-210-144-148.hsd1.ca.comcast.net. [98.210.144.148])
        by mx.google.com with ESMTPSA id sv10sm24542389pbc.74.2014.04.26.14.12.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 26 Apr 2014 14:12:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140426124307.GB4767@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247185>

Yes, when git-p4 runs git-apply to test the patch, this fails
due to abbreviated blob object names. I think git-apply requires
full object names for binary patches.

On 04/26/2014 05:43 AM, Pete Wyckoff wrote:
> tolga.ceylan@gmail.com wrote on Thu, 24 Apr 2014 21:46 -0700:
>> When applying binary patches a full index is required. format-patch
>> already handles this, but diff-tree needs '--full-index' argument
>> to always output full index.
>>
>> Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
>> ---
>>   git-p4.py |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index cdfa2df..4ee6739 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1311,7 +1311,7 @@ class P4Submit(Command, P4UserMap):
>>               else:
>>                   die("unknown modifier %s for %s" % (modifier, path))
>>
>> -        diffcmd = "git diff-tree -p \"%s\"" % (id)
>> +        diffcmd = "git diff-tree --full-index -p \"%s\"" % (id)
>>           patchcmd = diffcmd + " | git apply "
>>           tryPatchCmd = patchcmd + "--check -"
>>           applyPatchCmd = patchcmd + "--check --apply -"
>> --
>
> This looks like a straightforward change, but can you give a
> bit more background on why a full index is required?  Do you
> mean that "git apply" will reject a patch with abbreviated
> blob object names?
>
> 		-- Pete
>
