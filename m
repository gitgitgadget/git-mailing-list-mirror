From: Allan Caffee <allan.caffee@gmail.com>
Subject: Re: [PATCH] Autoconf: Disable inline for compilers that don't
	support it.
Date: Sun, 15 Mar 2009 11:21:27 -0400
Message-ID: <20090315152127.GA7988@linux.vnet>
References: <20090114223832.GC30710@genesis.frugalware.org> <20090314010421.GA6642@linux.vnet> <7vy6v7al37.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 16:23:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LisB7-00038Y-7G
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 16:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbZCOPVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 11:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbZCOPVe
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 11:21:34 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:11498 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbZCOPVe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 11:21:34 -0400
Received: by rv-out-0506.google.com with SMTP id g37so1181178rvb.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 08:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=ehn71N74PO1Js3XvidoIGVxiAuLJhdhHhZaAwJEqIeU=;
        b=V1t5mNF97V9kdWL1IQuj3z560rXuprH9kf+6IUMl9hJRSjo9Qwf3mTX6KIKVEArGJH
         PfcFEvUB8WLWF/If552czACY/28QyNLOMWngb39snXS6nJ+Aq1YzQHTS0J/qoQMW9tbl
         Xs++mMJAgnDS3r4nzoXqQ/MNaELrYQqzPINRQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=f5ROvOl/1fXL5xC/Z5XGiqa7Qtx4NIOWmzlDpcwBgvxYn7ZLtnPVQe90aYbesmOc4l
         hywdh3L5VieuM1DUT9lCeAwJju5dubrobeUJAbel74MYS7XHTQ0mvuJZsuv/W6i+IzHx
         estO/DXibBt6X8deHjkPx5odgp2jRtJ9xHi2A=
Received: by 10.142.180.20 with SMTP id c20mr1662070wff.131.1237130492347;
        Sun, 15 Mar 2009 08:21:32 -0700 (PDT)
Received: from linux.vnet (pool-71-185-49-127.phlapa.fios.verizon.net [71.185.49.127])
        by mx.google.com with ESMTPS id 20sm9468792wfi.52.2009.03.15.08.21.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Mar 2009 08:21:31 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vy6v7al37.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113289>

On Sat, 14 Mar 2009, Junio C Hamano wrote:
> Allan Caffee <allan.caffee@gmail.com> writes:
> 
> > The Autoconf macro AC_C_INLINE will redefine the inline keyword to whatever the
> > current compiler supports (including possibly nothing).
> >
> > Signed-off-by: Allan Caffee <allan.caffee@gmail.com>
> 
> As far as I can tell, this makes scriptlet to set ac_cv_c_inline and then
> the result is written to confdefs.h:
> 
>     case $ac_cv_c_inline in
>       inline | yes) ;;
>       *)
>         case $ac_cv_c_inline in
>           no) ac_val=;;
>           *) ac_val=$ac_cv_c_inline;;
>         esac
>         cat >>confdefs.h <<_ACEOF
>     #ifndef __cplusplus
>     #define inline $ac_val
>     #endif
>     _ACEOF
>         ;;
>     esac
> 
> which is used only during the ./configure run but not during the actual
> build.
> 
> What am I missing?

My mistake; it looks like this macro will only work the way I described
when using a config.h, which I see git is not currently doing.  I
assumed that it would also provide a -D flag to the precompiler if a
configuration header isn't used but this doesn't appear to be case (from
a cursory glance at the macros definition).  I could send a patch that
would set up a config header, but that would mean adding an #include
directive to all of the source files (or at least those using inline).
OTOH doing so would allow git to make use of some other handy macros
like AC_C_CONST.  Do you think this is worth adding a configuration
header?
