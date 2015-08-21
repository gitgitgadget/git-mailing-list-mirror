From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 2/3] run-commands: add an async queue processor
Date: Fri, 21 Aug 2015 13:56:50 -0700
Message-ID: <CAGZ79kaj0=2yw+KBLKQCkMzZpmcdFk93yDd7m+3x6Jn7gGap8w@mail.gmail.com>
References: <1440121237-24576-1-git-send-email-sbeller@google.com>
	<1440121237-24576-2-git-send-email-sbeller@google.com>
	<xmqqegiw5uom.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZrcPAAt+miHDGQp=052S-q=JaKvvLgKHaPG+G6cDjBtg@mail.gmail.com>
	<xmqqy4h44bdp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZStMu-00009e-N8
	for gcvg-git-2@plane.gmane.org; Fri, 21 Aug 2015 22:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbbHUU4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 16:56:52 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34233 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516AbbHUU4v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 16:56:51 -0400
Received: by ykdt205 with SMTP id t205so83200510ykd.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 13:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Cq9ZysYD2ji5WYvphVNfnAw3aokgwWhslLRHvadQ/ck=;
        b=cUsn6p9tNz3SvY+E8KoC4eWcUvz2dSV2l57Xh7w2sCbrQpuDKFYiJpee0QYF6XE5u4
         TZLnKCkYddlWSLmrer797QOlcWt2knQUpdIQDSvD6ax4eNfL8qAob7reLJax9x11AtTo
         zxbHsBSrtJkbkZrwe/+dO5bdz8hmzgJLlclWwIAewV8twm88u0wmIErFw/GZXn0rLbCF
         6dJEB1DImK9ojDNAF6kVPE13DG7vljymL2nKSuqNbm9PdWQD1IL+HEXmGQGew6eP+uFB
         PYUctZCTdJWhw9/jdF+9cwc4DoE2YNt2V37PuY3kDeYmTxoubPT7iaA0uADMSgA0OKYx
         snIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Cq9ZysYD2ji5WYvphVNfnAw3aokgwWhslLRHvadQ/ck=;
        b=bMaNcoWrd9xXxWuvzqLBEJPXSFZsoEpwrZ5rQmx/wsDRIR6eNY22DkYHRvz6Zk5hyt
         Sv3JNGYgN/3rKPJjKBGAosBm2AcH2adVnJjvRGEb1VAFVjXlR6PXnfY48QDigCr2M+2d
         jFkMhzCWJFuM6zRZFcYYOkg/wASXS12baEebr67agkT1BAElVlGHktYm+HTaJFyXF0Y3
         7/9TpB+ij+QxpQL61kYlD2mKICudERA+AtviV9SSorwQwgb+mHi3kWMvJhlfLo3ONFB/
         KeU/ItQtOIwNZ7FEBTmkgDqmeuxaY4HTWJEIZC8C13KkVfYDzU0hmg8ZoMhRSisRcl3r
         mQ+A==
X-Gm-Message-State: ALoCoQlTLfv5Z+pQrpV5mt82nOW+oi1KS/dhlANKXxJax/z68mIbLF6zZTzzyGaFV1yuGUXx7O1t
X-Received: by 10.170.56.8 with SMTP id 8mr14625361yky.115.1440190610696; Fri,
 21 Aug 2015 13:56:50 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 21 Aug 2015 13:56:50 -0700 (PDT)
In-Reply-To: <xmqqy4h44bdp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276334>

On Fri, Aug 21, 2015 at 1:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I do not think we are on the same wavelength.  What I meant was to
> do this:
>
>         aq = xmalloc(...);
>         set up _everything_ in aq and make it a consistent state;
>         /* aq->first and aq->last are part of _everything_ in aq */
>         for (many times)
>                 pthread_create(...);
>
>         /* No aq->first = aq->last = NULL assignment here */
>
> instead of
>
>         aq = xmalloc(...);
>         set up part of aq;
>         for (many times)
>                 pthread_create(...);
>         belatedly initialize aq->first and aq->last and finally
>         aq becomes a consistent state.
>
> which is what we see above.  The latter works _only_ because the
> threads created are blocked waiting on aq->workingcount which is
> initialized to block before threads are created to run dispatch,
> and one of the early things dispatch does is to try acquiring that
> semaphore to block before accessing aq->first and aq->last.

I see your point and it makes sense to me as it makes the
mental memory model cleaner

I viewed the methods as atomic units (you would not call add_task
before the constructor has finished, so no harm there. And a dispatcher
in the pthread would just block on the `workingcount` semaphore as the
semaphores are the main inter thread communication. I viewed the queue
as just a secondary thing to distribute the work load.
