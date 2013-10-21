From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Prevent buffer overflows when path is too big
Date: Mon, 21 Oct 2013 15:14:39 -0400
Message-ID: <20131021191439.GB29681@sigill.intra.peff.net>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
 <1382179954-5169-1-git-send-email-apelisse@gmail.com>
 <52636E5A.1080909@web.de>
 <CACsJy8AXV=KJtTWxp6dpfa_Pr81h3YwW5EK=c_dV=F7tr7ChWQ@mail.gmail.com>
 <CALWbr2z1RmLLNa3Cj+n6g=zu5FB4VZSmRTU1qYb86pXLfYGJGg@mail.gmail.com>
 <CACsJy8BQ=qzXbMT9OSeQ+aDjLe5ogkUMZzdUhK0ObJP+VHkYvQ@mail.gmail.com>
 <52657A3D.8090609@kdbg.org>
 <CABPQNSZku9RtwKe2r=zpGrNcHRDD_Ct7C+=x8UcNhJeJDn-oqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Wataru Noguchi <wnoguchi.0727@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	msysGit <msysgit@googlegroups.com>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBBJH2SWJQKGQE7LOCGBY@googlegroups.com Mon Oct 21 21:14:47 2013
Return-path: <msysgit+bncBDO2DJFKTEFBBJH2SWJQKGQE7LOCGBY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vc0-f183.google.com ([209.85.220.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBJH2SWJQKGQE7LOCGBY@googlegroups.com>)
	id 1VYKwA-00041s-Ff
	for gcvm-msysgit@m.gmane.org; Mon, 21 Oct 2013 21:14:46 +0200
Received: by mail-vc0-f183.google.com with SMTP id hz11sf16296vcb.10
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Oct 2013 12:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=IXDfXKSHJKPEhWVi4u4vEvNtSDt2i7F4cF01+P4hrqI=;
        b=ZQw/o+Ot5vzg4OZXO9e/zyUIk6/cgfsmqOBvvnmTkvNEpsZTJbhBRGgh5zaQsnul9g
         7tnYQc+pBEftbw+XbPBvE39OSfibo/dzjYg+aGM93vOrYoEuMtPNQcp1Fk7mYIDgUj8J
         4ztTej+gLvDUt7aW49QtRP64sV1HOC0G7bVCMvUNuiydmgWCKrjef4pnsqlqW790aczk
         zvuM5scubIJ00Djpl8ibLYfYBuPIuXHlbbV3UYeces0zyGjpO8qOoIdw/3f4nH/H0kq7
         zO8NUdau1J+z07H8QIqYxim8g2DIQFNAKG+NV0kwa8Yr15Zl7t1Yez/oPTAB10fhKxXv
         4wDg==
X-Received: by 10.50.82.33 with SMTP id f1mr291030igy.0.1382382885639;
        Mon, 21 Oct 2013 12:14:45 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.50.176.193 with SMTP id ck1ls1927916igc.22.gmail; Mon, 21 Oct
 2013 12:14:44 -0700 (PDT)
X-Received: by 10.66.218.99 with SMTP id pf3mr6834251pac.8.1382382884682;
        Mon, 21 Oct 2013 12:14:44 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id vn2si3417813igb.2.2013.10.21.12.14.44
        for <msysgit@googlegroups.com>;
        Mon, 21 Oct 2013 12:14:44 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 27672 invoked by uid 102); 21 Oct 2013 19:14:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Oct 2013 14:14:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Oct 2013 15:14:39 -0400
In-Reply-To: <CABPQNSZku9RtwKe2r=zpGrNcHRDD_Ct7C+=x8UcNhJeJDn-oqQ@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236446>

On Mon, Oct 21, 2013 at 09:07:26PM +0200, Erik Faye-Lund wrote:

> I would argue that this is probably even a bug on Linux, only harder
> (if not impossible) to trigger by accident as there's probably no
> git-client that will generate such trees. But a "malicious" client
> might.

I've just been poking through the impacts of these overflows, for that
exact reason. I don't think any of them are easily triggerable by
somebody sending you a malicious tree (e.g., the `remove_subtree` one
only triggers when we have seen that tree in the filesystem, so it must
be limited to `PATH_MAX`). Some of them are triggerable if you use
particular options (e.g., the one in `match_order` is easy to trigger if
you use `diff -O`).

Still, they should all be fixed, even for Linux. I shouldn't have to
trace the provenance of the data back through 10 functions just to find
out a buffer overflow isn't easily exploitable. :)

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
