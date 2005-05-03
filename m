From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git and symlinks as tracked content
Date: Tue, 03 May 2005 12:50:33 -0700
Message-ID: <4277D609.5050701@zytor.com>
References: <1115145234.21105.111.camel@localhost.localdomain> <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 21:45:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT3Jx-0007NT-VN
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVECTu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVECTu4
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:50:56 -0400
Received: from terminus.zytor.com ([209.128.68.124]:59359 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261649AbVECTus
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 15:50:48 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j43JocLU005618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 3 May 2005 12:50:38 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=ham 
	version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> So you have
> 
>  - directories: S_IFDIR (0040000) point to "tree" objects for contents
>  - symlinks: S_IFLNK (0120000) point to "blob" objects
>  - executables: S_IFREG | 0755 (0100755) point to "blob" objects
>  - regular files: S_IFREG | 0644 (0100644) point to "blob" objects
> 
> which seems very sane and regular. 
> 

One thing about using a hierarchy of "tree" objects... as far as I 
understand today, it's possible for "git" to represent a limited 
scattering of files underneath the root, such as keeping one's 
configuration files underneath one's home directory.  Scanning the whole 
home directory to check in (or worse, out) files would suck.

On the other hand, having a single "tree" object for a large project 
that would have to be constantly updated would suck, too.

This is certainly *not* mutually exclusive; it's mostly a matter of 
making sure that if scaffolding directory objects are necessary, that 
they can be automatically added/created, and aren't exhaustively 
searched for uncontrolled objects.

> Now, I also haev a plan for device nodes, but that one is so ugly that I'm 
> a bit ashamed of it. That one does:
> 
>  - S_IFCHR/S_IFBLK (0020000 or 0060000), with the 20-byte SHA1 not being a 
>    SHA1 at all, but just the major:minor numbers in some nice binary 
>    encoding. Probably: two network byte order 32-bit values, with twelve 
>    bytes of some non-zero signature (the SHA1 of all zeroes should be 
>    avoided, so the signature really should be soemthing else than just 
>    twelve bytes of zero).
> 

OK, that's ugly.  I'm impressed.  :)

	-hpa
