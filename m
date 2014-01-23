From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] compat: move unaligned helpers to bswap.h
Date: Thu, 23 Jan 2014 12:08:04 -0800
Message-ID: <20140123200804.GW18964@google.com>
References: <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123183522.GA26447@sigill.intra.peff.net>
 <20140123194118.GT18964@google.com>
 <20140123194401.GA31412@sigill.intra.peff.net>
 <20140123195643.GV18964@google.com>
 <20140123200450.GB31920@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:08:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QZa-0002cF-4M
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbaAWUIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:08:13 -0500
Received: from mail-bk0-f54.google.com ([209.85.214.54]:39274 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbaAWUIK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:08:10 -0500
Received: by mail-bk0-f54.google.com with SMTP id u14so621183bkz.41
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 12:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yBIgRISKEToGWNW6osp9coHaaIyGyDZlcE2Bg36Ne2s=;
        b=0+weSBuLfK57znDC1Q+09EoFHBGF0C9Nq1fAEONhHNeSg/SL5cwZDdxppsPEoKv8k5
         ZqONlTUhmJnurmZ9/0WZSIGLIaQuiSBAV/EOCLWcSkERKHR1j8f+/kAKGDPLbhzrZm0S
         8y2J1F5YjxXfLi/i6jn4bv4zHWXI+HQXHDoe0Y1HfybS1KXm14J6pVWLqpSMv9RI5G1B
         vT09BzHOU5qYQmcPEtj2Ra+uQzGt0b5hC+8Y5wK+wG/XN8FSo2+QJDshKBJZLoTwPdej
         Wmdt4KTp1aeIWJjha6NYsAEgrmXq97u0pJYnGRZ/raJpWqxovET0aoiyg3B7gOPyjWxd
         60hQ==
X-Received: by 10.204.69.203 with SMTP id a11mr1683176bkj.111.1390507689167;
        Thu, 23 Jan 2014 12:08:09 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id rf10sm148590bkb.3.2014.01.23.12.08.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 12:08:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123200450.GB31920@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240939>

Jeff King wrote:
> On Thu, Jan 23, 2014 at 11:56:43AM -0800, Jonathan Nieder wrote:

>> In that case I think git-compat-util.h should include something like
>> what block-sha1/sha1.c has:
>> 
>> 	#if !defined(__i386__) && !defined(__x86_64__) && \
>> 	    !defined(_M_IX86) && !defined(_M_X64) && \
>> 	    !defined(__ppc__) && !defined(__ppc64__) && \
>> 	    !defined(__powerpc__) && !defined(__powerpc64__) && \
>> 	    !defined(__s390__) && !defined(__s390x__)
>> 	#define NEEDS_ALIGNED_ACCESS
>> 	#endif
>>
>> Otherwise we are relying on the person building to know their own
>> architecture intimately, which shouldn't be necessary.
>
> Yeah, I agree it would be nice to autodetect.

The nice thing is that false positives are harmless, modulo slowing
down git a little if the compiler doesn't figure out how to optimize
the NEEDS_ALIGNED_ACCESS codepath when on an unlisted platform that
doesn't, in fact, need aligned access.

In other words, it would work out of the box for everybody.
