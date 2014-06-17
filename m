From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 09/11] trace: add high resolution timer
 function to debug performance issues
Date: Tue, 17 Jun 2014 09:44:34 -0700
Message-ID: <xmqq4mzjo58t.fsf@gitster.dls.corp.google.com>
References: <53980B83.9050409@gmail.com> <53980CBF.2060400@gmail.com>
	<53980F68.7050009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,  msysGit <msysgit@googlegroups.com>,  Jeff King <peff@peff.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBCG77UMM3EJRB6HAQGOQKGQEPMGIHBA@googlegroups.com Tue Jun 17 18:44:42 2014
Return-path: <msysgit+bncBCG77UMM3EJRB6HAQGOQKGQEPMGIHBA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f61.google.com ([209.85.160.61])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRB6HAQGOQKGQEPMGIHBA@googlegroups.com>)
	id 1WwwV0-00085X-HY
	for gcvm-msysgit@m.gmane.org; Tue, 17 Jun 2014 18:44:42 +0200
Received: by mail-pb0-f61.google.com with SMTP id md12sf1498655pbc.16
        for <gcvm-msysgit@m.gmane.org>; Tue, 17 Jun 2014 09:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=Te+PUfLc2aOJPrHgn0UbPiQBqmGjmHrtvKZflCE0UVY=;
        b=vj42n5bwYtinFEzVuaOhQJmISwXsk/kUmwWK8hsPPwTutqz98ckihcxOjC1a+25mgT
         LEl+Yladn/dv301nMDAWzQTZjjqd7g+J503GRzHvjgAH8g5yF7rvBML4pi+iRZmJfDsR
         0vjT8pxbU1vUdMDo5Hb/bCjFig3+WNw2hXFDbhjzOLGpfsHJ12qSL1Gv7VoEhr59+oYf
         kQCOjh7cviMKIgK+/sNF/QBExj5xtuttRAH+6RmvCAUg3AWvjEKQqTpZNoOdx1CMaqiH
         VJoWbeFyueUhu0R4Ax83eDKgNEOTKL4Ygf2w5IY3a40xnVlUFgqp4MZoZFwdZIhSAW28
         xRZQ==
X-Received: by 10.50.79.137 with SMTP id j9mr646725igx.6.1403023481141;
        Tue, 17 Jun 2014 09:44:41 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.3.7 with SMTP id 7ls1645138igy.19.canary; Tue, 17 Jun 2014
 09:44:40 -0700 (PDT)
X-Received: by 10.43.126.130 with SMTP id gw2mr2479435icc.15.1403023480348;
        Tue, 17 Jun 2014 09:44:40 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id ci7si3282192qcb.1.2014.06.17.09.44.40
        for <msysgit@googlegroups.com>;
        Tue, 17 Jun 2014 09:44:40 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E582020757;
	Tue, 17 Jun 2014 12:44:37 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DA26D20756;
	Tue, 17 Jun 2014 12:44:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9685D20752;
	Tue, 17 Jun 2014 12:44:33 -0400 (EDT)
In-Reply-To: <53980F68.7050009@gmail.com> (Karsten Blees's message of "Wed, 11
	Jun 2014 10:12:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A9139912-F63E-11E3-A1AE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251920>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 11.06.2014 10:01, schrieb Karsten Blees:
>> the epoch allows using the results (div 10e9) with other time-related APIs.
>
> s/10e9/1e9/

That replacement is fine but the "(div 1e9)" still wants to be
clarified.  What did you exactly mean by that?  If the result is
divided by 10^9 then it yields the number of seconds?

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
