From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v4 3/3] add command performance tracing to
 debug scripted commands
Date: Wed, 21 May 2014 12:55:08 -0400
Message-ID: <20140521165508.GC2040@sigill.intra.peff.net>
References: <537BA806.50600@gmail.com>
 <537BA8DC.9070104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, msysGit <msysgit@googlegroups.com>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBB35U6ONQKGQEFHBGAEQ@googlegroups.com Wed May 21 18:55:14 2014
Return-path: <msysgit+bncBDO2DJFKTEFBB35U6ONQKGQEFHBGAEQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f57.google.com ([209.85.220.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBB35U6ONQKGQEFHBGAEQ@googlegroups.com>)
	id 1Wn9nN-0001hE-7M
	for gcvm-msysgit@m.gmane.org; Wed, 21 May 2014 18:55:13 +0200
Received: by mail-pa0-f57.google.com with SMTP id rd3sf564726pab.12
        for <gcvm-msysgit@m.gmane.org>; Wed, 21 May 2014 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=ArmFT3Y+YEns/QlWPIY3D8jdMnqqoepvyGPuLO1WwVA=;
        b=RGkIPNZUjkI1IZjVWl40m8/Kk0xKroJ9ZRqXJxHPY1HrEQEvPrsaHjPlBQCuiND6oQ
         C4r5HxjfGVk/973D3q1EijpCBbrtfarpxRd1EsiUT4R0zyKLX9cIyGtWTpIv8LdaMwly
         kSWAvAWjjGdN7hPnxZUT7o/Pgh1+3RGxjld7GtjqMXrabCea58HwGcfHN+7H/7O5xLD4
         vT06TX02iw2LR1MG9FTAgQcdUwI2mc0p4ZR25Oma2t/ogPd6uptw9FG81rYwMlucoELH
         1QivZx6j6mTFA6toajJdBlj977sSsdBOvEglMS4qvxTNchcp5bAxbrBFpi7IqSTuq/dj
         dU7A==
X-Received: by 10.50.103.104 with SMTP id fv8mr327016igb.2.1400691312121;
        Wed, 21 May 2014 09:55:12 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.8.105 with SMTP id q9ls1222875iga.28.gmail; Wed, 21 May
 2014 09:55:11 -0700 (PDT)
X-Received: by 10.50.130.102 with SMTP id od6mr5100908igb.0.1400691311268;
        Wed, 21 May 2014 09:55:11 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id la2si247697igb.1.2014.05.21.09.55.10
        for <msysgit@googlegroups.com>;
        Wed, 21 May 2014 09:55:10 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 20903 invoked by uid 102); 21 May 2014 16:55:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 11:55:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 12:55:08 -0400
In-Reply-To: <537BA8DC.9070104@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249807>

On Tue, May 20, 2014 at 09:11:24PM +0200, Karsten Blees wrote:

> Add performance tracing to identify which git commands are called and how
> long they execute. This is particularly useful to debug performance issues
> of scripted commands.
> 
> Usage example: > GIT_TRACE_PERFORMANCE=~/git-trace.log git stash list
> 
> Creates a log file like this:
> performance: at trace.c:319, time: 0.000303280 s: git command: 'git' 'rev-parse' '--git-dir'
> performance: at trace.c:319, time: 0.000334409 s: git command: 'git' 'rev-parse' '--is-inside-work-tree'
> performance: at trace.c:319, time: 0.000215243 s: git command: 'git' 'rev-parse' '--show-toplevel'
> performance: at trace.c:319, time: 0.000410639 s: git command: 'git' 'config' '--get-colorbool' 'color.interactive'
> performance: at trace.c:319, time: 0.000394077 s: git command: 'git' 'config' '--get-color' 'color.interactive.help' 'red bold'
> performance: at trace.c:319, time: 0.000280701 s: git command: 'git' 'config' '--get-color' '' 'reset'
> performance: at trace.c:319, time: 0.000908185 s: git command: 'git' 'rev-parse' '--verify' 'refs/stash'
> performance: at trace.c:319, time: 0.028827774 s: git command: 'git' 'stash' 'list'

Neat. I actually wanted something like this just yesterday. It looks
like you are mainly tracing the execution of programs. Would it make
sense to just tie this to regular trace_* calls, and if
GIT_TRACE_PERFORMANCE is set, add a timestamp to each line?

Then we would not need to add separate trace_command_performance calls,
and other parts of the code that are already instrumented with GIT_TRACE
would get the feature for free.

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
