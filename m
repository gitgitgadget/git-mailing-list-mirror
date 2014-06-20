From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 05/11] trace: add infrastructure to augment
 trace output with additional info
Date: Fri, 20 Jun 2014 15:33:22 -0700
Message-ID: <xmqqmwd7citp.fsf@gitster.dls.corp.google.com>
References: <53A4A195.1070502@gmail.com> <53A4A267.2060907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRBOPNSKOQKGQE5HTBC3I@googlegroups.com Sat Jun 21 00:33:34 2014
Return-path: <msysgit+bncBCG77UMM3EJRBOPNSKOQKGQE5HTBC3I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pd0-f186.google.com ([209.85.192.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBOPNSKOQKGQE5HTBC3I@googlegroups.com>)
	id 1Wy7ND-0004Z4-3r
	for gcvm-msysgit@m.gmane.org; Sat, 21 Jun 2014 00:33:31 +0200
Received: by mail-pd0-f186.google.com with SMTP id fp1sf940983pdb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 20 Jun 2014 15:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=ACfJGkTqp+waCDmKslhhZoYXtIMXmyZQ4jJHZBeaxGo=;
        b=HlTewyTjQNhLXdDIT68x75BU1qdaLV1mUT0KsYu0auz4c8nGToCOmCqYZTaIPGVn/g
         zsfP3Wr+qDgMTuQ5LncQxqxR+nM6p244b0hv0q16x/TUtxbh+rUs0Cv+j329vQ++s0Ud
         z3dfsHmCk5x1LbD3xxzW8GnAGA6iFJw9dXQ3cLu9g/sa3P76uhtKEU6OiIMgZrTzRuS1
         hDNLAc1b74sdaTUAUlCPHbbMBCImtzrdSBYmpK17Nofh9B9X6u/tsWouJfh/7dFh94Le
         Si+R0DIjoOFj0EuVYEC53GH7B7WCzCEdLBIeRZTJHvGs1z5b6a7VFU1jxaBUg8i75nPN
         cO1Q==
X-Received: by 10.182.165.36 with SMTP id yv4mr35900obb.18.1403303609828;
        Fri, 20 Jun 2014 15:33:29 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.22.129 with SMTP id d1ls429436obf.30.gmail; Fri, 20 Jun
 2014 15:33:28 -0700 (PDT)
X-Received: by 10.182.33.106 with SMTP id q10mr2755763obi.8.1403303608688;
        Fri, 20 Jun 2014 15:33:28 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ci7si2101803qcb.1.2014.06.20.15.33.28
        for <msysgit@googlegroups.com>;
        Fri, 20 Jun 2014 15:33:28 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F39A22B4D;
	Fri, 20 Jun 2014 18:33:24 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 161ED22B4C;
	Fri, 20 Jun 2014 18:33:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B293E22B49;
	Fri, 20 Jun 2014 18:33:19 -0400 (EDT)
In-Reply-To: <53A4A267.2060907@gmail.com> (Karsten Blees's message of "Fri, 20
	Jun 2014 23:06:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1406CA0-F8CA-11E3-BAFD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252294>

Karsten Blees <karsten.blees@gmail.com> writes:

> To be able to add a common prefix or suffix to all trace output (e.g.
> a timestamp or file:line of the caller), factor out common setup and
> cleanup tasks of the trace* functions.
>
> Some unit-tests use trace output to verify internal state, and variable
> output such as timestamps and line numbers are not useful there. Disable
> additional trace output if GIT_TRACE_BARE is set.

Hmph, this makes me wonder if we are better off making these
additional trace output optional, i.e. not disabling with
GIT_TRACE_BARE like this, but show the new output only when
explicitly asked for by setting GIT_TRACE_PERF or something.

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
