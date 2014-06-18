From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 10/11] trace: add trace_performance facility
 to debug performance issues
Date: Wed, 18 Jun 2014 10:28:09 -0700
Message-ID: <xmqqbntqjffa.fsf@gitster.dls.corp.google.com>
References: <53980B83.9050409@gmail.com> <53980CD8.5090801@gmail.com>
	<xmqqsin3mpfe.fsf@gitster.dls.corp.google.com>
	<53A1ACE2.30406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Jeff King <peff@peff.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBMMYQ6OQKGQERIC5KOI@googlegroups.com Wed Jun 18 19:28:21 2014
Return-path: <msysgit+bncBCG77UMM3EJRBMMYQ6OQKGQERIC5KOI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yk0-f189.google.com ([209.85.160.189])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBMMYQ6OQKGQERIC5KOI@googlegroups.com>)
	id 1WxJek-0003DT-UF
	for gcvm-msysgit@m.gmane.org; Wed, 18 Jun 2014 19:28:19 +0200
Received: by mail-yk0-f189.google.com with SMTP id 9sf95963ykp.16
        for <gcvm-msysgit@m.gmane.org>; Wed, 18 Jun 2014 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ONmah/lb1ocMVCUlcOV26aeDYxjXREYUeQmdg4J3qJI=;
        b=XNJyEEbvxqTKNizWo3KDHkkUfNGqcr1MeIjm0uIG48Zk1C/2mEgfNe2n6AarRQNDoT
         lQvkBBv7cccHP8lVlf81X7lILfXhI6hWCM3Hffpy5dIeTSKJ2ldurgKwdy2Bp7/HEdTP
         T8E4k1bN6kLzQrRtuIqyOOw7OzrgW780OUYpIfQ18RYiFv/O+OT5TrYlN1TmxqwiFQ9b
         MiUxoWdN+onnpgocDSUD9NYUSLIGdkgRsBLjuDuIgIpt2yHICdaXUN//cvK4g/SQ51YI
         BXxQ7ZdKb1GjOwevdN8oNDUVPgZxGC7VwHOJqg52aAYnOpk68dKZCySBRhlQefyuFgG/
         ESDw==
X-Received: by 10.140.49.67 with SMTP id p61mr56216qga.21.1403112497950;
        Wed, 18 Jun 2014 10:28:17 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.24.181 with SMTP id 50ls177311qgr.92.gmail; Wed, 18 Jun
 2014 10:28:17 -0700 (PDT)
X-Received: by 10.236.124.100 with SMTP id w64mr1345053yhh.57.1403112497173;
        Wed, 18 Jun 2014 10:28:17 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id o69si176297yhp.6.2014.06.18.10.28.17
        for <msysgit@googlegroups.com>;
        Wed, 18 Jun 2014 10:28:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A85CD1E11B;
	Wed, 18 Jun 2014 13:28:13 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BA501E11A;
	Wed, 18 Jun 2014 13:28:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4C2561E10E;
	Wed, 18 Jun 2014 13:28:09 -0400 (EDT)
In-Reply-To: <53A1ACE2.30406@gmail.com> (Karsten Blees's message of "Wed, 18
	Jun 2014 17:14:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EA90B6FC-F70D-11E3-8377-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252015>

Karsten Blees <karsten.blees@gmail.com> writes:

> Right, it makes no sense for trace_performance(), and for
> trace_performance_since() only if followed by another 'measured' code
> section. In that special case, I think it wouldn't hurt if you had to
> write:
>
>   uint64_t start = getnanotime();
>   /* first code section to measure */
>   trace_performance_since(start, "first foobar");
>
>   start = getnanotime();
>   /* second code section to measure */
>   trace_performance_since(start, "second foobar");
>
> So I guess I'll drop the return value (and the second example, which
> is then redundant to the first).

That also sounds OK to me.

>>> +static void trace_performance_vfl(const char *file, int line,
>>> +				      uint64_t nanos, const char *format,
>>> +				      va_list ap)
>>> +{
>> 
>> Just being curious, but what does "v" stand for?
>> 
>
> trace_performance_vfl(, va_list)
> vs.
> trace_performance_fl(, ...)
>
> Will change to trace_performance_vprintf_fl()

Ah, OK.  The name with 'vprintf' in it does sound better.

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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
