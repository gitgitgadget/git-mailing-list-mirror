From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: [patch] munmap-before-rename, cygwin need
Date: Mon, 8 May 2006 10:58:00 +0000
Message-ID: <f36b08ee0605080358y3830f1aep879331df806211e0@mail.gmail.com>
References: <f36b08ee0605071258s7a0cb085r3f08e9981234255a@mail.gmail.com>
	 <7vslnlk04v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 12:58:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd3RN-0000Bk-Jv
	for gcvg-git@gmane.org; Mon, 08 May 2006 12:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWEHK6D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 06:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWEHK6D
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 06:58:03 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:43910 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751066AbWEHK6B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 06:58:01 -0400
Received: by py-out-1112.google.com with SMTP id x31so1432578pye
        for <git@vger.kernel.org>; Mon, 08 May 2006 03:58:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FSMyaiwFEtOnefLjo2f5/12neEUpwObVSC4JxGcc616hgD4MYdoahwD1HzzXB1ZmoPx6C1FpdYnZuzbPdbeUrDYdF0o5Km13gMMvkrXpRShj6+tdKwbB8/+ldwr9OOEFgQLE+SIKufxtI0m1u6bpVXhm6S6Ekwwfey3TqTwBb5o=
Received: by 10.35.98.6 with SMTP id a6mr883663pym;
        Mon, 08 May 2006 03:58:00 -0700 (PDT)
Received: by 10.35.96.18 with HTTP; Mon, 8 May 2006 03:58:00 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vslnlk04v.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19762>

On 5/8/06, Junio C Hamano <junkio@cox.net> wrote:
> "Yakov Lerner" <iler.ml@gmail.com> writes:
>
> > I found that mmap() works on cygwin, but needs a patch.
> > On Cygwin, rename() fails if target file has active mmap().
> > The patch below adds  munmap() before rename().
>
> This is interesting in three counts.
>
>  - I from time to time test Cygwin version on my day-job machine
>   (W2K) and my wife's machine (XP); on both machines I usually
>   have less than two weeks old Cygwin installation, and I have
>   not seen the breakage.  I wonder how reproducible this is.
>   Also previously people reported mmap() works for some and
>   fake mmap is needed for others.  Would this patch make things
>   work for everybody?
>
>  - The part you patched is commit_index_file().  This typically
>   is called just before program exit, but some callers, like
>   apply.c, may want to still look at the index after calling
>   it, fully aware that the changes after commit_index will not
>   be written out.  Although I haven't traced the codepath fully
>   in apply.c yet, unmapping would break the access to the index
>   (i.e. active_cache[]).  Does apply still work with your
>   patch?

I am checking this. I am trying different options and different
scenarios.

Yakov
