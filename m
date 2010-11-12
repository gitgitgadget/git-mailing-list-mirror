From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Scripted clone generating an incomplete, unusable .git/config
Date: Thu, 11 Nov 2010 23:18:04 -0600
Message-ID: <20101112051804.GE10765@burratino>
References: <AANLkTik7-QzrMKDpV=W4dqpuguZsAr5yrMELmHu5NZMd@mail.gmail.com>
 <20101111103742.GA16422@burratino>
 <AANLkTinzotA4TSjMjjmW--gw7ST3dXMyHzPveGynaVmZ@mail.gmail.com>
 <20101111173253.GC16972@burratino>
 <alpine.LNX.2.00.1011111241360.14365@iabervon.org>
 <20101111184829.GG16972@burratino>
 <20101111190508.GA3038@sigill.intra.peff.net>
 <20101112043229.GB10765@burratino>
 <20101112044137.GA24915@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, Git ML <git@vger.kernel.org>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Carl Worth <cworth@cworth.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 12 06:19:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGm2a-0008Kz-0u
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 06:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837Ab0KLFSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 00:18:31 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35033 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab0KLFSa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 00:18:30 -0500
Received: by yxt33 with SMTP id 33so185066yxt.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 21:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=P2JLmHR7lrve2Xk/tVkM+iuWpvibA16GlDfCUVWpI28=;
        b=FXxzid5O6UwqoWFtMaUPTMNrYGZ/K7pVTbifR2rfS1AgS5L1GbvfTgm+rUhq4OtK3v
         X0JgCLhCP7NaLSurdEt2Mv+MmCga8jWzXTwG6u8jsb78YkCVnPZmXd3kMgdGORTdTFL8
         R7orhjObDaRFQ2E1FyOC7UO4S1lLUDWlYdqMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rcNbe1VHzdH/7Onc/6r4+bqyLU8wgLBrSM7m0NZTnWxOmxo/w6FOybgPefhQ6dZ4wj
         zEHf8MGFVu47Ngq9JQG4+qoE19PJwLvuY6b1un5xOAzAC4276zpVY3O4yAhtOJq7i/z0
         98xwcKeTRkt0Dl41ySFNLs3L7C68irkRnbv/s=
Received: by 10.151.26.1 with SMTP id d1mr3233043ybj.267.1289539109399;
        Thu, 11 Nov 2010 21:18:29 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id l66sm2110501yhd.20.2010.11.11.21.18.27
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 21:18:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101112044137.GA24915@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161325>

Jeff King wrote:
> On Thu, Nov 11, 2010 at 10:32:30PM -0600, Jonathan Nieder wrote:

>> Subject: SIGPIPE and other fatal signals should default to SIG_DFL
>> 
>> The intuitive behavior when a git command receives a fatal
>> signal is for it to die.
[...]
> Do we need to have it in every command? Is calling git-foo deprecated
> enough that we can just put it in git.c?
> 
> I guess there are still a few commands that get installed explicitly in
> .../bin (upload-pack, for example). They would need a separate one.
> Perhaps it doesn't hurt to just put it in all of the non-builtins as you
> did. It's not that big a maintenance issue.

Okay.  Here's a hunk I forgot to add.  The next challenge is how to
test this mess. :)

diff --git a/cache.h b/cache.h
index d85ce86..8088e26 100644
--- a/cache.h
+++ b/cache.h
@@ -5,6 +5,7 @@
 #include "strbuf.h"
 #include "hash.h"
 #include "advice.h"
+#include "sigchain.h"
 
 #include SHA1_HEADER
 #ifndef git_SHA_CTX
