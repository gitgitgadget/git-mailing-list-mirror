From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 1/2] entry.c: convert checkout_entry to use strbuf
Date: Wed, 23 Oct 2013 19:34:18 +0200
Message-ID: <CABPQNSZgFa1Roq=aEg8CBpo320hP7bFEOq2RK8xY3fESdYLdTg@mail.gmail.com>
References: <20131021193223.GC29681@sigill.intra.peff.net> <1382532907-30561-1-git-send-email-pclouds@gmail.com>
 <20131023172914.GA6824@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>, 
	GIT Mailing-list <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>, Antoine Pelisse <apelisse@gmail.com>, 
	=?ISO-8859-1?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>, 
	Wataru Noguchi <wnoguchi.0727@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?ISO-8859-1?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBDR53PPJ7YHRBQ4RUCJQKGQEBT3LMVY@googlegroups.com Wed Oct 23 19:35:02 2013
Return-path: <msysgit+bncBDR53PPJ7YHRBQ4RUCJQKGQEBT3LMVY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f188.google.com ([209.85.216.188])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBQ4RUCJQKGQEBT3LMVY@googlegroups.com>)
	id 1VZ2Ki-0003mA-El
	for gcvm-msysgit@m.gmane.org; Wed, 23 Oct 2013 19:35:00 +0200
Received: by mail-qc0-f188.google.com with SMTP id k8sf246347qcq.15
        for <gcvm-msysgit@m.gmane.org>; Wed, 23 Oct 2013 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=ruwQ4XsLfyBlclkUM26r32x3w0RxsJd707KZzvOohsM=;
        b=LAkrEcJV46ztPSnWyvN4HhX1rcrBlP3OvuVusPESpKF+7tMMW2OR1dH982z6W00C4M
         mKicdhLQ2YjS960ZFOonLp4V8Zn8/5iDUOtgk1Le4kXASQNzgts+l3wvGNeuJ3Yjy39P
         unJP8k6/8lz0bit+qrE3k+i5kDH+ImvVJBBknqa4iM9wfxHn1wZziP1xSZBhojWboFf0
         u+dWu1Ma+UYH1xXfpTWnz0oC6aRx+GBKobYddjSTwjtWMeIRydHsmplgOnZ75eRe2IBw
         O3yz/5Rz5vLFCOgdmrgt9zbVS7kLvsZQu8dHykwRCA2sh1D6MRt3lyntGWa82n+QM4y7
         jxNw==
X-Received: by 10.49.94.41 with SMTP id cz9mr80790qeb.26.1382549699700;
        Wed, 23 Oct 2013 10:34:59 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.49.64.38 with SMTP id l6ls559605qes.89.gmail; Wed, 23 Oct 2013
 10:34:59 -0700 (PDT)
X-Received: by 10.59.4.176 with SMTP id cf16mr1125005ved.10.1382549699147;
        Wed, 23 Oct 2013 10:34:59 -0700 (PDT)
Received: from mail-ie0-x22b.google.com (mail-ie0-x22b.google.com [2607:f8b0:4001:c03::22b])
        by gmr-mx.google.com with ESMTPS id vn2si1208353igb.2.2013.10.23.10.34.59
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Oct 2013 10:34:59 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22b as permitted sender) client-ip=2607:f8b0:4001:c03::22b;
Received: by mail-ie0-x22b.google.com with SMTP id tp5so1843123ieb.2
        for <msysgit@googlegroups.com>; Wed, 23 Oct 2013 10:34:58 -0700 (PDT)
X-Received: by 10.50.118.105 with SMTP id kl9mr1411329igb.3.1382549698893;
 Wed, 23 Oct 2013 10:34:58 -0700 (PDT)
Received: by 10.64.249.33 with HTTP; Wed, 23 Oct 2013 10:34:18 -0700 (PDT)
In-Reply-To: <20131023172914.GA6824@sigill.intra.peff.net>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c03::22b
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236538>

On Wed, Oct 23, 2013 at 7:29 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 23, 2013 at 07:55:06PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> The old code does not do boundary check so any paths longer than
>> PATH_MAX can cause buffer overflow. Replace it with strbuf to handle
>> paths of arbitrary length.
>
> I think this is a reasonable solution. If we have such a long path, we
> are probably about to feed it to open() or another syscall, and we will
> just get ENAMETOOLONG there anyway. But certainly we need to fix the
> buffer overflow, and we are probably better off letting the syscall
> report failure than calling die(), because we generally handle the
> syscall failure more gracefully (e.g., by reporting the failed path but
> continuing).
>
>> -     memcpy(path, state->base_dir, len);
>> -     strcpy(path + len, ce->name);
>> -     len += ce_namelen(ce);
>> +     strbuf_reset(&path_buf);
>> +     strbuf_addf(&path_buf, "%.*s%s", state->base_dir_len, state->base_dir, ce->name);
>> +     path = path_buf.buf;
>> +     len = path_buf.len;
>
> This is not something you introduced, but while we are here, you may
> want to use ce->namelen, which would be a little faster than treating it
> as a string (especially for strbuf, as it can then know up front how big
> the size is).
>
> I doubt it's measurable, though (especially as the growth cost is
> amortized due to the static buffer).

I somehow feel that:

strbuf_reset(&path_buf);
strbuf_add(&path_buf, state->base_dir, state->base_dir_len);
strbuf_addch(&path_buf, '/');
strbuf_add(&path_buf, state->name, state->name_len);

feels a bit neater than using strbuf_addf. But that might just be me.

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
