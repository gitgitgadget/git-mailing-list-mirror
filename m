From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Sun, 11 Nov 2012 11:54:31 -0500
Message-ID: <20121111165431.GA25884@sigill.intra.peff.net>
References: <1352568970-4669-1-git-send-email-jeanjacques.lafay@gmail.com>
 <03ED9D50D1F64467863C051959CFC433@PhilipOakley>
 <d9843c09-3ca9-406e-9df8-78603235d985@googlegroups.com>
 <509FD668.20609@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>,
	msysgit@googlegroups.com, Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: msysgit+bncBDO2DJFKTEFBBSVQ76CAKGQECNWIOGA@googlegroups.com Sun Nov 11 17:54:46 2012
Return-path: <msysgit+bncBDO2DJFKTEFBBSVQ76CAKGQECNWIOGA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBSVQ76CAKGQECNWIOGA@googlegroups.com>)
	id 1TXao0-0002vw-QY
	for gcvm-msysgit@m.gmane.org; Sun, 11 Nov 2012 17:54:45 +0100
Received: by mail-pb0-f58.google.com with SMTP id xa7sf81285pbc.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 11 Nov 2012 08:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :references:mime-version:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type:content-disposition
         :content-transfer-encoding;
        bh=xAdNX3joPco7kbpacs2UHph7AyV3M3Yc0h3DV8mhWNM=;
        b=ds1ts+2Qiq6aA+4bXzlJxDjk5asWP1gnwxBhHrlABAgX6p/iBLMMmBvkbJVBerskHr
         CB5xRtSkZ8EjPskqTZtOVM+g4Uhpmii+4/YhTCWiZT+8JrqHhI9t2BCHryQoWleW79e3
         8Ep+66ZR0z2PxHu2QOw4tfKQjrdngMA0DwnJ6WpBcpiaNIg4MPodrsjDdT86y2UBOr5V
         6VTt/svtrPTCTPi0VJscMES/pOrbQ78MIp18gw0tgdFEKm0NIGj5FUzF5v2vpYrmtfve
         bz8FZKCZEKe64HzVRUj8ElHH8BxU9/Nay8gW1pg 
Received: by 10.50.37.242 with SMTP id b18mr3439924igk.6.1352652874751;
        Sun, 11 Nov 2012 08:54:34 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.106.229 with SMTP id gx5ls4237629igb.3.gmail; Sun, 11 Nov
 2012 08:54:34 -0800 (PST)
Received: by 10.50.173.68 with SMTP id bi4mr4518844igc.1.1352652874127;
        Sun, 11 Nov 2012 08:54:34 -0800 (PST)
Received: by 10.50.173.68 with SMTP id bi4mr4518841igc.1.1352652874076;
        Sun, 11 Nov 2012 08:54:34 -0800 (PST)
Received: from peff.net (75-15-5-89.uvs.iplsin.sbcglobal.net. [75.15.5.89])
        by gmr-mx.google.com with ESMTPS id dx8si932635igc.1.2012.11.11.08.54.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 08:54:34 -0800 (PST)
Received-SPF: pass (google.com: domain of peff@peff.net designates 75.15.5.89 as permitted sender) client-ip=75.15.5.89;
Received: (qmail 1007 invoked by uid 107); 11 Nov 2012 16:55:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Nov 2012 11:55:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2012 11:54:31 -0500
In-Reply-To: <509FD668.20609@lsrfire.ath.cx>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209402>

On Sun, Nov 11, 2012 at 05:46:32PM +0100, Ren=E9 Scharfe wrote:

> >However, I couldn't reproduce it on Linux : where the windows
> >implementations crashes at a ~32000 depth (*not* exactly 32768, mind
> >you), on linux it happily went through 100000 commits. I didn't take
> >time to look much further, but maybe on my 64 bit Linux VM, the process
> >can afford to reserve a much bigger address range for the stack of each
> >thread than the 1Mb given to 32 bit processes on windows.
> >Jean-Jacques.
>=20
> I can reproduce it on Linux (Debian testing amd64) with ulimit -s
> 1000 to reduce the stack size from its default value of 8MB.
>=20
> After reverting ffc4b8012d9a4f92ef238ff72c0d15e9e1b402ed (tag: speed
> up --contains calculation) the test passes even with the smaller
> stack, but it makes "git tag --contains" take thrice the time as
> before.

Right, I am not too surprised.  That function replaced the original
algorithm with a much faster depth-first recursive one. I haven't looked
closely yet at Jean-Jacques' iterative adaptation, but that direction
seems like a good fix for now.

Ultimately, I have some ideas for doing this in a breadth-first way,
which would make it more naturally iterative. It would involve having N
bits of storage per commit to check N tags, but it would mean that we
could get accurate answers in the face of clock skew (like the
merge-base calculation, it would merely get slower in the face of skew).

But since I haven't worked on that at all, fixing the depth-first
algorithm to be iterative makes sense to me.

-Peff

--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den
