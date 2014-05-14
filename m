From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep -I: do not bother to read known-binary files
Date: Wed, 14 May 2014 15:44:42 -0400
Message-ID: <20140514194442.GD2715@sigill.intra.peff.net>
References: <20140514154419.GA4517@camelia.ucw.cz>
 <xmqqbnv0l02r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDO2DJFKTEFBBLMPZ6NQKGQEPGH5Q6I@googlegroups.com Wed May 14 21:44:47 2014
Return-path: <msysgit+bncBDO2DJFKTEFBBLMPZ6NQKGQEPGH5Q6I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f190.google.com ([209.85.214.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBLMPZ6NQKGQEPGH5Q6I@googlegroups.com>)
	id 1Wkf6c-0000pu-RJ
	for gcvm-msysgit@m.gmane.org; Wed, 14 May 2014 21:44:46 +0200
Received: by mail-ob0-f190.google.com with SMTP id wm4sf5293obc.17
        for <gcvm-msysgit@m.gmane.org>; Wed, 14 May 2014 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=CpaxgX9fKsXjSLzRor8/QUsSFLSW2qrGC4jUkNM83dI=;
        b=pOnMs9c4rflWvGTeFKvq1xW2zKbIcbixdDeuvg/FP8IFrG1mjy6Lv7bNuny1h1FH09
         eAqwzQIbXFR+V7bIIOp4kICU0hsti6iat/I1sv8dKe5NCtVmgR57/Rruup4ZF0+CGgMU
         DSajE/OLWeaZswVBacr8FwiaNMhwC1dOnp6r8Z4UyLNvClz26V+2oKfUcqxV7liI91VL
         fvbdRZ8PBOBVY9Buo2yjMyZdocf3B9v8VpQc6+iu/jy4QAWH+1qNiG5OSPVDmtuf0L/V
         g3+VC2G9+z+bmruw4EV2PS4UJMvlMx9n4wA00j9t2fsfLveLLempSFMZvDCnVU0n+/QS
         KXuQ==
X-Received: by 10.50.103.104 with SMTP id fv8mr442804igb.2.1400096685948;
        Wed, 14 May 2014 12:44:45 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.66.237 with SMTP id i13ls3016112igt.32.gmail; Wed, 14 May
 2014 12:44:45 -0700 (PDT)
X-Received: by 10.68.253.66 with SMTP id zy2mr2675936pbc.1.1400096685179;
        Wed, 14 May 2014 12:44:45 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id b5si274715igl.0.2014.05.14.12.44.44
        for <msysgit@googlegroups.com>;
        Wed, 14 May 2014 12:44:45 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 10573 invoked by uid 102); 14 May 2014 19:44:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 May 2014 14:44:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 May 2014 15:44:42 -0400
In-Reply-To: <xmqqbnv0l02r.fsf@gitster.dls.corp.google.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248942>

On Wed, May 14, 2014 at 10:52:28AM -0700, Junio C Hamano wrote:

> I do not think checking 'text' is the right way to do this.  The
> attribute controls the eof normalization, and people sometimes want
> to keep CRLF terminated files in the repository no matter what the
> platform is (an example I heard is a sample protocol exchange over
> textual network protocol such as HTTP and SMTP), and the way to do
> so is to unset it.  That would still let them look for patterns in
> and compare the changes to these paths.
> 
> Looking for "Marking files as binary" in gitattributes(5) gives us a
> more authoritative alternative, I think.  In short:
> 
>  - If 'diff' is Unset, or
>  - If 'diff' is Set to X and diff.X.binary is true
>
> then the contents are not suitable for human consumption.

I responded elsewhere in the thread that I think the patch under
discussion is redundant at this point, but just to clarify: grep
currently uses the rules you give above, as it builds on the userdiff
driver code.

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
