From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 05/11] trace: add infrastructure to augment
 trace output with additional info
Date: Fri, 20 Jun 2014 17:33:47 -0700
Message-ID: <CAPc5daV=vbJz90X9K85DzJZ0PjyzF_xfSi9Cy9XZ+TX0YdEkeg@mail.gmail.com>
References: <53A4A195.1070502@gmail.com> <53A4A267.2060907@gmail.com>
 <xmqqmwd7citp.fsf@gitster.dls.corp.google.com> <53A4C47D.609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBAFGSOOQKGQEJXKAIWI@googlegroups.com Sat Jun 21 02:34:12 2014
Return-path: <msysgit+bncBCG77UMM3EJRBAFGSOOQKGQEJXKAIWI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f187.google.com ([209.85.217.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBAFGSOOQKGQEJXKAIWI@googlegroups.com>)
	id 1Wy9Fy-00065a-0B
	for gcvm-msysgit@m.gmane.org; Sat, 21 Jun 2014 02:34:10 +0200
Received: by mail-lb0-f187.google.com with SMTP id n15sf3877lbi.24
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 17:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :list-subscribe:list-unsubscribe:content-type;
        bh=X7GShypHHqVDb+avRu6UCoOt3p/Cp/3AGvkjHfi2eGc=;
        b=TZa421IMRRfegNwb/XJPa8UP1gEuuR/6nJSB4cLH2G2dlGKk9x6+iOnX2B+/Igrgxt
         AJCIh/t/aab9a+u60maPDjR7dGhHnS6zlHA5+g3IuMvWqLsxYprOXtaRh0NBWAcH+CSI
         8eVGWecyA0saWUVWHwDvcjYuaD1CxawNu0WDy2er1A78QlL5KgsQCgdNJeCslIcgwxM0
         5f0DVTmpmgghYf9xf+IzhN1q/bWNeG7io0woH70uGweqTxJ734EXfUhaaXL5UOc2CihW
         5+71caegeIAxmScI2HpcDAIMe5GgLTreH/Iy4yf/OWkXGPxDjcgXwyZ/D6qZi0lZ5vzt
         ASQA==
X-Received: by 10.152.2.40 with SMTP id 8mr88lar.12.1403310849549;
        Fri, 20 Jun 2014 17:34:09 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.18.228 with SMTP id z4ls216016lad.109.gmail; Fri, 20 Jun
 2014 17:34:08 -0700 (PDT)
X-Received: by 10.152.23.65 with SMTP id k1mr601703laf.2.1403310848114;
        Fri, 20 Jun 2014 17:34:08 -0700 (PDT)
Received: from mail-lb0-x233.google.com (mail-lb0-x233.google.com [2a00:1450:4010:c04::233])
        by gmr-mx.google.com with ESMTPS id tf1si1321048lbb.1.2014.06.20.17.34.08
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 20 Jun 2014 17:34:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of jch2355@gmail.com designates 2a00:1450:4010:c04::233 as permitted sender) client-ip=2a00:1450:4010:c04::233;
Received: by mail-lb0-f179.google.com with SMTP id z11so2771216lbi.38
        for <msysgit@googlegroups.com>; Fri, 20 Jun 2014 17:34:08 -0700 (PDT)
X-Received: by 10.152.180.195 with SMTP id dq3mr4861141lac.26.1403310848005;
 Fri, 20 Jun 2014 17:34:08 -0700 (PDT)
Sender: msysgit@googlegroups.com
Received: by 10.112.172.103 with HTTP; Fri, 20 Jun 2014 17:33:47 -0700 (PDT)
In-Reply-To: <53A4C47D.609@gmail.com>
X-Original-Sender: gitster@pobox.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jch2355@gmail.com designates 2a00:1450:4010:c04::233
 as permitted sender) smtp.mail=jch2355@gmail.com;       dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252299>

On Fri, Jun 20, 2014 at 4:32 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 21.06.2014 00:33, schrieb Junio C Hamano:
>> Karsten Blees <karsten.blees@gmail.com> writes:
>
> GIT_TRACE_VERBOSE perhaps? It affects all trace output, not just
> GIT_TRACE_PERFORMANCE. The tests would still have to disable it
> explicitly, though, in case someone sets it in their profile.
>
> However, IIRC conclusion of v4 discussion was that this would be
> useful for all trace output [1], so I think it should be the default.
>
> [1] https://groups.google.com/forum/#!topic/msysgit/UMKTvmZX5aI

Hmph, after re-reading of that thread, I recall that I thought Peff's

>> Would it make
>> sense to just tie this to regular trace_* calls, and if
>> GIT_TRACE_PERFORMANCE is set, add a timestamp to each line?

was the conclusion (i.e. by default no change, ask with GIT_TRACE_PERFORMANCE),
and that I found that reasonable back then.

As to the need to disable in the tests, yes, you are right. Just like
we give predictiable
environment to tests by setting EDITOR, HOME, etc. in test-lib.sh, we
should do the
same for these new settings there.

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
