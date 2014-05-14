From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep -I: do not bother to read known-binary files
Date: Wed, 14 May 2014 14:15:42 -0700
Message-ID: <xmqqy4y4hxj5.fsf@gitster.dls.corp.google.com>
References: <20140514154419.GA4517@camelia.ucw.cz>
	<20140514194128.GC2715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>,  GIT Mailing-list <git@vger.kernel.org>,  Johannes Schindelin <johannes.schindelin@gmx.de>,  msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCG77UMM3EJRBDF2Z6NQKGQEGMNYTSY@googlegroups.com Wed May 14 23:15:59 2014
Return-path: <msysgit+bncBCG77UMM3EJRBDF2Z6NQKGQEGMNYTSY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f183.google.com ([209.85.223.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCG77UMM3EJRBDF2Z6NQKGQEGMNYTSY@googlegroups.com>)
	id 1WkgWr-0000EI-VH
	for gcvm-msysgit@m.gmane.org; Wed, 14 May 2014 23:15:58 +0200
Received: by mail-ie0-f183.google.com with SMTP id as1sf22528iec.0
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 14:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=CuhtoL62g47+H+D7git7iCSaGqyv9n5XbDKG5jnUARI=;
        b=yfaw4pyMEcvEzjal414xOj1fKmxPFEmBucFkOHEmjv6UB73jiWzXNUp75WC9GOPk0o
         aTpnF0lJuUBZc7smw3QyGHo2BVzMch1BYaksia8NWVFiRzgSlcRps7620LwxetVJGjdg
         yQ1D080o90nnABfX7TtfjVreMsB/LDDFC0sCPhq0vvTVU7Vbncs+MA52vTAfT9ZY8wwt
         eK+7FeLsm928J7os/OdOfqht1y/YyA8rtQ0961YKbelR+NeTy7mgTrYxKeocT17wJsIl
         ZtcTb3dqh2OniN0HqGvitOl6VZiOtQorIWiAHlUtSy/rppFw1vL+EebtC2tosbzRgX3r
         L+oQ==
X-Received: by 10.50.103.10 with SMTP id fs10mr193816igb.12.1400102156981;
        Wed, 14 May 2014 14:15:56 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.25.70 with SMTP id a6ls3599635igg.42.canary; Wed, 14 May
 2014 14:15:56 -0700 (PDT)
X-Received: by 10.66.163.33 with SMTP id yf1mr382073pab.19.1400102156172;
        Wed, 14 May 2014 14:15:56 -0700 (PDT)
Received: from smtp.pobox.com (smtp.pobox.com. [208.72.237.35])
        by gmr-mx.google.com with ESMTP id h5si430324qce.1.2014.05.14.14.15.56
        for <msysgit@googlegroups.com>;
        Wed, 14 May 2014 14:15:56 -0700 (PDT)
Received-SPF: pass (google.com: domain of junio@pobox.com designates 208.72.237.35 as permitted sender) client-ip=208.72.237.35;
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE1EA18B84;
	Wed, 14 May 2014 17:15:55 -0400 (EDT)
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D304B18B83;
	Wed, 14 May 2014 17:15:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 71D6418B4F;
	Wed, 14 May 2014 17:15:44 -0400 (EDT)
In-Reply-To: <20140514194128.GC2715@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 14 May 2014 15:41:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E9374A0E-DBAC-11E3-A1D1-DDB853EDF712-77302942!pb-smtp0.pobox.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248953>

Jeff King <peff@peff.net> writes:

> On Wed, May 14, 2014 at 05:44:19PM +0200, Stepan Kasal wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Date: Mon, 8 Nov 2010 16:10:43 +0100
>> 
>> Incidentally, this makes grep -I respect the "binary" attribute (actually,
>> the "-text" attribute, but "binary" implies that).
>> 
>> Since the attributes are not thread-safe, we now need to switch off
>> threading if -I was passed.
>> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
>> ---
>> 
>> Hi,
>> this patch has been in msysgit for 3.5 years.
>> Stepan
>
> Hrm. Is this patch still necessary? In the time since this patch was
> written, we did 0826579 (grep: load file data after checking
> binary-ness, 2012-02-02), which should do the same thing. It deals with
> the threading via a lock, but we later learned in 9dd5245 (grep:
> pre-load userdiff drivers when threaded, 2012-02-02) to hoist that bit
> out.

Wow, power of Git history ;-)

> So I suspect this patch at best is doing nothing, and at worst is
> wasting extra time doing redundant attribute checks.

Sounds like a sensible conclusion.  Thanks.

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
