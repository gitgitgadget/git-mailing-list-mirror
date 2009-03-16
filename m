From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [PATCH] Autoconf: Disable inline for compilers that don't
	support it.
Date: Mon, 16 Mar 2009 18:31:34 -0400
Message-ID: <20090316223134.GA6053@linux.vnet>
References: <20090114223832.GC30710@genesis.frugalware.org> <20090314010421.GA6642@linux.vnet> <7vy6v7al37.fsf@gitster.siamese.dyndns.org> <20090315152127.GA7988@linux.vnet> <7vab7m7ecp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 23:33:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjLMv-0006gC-Si
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 23:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754316AbZCPWbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 18:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbZCPWbo
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 18:31:44 -0400
Received: from mail-gx0-f165.google.com ([209.85.217.165]:57839 "EHLO
	mail-gx0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbZCPWbn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2009 18:31:43 -0400
Received: by gxk9 with SMTP id 9so2311052gxk.13
        for <git@vger.kernel.org>; Mon, 16 Mar 2009 15:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=vY9Rl8TA5lYp+W6NzJED/1FkQR/ptcrWLdgQRMfEhFQ=;
        b=bPHi7q1E4+kw5XdS+Tw3JFnstyOiNv8NkXYv8jjIIZlXxGsVqq2DwjjTFUC4KaKt4l
         UY9ZtlABZ+T9Wp1QPjW4kSVzTdHd/+XMDkDFfSMFraUEEmQnuWDLEnBMQDGPjLx0DX5K
         tRlnV4Gfms/oyjMEwXPU8FnrnkC0bKWTzCvDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=KF+u7vjHPzo2MQi1oSs7WGJhqTh6mHJ5JPZFcVd82oRsVoRKbGnvkxFyOOjIGQ9VgQ
         iGGNqkaGWEwRxIAIwo3kD2lWqtTjrE54/B2Zixj10hZcQcsj+BI5rjdjGt3c3gVaBL8x
         fbl/IkLAj/wJqUSk0lHUwk9XyCP72OVT/vZZ8=
Received: by 10.142.172.20 with SMTP id u20mr568541wfe.306.1237242700300;
        Mon, 16 Mar 2009 15:31:40 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 30sm12799153wff.7.2009.03.16.15.31.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Mar 2009 15:31:39 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vab7m7ecp.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113396>

On Sun, 15 Mar 2009, Junio C Hamano wrote:
> Allan Caffee <allan.caffee@gmail.com> writes:
> > My mistake; it looks like this macro will only work the way I described
> > when using a config.h, which I see git is not currently doing.  I
> > assumed that it would also provide a -D flag to the precompiler if a
> > configuration header isn't used but this doesn't appear to be case (from
> > a cursory glance at the macros definition).
> 
> The design of our Makefile is such that it will default to some reasonable
> values for the make variables depending on the environment, and people who
> do not want to use the configure script can override them by creating
> custom entries in config.mak manually, which is included by the Makefile.
> 
> OPTIONALLY configure can be used to produce config.mak.autogen that is
> included just before config.mak is included (so that misdetection by
> configure script can be overridden away by config.mak), so the same kind
> of overriding happens.
> 
> I suspect addition of config.h, unless done carefully, will close the door
> to the people who do not use configure to get certain customizations, and
> when the same carefulness is applied, we probably do no need to introduce
> config.h.
> 
> For example, for -Dinline=__inline__, I think you can:
> 
>  (1) Add something like this near the beginning of the Makefile:
> 
>      # Define USE_THIS_INLINE=__inline__ if your compiler does not
>      # understand "inline", but does understand __inline__.
>      #
>      # Define NO_INLINE=UnfortunatelyYes if your compiler does not
>      # understand "inline" at all.
> 
>  (2) Add something like this after include "config.mak" happens in the
>      Makefile:
> 
>      ifdef USE_THIS_INLINE
>          BASIC_CFLAGS += -Dinline=$(USE_THIS_INLINE)
>      else
>          ifdef NO_INLINE
>              BASIC_CFLAGS += -Dinline=""
> 	 endif
>      endif
> 
>  (3) Add your new logic to configure.ac, _and_ arrange it to substitute
>      USE_THIS_INLINE if ac_cv_c_inline is not "inline", and set NO_INLINE
>      if it detected that the compiler does not understand inline in any
>      shape or form.  You would need two new entries in config.mak.in, I
>      think.

In addition to these three possibilities we could also use config.h only
in the event that the user decides to run configure.  When using a
config header autoconf appends -DHAVE_CONFIG_H to the CPPFLAGS.  So
the code could conditionally include it.

Although I'm not really sure if this still maintains the degree of user
control you're looking for.
