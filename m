From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/5] mingw: make fgetc raise SIGINT if apropriate
Date: Sat, 1 Dec 2012 12:39:43 -0500
Message-ID: <20121201173943.GA18339@sigill.intra.peff.net>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com>
 <1352815447-8824-2-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1211301857170.31987@s15462909.onlinehome-server.info>
 <20121130181119.GA7197@sigill.intra.peff.net>
 <CABPQNSZaaZsfcC6dHDEhYUDpX4doQC7H=1VHGHuqfU4+m31jkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBB2UB5GCQKGQEN67QLFY@googlegroups.com Sat Dec 01 18:40:08 2012
Return-path: <msysgit+bncBDO2DJFKTEFBB2UB5GCQKGQEN67QLFY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBB2UB5GCQKGQEN67QLFY@googlegroups.com>)
	id 1Ter2t-00062J-L6
	for gcvm-msysgit@m.gmane.org; Sat, 01 Dec 2012 18:40:07 +0100
Received: by mail-pb0-f58.google.com with SMTP id xa7sf1462942pbc.3
        for <gcvm-msysgit@m.gmane.org>; Sat, 01 Dec 2012 09:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=Dv32iieLc6fpv6E7i31yonjamE6dB2a2EsNNpVOEdd8=;
        b=Hv09GNp7m8AYO44aoG0rg9CyF+eF7tgqvDe0wRE9MjuOPlzUw+Do8lnpGquUiBq5ez
         PofjXfXns+DT6mMnnIAe2E6uURyPUP0L76CToImDw94HSyJ1J7rEVQDiUUNmhEDh/jRB
         IqmNTRHao1lgDeV9s3R4/f1rRi6FBTAsmpcQHE5Qb4qy0b2EPv+K2VtnTByFyr+4OWur
         DP/hbD7YXqCPHHkNjiOZC9rXXOSG8tE+rWwXPm3EHrDvn0VWxJLK1xIoA4p+qUd0WqbP
         FhgySW9Fv4r3fLoNMFZ8fBhNGUt0+pzQekIEp6u+6MWCeDBlOVA1b/HQ1cBUvesO7au2
       
Received: by 10.50.196.199 with SMTP id io7mr572825igc.4.1354383595118;
        Sat, 01 Dec 2012 09:39:55 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.222.129 with SMTP id qm1ls604688igc.28.gmail; Sat, 01 Dec
 2012 09:39:54 -0800 (PST)
Received: by 10.50.0.148 with SMTP id 20mr1576211ige.3.1354383594481;
        Sat, 01 Dec 2012 09:39:54 -0800 (PST)
Received: by 10.50.0.148 with SMTP id 20mr1576208ige.3.1354383594470;
        Sat, 01 Dec 2012 09:39:54 -0800 (PST)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id s15si298420igi.1.2012.12.01.09.39.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 01 Dec 2012 09:39:54 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 14812 invoked by uid 107); 1 Dec 2012 17:40:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Dec 2012 12:40:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Dec 2012 12:39:43 -0500
In-Reply-To: <CABPQNSZaaZsfcC6dHDEhYUDpX4doQC7H=1VHGHuqfU4+m31jkA@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210982>

On Sat, Dec 01, 2012 at 01:31:23PM +0100, Erik Faye-Lund wrote:

> >> One thing you might want to mention is that the fgetc() handling is not
> >> thread-safe, and intentionally so: if two threads read from the same
> >> console, we are in trouble anyway.
> >
> > That makes sense to me, but I'm confused why it is part of mingw_fgetc,
> > which could in theory read from arbitrary streams, no? It it is not
> > necessarily a console operation at all. I feel like I'm probably missing
> > something subtle here...
> 
> I did add an early out for the non-console cases. Is this what you're
> missing, perhaps?

Oops, yes. That is exactly what I was missing. :)

Sorry for the noise.

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
