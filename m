From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: My git repo is broken, how to fix it ?
Date: Wed, 28 Feb 2007 20:12:03 +0100
Message-ID: <81b0412b0702281112y714c3b0eread09ee9440d0537@mail.gmail.com>
References: <200702281036.30539.litvinov2004@gmail.com>
	 <Pine.LNX.4.64.0702272039540.12485@woody.linux-foundation.org>
	 <200702281754.42383.litvinov2004@gmail.com>
	 <Pine.LNX.4.64.0702280802150.12485@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 28 20:12:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUDj-00050o-QA
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbXB1TMJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbXB1TMJ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:12:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:19673 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932359AbXB1TMF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:12:05 -0500
Received: by ug-out-1314.google.com with SMTP id 44so206565uga
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 11:12:04 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mQx3Pbvttt91+PNrqKtd3mA+OUCU6V72QFpVYVb54r8i9+CqyWyx0MGZKXiE0LoMnSOIyqffSMggFtfGziMxJvVP0RbvYNqCtGz+mTG3GjaT1y398v5McLYeuXdL2PL9a6GnqZaI6Po3Rt1YkPNYBAPqT9mBD62mEj6w82oRS5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W86hbzZoQi0jZfuBMPkHl7bbvRRQpClHsOHrvqrnKIYYJbyVE1/EMM/Ao9YlMkudrSOkNjRnolTftYql+lcc64WoDKdvQrCvvA1VDNKwruT5GvsDbEN005l1J++3EtjdP0xgJfBFFMg3FtZQrLH7/uIaGiXRm+uD+bR6OsDRfMU=
Received: by 10.78.160.2 with SMTP id i2mr75902hue.1172689924297;
        Wed, 28 Feb 2007 11:12:04 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Wed, 28 Feb 2007 11:12:03 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702280802150.12485@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40990>

On 2/28/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>  - try to figure out why things got corrupted in the first place.
> ...
>    But I would not be shocked to hear that the "link + unlink" sequence
>    ends up being emulated under cygwin as a "copy + delete" due to lack of
>    hardlinks or something.

Well, cygwin has a whole rename implementation using wincalls (which
may or maybe not syscalls). It's hard to tell whether micros$#%^ used
link+unlink: windows traditionally had no link(2). It has it since W2K,
allowed only on ntfs, and even there it spent some time undocumented :)

>    Also, even if the link fails, and git then falls back to "rename()"
>    (since some filesystems don't do hardlinks at all, or limit them to one
>    particular directory), I would _still_ not be totally surprised if the
>    rename got emulated as a copy/delete for some strange Windows reason.
>
>    There are other possibilities for corruption, of course: just plain
>    disk corruption, or (again) some other subtle cygwin emulation or
>    Windows issue could bite us.

It is very hard to tell: the rename function in cygwin is over 200 lines long,
has multiple calls down to the kernel (or whatever it is), and there are two
different wincalls used. It is hard to predict what path will be taken or
whether there were actually any data copying happened.
Of course, windows known to corrupt data just so...

>  - It would probably be good to write up the "How to recover" thing,
>    regardless of why any corruption happens. It doesn't matter if you're
>    under UNIX and using native protocols, and just being careful as hell:
>    disks get corrupted, sh*t happens, alpha-particles in the wrong place
>    do bad things to memory cells. And bugs _are_ inevitable, even if
>    we've been pretty damn good about these things.

It'd be a good start to link the recent disaster recoveries from
git.or.cz wiki from the title page (unless it is already).
