From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Prevent buffer overflows when path is too big
Date: Mon, 21 Oct 2013 15:32:23 -0400
Message-ID: <20131021193223.GC29681@sigill.intra.peff.net>
References: <CABPQNSaqjKPGAQ4EKBSk+bQP2WMksc6M0YQxSkB91UrnFF28xQ@mail.gmail.com>
 <1382179954-5169-1-git-send-email-apelisse@gmail.com>
 <52636E5A.1080909@web.de>
 <CACsJy8AXV=KJtTWxp6dpfa_Pr81h3YwW5EK=c_dV=F7tr7ChWQ@mail.gmail.com>
 <CALWbr2z1RmLLNa3Cj+n6g=zu5FB4VZSmRTU1qYb86pXLfYGJGg@mail.gmail.com>
 <CACsJy8BQ=qzXbMT9OSeQ+aDjLe5ogkUMZzdUhK0ObJP+VHkYvQ@mail.gmail.com>
 <52657A3D.8090609@kdbg.org>
 <CABPQNSZku9RtwKe2r=zpGrNcHRDD_Ct7C+=x8UcNhJeJDn-oqQ@mail.gmail.com>
 <20131021191439.GB29681@sigill.intra.peff.net>
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
X-From: msysgit+bncBDO2DJFKTEFBBTECS2JQKGQEI6VPMAQ@googlegroups.com Mon Oct 21 21:32:30 2013
Return-path: <msysgit+bncBDO2DJFKTEFBBTECS2JQKGQEI6VPMAQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f187.google.com ([209.85.214.187])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBTECS2JQKGQEI6VPMAQ@googlegroups.com>)
	id 1VYLDJ-0006B3-OI
	for gcvm-msysgit@m.gmane.org; Mon, 21 Oct 2013 21:32:30 +0200
Received: by mail-ob0-f187.google.com with SMTP id wo20sf1428539obc.14
        for <gcvm-msysgit@m.gmane.org>; Mon, 21 Oct 2013 12:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=5fwobzV+kP55Au80A8NMcTghL9pYf3nY6VTCpeqruu0=;
        b=cN3XZj++CKDCx1RtRmY1Gk/o6amiozu1e0OUizVWB/6quB/b1XTf0xlw4fzqj5+JbR
         i82PyiiUD5jl96mShN/4peoLyyG84x9XXXl9VWMmndhlr1H8GsrR4CGrpuqTFIhX4fyh
         6J/GUyY4KrmQN2ei3kXZz1CQ9R9C5AgFpgbBPSVAoS4wNieOMQaa7gQ7xuMKHQ1uBLW8
         e5JCQofc0BmZqA5HUzSzEJ4PdO2hD5uMd4AQM5WXfhXy68NiU89OwRMrJmhZIQUnQ/eB
         f2kcdyf/CpJ1dxCSB0VPxk2uZKPk0MCQPU7bGFNrvsPiQOepCCFkYwYLh3NzTQpjJ7tR
         2dXA==
X-Received: by 10.49.2.33 with SMTP id 1mr62005qer.38.1382383948797;
        Mon, 21 Oct 2013 12:32:28 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.81.9 with SMTP id v9ls2192309qex.99.gmail; Mon, 21 Oct 2013
 12:32:28 -0700 (PDT)
X-Received: by 10.236.167.138 with SMTP id i10mr19891781yhl.9.1382383948192;
        Mon, 21 Oct 2013 12:32:28 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id ri8si4012352igc.0.2013.10.21.12.32.27
        for <msysgit@googlegroups.com>;
        Mon, 21 Oct 2013 12:32:28 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 28512 invoked by uid 102); 21 Oct 2013 19:32:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Oct 2013 14:32:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Oct 2013 15:32:23 -0400
In-Reply-To: <20131021191439.GB29681@sigill.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236447>

On Mon, Oct 21, 2013 at 03:14:39PM -0400, Jeff King wrote:

> On Mon, Oct 21, 2013 at 09:07:26PM +0200, Erik Faye-Lund wrote:
> 
> > I would argue that this is probably even a bug on Linux, only harder
> > (if not impossible) to trigger by accident as there's probably no
> > git-client that will generate such trees. But a "malicious" client
> > might.
> 
> I've just been poking through the impacts of these overflows, for that
> exact reason. I don't think any of them are easily triggerable by
> somebody sending you a malicious tree (e.g., the `remove_subtree` one
> only triggers when we have seen that tree in the filesystem, so it must
> be limited to `PATH_MAX`). Some of them are triggerable if you use
> particular options (e.g., the one in `match_order` is easy to trigger if
> you use `diff -O`).

Actually, I take that back. The one in checkout_entry is quite easy to
trigger if the victim checks out your tree. The rest are much harder,
though.

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
