From: Jeff King <peff@peff.net>
Subject: Re: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Mon, 12 Nov 2012 23:05:41 -0500
Message-ID: <20121113040541.GA9439@sigill.intra.peff.net>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com>
 <03ED9D50D1F64467863C051959CFC433@PhilipOakley>
 <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
 <509FD668.20609@lsrfire.ath.cx>
 <20121111165431.GA25884@sigill.intra.peff.net>
 <CA+TMuX2p4ck0qXijH+OOcBoveBC42U8PqnXdisau57RXwt1isg@mail.gmail.com>
 <20121112231453.GA21679@sigill.intra.peff.net>
 <alpine.DEB.1.00.1211130114180.13573@bonsai2>
 <20121113034605.GB8387@sigill.intra.peff.net>
 <alpine.DEB.1.00.1211130400030.13573@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	msysgit@googlegroups.com, Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncBDO2DJFKTEFBBGUOQ6CQKGQEAU6UIII@googlegroups.com Tue Nov 13 05:05:58 2012
Return-path: <msysgit+bncBDO2DJFKTEFBBGUOQ6CQKGQEAU6UIII@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oa0-f58.google.com ([209.85.219.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBGUOQ6CQKGQEAU6UIII@googlegroups.com>)
	id 1TY7l7-0003TA-B1
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 05:05:57 +0100
Received: by mail-oa0-f58.google.com with SMTP id l10sf5489653oag.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 Nov 2012 20:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition;
        bh=0uZXDGPFNNuP/+Xz/p3t8IMq3LZmfndrrIYMe4hrnto=;
        b=DzwVRKZdSph2KnNhSP9rDJI0e85NC0KOVuebT1myw1rUbLk2RNCCxhiG9eAvPrD1FI
         7LVBZxzzeFep7R1dQ47IB2TGweQV+zyRH6T9VMPwf3KeIKDbxkGTZxrBnWRVcmP7zPKv
         DteXndstwlNafb7xh4gY4JftTvnD4BOk8Evj5jivFRMS+HmJAu1pH0UTzOqupWZ6X1h4
         CRkNMH82c/23t82qlL7HE73bIf/NTlRP/6nGNegA92dQt1/jv9zW5O3EhjfJJhDxBUM5
         WneHkKOqULWixi6kZApQ2TaqrtmyKV8SVB6g0H2f0yYJHsOKmrlWJBTEvkCgFMDOtCmz
       
Received: by 10.50.12.169 with SMTP id z9mr5647190igb.1.1352779546887;
        Mon, 12 Nov 2012 20:05:46 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.194.196 with SMTP id hy4ls7393972igc.0.canary; Mon, 12 Nov
 2012 20:05:46 -0800 (PST)
Received: by 10.50.202.10 with SMTP id ke10mr7646017igc.2.1352779546264;
        Mon, 12 Nov 2012 20:05:46 -0800 (PST)
Received: by 10.50.202.10 with SMTP id ke10mr7646016igc.2.1352779546255;
        Mon, 12 Nov 2012 20:05:46 -0800 (PST)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id us14si1001662igb.3.2012.11.12.20.05.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 20:05:46 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 18811 invoked by uid 107); 13 Nov 2012 04:06:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 23:06:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 23:05:41 -0500
In-Reply-To: <alpine.DEB.1.00.1211130400030.13573@bonsai2>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209570>

On Tue, Nov 13, 2012 at 04:01:11AM +0000, Johannes Schindelin wrote:

> > Note that name-rev will produce wrong answers in the face of clock skew.
> > And I think that you even wrote that code. :)
> 
> IIRC the cute code to short-circuit using the date is not from me. If it
> is, I am very ashamed.

Sorry, but it was:

  $ git blame -L'/commit->date < cutoff/',+1  builtin/name-rev.c
  bd321bcc name-rev.c (Johannes Schindelin 2005-10-26 15:10:20 +0200 32)
  if (commit->date < cutoff)

But it is never too late to fix it. :)

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
