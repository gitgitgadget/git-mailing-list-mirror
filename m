From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] entry.c: convert checkout_entry to use strbuf
Date: Wed, 23 Oct 2013 14:10:58 -0400
Message-ID: <20131023181057.GA7950@sigill.intra.peff.net>
References: <20131021193223.GC29681@sigill.intra.peff.net>
 <1382532907-30561-1-git-send-email-pclouds@gmail.com>
 <20131023172914.GA6824@sigill.intra.peff.net>
 <xmqqa9hzrh9k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Antoine Pelisse <apelisse@gmail.com>,
	Torsten =?utf-8?B?QsODwrZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Wataru Noguchi <wnoguchi.0727@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?UmVuw4PCqQ==?= Scharfe <l.s.r@web.de>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: msysgit+bncBDO2DJFKTEFBBNFCUCJQKGQEKXAK36Y@googlegroups.com Wed Oct 23 20:11:03 2013
Return-path: <msysgit+bncBDO2DJFKTEFBBNFCUCJQKGQEKXAK36Y@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qa0-f56.google.com ([209.85.216.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDO2DJFKTEFBBNFCUCJQKGQEKXAK36Y@googlegroups.com>)
	id 1VZ2ta-0001KH-03
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 20:11:02 +0200
Received: by mail-qa0-f56.google.com with SMTP id k4sf277958qaq.11
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-disposition;
        bh=qzQMntBXqSFc8Cj8hcdNtfGOr5ocoqObZQj0VHh/gK8=;
        b=dRchaEnGM/wp396bJyUsemLP4V+cOdW4aMNASe4p4byqQrQMHmKIzUdv6M9oKB8K58
         gQY78eXqkbrdZCe9UDqkv3NmWM/xI+eiAfv4qp0BOtBLq+pvfRJQUkuS16FmymcoZKih
         oXUV2I+ecBz3e7sDHQgG80KC5rhdlcfndK3qOxeVz2xpqHJF2MurLomh2B3vTWBmibDv
         ZfUGpETZqW1QsZq//MFp3D5LWSd22CLnMhEHVOp53WUjgpNVR51ndMu9JRyMCfzEsW7q
         aFwKysFJWTTRza3olNipANA0QDsXlyxhZFIiNW9ch7sli9pxNge3Ep/XuxdXIUowGc5y
         eg8Q==
X-Received: by 10.182.137.225 with SMTP id ql1mr41576obb.23.1382551861222;
        Wed, 23 Oct 2013 11:11:01 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.103.201 with SMTP id fy9ls332142obb.59.gmail; Wed, 23 Oct
 2013 11:11:00 -0700 (PDT)
X-Received: by 10.182.19.133 with SMTP id f5mr1208195obe.36.1382551860801;
        Wed, 23 Oct 2013 11:11:00 -0700 (PDT)
Received: from peff.net (cloud.peff.net. [50.56.180.127])
        by gmr-mx.google.com with SMTP id qb12si1230867igc.1.2013.10.23.11.11.00
        for <msysgit@googlegroups.com>;
        Wed, 23 Oct 2013 11:11:00 -0700 (PDT)
Received-SPF: pass (google.com: domain of peff@peff.net designates 50.56.180.127 as permitted sender) client-ip=50.56.180.127;
Received: (qmail 28961 invoked by uid 102); 23 Oct 2013 18:11:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Oct 2013 13:11:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Oct 2013 14:10:58 -0400
In-Reply-To: <xmqqa9hzrh9k.fsf@gitster.dls.corp.google.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236542>

On Wed, Oct 23, 2013 at 11:09:27AM -0700, Junio C Hamano wrote:

> > This is not something you introduced, but while we are here, you may
> > want to use ce->namelen, which would be a little faster than treating it
> > as a string (especially for strbuf, as it can then know up front how big
> > the size is).
> 
> Hmmmm, do you mean something like this on top?
> 
> diff --git a/entry.c b/entry.c
> index d955af5..0d48292 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -246,7 +246,9 @@ int checkout_entry(struct cache_entry *ce,
>  		return write_entry(ce, topath, state, 1);
>  
>  	strbuf_reset(&path_buf);
> -	strbuf_addf(&path_buf, "%.*s%s", state->base_dir_len, state->base_dir, ce->name);
> +	strbuf_addf(&path_buf, "%.*s%.*s",
> +		    state->base_dir_len, state->base_dir,
> +		    ce_namelen(ce), ce->name);
>  	path = path_buf.buf;
>  	len = path_buf.len;

Yes, though I actually find Erik's version with two separate strbuf_add
invocations slightly more readable (it _could_ result in two
allocations, but again, we are amortizing the growth over many calls
anyway, so most of them will not need to grow the buffer at all).

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
