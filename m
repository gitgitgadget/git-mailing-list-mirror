From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 12 Sep 2013 11:14:19 +0100
Message-ID: <20130912101419.GY2582@serenity.lan>
References: <523094F0.9000509@gmail.com>
 <20130911182921.GE4326@google.com>
 <CAHGBnuN0pSmX7_mM6xpRqpF4qPVbP7oBK416NrTVM7tu=DZTjg@mail.gmail.com>
 <20130911214116.GA12235@sigill.intra.peff.net>
 <CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 12:14:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK3v6-0002VZ-Jd
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 12:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab3ILKOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 06:14:36 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:42183 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab3ILKOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 06:14:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 350F9CDA608;
	Thu, 12 Sep 2013 11:14:35 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Lz6BvuYtxL5; Thu, 12 Sep 2013 11:14:28 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id CA006CDA615;
	Thu, 12 Sep 2013 11:14:21 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAHGBnuP3iX9pqm5kK9_WjAXr5moDuJ1jxtUkXwKEt2jjLTcLkQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234639>

On Thu, Sep 12, 2013 at 11:36:56AM +0200, Sebastian Schuberth wrote:
> > Just wondering if that is the root of the problem, or if maybe there is
> > something else subtle going on. Also, does __CRT_INLINE just turn into
> > "inline", or is there perhaps some other pre-processor magic going on?
> 
> This is the function definition from string.h after preprocessing:
> 
> extern __inline__ int __attribute__((__cdecl__)) __attribute__ ((__nothrow__))
> strncasecmp (const char * __sz1, const char * __sz2, size_t __sizeMaxCompare)
>   {return _strnicmp (__sz1, __sz2, __sizeMaxCompare);}

I wonder if GCC has changed it's behaviour to more closely match C99.
Clang as a compatibility article about this sort of issue:

    http://clang.llvm.org/compatibility.html#inline
