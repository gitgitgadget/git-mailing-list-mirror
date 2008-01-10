From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/5] Add zlib decompress helper functions
Date: Thu, 10 Jan 2008 13:57:40 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801101351250.3148@woody.linux-foundation.org>
References: <e5bfff550801101304m4f0b97baua6553c45772793b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 22:58:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD5Pf-0001fP-BN
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 22:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbYAJV5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 16:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752218AbYAJV5n
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 16:57:43 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52821 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751587AbYAJV5m (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jan 2008 16:57:42 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0ALvev8029896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Jan 2008 13:57:41 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0ALvegl011177;
	Thu, 10 Jan 2008 13:57:40 -0800
In-Reply-To: <e5bfff550801101304m4f0b97baua6553c45772793b6@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.184 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,TW_XX
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70100>



On Thu, 10 Jan 2008, Marco Costalba wrote:
>
> When decompressing a zlib stream use this
> helpers instead of calling low level zlib
> function.

I really *really* hate your naming.

> This is the first step in generalizing compress and
> decompress functions avoiding zlib directly calls.

If that's the goal, why keep the horrible "z_" prefix, and why the opaque 
and non-obvious "inflate"/"deflate" names?

I'd suggest that you just replace all "z_deflate_" with "compress_" and 
"z_inflate_" with "decompress_".

Yes, it would still leave zlib-specific stuff in there (the return codes, 
the "z_stream" type thing etc), but at least it would be a _step_ towards 
more readable code and code that is less obviously zlib-specific.

With those changes, I'd heartily recommend merging this even if we never 
actually switch away from zlib, if only because zlib has all these 
horrible names.

		Linus

[ How many people really know that "inflate" means "uncompress", without 
  having to think about it a bit?

  I guarantee that any computer person immediately knows the difference 
  between "compress" and "decompress" without even thinking, but ask 
  somebody what "inflate" vs "deflate" does, and they'll be able to answer 
  you, but they'll first have to think about an air mattress or something.

  Yeah, yeah, old-time zip users probably think the whole xxflate thing 
  makes sense, and I'm just grouchy because _I_ always have to think 
  about it. ]
