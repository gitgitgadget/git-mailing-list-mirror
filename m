From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] http_init: only initialize SSL for https
Date: Sat, 16 Mar 2013 08:03:00 -0400
Message-ID: <20130316120300.GA2626@sigill.intra.peff.net>
References: <1363269079-6124-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.1303141621340.3794@s15462909.onlinehome-server.info>
 <CABPQNSZNdGea9Nn91emWhfRGAZjZXm755UKArNr3EUy9CrSKHg@mail.gmail.com>
 <7vmwu6x72q.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1303142333170.3794@s15462909.onlinehome-server.info>
 <7vk3p9wqh5.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1303151054130.32216@tvnag.unkk.fr>
 <7v4ngcwt4w.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1303151719170.32216@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	kusmabite@gmail.com, git@vger.kernel.org, msysgit@googlegroups.com
To: Daniel Stenberg <daniel@haxx.se>
X-From: msysgit+bncBDO2DJFKTEFBB6F6SGFAKGQERKF7WKQ@googlegroups.com Sat Mar 16 13:03:31 2013
Return-path: <msysgit+bncBDO2DJFKTEFBB6F6SGFAKGQERKF7WKQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f57.google.com ([209.85.160.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBB6F6SGFAKGQERKF7WKQ@googlegroups.com>)
	id 1UGpph-0002D5-4B
	for gcvm-msysgit@m.gmane.org; Sat, 16 Mar 2013 13:03:29 +0100
Received: by mail-pb0-f57.google.com with SMTP id wy12sf1616020pbc.2
        for <gcvm-msysgit@m.gmane.org>; Sat, 16 Mar 2013 05:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-received:x-beenthere:x-received:received-spf:date:from:to:cc
         :subject:message-id:references:mime-version:in-reply-to
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-google-group-id:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=memaiuFYxAe19zPc2Ypbp3kVr1f1qpm94JoKKuK7SqQ=;
        b=J4K2iikMTsbrKC9cwSAc0VMGZtZF2XLRl2772p10/GoQUBht0wFuNYDLxODvW/lsBV
         2Ad09/V2BsWsNDFpxaHo8z8yCWaggwP86+6XvZfOyorN7ErzwCubwXBiyLXQKesyAFt8
         HQiTe2rPBNTq/hDMNJdorw6JJ0AlBiBmQ5c55imUL5yjhGyNDIvdkk4iYoozC5aSvntg
         y9wE0I0LJbp5qHFJ86+5aMmGs5Fx1XaAkKlGDIFlEQCzZfgOKieYXhYI5lap+5/751vB
         QJQzKLggcxYQHrfXbxM81v6cSrxnTWKhBYZ8wJ05/tP 
X-Received: by 10.50.242.37 with SMTP id wn5mr685655igc.15.1363435385185;
        Sat, 16 Mar 2013 05:03:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.192.169 with SMTP id hh9ls341045igc.6.canary; Sat, 16 Mar
 2013 05:03:04 -0700 (PDT)
X-Received: by 10.43.85.4 with SMTP id am4mr6635868icc.13.1363435384354;
        Sat, 16 Mar 2013 05:03:04 -0700 (PDT)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id fc5si92666igc.0.2013.03.16.05.03.04
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 16 Mar 2013 05:03:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 1891 invoked by uid 107); 16 Mar 2013 12:04:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Mar 2013 08:04:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Mar 2013 08:03:00 -0400
In-Reply-To: <alpine.DEB.2.00.1303151719170.32216@tvnag.unkk.fr>
X-Original-Sender: peff@peff.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted
 sender) smtp.mail=peff@peff.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218299>

On Fri, Mar 15, 2013 at 05:23:27PM +0100, Daniel Stenberg wrote:

> >Thanks, then we should stick to starting from ALL like everybody
> >else who followed the suggestion in the documentation.  Do you have
> >recommendations on the conditional dropping of SSL?
> 
> Not really, no.
> 
> SSL initing is as has been mentioned alredy only relevant with
> libcurl if an SSL powered protocol is gonna be used, so if checking
> the URL for the protocol is enough to figure this out then sure that
> should work fine.

But are we correct in assuming that curl will barf if it gets a redirect
to an ssl-enabled protocol? My testing seems to say yes:

  [in one terminal]
  $ nc -lCp 5001 <<\EOF
  HTTP/1.1 301
  Location: https://github.com/peff/git.git

  EOF

  [in another, git compiled with Erik's patch]
  $ git ls-remote http://localhost:5001
  error: SSL: couldn't create a context: error:140A90A1:lib(20):func(169):reason(161) while accessing http://localhost:5001/info/refs?service=git-upload-pack
  fatal: HTTP request failed

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
