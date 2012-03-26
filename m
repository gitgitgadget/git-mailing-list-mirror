From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: GSoC - Designing a faster index format
Date: Mon, 26 Mar 2012 23:19:36 +0700
Message-ID: <CACsJy8AqQdWO4E2oYTMLbpYhxobH8iXE-jXPoj2BcEGtfh+T=Q@mail.gmail.com>
References: <CAKTdtZm3qfG1rcoashDoMoqtD34JJDUDtDruGqGn9bSMzQTcFA@mail.gmail.com>
 <87aa3aw5z8.fsf@thomas.inf.ethz.ch> <CAKTdtZkGP3KbMGf88yW7zcCjemUyEy_4CVNkLD0SV=Lm7=Kveg@mail.gmail.com>
 <CAKTdtZmYc=xz4zCPQiuSTUvdmbLRKXNWNL3N6_4Bj0gujYmRvw@mail.gmail.com>
 <CACsJy8AYs5bzRnhRj_R33qTt-2gPh-rJaO0=1iTva9n14wHB4w@mail.gmail.com>
 <CAKTdtZk4FJD9qXEybpN01+S=5fOm=4AbOp8trFr5c6Uxbfykkg@mail.gmail.com>
 <CACsJy8CU_q+3ROO9z5nHe8NZDjTD4mvnEUP7C0+T3u3bRD11rQ@mail.gmail.com>
 <CAKTdtZmLOzAgG0uCDcVr+O41XPX-XnoVZjsZWPN-BLjq2oG-7A@mail.gmail.com>
 <CACsJy8C=4WaN4MZrZMaD3FqZrF2jCP5sm0F0SpDvzQnYfka9Ew@mail.gmail.com>
 <CAKTdtZkpjVaBSkcieojKj+V7WztT3UDzjGfXyghY=S8mq+X9zw@mail.gmail.com>
 <CACsJy8D85thmK_5jLC7MxJtsitLr=zphKiw2miwPu7Exf7ty=Q@mail.gmail.com>
 <CAKTdtZkx+7iU5T4oBNDEx-A5cgZCLU9ocdXmC9jRbD39J1zb3Q@mail.gmail.com> <87iphrjv23.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: elton sky <eltonsky9404@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 26 18:20:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCCeX-0001KN-5d
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 18:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932854Ab2CZQUK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 12:20:10 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:52430 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932655Ab2CZQUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 12:20:08 -0400
Received: by wejx9 with SMTP id x9so4316106wej.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0hn/mjY87kZKy+prOAqTEgX6+zFgwyZ7TIE0WLfVUYg=;
        b=x2giym/miOqv8Wmfyjkl/WG1LXo9NzMl8KfpkTKciboMnMg++AaFVa8bKgIw5hR5bL
         233yK3znj6X649KmlHxgBQx6GF2LZu6EkxaWFER6+mSceNTRwP0t9geKCLlDF9SO5RdF
         GduaK8wSTOs2qKeyhD1zryd0YkOK4W0cKp7sORaEub5DzM53RxUaQWgcp70reHpNqBiu
         qjH/W55WNWk8+/SyewBuMyGQFCgvUFnXQzONBFC09Br310edola7h5g3WhGXAhT7Wlib
         s7J9ZwLHo99Fj+SrXCzrLT4WDSdsZsrXGPRibM23hAuSRvfuJwpSttQOuNij5pXhSZpR
         731Q==
Received: by 10.216.135.225 with SMTP id u75mr11915391wei.97.1332778807139;
 Mon, 26 Mar 2012 09:20:07 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Mon, 26 Mar 2012 09:19:36 -0700 (PDT)
In-Reply-To: <87iphrjv23.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193924>

On Mon, Mar 26, 2012 at 9:28 PM, Thomas Rast <trast@student.ethz.ch> wrote:
> Doesn't that venture into database land?

How about this (a bit like memory management). Maybe it's simpler than
a database and fits us better.

The header consists of crc32 and three uint32_t, one points to the
root tree, one the first extension block, the last one the free list
at the end of the file. The rest of the file contains sizable blocks.
There can be free space between them. Free spaces (offset and size)
are recorded at the end of the file, pointed in header. The header's
crc32 covers the header and free list.

When we need a new block, we look up in free list. If we cannot find a
suitable space, we append to the end of the file (moving free list
further to keep it always the end of the file). Removing a block means
marking it in free list. We only truncate if there is free space at
the end. Operations that we know will scratch the whole index are our
opportunity to rewrite the index and make it compact again. No random
garbage collection (iow disk is cheap).

A block starts with a signature (a tree block, or an extension...). A
tree block consists of:

 - uint32_t tree object's size
 - sha-1 of tree object
 - crc32 of the rest of the block except tree object
 - maybe reference counter of a block can be refered by many blocks??
 - tree object (i.e. something that tree-walk.c can parse)
 - other index attributes, stored separately in the same order as in
tree object above, uint32_t block offset of subdirectories.

An extension block basically consists of what we have now in an
extension plus uint32_t offset to the next extension block, so we can
keep track of all extensions. crc32 is used for extension blocks.

This way we only need to verify checksum of the header (and free list)
and blocks we visit. We don't need cache-tree extension because it's
part of the format. There will be headache with unpack-trees.c because
of entry order change. But in the end we would use the same order tree
objects are using now, much simpler for us.
-- 
Duy
