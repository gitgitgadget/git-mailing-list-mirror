From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] update-index/diff-index: use core.preloadindex
 to improve performance
Date: Tue, 30 Oct 2012 11:15:37 +0100
Message-ID: <CABPQNSb6QzxxJpoackhzRz19UWwpxjJ6MPEeptTU9Z0bEaAB+A@mail.gmail.com>
References: <OF831F4AE9.23F46743-ONC1257AA7.00353C1F-C1257AA7.00361535@dcon.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, pro-logic@optusnet.com.au
To: karsten.blees@dcon.de
X-From: msysgit+bncBDR53PPJ7YHRB4ORX2CAKGQEES5THBI@googlegroups.com Tue Oct 30 11:16:30 2012
Return-path: <msysgit+bncBDR53PPJ7YHRB4ORX2CAKGQEES5THBI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-da0-f58.google.com ([209.85.210.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRB4ORX2CAKGQEES5THBI@googlegroups.com>)
	id 1TT8rz-0006T2-W6
	for gcvm-msysgit@m.gmane.org; Tue, 30 Oct 2012 11:16:28 +0100
Received: by mail-da0-f58.google.com with SMTP id a18sf54581dak.3
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Oct 2012 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=CJ9+3YxlUgE+RCRVUxC/hMEKTmDtauXjdNHNaEoW0c0=;
        b=j7sufz/f1q9Aq+exZ2S4NCSgoR4UvFWwDiwtbv7d7mZZcrzRKx/Qv+Suy3B7ec/vfn
         aNjzf2/POGcCXMNufuUDHGWOcF3p6v7+xmfjogctWGaDAAtvTL3zakc2XRwYi19EMWpY
         9u/IrJ1CGhNp2SzciJuPfbVJBkx0ituCRvfQ52/tRxxvURuF6VwyN6N4hAnCOpti2Kix
         tqVzCQqmmC8jlR8jZasKYTTpiXIgXe+9GklcWcgEs2H4H6Dl+dnpHP+pQUvWAnCLQS4w
         4hblzvPO49EFXWRHha1D/IIBo6aN6F3k2Q7LwfcHVzYjvy6vNCCEIilfO+PPzlOW3Lj9
         JWVg==
Received: by 10.52.76.136 with SMTP id k8mr3956986vdw.13.1351592178369;
        Tue, 30 Oct 2012 03:16:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.220.210.197 with SMTP id gl5ls84354vcb.0.gmail; Tue, 30 Oct
 2012 03:16:17 -0700 (PDT)
Received: by 10.58.59.73 with SMTP id x9mr12237629veq.39.1351592177882;
        Tue, 30 Oct 2012 03:16:17 -0700 (PDT)
Received: by 10.58.59.73 with SMTP id x9mr12237628veq.39.1351592177872;
        Tue, 30 Oct 2012 03:16:17 -0700 (PDT)
Received: from mail-vb0-f48.google.com (mail-vb0-f48.google.com [209.85.212.48])
        by gmr-mx.google.com with ESMTPS id bn19si34590vdb.0.2012.10.30.03.16.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 03:16:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.212.48 as permitted sender) client-ip=209.85.212.48;
Received: by mail-vb0-f48.google.com with SMTP id e21so112628vbm.21
        for <msysgit@googlegroups.com>; Tue, 30 Oct 2012 03:16:17 -0700 (PDT)
Received: by 10.58.94.109 with SMTP id db13mr57422508veb.39.1351592177787;
 Tue, 30 Oct 2012 03:16:17 -0700 (PDT)
Received: by 10.58.169.106 with HTTP; Tue, 30 Oct 2012 03:15:37 -0700 (PDT)
In-Reply-To: <OF831F4AE9.23F46743-ONC1257AA7.00353C1F-C1257AA7.00361535@dcon.de>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.212.48 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208690>

On Tue, Oct 30, 2012 at 10:50 AM,  <karsten.blees@dcon.de> wrote:
> 'update-index --refresh' and 'diff-index' (without --cached) don't honor
> the core.preloadindex setting yet. Porcelain commands using these (such as
> git [svn] rebase) suffer from this, especially on Windows.
>
> Use read_cache_preload to improve performance.
>
> Additionally, in builtin/diff.c, don't preload index status if we don't
> access the working copy (--cached).
>
> Results with msysgit on WebKit repo (2GB in 200k files):
>
>                 | update-index | diff-index | rebase
> ----------------+--------------+------------+---------
> msysgit-v1.8.0  |       9.157s |    10.536s | 42.791s
> + preloadindex  |       9.157s |    10.536s | 28.725s
> + this patch    |       2.329s |     2.752s | 15.152s
> + fscache [1]   |       0.731s |     1.171s |  8.877s
>

Wow, awesome results :)

This also makes me want to play around with the fscache stuff a bit;
about an order of magnitude improvement is quite noticeable :)

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
