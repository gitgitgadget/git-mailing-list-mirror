From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] compat: move unaligned helpers to bswap.h
Date: Thu, 23 Jan 2014 11:56:43 -0800
Message-ID: <20140123195643.GV18964@google.com>
References: <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123183522.GA26447@sigill.intra.peff.net>
 <20140123194118.GT18964@google.com>
 <20140123194401.GA31412@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 20:56:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QOU-00068U-FN
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 20:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbaAWT4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 14:56:50 -0500
Received: from mail-bk0-f44.google.com ([209.85.214.44]:58035 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbaAWT4u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 14:56:50 -0500
Received: by mail-bk0-f44.google.com with SMTP id mz12so616150bkb.17
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 11:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=d/ngAD6WOifpSW44W02Z3GdtS5+TFJBh3ezK6jKQSwA=;
        b=aqenNK0g1FcjBx7T2OJejJc+93Xb2R/fGgzXymHfLmBLtIkvOzPLByFcth495q4Jgb
         KNHqgIkny/kTmP9wKybBMeCbA197X8RBe5y6dVSaxPscjOi14i2NhJUdxpoKY1+L1LqP
         rO3n+8c+zkSSixRpklkag+PE9mpMED5v+j7jsanOGoumjhRQI2Lb5VoKvindzypAXV0w
         9aQawAoDH6vixbNsqrW7o5P6rSbJLhqDbOsrRqgktqnsXgpfNk10UY6RFhcBph0Y+D+m
         WrtvQi5gnfREmKzeOSUiMYIy2ul2g542bNHFGkHUuY9Gh4LMfBVi/OhNvczcgg8s1Stt
         L2xA==
X-Received: by 10.204.103.7 with SMTP id i7mr5082291bko.14.1390507008927;
        Thu, 23 Jan 2014 11:56:48 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tf11sm87083bkb.17.2014.01.23.11.56.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 11:56:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123194401.GA31412@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240935>

Jeff King wrote:

> I think it was a bug waiting to surface if index v4 ever got wide use.

Ah, ok.

In that case I think git-compat-util.h should include something like
what block-sha1/sha1.c has:

	#if !defined(__i386__) && !defined(__x86_64__) && \
	    !defined(_M_IX86) && !defined(_M_X64) && \
	    !defined(__ppc__) && !defined(__ppc64__) && \
	    !defined(__powerpc__) && !defined(__powerpc64__) && \
	    !defined(__s390__) && !defined(__s390x__)
	#define NEEDS_ALIGNED_ACCESS
	#endif

Otherwise we are relying on the person building to know their own
architecture intimately, which shouldn't be necessary.

Meanwhile, as mentioned in the other message, I suspect the
NEEDS_ALIGNED_ACCESS code path is broken for aggressive compilers
anyway.  Looking more.

Thanks,
Jonathan
