From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC 2/5] compat/terminal: factor out echo-disabling
Date: Tue, 4 Dec 2012 18:12:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1212041812160.31987@s15462909.onlinehome-server.info>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com> <1352815447-8824-3-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1211301858570.31987@s15462909.onlinehome-server.info>
 <CABPQNSY_vHdvBvU_ezjyOzoZeBJAYTJ2829o6Vxs-nJjQVcvDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRB7O57CCQKGQESRK2VHY@googlegroups.com Tue Dec 04 18:12:42 2012
Return-path: <msysgit+bncBCZPH74Q5YNRB7O57CCQKGQESRK2VHY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ee0-f58.google.com ([74.125.83.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB7O57CCQKGQESRK2VHY@googlegroups.com>)
	id 1Tfw30-0000XZ-0O
	for gcvm-msysgit@m.gmane.org; Tue, 04 Dec 2012 18:12:42 +0100
Received: by mail-ee0-f58.google.com with SMTP id e49sf1681660eek.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 04 Dec 2012 09:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=z+d4ouYoSisa7+qjiD21NNY4CqhZXFv1rrVpGz6mp94=;
        b=CynZk8uT5AHCytGz4lauLrf+mDP2R41LJNpF4lgfxt55Mbk0Fo+q/lMyLOyabOjxgG
         nTPbUfQ1VF4tWpMytYKEIfDlUuHpIZWfxqWdLS/mj9qgjPA0RxYHDgkk1fTTM0ur/11h
         nRFGImLZ+KLc1h98TQ2H+ZO+O72rqdvpAYz+gterNxa6BVy11TJAN/kWJHTWL6lz4eWt
         Yu1f+u23KG8sZQzS7cGGVGu7meD5YufFpP18kA2pRSuEAh3XPHY3kcfOIya6mDmE2bTk
         1fKyszhTtuLnuzA85N 
Received: by 10.180.99.69 with SMTP id eo5mr651423wib.3.1354641150293;
        Tue, 04 Dec 2012 09:12:30 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.76.74 with SMTP id i10ls417061wiw.9.gmail; Tue, 04 Dec
 2012 09:12:29 -0800 (PST)
Received: by 10.14.216.197 with SMTP id g45mr15144897eep.3.1354641149514;
        Tue, 04 Dec 2012 09:12:29 -0800 (PST)
Received: by 10.14.216.197 with SMTP id g45mr15144896eep.3.1354641149502;
        Tue, 04 Dec 2012 09:12:29 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.23])
        by gmr-mx.google.com with SMTP id u8si577471een.1.2012.12.04.09.12.29;
        Tue, 04 Dec 2012 09:12:29 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted sender) client-ip=213.165.64.23;
Received: (qmail invoked by alias); 04 Dec 2012 17:12:29 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp033) with SMTP; 04 Dec 2012 18:12:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+G7ZB/wCyG2cNEsSSiwK5kvBZhUlx7GYH9gdOxhb
	TDZvCN4ZkSajIS
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <CABPQNSY_vHdvBvU_ezjyOzoZeBJAYTJ2829o6Vxs-nJjQVcvDQ@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211089>

Hi kusma,

On Sat, 1 Dec 2012, Erik Faye-Lund wrote:

> On Fri, Nov 30, 2012 at 6:59 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Tue, 13 Nov 2012, Erik Faye-Lund wrote:
> >
> >> By moving the echo-disabling code to a separate function, we can
> >> implement OS-specific versions of it for non-POSIX platforms.
> >>
> >> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> >> ---
> >>  compat/terminal.c | 43 +++++++++++++++++++++++++------------------
> >>  1 file changed, 25 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/compat/terminal.c b/compat/terminal.c
> >> index bbb038d..3217838 100644
> >> --- a/compat/terminal.c
> >> +++ b/compat/terminal.c
> >> @@ -14,6 +14,7 @@ static void restore_term(void)
> >>               return;
> >>
> >>       tcsetattr(term_fd, TCSAFLUSH, &old_term);
> >> +     close(term_fd);
> >>       term_fd = -1;
> >>  }
> >
> > That looks like an independent resource leak fix... correct?
> 
> It might look like it, but it's not; term_fd used to be returned by
> "fileno(fh)", and fh did get properly closed.
> 
> With my refactoring, disable_echo/restore_term takes opens /dev/tty a
> second time, like Jeff points out. And that second file descriptor
> needs to be closed.

Thanks for clarifying,
Dscho

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
