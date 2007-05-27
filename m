From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GIT on MinGW problem
Date: Sun, 27 May 2007 11:09:11 +0200
Message-ID: <200705271109.11942.jnareb@gmail.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <46592CFE.40303@xs4all.nl> <4659318B.20801@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon May 28 01:12:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsRuO-0001if-2H
	for gcvg-git@gmane.org; Mon, 28 May 2007 01:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757981AbXE0XLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 19:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757108AbXE0XLk
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 19:11:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:24011 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759216AbXE0XLj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 19:11:39 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1510505ugf
        for <git@vger.kernel.org>; Sun, 27 May 2007 16:11:38 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MV+nwgagy5h93dvAWpK/AOhLnxF+I+8NJa+a/Vwbtgg7k1amvayvochF+nB4A4pxPiSoA9Bd85mrElu3z4DUzHZfzglKE0hzEfoGrF0ptmZDDjIlXKgt8G+/BvsyIYBRSD5xKWzsjgX6BPN9mqvVs2Feo3r18vw0hCs5gFx7zVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nByXL1AMBnI1xgzoGv4xnZNWXyWzZGzmGLXrYGeTu9Bw/noK1ntnfjltmzL17ESS27KtuB8bx54R7d3rHE18N4SpxE2Z3v8PxPPelZxmwyTt56+BZWQAG02tixCLtwyizJNUF2Sv4AFx6ENnliZySx4LGv2qQ/8/fnRGlToO1oc=
Received: by 10.67.22.2 with SMTP id z2mr4802828ugi.1180307498882;
        Sun, 27 May 2007 16:11:38 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id i5sm24835683mue.2007.05.27.16.11.37;
        Sun, 27 May 2007 16:11:38 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4659318B.20801@midwinter.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48595>

On Sun, 27 May 2007, Steven Grimm wrote:
> Han-Wen Nienhuys wrote:
>> Shawn O. Pearce escreveu:
>>>
>>> On systems like Cygwin the fork+exec overheads are very high
>>
>> A well written configure script is able to detect presence
>> of a linkable libcurl.
> 
> IMO the reasons configure is so unwieldy, at least as it's set up in 
> most open source projects, are that a) it spends 95% of its time 
> checking for things that basically never vary (yes, I have stdlib.h, 
> thank you) and that b) it doesn't remember the results from previous 
> runs on the same host (I'm just changing the install path; my ints won't 
> have stopped being 32 bits as a result.)

./configure _can_ cache tests results:

$ ./configure --help
[...]
      --cache-file=FILE   cache test results in FILE [disabled]
  -C, --config-cache      alias for `--cache-file=config.cache'

but it does not do this, and does not check chache by default. Of course
tests have to be written to make use of cache, IIRC...

> I wonder if we could satisfy  
> most people with a configure script -- maybe not based on autoconf -- 
> that is limited in scope to just the things that are currently tweakable 
> in the git Makefile.

The problem with handcrafted configure script lies in the portability
of it. There was an attempt to add such script, IIRC based on mplayer's
configure.sh script, but it turned out it was not portable enough.
The conclusion was that sice so many manhours were put into making
autoconf generate ultra-portable ./configure shell script, it would
be better to use it.

> If configure ran only, say, 10-15 tests, I bet the fork+exec overhead on 
> Cygwin would be perfectly tolerable.

That's not only fork+exec, that is also the fact that large number
of tests relies on compiling snippets of code...


P.S. What do you think about separating the guessing appropriate
values of build variables based on uname to separate file
config.mak.guess, included in Makefile?

-- 
Jakub Narebski
Poland
