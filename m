From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 10/11] trace: add trace_performance facility
 to debug performance issues
Date: Tue, 17 Jun 2014 10:11:33 -0700
Message-ID: <xmqqsin3mpfe.fsf@gitster.dls.corp.google.com>
References: <53980B83.9050409@gmail.com> <53980CD8.5090801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Jeff King <peff@peff.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBS7NQGOQKGQE7MWSR4A@googlegroups.com Tue Jun 17 19:11:42 2014
Return-path: <msysgit+bncBCG77UMM3EJRBS7NQGOQKGQE7MWSR4A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f56.google.com ([209.85.160.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBS7NQGOQKGQE7MWSR4A@googlegroups.com>)
	id 1Wwwv7-0008Cx-88
	for gcvm-msysgit@m.gmane.org; Tue, 17 Jun 2014 19:11:41 +0200
Received: by mail-pb0-f56.google.com with SMTP id rp16sf1721104pbb.21
        for <gcvm-msysgit@m.gmane.org>; Tue, 17 Jun 2014 10:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=8UstO6bIdPpiIi26nMEbyjE0D7WR9TJ3i0WjawyEBRE=;
        b=J73pcymtAE1hq1Eyctc7p/BCSvvPhtFWsFj3u9XdZmCsKoB/dM4HBz1Aqa4S3DUBIY
         x3HcxygprgoKBV//BQ7plBQ4UOsyvcEoNaKP4Ui2TWiBva4aSFuzvkDhqyL/R3gxQF7u
         J+0gwpAJuy1L/5245S6zwNVLmi6jUOl2IWYCUQ3/uanCdYorIMGFjUlRLmRWeJ3TMULb
         NYku1zzOLugEqKP+OW8AWWV14EHueLvfYl9xH0Np0khxZ9/9wUuxaBdvT2g4nHTpRmat
         Hcgyp26SnT0Z7Gg95sBt7fEH1q2F/W0Oc0FV+6dAuTDnwRN611E3zk7xQMRtBIs3FKX6
         YdCQ==
X-Received: by 10.140.98.203 with SMTP id o69mr178187qge.9.1403025099958;
        Tue, 17 Jun 2014 10:11:39 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.101.78 with SMTP id t72ls2254294qge.32.gmail; Tue, 17 Jun
 2014 10:11:39 -0700 (PDT)
X-Received: by 10.236.124.100 with SMTP id w64mr3200251yhh.57.1403025099455;
        Tue, 17 Jun 2014 10:11:39 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id m2si1336773qcr.2.2014.06.17.10.11.39
        for <msysgit@googlegroups.com>;
        Tue, 17 Jun 2014 10:11:39 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 051B220E41;
	Tue, 17 Jun 2014 13:11:37 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EE52F20E40;
	Tue, 17 Jun 2014 13:11:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF9E020E3D;
	Tue, 17 Jun 2014 13:11:32 -0400 (EDT)
In-Reply-To: <53980CD8.5090801@gmail.com> (Karsten Blees's message of "Wed, 11
	Jun 2014 10:01:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6E22DCCE-F642-11E3-B8D8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251922>

Karsten Blees <karsten.blees@gmail.com> writes:

> Simple use case (measure one code section):
>
>   uint64_t start = getnanotime();
>   /* code section to measure */
>   trace_performance_since(start, "foobar");
>
> Medium use case (measure consecutive code sections):
>
>   uint64_t start = getnanotime();
>   /* first code section to measure */
>   start = trace_performance_since(start, "first foobar");
>   /* second code section to measure */
>   trace_performance_since(start, "second foobar");
>
> Complex use case (measure repetitive code sections):
>
>   uint64_t t = 0;
>   for (;;) {
>     /* ignore */
>     t -= getnanotime();
>     /* code section to measure */
>     t += getnanotime();
>     /* ignore */
>   }
>   trace_performance(t, "frotz");

Hmph.  Even though trace_performance() makes an extra call to
getnanotime() in order to return, examples do not use the returned
value?  The second example is a good illustration why it makes sense
for trace_performance_since(), though.

> +static void trace_performance_vfl(const char *file, int line,
> +				      uint64_t nanos, const char *format,
> +				      va_list ap)
> +{

Just being curious, but what does "v" stand for?

The "_fl" suffix you gave to printf family made a lot of sense to
me, and I would have expected that this to be called with a "_flt"
suffix, meaning "we have file, line and then time as extra
parameters" or something.

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
