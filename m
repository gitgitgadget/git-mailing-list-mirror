From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: 'git status' is not read-only fs friendly
Date: Fri, 9 Feb 2007 21:19:54 +0100
Message-ID: <e5bfff550702091219n4df5531ek6be2cd04f00be650@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "GIT list" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 09 21:20:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFcE5-00027B-QE
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 21:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423284AbXBIUUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 15:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423291AbXBIUUA
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 15:20:00 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:15485 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423284AbXBIUTz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 15:19:55 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1066185wri
        for <git@vger.kernel.org>; Fri, 09 Feb 2007 12:19:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jnAgBkzbYdUgvjlFtaGkTs81z/9SJ7NMr7RlpbyLFSjAZ+LoO5P7K3VShTS6E5LbxnIIFs+rFuEIP8Yp4KD6MQDi+O6w/uvtGkDWXGPfOQtr0w065nTvQ9Hi2vUdTiOFTssGVBD1HCJHsq97e0bSy8ZPspKj1k/4D4o1rFpzARI=
Received: by 10.114.169.2 with SMTP id r2mr6332557wae.1171052394527;
        Fri, 09 Feb 2007 12:19:54 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Fri, 9 Feb 2007 12:19:54 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0702091148060.8424@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39194>

On 2/9/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>

> And you wouldn't think that it really needs write access, and you'd be
> largely correct, EXCEPT for the fact that git status actually does a
> refresh of the index, to make sure that we don't claim that something is
> dirty just because somebody has touched the file.
>
> IOW, there's an implicit "git update-index --refresh" as part of
> calculating the status, and that's the thing that wants to lock the index
> file (and thus write to the filesystem).
>
------ cut ------
>
> You *can* just use "git-runstatus" instead. That's the command that
> actually does all the heavy lifting. But you can see the difference by
> doing this:
>
>         touch Makefile
>         git runstatus
>
> vs
>
>         touch Makefile
>         git status
>
> Notice how the "runstatus" one claims that Makefile is "modified:". That's
> exactly because it doesn't do the index refresh.
>
Sorry, perhaps it is a silly question, but why git index should be
different after just touching a file?

IOW is it not possible that "git update-index --refresh" exists
without modifing the index, just because ther's nothing to modify?

So, finally, could be possible making "git status" taking the lock
only _after_ has checked there's something new to write to the index?
So to avoid write access in most cases ? (expecially with repo mounted
on a read-only fs)

Thanks
Marco
