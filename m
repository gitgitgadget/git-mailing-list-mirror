From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] entry.c: convert checkout_entry to use strbuf
Date: Wed, 23 Oct 2013 13:52:29 -0400
Message-ID: <20131023175229.GB6824@sigill.intra.peff.net>
References: <20131021193223.GC29681@sigill.intra.peff.net>
 <1382532907-30561-1-git-send-email-pclouds@gmail.com>
 <20131023172914.GA6824@sigill.intra.peff.net>
 <CABPQNSZgFa1Roq=aEg8CBpo320hP7bFEOq2RK8xY3fESdYLdTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>, Antoine Pelisse <apelisse@gmail.com>,
	Torsten =?utf-8?B?QsODwrZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Wataru Noguchi <wnoguchi.0727@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?UmVuw4PCqQ==?= Scharfe <l.s.r@web.de>,
	msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBYEZUCJQKGQEX2TNHTA@googlegroups.com Wed Oct 23 19:52:34 2013
Return-path: <msysgit+bncBDO2DJFKTEFBBYEZUCJQKGQEX2TNHTA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f188.google.com ([209.85.216.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBYEZUCJQKGQEX2TNHTA@googlegroups.com>)
	id 1VZ2bi-0006hG-1R
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 19:52:34 +0200
Received: by mail-qc0-f188.google.com with SMTP id k8sf248586qcq.15
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 10:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=IWPP1N9V2pYPR9ScaHvzwZ8ItNo5MnzLsYharPA60yI=;
        b=Sm0EOh/dl3uSBewy9dDwtHYRzTSNncha0uEQmxC94JVcNP8MIFyLY7cHZ62d0Sfuu2
         9PbVThpfxAK1YZjhrCEAQWtnVh4ycdOZxEAms0YLNg8DW/HDRekoUNh4Du80does+jex
         wbdJv7xM+NAUMK9N9rhOAymGVIzR9MVeudEI2r8njjna0+akPJsIjWs4u53urOQVbCV8
         r0+hK9KgDlLCqU8Wxz8AcSPatlmrdgtzOlQjrPdngZn2yf6Sl4ny03Uj2wgRY2+TDj3l
         3UrKjFhj7r9vqUHmiGl5Aedm/R217O6w/Dbuj+4oEqYYwz0HZlleaKLqeQ44B2uCVLRD
         cZZQ==
X-Received: by 10.50.170.228 with SMTP id ap4mr94566igc.16.1382550753253;
        Wed, 23 Oct 2013 10:52:33 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.29.110 with SMTP id j14ls3198959igh.34.canary; Wed, 23 Oct
 2013 10:52:32 -0700 (PDT)
X-Received: by 10.67.3.34 with SMTP id bt2mr1663490pad.41.1382550752282;
        Wed, 23 Oct 2013 10:52:32 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id vn2si1218452igb.2.2013.10.23.10.52.31
        for <msysgit@googlegroups.com>;
        Wed, 23 Oct 2013 10:52:31 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 27875 invoked by uid 102); 23 Oct 2013 17:52:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Oct 2013 12:52:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Oct 2013 13:52:29 -0400
In-Reply-To: <CABPQNSZgFa1Roq=aEg8CBpo320hP7bFEOq2RK8xY3fESdYLdTg@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236539>

On Wed, Oct 23, 2013 at 07:34:18PM +0200, Erik Faye-Lund wrote:

> >> -     memcpy(path, state->base_dir, len);
> >> -     strcpy(path + len, ce->name);
> >> -     len += ce_namelen(ce);
> >> +     strbuf_reset(&path_buf);
> >> +     strbuf_addf(&path_buf, "%.*s%s", state->base_dir_len, state->base_dir, ce->name);
> >> +     path = path_buf.buf;
> >> +     len = path_buf.len;
> >
> > This is not something you introduced, but while we are here, you may
> > want to use ce->namelen, which would be a little faster than treating it
> > as a string (especially for strbuf, as it can then know up front how big
> > the size is).
> >
> > I doubt it's measurable, though (especially as the growth cost is
> > amortized due to the static buffer).
> 
> I somehow feel that:
> 
> strbuf_reset(&path_buf);
> strbuf_add(&path_buf, state->base_dir, state->base_dir_len);
> strbuf_addch(&path_buf, '/');
> strbuf_add(&path_buf, state->name, state->name_len);
> 
> feels a bit neater than using strbuf_addf. But that might just be me.

I agree. But note that your addch is a bug. :)

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
For more options, visit https://groups.google.com/groups/opt_out.
