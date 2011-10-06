From: Alexey Shumkin <zapped@mail.ru>
Subject: Re: [PATCH 2/4] cleanup: use internal memory allocation wrapper
 functions everywhere
Date: Thu, 6 Oct 2011 11:01:13 +0400
Message-ID: <20111006110113.45f47e58@ashu.dyn.rarus.ru>
References: <5XXEFw0WjtXKd9dpXSxpkskCcgVyG9Db1_zzVSEBNey-kpXSBbmQfYaxZ2Szg6Pbck6hZZTQ5hHzBwG4rhKYXshrdmveEFLPZ9W0V8P_lw@cipher.nrlssc.navy.mil>
	<1316051979-19671-1-git-send-email-drafnel@gmail.com>
	<1316051979-19671-3-git-send-email-drafnel@gmail.com>
	<4E71A0C7.8080602@viscovery.net>
	<CA+sFfMdVntk+U13UeMO=k1SCKJGhPfTpC9_i9kFOkbUJXrF-qg@mail.gmail.com>
	<CA+sFfMf73K3yv_5K633DKOsVufMV6rTjd+SSunq4sBikt4jCsg@mail.gmail.com>
	<CA+sFfMdHpvdMU==a2sUR9sZZCcgqPfGF7+dy6yi8RVoMZ+uZVA@mail.gmail.com>
	<4E8D4812.9090102@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>, "peff@peff.net" <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>,
	"bharrosh@panasas.com" <bharrosh@panasas.com>,
	"trast@student.ethz.ch" <trast@student.ethz.ch>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 06 09:01:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBhxQ-0000JH-3W
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 09:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415Ab1JFHBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 03:01:23 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62732 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755680Ab1JFHBW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 03:01:22 -0400
Received: by wwf22 with SMTP id 22so3756000wwf.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 00:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=lAheLJhv7y+uBnCGuDXQTN0CC0kV0ifbn/7G5WfJonc=;
        b=M1IhD2nrtPbDLO9lOxGMcbSvFRAru81YBMUF2lwgp0pqqsLCLillpX/Pjhhcs2QrbA
         7s8AGDMzjBcXt2oz/adpbCY0Nl5hO+/UwrRNP6m8mpQr3NFeCtQ4Yy7ZA4frlfPv4Oit
         EKDnWwWVVxSgnFCdBeNRvNCLv35wYId/Dw69Y=
Received: by 10.216.189.82 with SMTP id b60mr708848wen.23.1317884481566;
        Thu, 06 Oct 2011 00:01:21 -0700 (PDT)
Received: from ashu.dyn.rarus.ru (mail.rarus.ru. [213.247.194.83])
        by mx.google.com with ESMTPS id l40sm8496073wbm.10.2011.10.06.00.01.18
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 00:01:21 -0700 (PDT)
In-Reply-To: <4E8D4812.9090102@viscovery.net>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182930>

Offtopic:
Excuse me, guys
May I ask you to exclude me from CC-list for this topic,
it seems to me I got in it for a mistake somehow,
I have no relation to this topic

thanks in advance :)

> Am 10/6/2011 4:00, schrieb Brandon Casey:
> > [resend without html bits added by "gmail offline"]
> > On Wed, Oct 5, 2011 at 7:53 PM, Brandon Casey <drafnel@gmail.com>
> > wrote:
> >> On Thursday, September 15, 2011, Brandon Casey wrote:
> >>>
> >>> On Thu, Sep 15, 2011 at 1:52 AM, Johannes Sixt
> >>> <j.sixt@viscovery.net>
> >>>> There is a danger that the high-level die() routine (which is
> >>>> used by the
> >>>> x-wrappers) uses one of the low-level compat/ routines. IOW, in
> >>>> the case of errors, recursion might occur. Therefore, I would
> >>>> prefer that the compat/ routines do their own error reporting
> >>>> (preferably via return values and errno).
> >>>
> >>> Thanks.  Will do.
> >>
> >> Hi Johannes,
> >> I have taken a closer look at the possibility of recursion with
> >> respect to die() and the functions in compat/.  It appears the
> >> risk is only related to vsnprintf/snprintf at the moment.  So as
> >> long as we avoid calling xmalloc et al from within snprintf.c, I
> >> think we should be safe from recursion. I'm inclined to keep the
> >> additions to mingw.c and win32/syslog.c since they both already
> >> use the x-wrappers or strbuf, even though they could easily be
> >> worked around.  The other file that was touched is compat/qsort,
> >> which returns void and doesn't have a good alternative error
> >> handling path.  So, I'm inclined to keep that one too.
> 
> I'm fine with keeping the change to mingw.c (getaddrinfo related) and
> qsort: both are unlikely to be called from die().
> 
> But syslog() *is* called from die() in git-daemon, and it would be
> better to back out the other offenders instead of adding to them.
> 
> -- Hannes
> 
