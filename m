From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep -I: do not bother to read known-binary files
Date: Wed, 14 May 2014 15:41:29 -0400
Message-ID: <20140514194128.GC2715@sigill.intra.peff.net>
References: <20140514154419.GA4517@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBDO2DJFKTEFBB24NZ6NQKGQEVHMKUII@googlegroups.com Wed May 14 21:41:34 2014
Return-path: <msysgit+bncBDO2DJFKTEFBB24NZ6NQKGQEVHMKUII@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f57.google.com ([209.85.213.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBB24NZ6NQKGQEVHMKUII@googlegroups.com>)
	id 1Wkf3U-0001NW-QT
	for gcvm-msysgit@m.gmane.org; Wed, 14 May 2014 21:41:32 +0200
Received: by mail-yh0-f57.google.com with SMTP id c41sf600521yho.2
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 12:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=+Ilf1FJ6s5e5w/5ISGkIxYle1U+Mil+vPTfYlffv7Ns=;
        b=Bg+ihMfe/jtfqdhpb3wjtI+mF+yz/WmV4KDCkax0YbsCQaZY7eyjd53AR7mzY0Z61L
         T+dHqVD+0Hsqf1nZJXV3bUAA7BWSDOobx7CawvMxmXC+kA72ZGVWOcXcepk+lhU6R6To
         +sfGzs5EyeUCyTjZ0/VNS32Ye5zxA1E6okpjFg65I1XvOVC8NLbxJkKvjlf59gD30a73
         J7SfrxOafCQu1tz6cVEdz2AB/Dzg+KKkUwP1mcqSNrvQXj/TKDYwa9XVVUrIws/X2gjV
         hQ1shBdPhj4Stbm4u0Y8YMXVR0TleYpB0b2+etARJbyeFl6ial1vZo7Hp4eR0ZNRdjIR
         MB0A==
X-Received: by 10.140.47.201 with SMTP id m67mr44001qga.29.1400096492017;
        Wed, 14 May 2014 12:41:32 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.19.9 with SMTP id 9ls2436423qgg.75.gmail; Wed, 14 May 2014
 12:41:31 -0700 (PDT)
X-Received: by 10.236.171.169 with SMTP id r29mr2268612yhl.32.1400096491315;
        Wed, 14 May 2014 12:41:31 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id jj2si1332998igb.3.2014.05.14.12.41.31
        for <msysgit@googlegroups.com>;
        Wed, 14 May 2014 12:41:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 10416 invoked by uid 102); 14 May 2014 19:41:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 May 2014 14:41:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 May 2014 15:41:29 -0400
In-Reply-To: <20140514154419.GA4517@camelia.ucw.cz>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted
 sender) smtp.mail=peff@peff.net
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
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248941>

On Wed, May 14, 2014 at 05:44:19PM +0200, Stepan Kasal wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Mon, 8 Nov 2010 16:10:43 +0100
> 
> Incidentally, this makes grep -I respect the "binary" attribute (actually,
> the "-text" attribute, but "binary" implies that).
> 
> Since the attributes are not thread-safe, we now need to switch off
> threading if -I was passed.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Stepan Kasal <kasal@ucw.cz>
> ---
> 
> Hi,
> this patch has been in msysgit for 3.5 years.
> Stepan

Hrm. Is this patch still necessary? In the time since this patch was
written, we did 0826579 (grep: load file data after checking
binary-ness, 2012-02-02), which should do the same thing. It deals with
the threading via a lock, but we later learned in 9dd5245 (grep:
pre-load userdiff drivers when threaded, 2012-02-02) to hoist that bit
out.

So I suspect this patch at best is doing nothing, and at worst is
wasting extra time doing redundant attribute checks.

-Peff

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
