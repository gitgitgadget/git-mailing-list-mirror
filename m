From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v4 3/3] add command performance tracing to
 debug scripted commands
Date: Thu, 22 May 2014 05:59:20 -0400
Message-ID: <20140522095920.GA15461@sigill.intra.peff.net>
References: <537BA806.50600@gmail.com>
 <537BA8DC.9070104@gmail.com>
 <20140521165508.GC2040@sigill.intra.peff.net>
 <537D4790.6030106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBB7EU66NQKGQEEB33OMQ@googlegroups.com Thu May 22 11:59:26 2014
Return-path: <msysgit+bncBDO2DJFKTEFBB7EU66NQKGQEEB33OMQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yh0-f57.google.com ([209.85.213.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBB7EU66NQKGQEEB33OMQ@googlegroups.com>)
	id 1WnPmY-0006Iw-1m
	for gcvm-msysgit@m.gmane.org; Thu, 22 May 2014 11:59:26 +0200
Received: by mail-yh0-f57.google.com with SMTP id c41sf817475yho.22
        for <gcvm-msysgit@m.gmane.org>; Thu, 22 May 2014 02:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=KDRNFIdKFp+Yh4puR6ZfigX+N8spUnzoqFAgVQLsR38=;
        b=ZIf1+EXljbY/SVSmeQBn3MCL8a+drpPA5HcLGnrdW1AaGqsnPcEmkX4oIsge/TCr81
         vHXRb+P6+hiBUS/v+XmUvQ9ys/9OVFo6jske1IwRojTP+VeGnubxiruEZPxc1929l2P3
         k3Hjpg8CXcg3vv6IH0ygobCDZisn6Ee03y+gLhocvlkJkOPUPcUTNpKRNu6zxMAKyRUI
         N5FceI1Ru7uDMCRrAYEFjPtbEfCw4L3osbko8Wy41qJSIIiEJUKohmdBB8PC93Yfhyks
         FXzQz4JTd1qAZlS/xDe2y3WYcC+a/p4WZWBJ+2pko2idKDkCGFotNXJqeOlX1tipOskG
         1VTw==
X-Received: by 10.50.8.1 with SMTP id n1mr446431iga.5.1400752765107;
        Thu, 22 May 2014 02:59:25 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.122.98 with SMTP id lr2ls3557330igb.7.canary; Thu, 22 May
 2014 02:59:24 -0700 (PDT)
X-Received: by 10.68.253.66 with SMTP id zy2mr25494928pbc.1.1400752764317;
        Thu, 22 May 2014 02:59:24 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id b5si440398igl.0.2014.05.22.02.59.23
        for <msysgit@googlegroups.com>;
        Thu, 22 May 2014 02:59:24 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 14159 invoked by uid 102); 22 May 2014 09:59:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 04:59:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 05:59:20 -0400
In-Reply-To: <537D4790.6030106@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249897>

On Thu, May 22, 2014 at 02:40:48AM +0200, Karsten Blees wrote:

> E.g. if I'm interested in a particular code section, I throw in 2
> lines of code (before and after the code section). This gives very
> accurate results, without significantly affecting overall performance.
> I can then push the changes to my Linux/Windows box and get comparable
> results there. No need to disable optimization. No worries that the
> profiling tool isn't available on the other platform. No analyzing
> megabytes of mostly irrelevant profiling data.
> 
> Does that make sense?

Ah, I see. I misunderstood from your example above.

I do agree that automatically stamping with __FILE__ and __LINE__ is
very helpful there. Could we maybe restrict that use of the variadic
macros to a few known-good compilers (maybe #ifdef __GNUC__, which also
hits clang, and something to catch MSVC)? On other systems it would
become a compile-time noop, and they could live without the feature.

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
