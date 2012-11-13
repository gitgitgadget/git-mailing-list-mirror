From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Tue, 13 Nov 2012 04:52:48 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.1211130452200.13573@bonsai2>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com> <03ED9D50D1F64467863C051959CFC433@PhilipOakley> <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com> <509FD668.20609@lsrfire.ath.cx> <20121111165431.GA25884@sigill.intra.peff.net>
 <CA+TMuX2p4ck0qXijH+OOcBoveBC42U8PqnXdisau57RXwt1isg@mail.gmail.com> <20121112231453.GA21679@sigill.intra.peff.net> <alpine.DEB.1.00.1211130114180.13573@bonsai2> <20121113034605.GB8387@sigill.intra.peff.net> <alpine.DEB.1.00.1211130400030.13573@bonsai2>
 <20121113040541.GA9439@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>, 
    =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>, 
    msysgit@googlegroups.com, Git List <git@vger.kernel.org>, 
    Philip Oakley <philipoakley@iee.org>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCZPH74Q5YNRBI5EQ6CQKGQEQRRKIVA@googlegroups.com Tue Nov 13 05:53:05 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBI5EQ6CQKGQEQRRKIVA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f186.google.com ([209.85.212.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBI5EQ6CQKGQEQRRKIVA@googlegroups.com>)
	id 1TY8Ug-0000NS-1c
	for gcvm-msysgit@m.gmane.org; Tue, 13 Nov 2012 05:53:02 +0100
Received: by mail-wi0-f186.google.com with SMTP id x18sf482116wia.3
        for <gcvm-msysgit@m.gmane.org>; Mon, 12 Nov 2012 20:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=Ca2bsxOvfSPhMew2YpoFfBfV2h33zj7d6mzDyh/ZcIQ=;
        b=Pa0X2H3AY1x/JPQ3Jwnzg0INzw3FrU7TRZxbLnNSu59pY++zhvaduMlW48XHQxgMZ8
         e4SSEYIhVBrRYASnO+yxxqA+X/5Ka6rtVzQrSrsSV+zBC48n0ed7ceK0RYtzrL+WYbeA
         KjiPJ4uoSkt00u1dhF+NrzNWH7UMW1//apjGCCLi/6raN5n1iQub7aVYnhp4W0wcKoyZ
         xSGU9ONB0iBqIwqvf2v3B4AY/FvE2uOWa+ETt6aVnJhIJW82s0AKgeznyIekpUJLK0BG
         IgajqaAVphMMWW9Ira 
Received: by 10.216.227.25 with SMTP id c25mr527771weq.8.1352782372508;
        Mon, 12 Nov 2012 20:52:52 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.14.209.132 with SMTP id s4ls798735eeo.9.gmail; Mon, 12 Nov
 2012 20:52:50 -0800 (PST)
Received: by 10.14.216.197 with SMTP id g45mr21794420eep.3.1352782370693;
        Mon, 12 Nov 2012 20:52:50 -0800 (PST)
Received: by 10.14.216.197 with SMTP id g45mr21794418eep.3.1352782370683;
        Mon, 12 Nov 2012 20:52:50 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.22])
        by gmr-mx.google.com with SMTP id u8si2153133een.1.2012.11.12.20.52.50;
        Mon, 12 Nov 2012 20:52:50 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted sender) client-ip=213.165.64.22;
Received: (qmail invoked by alias); 13 Nov 2012 04:52:50 -0000
Received: from unknown (EHLO bonsai2.local) [94.185.209.43]
  by mail.gmx.net (mp032) with SMTP; 13 Nov 2012 05:52:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YnpAz6bFYGuoeMM1HqrhkexJmHmWfRgnspqs/vf
	6uJClXy8nCWeiB
X-X-Sender: gene099@bonsai2
In-Reply-To: <20121113040541.GA9439@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.22 as permitted
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209572>

Hi Peff,

On Mon, 12 Nov 2012, Jeff King wrote:

> On Tue, Nov 13, 2012 at 04:01:11AM +0000, Johannes Schindelin wrote:
> 
> > > Note that name-rev will produce wrong answers in the face of clock skew.
> > > And I think that you even wrote that code. :)
> > 
> > IIRC the cute code to short-circuit using the date is not from me. If it
> > is, I am very ashamed.
> 
> Sorry, but it was:
> 
>   $ git blame -L'/commit->date < cutoff/',+1  builtin/name-rev.c
>   bd321bcc name-rev.c (Johannes Schindelin 2005-10-26 15:10:20 +0200 32)
>   if (commit->date < cutoff)
> 
> But it is never too late to fix it. :)

I will now go and find a hole to hide in. Or alternatively finally go to
sleep.

Ciao,
Johannes

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
