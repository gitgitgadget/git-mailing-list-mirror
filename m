From: David Willmore <davidwillmore@gmail.com>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 12:10:19 -0400
Message-ID: <1cddf4cc05042009101b151139@mail.gmail.com>
References: <200504191250.10286.mason@suse.com>
	 <200504192049.21947.mason@suse.com>
	 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>
	 <200504201122.35448.mason@suse.com>
	 <Pine.LNX.4.58.0504200833580.6467@ppc970.osdl.org>
Reply-To: David Willmore <davidwillmore@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 18:07:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOHiX-0007xT-R4
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 18:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVDTQK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 12:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVDTQK0
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 12:10:26 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:51726 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261708AbVDTQKT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 12:10:19 -0400
Received: by rproxy.gmail.com with SMTP id a41so142598rng
        for <git@vger.kernel.org>; Wed, 20 Apr 2005 09:10:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WaNr7nVQAglHxp9AkRMi6e2463jaiOZQNfwCUiX/N7AoIxbZenxmgWiLPABndQ27tHoKnXwsoAH0Thas4X5UfiNrmMLnYYep8+s+h0sfTp2PSI5HP43kKckiyql9uxAqeafIbG4j6HiRtROc5qjZjEzkpOjyJbdOHIsriMx/4Sw=
Received: by 10.38.10.59 with SMTP id 59mr1186328rnj;
        Wed, 20 Apr 2005 09:10:19 -0700 (PDT)
Received: by 10.38.13.48 with HTTP; Wed, 20 Apr 2005 09:10:19 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504200833580.6467@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/20/05, Linus Torvalds <torvalds@osdl.org> wrote:
> It really _shouldn't_ be faster. It still does the compression, and throws
> the end result away.

Am I misunderstanding or is the proglem that doing:
<file with unknown status> -> compress -> sha1 -> compare with existing hash

is expensive?

What about doing:
<file it's supposed to be equal to> -> uncompress -> compare with
unknown status file

It's more file I/O, but the uncompress is much cheaper than the compress.

On a second issue, what's the format of the main 'index' file?  Is it:
<pathspec> <sha1hash>
<pathspec> <sha1hash> 
?
If so, that's not going to compress well.  A file like:
<pathspec1>
<pathspec2>

<sha1hash1>
<sha1hash2>

Will compress better.

Stop me if I'm way off base--I'm just following the mailing list, I
haven't tried out the code.

Cheers,
David
