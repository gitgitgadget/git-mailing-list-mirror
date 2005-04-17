From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Yet another base64 patch
Date: Sun, 17 Apr 2005 12:29:49 -0400
Message-ID: <42628EFD.3030509@dwheeler.com>
References: <Pine.LNX.4.21.0504171018410.30848-100000@iabervon.org>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paul Jackson <pj@sgi.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 18:24:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNCZH-0000ly-VO
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 18:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVDQQ2F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 12:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVDQQ2F
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 12:28:05 -0400
Received: from cujo.runbox.com ([193.71.199.138]:22677 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261353AbVDQQ15 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 12:27:57 -0400
Received: from [10.9.9.1] (helo=bolivar.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DNCcj-00034d-Iy; Sun, 17 Apr 2005 18:27:53 +0200
Received: from [70.17.101.238] (helo=[192.168.2.73])
	by bolivar.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DNCcj-0004Zu-51; Sun, 17 Apr 2005 18:27:53 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504171018410.30848-100000@iabervon.org>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I wrote:
>>>It's a trade-off, I know.

Paul Jackson replied:
>>So where do you recommend we make that trade-off?

Daniel Barkalow wrote:
> So why do we have to be consistant? It seems like we need a standard
> format for these reasons:
> 
>  - We use rsync to interact with remote repositories, and rsync won't
>    understand if they aren't organized the same way. But I'm working on
>    having everything go through git-specific code, which could understand
>    different layouts.
> 
>  - Everything that shares a local repository needs to understand the
>    format of that repository. But the filesystem constraints on the local
>    repository will be the same regardless of who is looking, so they'd all
>    expect the same format anyway.
> 
> So my idea is, once we're using git-smart transfer code (which can verify
> objects, etc.), add support for different implementations of 
> sha1_file_name suitable for different filesystems, and vary based either
> on a compile-time option or on a setting stored in the objects
> directory.

I think that's the perfect answer: make it a setting stored
in the objects directory (presumably set during
initialization of the directory), and handled automagically
by the tools.  I recommend handling them NOT be a compile-time option,
so that the same set of tools works everywhere automatically
(who wants to recompile tools just to work on a different file layout?).


> The only thing that matters is that repositories on
> non-special web servers have a standard format, because they'll be serving
> objects by URL, not by sha1.

If the "layout info" is stored in a standard location for a
given repository, then the rest doesn't matter. The library would just
download that, then know how to find the rest.

--- David A. Wheeler
