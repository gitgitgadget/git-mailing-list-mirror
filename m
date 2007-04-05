From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] git-{repack,pack-objects} accept --{pack,blob}-limit to
 control pack size
Date: Thu, 5 Apr 2007 08:34:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704050831520.6730@woody.linux-foundation.org>
References: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com>
 <alpine.LFD.0.98.0704041750030.28181@xanadu.home>
 <56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com>
 <20070405065433.GD5436@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dana How <danahow@gmail.com>, Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 17:35:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZTzp-0007oh-6O
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 17:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767078AbXDEPfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 11:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767079AbXDEPfZ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 11:35:25 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41206 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767078AbXDEPfY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 11:35:24 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l35FYwPD031358
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Apr 2007 08:34:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l35FYv1B019106;
	Thu, 5 Apr 2007 08:34:57 -0700
In-Reply-To: <20070405065433.GD5436@spearce.org>
X-Spam-Status: No, hits=-2.456 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43835>



On Thu, 5 Apr 2007, Shawn O. Pearce wrote:
> 
> For glibc we do try to set _FILE_OFFSET_BITS to 64

I repeat: that's _broken_.

It's in no way portable. It's a glibc horror. It should not be used.

It was a quick hack, but the real way to do it is to use "loff_t" and 
"llseek".

But there simply isn't any way to do mmap() or pread() portably outside 
the 32-bit area. So there are good reasons why we should just limit 
pack-files to 32-bits on 32-bit architectures.

So I think that Dana's approach is just fundamentally correct. Yeah, we 
should probably have a 64-bit index as a *possibility*, but it simply 
isn't a replacement for "keep packs under 2GB in size".

		Linus
