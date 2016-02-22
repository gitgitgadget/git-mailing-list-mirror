From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] Correct conditions to free textconv result data
Date: Tue, 23 Feb 2016 06:03:59 +0700
Message-ID: <CACsJy8BWgDFq_Dv=omkpDBa_pUF7zKr9cFftNL-KxtMcTkc5-w@mail.gmail.com>
References: <1456145545-5374-1-git-send-email-pclouds@gmail.com>
 <1456145545-5374-3-git-send-email-pclouds@gmail.com> <20160222180645.GB4587@sigill.intra.peff.net>
 <20160222181224.GA4917@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 00:04:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzWu-0003uB-1n
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 00:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756244AbcBVXEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 18:04:31 -0500
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33232 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106AbcBVXEa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 18:04:30 -0500
Received: by mail-lb0-f178.google.com with SMTP id x4so91854851lbm.0
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 15:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P90ohNiaWfcG+8vL4NBTfjUQeYvX1sqjYxT/cN9CSu4=;
        b=Ob6FNy0XcQnPOoNJRvRGDCXauH35bulhbud8HMXbJdYkM8bCE4gL3lCGIzACDHV6Z3
         RyuAGiTX4qVLe8c3BTBONKj/iNzUlONB1tXaJZqIkKakXaTDfDoLHBCX0Tb7KkSVdavl
         u/rH4nVtGZLL1foCNXqMOAHwRv2uCScHwv+0GR0Xdamt4okwHUTe6BmnInQ77FXe4gSu
         MoaUg+/smZc7sINjA0SuMFSLKio8XxWRs/QDxHvD4wsvSSAShbwgC5epgZPE1Z9ZjCGl
         7fNIp6xVya1J2aLuwXe5tOlYC4dtez/gIQwORcrt5k8xEBdAEaifJcLpU64XFAGuTdX0
         lYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=P90ohNiaWfcG+8vL4NBTfjUQeYvX1sqjYxT/cN9CSu4=;
        b=feCubGaqMGFYdS9hCMflaL+pKTr6VCCJ7I8WFxt8ZRRhYRmXhQEj6zBK8r29JBK/Uh
         P0JiwKcz0xeC5RDF0XL6KviHoxZuk5CqLeyLpLf2jH2xNmjFTNMBMdw5xIg+vVD51mbq
         gIvR9MNcjjnoKStlw4ZATdBPhHwMlHqtlVGw2UTAn8VohU28XZsmj3QiXSGj08IKM+Nt
         CZBpCC4GfFWtVOsZwiiIg3W2CmMydzLVHeh44zDIn4kIOGr+sKF/XadlpQ65+6r/uQxs
         yPXzxic7rtw9wafHM0QWh+IhDHj0Fu9Gq86Ds41wRVZh9nXo/7IpCop6FMeeqAJr5RyS
         FIaA==
X-Gm-Message-State: AG10YORVX2hrrgtNeK71f0aof2zgRY4XFLkscZRU0DYIKegmr4K82YmhA/wdYau2Bs4RdXDxg6YpznBBYSBtdA==
X-Received: by 10.112.219.234 with SMTP id pr10mr53917lbc.145.1456182269106;
 Mon, 22 Feb 2016 15:04:29 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 22 Feb 2016 15:03:59 -0800 (PST)
In-Reply-To: <20160222181224.GA4917@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286996>

On Tue, Feb 23, 2016 at 1:12 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 22, 2016 at 01:06:46PM -0500, Jeff King wrote:
>
>> Is there a case I'm missing here where we actually leak memory or try to
>> free non-allocated memory? I didn't see it.
>
> By the way, I saw only patches 2/3 and 3/3 on the list. So maybe there
> is something interesting going on in 1/3, or in a cover letter that
> didn't make it. :)

The only thing common in this series is it's the result of
-Wwrite-strings. 1/3 changes some "char *" to "const char *", you
don't miss anything.
-- 
Duy
