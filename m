From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Fri, 7 Jun 2013 12:01:15 +0200
Message-ID: <CABPQNSa+nZY2V44B-L47aqwt=4eKr96jtadgKHhS__29tTvsdg@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net>
 <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 07 12:02:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UktUf-0001zd-22
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 12:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487Ab3FGKB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 06:01:57 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39293 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab3FGKB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 06:01:56 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so9689032iee.6
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 03:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yfi39A0ptQFCLn4O2TsfGgAWIs2G8bucOy4GvAVXcpc=;
        b=fVZ3Bqsvqt/mg92QZ5typO8E8t2HQl78hJcAVtdRlV7VAeztq1EuAuUg8Qo7JTgOYy
         5UX+w0fXMWzsvyI8fCqbdBynZKZtHFXzlGzNxVtss45CUU9d5S+cFU+zGWnCuI7HXnZP
         pPLI2tyMRKUHSwGAvb4/xjB9cLdy6ZcUm6YHZKEKl1K3iBz17cgZ05VWfPtfaRfaRTom
         CxFNRWPzuQ+elOJKeRcnU1euQbXpNqWit85uRl3qQ9SxhiIfAuqtYcELRV8jnqmVbje3
         fu5iDiIYGPRh2lSuCuPKe6urNwOMgk0wzF/m8/tTp+t1/GUf905iy9bDwuL7XiZl9YHI
         2uOA==
X-Received: by 10.50.87.10 with SMTP id t10mr761110igz.108.1370599315871; Fri,
 07 Jun 2013 03:01:55 -0700 (PDT)
Received: by 10.64.23.199 with HTTP; Fri, 7 Jun 2013 03:01:15 -0700 (PDT)
In-Reply-To: <51B02D81.3000700@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226615>

On Thu, Jun 6, 2013 at 8:34 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> From: Johannes Sixt <j6t@kdbg.org>
>
> The test case depends on that test-sigchain can commit suicide by a call
> to raise(SIGTERM) in a way that run-command.c::wait_or_whine() can detect
> as death through a signal. There are no POSIX signals on Windows, and a
> sufficiently close emulation is not available in the Microsoft C runtime
> (and probably not even possible).
>
> The particular deficiency is that when a signal is raise()d whose SIG_DFL
> action will cause process death (SIGTERM in this case), the
> implementation of raise() just calls exit(3).
>
> We could check for exit code 3 in addition to 143, but that would miss
> the point of the test entirely. Hence, just skip it on Windows.
>

Huh? We do "exit(128 + sigint);" in mingw_raise these days, no?

Or is the signal triggered from a non-git process?
