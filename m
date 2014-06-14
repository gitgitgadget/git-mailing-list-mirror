From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 1/2] add strbuf_set operations
Date: Fri, 13 Jun 2014 21:49:06 -0700
Message-ID: <20140614044906.GB1375@hudson.localdomain>
References: <cover.1402557437.git.jmmahler@gmail.com>
 <f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
 <xmqqr42u55dq.fsf@gitster.dls.corp.google.com>
 <20140612193144.GA17077@hudson.localdomain>
 <CAPig+cTVLJQOsW7H4Ht2NNYkeiMb=EWT7BG3sNu0wNsTQ=oZNA@mail.gmail.com>
 <20140612234637.GB17803@hudson.localdomain>
 <20140613071550.GC7908@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 14 06:53:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wvfxu-0004On-PK
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 06:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbaFNEtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2014 00:49:11 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:49459 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751455AbaFNEtK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2014 00:49:10 -0400
Received: by mail-pd0-f170.google.com with SMTP id z10so1278181pdj.1
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 21:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Sb4u0a1O5PKI/nrjRquNb6e+WrNetgb2TV06427I9rU=;
        b=sHiTHpYVxISA1ep5UYZp3LEROGlpM/KEZRfGIRz4FNYyGemomFg4v9VMxTWn/b4w4K
         4VYMtbrqHw66qG7x5/i6Xfc5v49O8CF++EWk0k6KmJHXd0cDwdf1aQW4V5ZtlkWyy/zB
         y3GhY+GBNH5xnj59NtXjBPtFfKcRIkKOU029V5rb5ss8UTJaOel7P+IhNYMrysd2uCws
         u2/7Q7OMDDq5S3ENjYiqyEqaVucJaYh97OtoLBmWZnPLI4tP92Oq4xERrbny1L3Hcjlt
         0eFQNqceN/HZtT0SwD8TSWOuSrQGXGLXbvVKU0tv/fndjTp/OieZ4aIAWxyAdV15/lO2
         NVgg==
X-Received: by 10.66.122.36 with SMTP id lp4mr8382259pab.82.1402721349545;
        Fri, 13 Jun 2014 21:49:09 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id zc10sm31186104pac.46.2014.06.13.21.49.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jun 2014 21:49:08 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140613071550.GC7908@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251656>

Peff,

On Fri, Jun 13, 2014 at 03:15:50AM -0400, Jeff King wrote:
> On Thu, Jun 12, 2014 at 04:46:37PM -0700, Jeremiah Mahler wrote:
> 
> > >     Although strbuf_set() does make the code a bit easier to read
> > >     when strbufs are repeatedly re-used, re-using a variable for
> > >     different purposes is generally considered poor programming
> > >     practice. It's likely that heavy re-use of strbufs has been
> > >     tolerated to avoid multiple heap allocations, but that may be a
> > >     case of premature (allocation) optimization, rather than good
> > >     programming. A different ("better") way to make the code more
> > >     readable and maintainable may be to ban re-use of strbufs for
> > >     different purposes.
> > > 
> > > But I deleted it before sending because it's a somewhat tangential
> > > issue not introduced by your changes. However, I do see strbuf_set()
> > > as a Band-Aid for the problem described above, rather than as a useful
> > > feature on its own. If the practice of re-using strbufs (as a
> > > premature optimization) ever becomes taboo, then strbuf_set() loses
> > > its value.
> > > 
> > 
> > I am getting the feeling that I have mis-understood the purpose of
> > strbufs.  It is not just a library to use in place of char*.
> > 
> > If strbufs should only be added to and never reset a good test would be
> > to re-write builtin/remote.c without the use of strbuf_reset.
> > 
> > builtin/remote.c does re-use the buffers.  But it seems if a buffer is
> > used N times then to avoid a reset you would need N buffers.
> > 
> > But on the other hand I agree with your comment that re-using a variable
> > for different purposes is poor practice.
> > 
> > Now I am not even sure if I want my own patch :-)
> 
> I think reusing buffers like remote.c does makes things uglier and more
> confusing than necessary, and probably doesn't have any appreciable
> performance gain. We are saving a handful of allocations, and have such
> wonderful variable names as "buf2" (when is it OK to reuse that one,
> versus regular "buf"?).
> 
> A better reason I think is to reuse allocations across a loop, like:
> 
>   struct strbuf buf = STRBUF_INIT;
> 
>   for (i = 0; i < nr; i++) {
> 	strbuf_reset(&buf);
> 	strbuf_add(&buf, foo[i]);
> 	... do something with buf ...
>   }
>   strbuf_release(&buf);
> 
> You can write that as:
> 
>   for (i = 0; i < nr; i++) {
> 	struct strbuf buf = STRBUF_INIT;
> 	strbuf_add(&buf, foo[i]);
> 	... do something ...
> 	strbuf_release(&buf);
>   }
> 
> and it is definitely still a case of premature optimization. But:
> 
>   1. "nr" here may be very large, so the amortized benefits are greater
> 
>   2. It's only one call to strbuf_reset to cover many items. Not one
>      sprinkled every few lines.
> 
> You'll note that strbuf_getline uses a "set" convention (making it
> different from the rest of strbuf) to handle this looping case.
> 
> I don't have a problem with strbuf_set, but just peeking at remote.c, I
> think I'd rather see it cleaned up. It looks like one of the major uses
> is setting config variables. I wonder how hard it would be to make a
> git_config_set variant that took printf-style formats, and handled the
> strbuf itself.
> 
> -Peff

Improving remote.c sounds like a better direction than adding set
operations.  I will start looking in to it.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
