From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/14] git-compat-util.h: fix integer overflow
 on IL32P64 systems
Date: Wed, 08 Oct 2014 13:02:10 -0700
Message-ID: <xmqqfvey8h4t.fsf@gitster.dls.corp.google.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
	<1412791267-13356-14-git-send-email-marat@slonopotamus.org>
	<xmqqioju9xiz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCG77UMM3EJRBH5R22QQKGQEFUAWMZI@googlegroups.com Wed Oct 08 22:03:45 2014
Return-path: <msysgit+bncBCG77UMM3EJRBH5R22QQKGQEFUAWMZI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f185.google.com ([209.85.192.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBH5R22QQKGQEFUAWMZI@googlegroups.com>)
	id 1XbxSb-0002Lt-4P
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 22:03:45 +0200
Received: by mail-pd0-f185.google.com with SMTP id y13sf1297400pdi.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 13:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Cx0V4An2MxI10YbOtsbPh51sGCJiLLkblgmTFo3ftwY=;
        b=BtJJlUSNLQ5RkaZ72+mKwLKZqyJKTJeQPd6aGd+NesZiDG7DKV1vAxWQZ13oUBIZ+z
         a3T2kC8U9hC5d3pZAwI/FHnyikL/aFp4AJyNNoVoSZa0lRKTrazFn9wPYD0XdPx2jaVX
         XDbGJDF7xVDVfC1OU3nJOKTHZ9EaGMBmGuQXbBIpItriOSq1E83fCnQDwz/KSwh8tzjV
         Br+HHlzP63R0EsmUHVadQoeOpJVPf5Cz2ZhDgzq1gzZ1oOxb8i4tAr+AoPc+/v21MxyH
         EhylacsUXZ2AodsBTq5dWnLltbjLOYSjdNKKtwmgm2GWMSMPGeT8cTCEPSfLBI+IQMTt
         rRcw==
X-Received: by 10.50.3.33 with SMTP id 1mr1428igz.15.1412798624001;
        Wed, 08 Oct 2014 13:03:44 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.119.102 with SMTP id kt6ls1292300igb.13.canary; Wed, 08 Oct
 2014 13:03:43 -0700 (PDT)
X-Received: by 10.42.105.201 with SMTP id w9mr14818ico.19.1412798623596;
        Wed, 08 Oct 2014 13:03:43 -0700 (PDT)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id qj6si7184igc.0.2014.10.08.13.03.43
        for <msysgit@googlegroups.com>;
        Wed, 08 Oct 2014 13:03:43 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5ACA1449D;
	Wed,  8 Oct 2014 16:03:42 -0400 (EDT)
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B8F6B1449C;
	Wed,  8 Oct 2014 16:03:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5EE1D1441F;
	Wed,  8 Oct 2014 16:02:11 -0400 (EDT)
In-Reply-To: <xmqqioju9xiz.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 08 Oct 2014 12:22:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FD89591A-4F25-11E4-A1CB-855A93717476-77302942!pb-smtp1.pobox.com
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted
 sender) smtp.mail=junio@pobox.com;       dkim=pass header.i=@pobox.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>

Junio C Hamano <gitster@pobox.com> writes:

> Marat Radchenko <marat@slonopotamus.org> writes:
>
>> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
>> ---
>>  git-compat-util.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index b338277..101c9d7 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -474,7 +474,7 @@ extern int git_munmap(void *start, size_t length);
>>  #endif
>>  
>>  #define DEFAULT_PACKED_GIT_LIMIT \
>> -	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
>> +	((size_t)(1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
>
> 1024 * 1024 * 8192 overflows 32-bit unsigned, but is size_t always
> large enough?  Just checking.

Heh, I was being silly.  This gives the default value for a variable
whose type is size_t, so it would better fit.  So please throw 13 in
the list of changes I found sensible in the other message.

Thanks.

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
