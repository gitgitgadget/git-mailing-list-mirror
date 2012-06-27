From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] compat/terminal: support echoing on windows
Date: Wed, 27 Jun 2012 17:08:11 -0400
Message-ID: <20120627210810.GC2292@sigill.intra.peff.net>
References: <1340544903-37016-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncCN2hpKqZChC-7K3_BBoEx1D7AQ@googlegroups.com Wed Jun 27 23:08:16 2012
Return-path: <msysgit+bncCN2hpKqZChC-7K3_BBoEx1D7AQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f55.google.com ([209.85.213.55])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCN2hpKqZChC-7K3_BBoEx1D7AQ@googlegroups.com>)
	id 1SjzTD-0001zp-UM
	for gcvm-msysgit@m.gmane.org; Wed, 27 Jun 2012 23:08:16 +0200
Received: by yhgm50 with SMTP id m50sf1688827yhg.10
        for <gcvm-msysgit@m.gmane.org>; Wed, 27 Jun 2012 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=T6LZlUZzA/CVQj8T9J/IjbDud7H6rT6tLJCL2s4X/j4=;
        b=bS003mhkQCmQDZNqJtGmisCdS0hSHzqEBqXWRYwI7wIJyiCZI+3aXF/AqhwGh1Uex5
         prYpE0M/dTGvDGK4JLOyaRIKXITaGdTb/t1K/AeGnuViFkqDJrCgongHwpMdH3BZ2K8s
         5QvMoBHC/V8wKJn9+VT6Ydqw96U2zoCEBQxyQ=
Received: by 10.236.157.166 with SMTP id o26mr3514360yhk.10.1340831294946;
        Wed, 27 Jun 2012 14:08:14 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.236.42.69 with SMTP id i45ls3558437yhb.3.gmail; Wed, 27 Jun
 2012 14:08:14 -0700 (PDT)
Received: by 10.236.191.40 with SMTP id f28mr36945333yhn.2.1340831294098;
        Wed, 27 Jun 2012 14:08:14 -0700 (PDT)
Received: by 10.236.191.40 with SMTP id f28mr36945332yhn.2.1340831294087;
        Wed, 27 Jun 2012 14:08:14 -0700 (PDT)
Received: from peff.net (99-108-225-23.lightspeed.iplsin.sbcglobal.net. [99.108.225.23])
        by gmr-mx.google.com with ESMTPS id f27si9352162anj.1.2012.06.27.14.08.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Jun 2012 14:08:14 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 99.108.225.23 as permitted sender) client-ip=99.108.225.23;
Received: (qmail 3498 invoked by uid 107); 27 Jun 2012 21:08:17 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jun 2012 17:08:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jun 2012 17:08:11 -0400
In-Reply-To: <1340544903-37016-1-git-send-email-kusmabite@gmail.com>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of peff@peff.net designates 99.108.225.23 as permitted sender) smtp.mail=peff@peff.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200754>

On Sun, Jun 24, 2012 at 03:35:03PM +0200, Erik Faye-Lund wrote:

> Without /dev/tty support, git_terminal_prompt simply ignores the
> 'echo'-parameter. On Windows we can do better by clevering up our
> getpass-implementation a bit so it can conditionally echo.
> 
> While we're at it, plug a small memory-leak by returning a pointer
> to a static strbuf instead of detaching it. This is the same thing
> the /dev/tty-version of git_terminal_prompt does, and the callee
> doesn't expect to have to free it's memory.

Very nice. I was hoping for something exactly like this when I wrote the
original git_terminal_prompt patch.

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
