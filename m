From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/14] git-compat-util.h: fix integer overflow
 on IL32P64 systems
Date: Wed, 08 Oct 2014 12:22:44 -0700
Message-ID: <xmqqioju9xiz.fsf@gitster.dls.corp.google.com>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org>
	<1412791267-13356-14-git-send-email-marat@slonopotamus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org,  msysGit <msysgit@googlegroups.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: msysgit+bncBCG77UMM3EJRBB4622QQKGQE2WFFYQQ@googlegroups.com Wed Oct 08 21:22:49 2014
Return-path: <msysgit+bncBCG77UMM3EJRBB4622QQKGQE2WFFYQQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ig0-f184.google.com ([209.85.213.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBB4622QQKGQE2WFFYQQ@googlegroups.com>)
	id 1Xbwoy-0000mm-FP
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 21:22:48 +0200
Received: by mail-ig0-f184.google.com with SMTP id h15sf2658igd.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 08 Oct 2014 12:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Uq2u9s/RiMSFOfPi29xBUSqihGU+4qw9CnlSLK35qrk=;
        b=EaQjD+NJqHfhZakyFUhHbjKmW6nl0XKaKvl03lRYqHrPd5hPEjMkGHuG2KKJhNjw8+
         dyNL5QugaZzTLuXgEqCXEBdlFUQO4eQFxHdgAuslgdXsO4R8vBlKwZtWTii4FsSz+hO5
         Vb5Ha+g7bpFR83I23wcHGrdgX93PtuEO/Ym3pCvSf8155gKhp8xscOv+pq8btmTZ8dOt
         Enp4loY1xq/bq065/7cdgHk9z7yc8NU1pWpXqzTRNwx43dWNYOXBnaD/jNLjKxxsgqUy
         wDZlAPcgT+R9oSiO5SaafNtRhgncyYeyNbJCdz5+h/ve1LoUCIBhwN7CypiMRCnkmhVX
         Sc9A==
X-Received: by 10.182.20.242 with SMTP id q18mr22610obe.26.1412796167608;
        Wed, 08 Oct 2014 12:22:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.213.37 with SMTP id np5ls1298541obc.84.gmail; Wed, 08 Oct
 2014 12:22:47 -0700 (PDT)
X-Received: by 10.182.232.164 with SMTP id tp4mr8392715obc.29.1412796166996;
        Wed, 08 Oct 2014 12:22:46 -0700 (PDT)
Received: from sasl.smtp.pobox.com (pb-smtp1.int.icgroup.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id fl6si391326qcb.0.2014.10.08.12.22.46
        for <msysgit@googlegroups.com>;
        Wed, 08 Oct 2014 12:22:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DB7914725;
	Wed,  8 Oct 2014 15:22:46 -0400 (EDT)
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 637C214724;
	Wed,  8 Oct 2014 15:22:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E0C9014723;
	Wed,  8 Oct 2014 15:22:45 -0400 (EDT)
In-Reply-To: <1412791267-13356-14-git-send-email-marat@slonopotamus.org>
	(Marat Radchenko's message of "Wed, 8 Oct 2014 22:01:06 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7B9B9044-4F20-11E4-B9D1-855A93717476-77302942!pb-smtp1.pobox.com
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

> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  git-compat-util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index b338277..101c9d7 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -474,7 +474,7 @@ extern int git_munmap(void *start, size_t length);
>  #endif
>  
>  #define DEFAULT_PACKED_GIT_LIMIT \
> -	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
> +	((size_t)(1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))

1024 * 1024 * 8192 overflows 32-bit unsigned, but is size_t always
large enough?  Just checking.


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
