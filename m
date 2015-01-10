From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] receive-pack.c: don't miss exporting unsolicited push
 certificates
Date: Fri, 09 Jan 2015 19:55:45 -0800
Message-ID: <54B0A2C1.4040602@gmail.com>
References: <xmqqbnm7bj8m.fsf@gitster.dls.corp.google.com>	<1420849874-32013-1-git-send-email-sbeller@google.com> <xmqqmw5r9zck.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 04:56:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9n9d-0001I8-8f
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 04:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbbAJDzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2015 22:55:49 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:45403 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbbAJDzs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2015 22:55:48 -0500
Received: by mail-qg0-f54.google.com with SMTP id l89so11832956qgf.13
        for <git@vger.kernel.org>; Fri, 09 Jan 2015 19:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=yxx6wLJYJ/48H6y0Ktq/V9jUjI2xsYoFFn2+o6Y+r/Q=;
        b=mqMsAjh80gw5/3VyxZoyPxok6yoxbRjYktLFbFG0HT37tVZc4rZBaf4yHte6QERkxW
         2lKT8YFSFHvbf8S5Ty85F5lQtvGvLpkj5NMInHlVL0YH3Sz8M95esRwMX6WD69Ji8t8S
         7zipF5j807njhfEAR3uQImh88EHCZtiqTAXyEs5vSHU1p5+g/Y43OYQED9zVJ0QtPgPs
         DlM+Jrf3rPXFQCoimsmcIYdxmJAjI05rJ0zCJEpuZ7hDjH+axqbtvZ3OmBjLOVU1JZEL
         tutHsNuaDhHUo5tPZ315KN5CIuOmUMSNysY9uwJbEHHk6I9AajaulrIv5cQhKiEWCP8A
         y74w==
X-Received: by 10.140.98.33 with SMTP id n30mr31259801qge.62.1420862148038;
        Fri, 09 Jan 2015 19:55:48 -0800 (PST)
Received: from [192.168.2.7] (c-76-102-52-132.hsd1.ca.comcast.net. [76.102.52.132])
        by mx.google.com with ESMTPSA id 43sm8822547qgb.17.2015.01.09.19.55.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jan 2015 19:55:47 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <xmqqmw5r9zck.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262255>

On 09.01.2015 17:52, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
>> If the server is configured to not advertise push certificates,
>> a push certificate that gets pushed nevertheless will not be fully
>> recorded because push_cert_nonce is NULL.
> 
> Sorry, but I do not quite see what you are trying to get at.
> 
> When we did not advertise that this feature is supported, we know
> the incoming nonce is meaningless junk because we didn't supply the
> correct answer the pusher can give us; we do not even have the
> correct answer ourselves.

> 
> Besides, while reviewing the other patch, didn't we agree that we
> should reject such a push?  Then there is nothing to log anyway, no?

Yes we did. This is unrelated to the previous patch. I stuffed it into
this thread as I found it was touching the same feature.

> 
>     ... reads the patch and code beyond the context while scratching
>     head ...
> 
> I notice that the above three lines do not correspond what you did
> in this patch.  The certificate is exported via the blob interface
> fully with or without this change.

I had problems with wording the commit message because I have no
expertise with the feature. I am sorry for wasting your time there.

> 
> What is not given to the hook is the push-cert-nonce-status.  While
> it is sufficient to tell the hook that we are not getting a good
> nonce (i.e. the hook does not see GIT_PUSH_CERT_NONCE_STATUS=G), we
> are not showing that nonce-status is "unsolicited", even though we
> internally compute and decide that; is that what you are trying to
> fix?

yes that's what I was trying to hint at. The hook would just see
it is unsolicited instead of not having the state available.


> 
> Still puzzled...
> 
>>
>> The recording of GIT_PUSH_CERT_NONCE_STATUS should be dependent on
>> the status being there instead of push_cert_nonce being non NULL.
>>
>> Without this patch an unsolicited nonce never makes to the stage when
>> being exported with GIT_PUSH_CERT_NONCE_STATUS, because in the unsolicited
>> case push_cert_nonce is always NULL.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  builtin/receive-pack.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 628d13a..0e4878e 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -504,18 +504,18 @@ static void prepare_push_cert_sha1(struct child_process *proc)
>>  				 sigcheck.key ? sigcheck.key : "");
>>  		argv_array_pushf(&proc->env_array, "GIT_PUSH_CERT_STATUS=%c",
>>  				 sigcheck.result);
>> -		if (push_cert_nonce) {
>> +		if (push_cert_nonce)
>>  			argv_array_pushf(&proc->env_array,
>>  					 "GIT_PUSH_CERT_NONCE=%s",
>>  					 push_cert_nonce);
>> +		if (nonce_status)
>>  			argv_array_pushf(&proc->env_array,
>>  					 "GIT_PUSH_CERT_NONCE_STATUS=%s",
>>  					 nonce_status);
>> -			if (nonce_status == NONCE_SLOP)
>> -				argv_array_pushf(&proc->env_array,
>> -						 "GIT_PUSH_CERT_NONCE_SLOP=%ld",
>> -						 nonce_stamp_slop);
>> -		}
>> +		if (nonce_status == NONCE_SLOP)
>> +			argv_array_pushf(&proc->env_array,
>> +					 "GIT_PUSH_CERT_NONCE_SLOP=%ld",
>> +					 nonce_stamp_slop);
>>  	}
>>  }
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
