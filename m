From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 2/5] compat/terminal: factor out echo-disabling
Date: Fri, 30 Nov 2012 13:19:32 -0500
Message-ID: <20121130181932.GB7197@sigill.intra.peff.net>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-3-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1211301858570.31987@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDO2DJFKTEFBBNXR4OCQKGQEARLHVTI@googlegroups.com Fri Nov 30 19:19:49 2012
Return-path: <msysgit+bncBDO2DJFKTEFBBNXR4OCQKGQEARLHVTI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ye0-f186.google.com ([209.85.213.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBNXR4OCQKGQEARLHVTI@googlegroups.com>)
	id 1TeVBk-00015m-6g
	for gcvm-msysgit@m.gmane.org; Fri, 30 Nov 2012 19:19:48 +0100
Received: by mail-ye0-f186.google.com with SMTP id l10sf757301yen.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 30 Nov 2012 10:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=H8V5SLOYBgztkGQa9l4SJKmF/ksY47W6Ap8MPmacGL8=;
        b=XEhoRfwgc3yWlys/fwXlChxYl3+qDobTI7kDOBb9ufqOi8YNJDAFStr+bSWZlUBc1l
         Sl/ErbdjgBNHm/5NRqeoT3LIjBQUJWKAI0du2niqYvf9D78wCvWswpIneOcdZQEHawPP
         Pf5/4LZKoDA96MVhsBPQV+Vo8D2HsLOEOoeRVYgO7XVs4zaoM4LeziYl9ouxZibTQqUY
         WiaQ/UoDmqsYtQRdhcqmUWaCdSQVBzoCjrBSUyTpKGBf+GSVoaomk8yJBEMYCNF4ykZ4
         Y/FmYwg930aQcCj0/TdClxsCH5IuyCX3cHDphrPf4zeLk+2lyt5o1OX7ziTS4PmkWMLZ
       
Received: by 10.50.212.69 with SMTP id ni5mr2472689igc.5.1354299575956;
        Fri, 30 Nov 2012 10:19:35 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.1.230 with SMTP id 6ls6415514igp.15.canary; Fri, 30 Nov
 2012 10:19:34 -0800 (PST)
Received: by 10.42.215.203 with SMTP id hf11mr1715894icb.17.1354299574371;
        Fri, 30 Nov 2012 10:19:34 -0800 (PST)
Received: by 10.42.215.203 with SMTP id hf11mr1715892icb.17.1354299574336;
        Fri, 30 Nov 2012 10:19:34 -0800 (PST)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id wu4si1315857igb.3.2012.11.30.10.19.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Nov 2012 10:19:34 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 5299 invoked by uid 107); 30 Nov 2012 18:20:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Nov 2012 13:20:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2012 13:19:32 -0500
In-Reply-To: <alpine.DEB.1.00.1211301858570.31987@s15462909.onlinehome-server.info>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 75.15.5.89 as permitted sender) smtp.mail=peff@peff.net
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210937>

On Fri, Nov 30, 2012 at 06:59:30PM +0100, Johannes Schindelin wrote:

> > diff --git a/compat/terminal.c b/compat/terminal.c
> > index bbb038d..3217838 100644
> > --- a/compat/terminal.c
> > +++ b/compat/terminal.c
> > @@ -14,6 +14,7 @@ static void restore_term(void)
> >  		return;
> >  
> >  	tcsetattr(term_fd, TCSAFLUSH, &old_term);
> > +	close(term_fd);
> >  	term_fd = -1;
> >  }
> 
> That looks like an independent resource leak fix... correct?

I don't think so. In the current code, term_fd does not take ownership
of the fd. It is fundamentally part of the FILE* in git_terminal_prompt,
and is closed when we fclose() that. But in Erik's refactor, we actually
open a _second_ descriptor to /dev/tty, which needs to be closed.

I don't think there is any reason that should not work (the terminal
characteristics should be per-tty, not per-descriptor), though it does
feel a little hacky to have to open /dev/tty twice.

-Peff

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
