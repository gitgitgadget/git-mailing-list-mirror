From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep -I: do not bother to read known-binary files
Date: Fri, 16 May 2014 04:29:58 -0400
Message-ID: <20140516082958.GA21956@sigill.intra.peff.net>
References: <20140514154419.GA4517@camelia.ucw.cz>
 <20140514194128.GC2715@sigill.intra.peff.net>
 <alpine.DEB.1.00.1405151940170.14982@s15462909.onlinehome-server.info>
 <20140515192226.GC29746@sigill.intra.peff.net>
 <20140516081957.GA19845@camelia.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Stepan Kasal <kasal@ucw.cz>
X-From: msysgit+bncBDO2DJFKTEFBBCMZ26NQKGQE4L3IOXI@googlegroups.com Fri May 16 10:30:04 2014
Return-path: <msysgit+bncBDO2DJFKTEFBBCMZ26NQKGQE4L3IOXI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ie0-f184.google.com ([209.85.223.184])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBCMZ26NQKGQE4L3IOXI@googlegroups.com>)
	id 1WlDWk-0002ww-MX
	for gcvm-msysgit@m.gmane.org; Fri, 16 May 2014 10:30:02 +0200
Received: by mail-ie0-f184.google.com with SMTP id at1sf608318iec.21
        for <gcvm-msysgit@m.gmane.org>; Fri, 16 May 2014 01:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=AEhVbjYtoK7lquysdAXQYFSkK1W+s/NOKjII/tnIWzo=;
        b=yK7s0zFwBIbEnuNEyDoAdVSJPzmf+X8SUYr0ZwJDfP3BsnsQ7dcUhvmgqh+4K/dJdK
         4pzX7BMgZq5xYz5sJkf3HbG7tBaApzz0nXCUjodXVWvVxQJvGk77arqiyD/cNmLE5Qyc
         i+EouVIwOiY2SQCLl+dwYuU/Xzjqma8UWFr6Czfo5ej+ILhCqzMD98jPkLvSHqDUMAKL
         aBMTGW7EDqZXOdyFh2AnBQvyZLd2+tLMRuaR5lobyoRJkbqCO9kmjt2yT4hbwNnUNJ+9
         HpLCMougw+ZafIuBhTXvIlFO1fXIJ+qCgvysaOnddxUUUhE3g93r6rggl2IbqnydKb4M
         Z2Qg==
X-Received: by 10.182.24.1 with SMTP id q1mr105367obf.4.1400229001841;
        Fri, 16 May 2014 01:30:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.65.129 with SMTP id x1ls213084obs.62.gmail; Fri, 16 May
 2014 01:30:00 -0700 (PDT)
X-Received: by 10.182.45.131 with SMTP id n3mr7767294obm.20.1400229000712;
        Fri, 16 May 2014 01:30:00 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id 8si318852igs.0.2014.05.16.01.30.00
        for <msysgit@googlegroups.com>;
        Fri, 16 May 2014 01:30:00 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 4621 invoked by uid 102); 16 May 2014 08:30:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 May 2014 03:30:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 May 2014 04:29:58 -0400
In-Reply-To: <20140516081957.GA19845@camelia.ucw.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249278>

On Fri, May 16, 2014 at 10:19:57AM +0200, Stepan Kasal wrote:

> On Thu, May 15, 2014 at 03:22:26PM -0400, Jeff King wrote:
> > As the person who is proposing the patch for git.git, I would hope
> > Stepan would follow up on such review and confirm whether or not it is
> > still needed.
> 
> well, I try to.  (I verified that "less -I" works in msysGit before
> submitting the fixup back there, fox example.)
> 
> But I think my role is to moderate the reconciliation.
> In this case, having read the discussion, I decided to to ask Dscho
> to drop the patch.
> 
> (It is always about balancing the risks and the expenses.)

Sure, I think that is reasonable, and I hope I did not sound like "blame
Stepan, he was screwed up". After reading Dscho's other message and
knowing that he has not much time for git, I was trying to communicate
that I did not expect _him_ to be dealing with it.

Git.git has existed for a long time without that patch, so from our
perspective, it is a new patch. And as with any new patch, I would
expect a submitter who receives review of "eh, don't we already do this"
to either look into it, or decide that the review is probably right and
not bother with it. And you did the latter, and that is totally fine and
reasonable.

>From msysgit's perspective, they may or may not want to revert the patch
that they already have. That is a _separate_ issue, and I think the
burden of effort goes the other way. The patch should stay unless
somebody goes to the work to confirm that it is not necessary (or unless
they want to accept my say-so and indication that I did not do fresh
testing, but that is up to them).

Sorry if that is long and/or obvious. There have been enough bad
feelings on the list lately that I didn't want there to be a
misunderstanding about what I meant.

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
