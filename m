From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 0/7] Case-insensitive filesystem support, take 1
Date: Tue, 25 Mar 2008 11:14:09 +0300
Message-ID: <20080325081409.GI25381@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Frank <streamlake@tiscali.it>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 25 09:16:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je4JA-0003dJ-ES
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 09:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbYCYIOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 04:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751821AbYCYIOT
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 04:14:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:26425 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbYCYIOS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 04:14:18 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3386214fgb.17
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 01:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=FfJzFcHeGV3/J9R1cFlDOXD1uTNF5jGDr8BEYFtYHpw=;
        b=c2MXBxDyn4240OkcIYCWVpXsGXHQEZbdJ8Jc7iYFysXv/yJtVAYHt7VYGvyDkRHRlxa5z62EtHayogc00LHjoTwzHDZSU6//QkETx8/YrOua2T+ZzAh2PiV5SnMvVi2kBacwbGZEPBGG4iyPQl2NcJMVt4PkHxq3nicTBTeC74g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=MuqprvnMge3xxPLATesUxeR+rs2m1miWvNJnLVOB41Fc9775sN5R8YImMg2dFTJwffouTokAoNWTME/HZIMNE9/SzKnQxgg7KJrgCWfBN5DSgd6nn55OTQYqPGkfWeBc8Eelzg4nsimumwH7A0xswHYYMlV41bGithaWyJkNct0=
Received: by 10.86.51.2 with SMTP id y2mr5256236fgy.15.1206432853307;
        Tue, 25 Mar 2008 01:14:13 -0700 (PDT)
Received: from localhost ( [83.237.187.35])
        by mx.google.com with ESMTPS id l19sm9072669fgb.0.2008.03.25.01.14.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Mar 2008 01:14:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0803220955140.3020@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78161>

On Sat, Mar 22, 2008 at 10:21:05AM -0700, Linus Torvalds wrote:
> 
>  - I've tested this series, both on a case-sensitive one (using hardlinks 
>    to test corner cases) and on a vfat filesystem under Linux (which is 
>    case-insensitive and *really* odd wrt case preservation - it remembers 
>    the name of removed files, so it preserves case even across removal and 
>    re-creation!)

I also have observed this problem with VFAT on Linux, but the effect was not
stable. It looks like old information is preserved somewhere in caches...

Anyway, I have tested this series of patches a bit on Windows and so far
I have found the following:

- merge different branches were two file names are only differ by case
  will cause that the result branch has two file names that differ only
  by case and one of them will be overwritten by the other and shown as
  modified in the worktree by git status.

- git status cares only about case-insensitivity only for files and not
  for directories. Thus, if case of letters in a directory name is changed
  then this directory will be shown as untracked.

- pattern specified in .gitignore are match as case-sensitive despite
  core.ignorecase set to true.

Personally, I don't care about any of the above issues much as I rarely
work on Windows and when I do, I always check that all filenames are in
low case except Makefile (and a few more exceptions). So, I have never
had any problem with using Git on case-insensitive system...

Dmitry
