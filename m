From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/14] git-compat-util.h: fix integer overflow
 on IL32P64 systems
Date: Thu, 09 Oct 2014 00:31:07 -0700
Message-ID: <xmqq4mvd8zt0.fsf@gitster.dls.corp.google.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
	<1412791267-13356-14-git-send-email-marat@slonopotamus.org>
	<xmqqioju9xiz.fsf@gitster.dls.corp.google.com>
	<xmqqfvey8h4t.fsf@gitster.dls.corp.google.com>
	<20141009050540.GB17479@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCG77UMM3EJRBPXT3CQQKGQEIJRJP7I@googlegroups.com Thu Oct 09 09:31:13 2014
Return-path: <msysgit+bncBCG77UMM3EJRBPXT3CQQKGQEIJRJP7I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBPXT3CQQKGQEIJRJP7I@googlegroups.com>)
	id 1Xc8Br-00028s-BK
	for gcvm-msysgit@m.gmane.org; Thu, 09 Oct 2014 09:31:11 +0200
Received: by mail-ig0-f186.google.com with SMTP id uq10sf239288igb.13
        for <gcvm-msysgit@m.gmane.org>; Thu, 09 Oct 2014 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=PEiQKf4JpYOVQpSI6x20bXXpH0JfdSfJ8V7OVIaeIY0=;
        b=vL++qaNZNdZGatZNC+YLjueuziQs8HTYLeYP5dGPKYEVMOPCe/24XZSHzgHeB52Yip
         HwvokCi9n99nqw+WeuC5+qrdx1ao81WBAOwu6sP7+L6DLaCE8ZYWS9PQgilBA9CJoR7S
         J9phdEmmLJpwQSlENfI7ZUcE9Vq60hnX4XU4m/obmqH0Gy11Id6IdEbEHKZAaQsUh+KW
         8o6h1fiGDt488HG3OcqoeTz/xRQSLqq2EJNIRQywyOmm5FHUSiq5ggCwzMaYUrTEiHCD
         cA9ed9bUcHBzgzWCa/q33kkAQmti522xKpiQdQnR54EEymvcK4C6wYk9RmkB8pSKg16Y
         Ae1A==
X-Received: by 10.140.105.71 with SMTP id b65mr93835qgf.15.1412839870459;
        Thu, 09 Oct 2014 00:31:10 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.23.72 with SMTP id 66ls185823qgo.54.gmail; Thu, 09 Oct
 2014 00:31:10 -0700 (PDT)
X-Received: by 10.236.179.102 with SMTP id g66mr9440876yhm.23.1412839870010;
        Thu, 09 Oct 2014 00:31:10 -0700 (PDT)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id z1si571578qci.3.2014.10.09.00.31.09
        for <msysgit@googlegroups.com>;
        Thu, 09 Oct 2014 00:31:09 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8722611C78;
	Thu,  9 Oct 2014 03:31:09 -0400 (EDT)
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DA6A11C77;
	Thu,  9 Oct 2014 03:31:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE33E11C76;
	Thu,  9 Oct 2014 03:31:08 -0400 (EDT)
In-Reply-To: <20141009050540.GB17479@seldon> (Marat Radchenko's message of
	"Thu, 9 Oct 2014 09:05:41 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CA894B6-4F86-11E4-8725-855A93717476-77302942!pb-smtp1.pobox.com
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

Marat Radchenko <marat@slonopotamus.org> writes:

> On Wed, Oct 08, 2014 at 01:02:10PM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Marat Radchenko <marat@slonopotamus.org> writes:
>> >
>> >> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
>> >> ---
>> >>  git-compat-util.h | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/git-compat-util.h b/git-compat-util.h
>> >> index b338277..101c9d7 100644
>> >> --- a/git-compat-util.h
>> >> +++ b/git-compat-util.h
>> >> @@ -474,7 +474,7 @@ extern int git_munmap(void *start, size_t length);
>> >>  #endif
>> >>  
>> >>  #define DEFAULT_PACKED_GIT_LIMIT \
>> >> -	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
>> >> +	((size_t)(1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
>> >
>> > 1024 * 1024 * 8192 overflows 32-bit unsigned, but is size_t always
>> > large enough?  Just checking.
>> 
>> Heh, I was being silly.  This gives the default value for a variable
>> whose type is size_t, so it would better fit.  So please throw 13 in
>> the list of changes I found sensible in the other message.
>
> Is it an Acked-by?

Not really.  It just shows that the change needs to be explained
well in the proposed log message.

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
