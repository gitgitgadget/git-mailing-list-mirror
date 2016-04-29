From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 25/29] refs: resolve symbolic refs first
Date: Fri, 29 Apr 2016 19:14:52 -0400
Organization: Twitter
Message-ID: <1461971692.4123.41.camel@twopensource.com>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
	 <a33272db057ac6327cc0c87c002473c89ffcca6b.1461768690.git.mhagger@alum.mit.edu>
	 <1461886803.4123.14.camel@twopensource.com> <57232EAB.3080406@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Apr 30 01:15:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awHch-00006V-FK
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 01:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751979AbcD2XO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 19:14:56 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35712 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbcD2XOz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 19:14:55 -0400
Received: by mail-qk0-f180.google.com with SMTP id q76so46482736qke.2
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 16:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=vkmIPS2SX9NZ5v7rwEo7wWcrO7ihuXNx8kE8kcoAgtE=;
        b=D4ZWhAzHCVtCGwgWPAdixLzusxna6H/yGRKKXZoH34r3fVO8xxiy4XplKix+jQxpXT
         jvsXOJhzr+vsbgfVtJKt3s/Y5IAMxuvEcTuMA2SzyFlIGwcjQ8CeGlKTzj8P9/KQtfNI
         zD6jF0jSOL1glBVBVdgnMkAzyFLFAin952mP7GHd2b6zChFwP8qLF7IZHK9aGFXMd8R7
         uVrvA5rqWICyN7+DU+c2H6u2PsE0n+VJkzn3JpiRSLQPNd+WoBJCZT7gl5+IofW0JiCT
         2PzJx7v4roYLyY+1x7ML8MZlpIqCNOaAFgD+WlwC7jZau41ZOFazDj3MvSxwP3U1WSA8
         DJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=vkmIPS2SX9NZ5v7rwEo7wWcrO7ihuXNx8kE8kcoAgtE=;
        b=S9+tpXtorvNn6JEAFVPDFNTDbWtGTnZWv2LX8KZrxIa0hWV3Bo0pbET6NQzlA+5j7L
         o6/QY7hIUZ4Pm4CQwjOEYJ8Dxta+De8kghojm78HaO+X3/33/6pCVCFWU+23jbS3PU9T
         JgKltKJgE9qHa+1Lae3dgSTXo53XipHVUm71sLlvfwMNt4KIRqcP8YozpcI8oaufYz4M
         7xD213hG/tWN2ET3xPA2qneiunfaeABEQPDS+U0QURB5Kh//OnzZ5EDrwLuDaNCZQEnD
         mneMGIBHYb52hdcEJACFI8sPP1/ZYPf4o9skkl2np5SjB2IyuObOPgG7aHOjD6DPpQ3k
         Xvqw==
X-Gm-Message-State: AOPr4FWAResq4G61FqyV81WK/M/3CEPb1u9e0YacUctgLPy4mG8RYI5QaUPevgGHtnDeiw==
X-Received: by 10.233.235.67 with SMTP id b64mr23226943qkg.109.1461971694317;
        Fri, 29 Apr 2016 16:14:54 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id o78sm5157369qge.23.2016.04.29.16.14.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 16:14:53 -0700 (PDT)
In-Reply-To: <57232EAB.3080406@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293068>

On Fri, 2016-04-29 at 11:51 +0200, Michael Haggerty wrote:
> On 04/29/2016 01:40 AM, David Turner wrote:
> > On Wed, 2016-04-27 at 18:57 +0200, Michael Haggerty wrote:
> > +retry:
> > ...
> > > +		if (--attempts_remaining > 0)
> > > +			goto retry;
> > 
> > could this be a loop instead of using gotos?
> 
> It certainly could. The goto-vs-loop question was debated on the
> mailing
> list when I first added very similar code elsewhere (unfortunately
> I'm
> unable to find a link to that conversation). I was persuaded to
> change
> my loop into gotos, the argument being that the "retry" case is
> exceptional and shouldn't be such a dominant part of the function
> structure. Plus the goto code is briefer and feels less awkward to me
> in
> this case (that's subjective, of course).

It's part of the structure anyway; it's just implicit rather than
explicit. I won't block consensus tho.
