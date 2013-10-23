From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] entry.c: convert checkout_entry to use strbuf
Date: Wed, 23 Oct 2013 13:29:14 -0400
Message-ID: <20131023172914.GA6824@sigill.intra.peff.net>
References: <20131021193223.GC29681@sigill.intra.peff.net>
 <1382532907-30561-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Antoine Pelisse <apelisse@gmail.com>,
	Torsten =?utf-8?B?QsODwrZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Wataru Noguchi <wnoguchi.0727@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?UmVuw4PCqQ==?= Scharfe <l.s.r@web.de>,
	msysGit <msysgit@googlegroups.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: msysgit+bncBDO2DJFKTEFBB3MOUCJQKGQE6OHHTMI@googlegroups.com Wed Oct 23 19:29:21 2013
Return-path: <msysgit+bncBDO2DJFKTEFBB3MOUCJQKGQE6OHHTMI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f64.google.com ([209.85.220.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBB3MOUCJQKGQE6OHHTMI@googlegroups.com>)
	id 1VZ2FD-0000FQ-EG
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 19:29:19 +0200
Received: by mail-pa0-f64.google.com with SMTP id kx10sf273141pab.9
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=IiM5sy5wI2njlpT30Jy6LwY6hCq3OuN1HGnyOPxqu0Q=;
        b=B2nM0TGc+tqoXH3CJPt+3XeOjWQeqQc6iIB65ZhSGm3K+rMAWWJz/yXcH71gAdfyYk
         NcuIPrGRXXdMGcLT1yl4SRod8tALOMxfQruCk5cf6eQmKNZ5iqiT3ESs3943J6iCVOse
         8Z9FdlWHpa4+t427Z0pp/FinFMv+Q8V80uS9Q8OdAAfh6J+mbnCLvzkMCd+3Kde+MCxY
         OhpxecAVAPWmkfy2YFqC77MLKhYUkuzjPFXbb8E9AB5evTUs6HSyYzUw94YUVcJ68QrM
         6uESD28pjYJCNeMqiaEoKjQ5cBBGEWt+hHfWJLlKNY/EnjcegSvSqOxDclHM41ddQB/t
         lduw==
X-Received: by 10.182.158.2 with SMTP id wq2mr41834obb.10.1382549358216;
        Wed, 23 Oct 2013 10:29:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.129.166 with SMTP id nx6ls351705obb.53.gmail; Wed, 23 Oct
 2013 10:29:17 -0700 (PDT)
X-Received: by 10.182.186.105 with SMTP id fj9mr1100300obc.5.1382549357796;
        Wed, 23 Oct 2013 10:29:17 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id e8si1207828igg.0.2013.10.23.10.29.17
        for <msysgit@googlegroups.com>;
        Wed, 23 Oct 2013 10:29:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 26781 invoked by uid 102); 23 Oct 2013 17:29:17 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Oct 2013 12:29:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Oct 2013 13:29:14 -0400
In-Reply-To: <1382532907-30561-1-git-send-email-pclouds@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236537>

On Wed, Oct 23, 2013 at 07:55:06PM +0700, Nguyen Thai Ngoc Duy wrote:

> The old code does not do boundary check so any paths longer than
> PATH_MAX can cause buffer overflow. Replace it with strbuf to handle
> paths of arbitrary length.

I think this is a reasonable solution. If we have such a long path, we
are probably about to feed it to open() or another syscall, and we will
just get ENAMETOOLONG there anyway. But certainly we need to fix the
buffer overflow, and we are probably better off letting the syscall
report failure than calling die(), because we generally handle the
syscall failure more gracefully (e.g., by reporting the failed path but
continuing).

> -	memcpy(path, state->base_dir, len);
> -	strcpy(path + len, ce->name);
> -	len += ce_namelen(ce);
> +	strbuf_reset(&path_buf);
> +	strbuf_addf(&path_buf, "%.*s%s", state->base_dir_len, state->base_dir, ce->name);
> +	path = path_buf.buf;
> +	len = path_buf.len;

This is not something you introduced, but while we are here, you may
want to use ce->namelen, which would be a little faster than treating it
as a string (especially for strbuf, as it can then know up front how big
the size is).

I doubt it's measurable, though (especially as the growth cost is
amortized due to the static buffer).

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
