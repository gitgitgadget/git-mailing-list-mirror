From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Shrink the git binary a bit by avoiding unnecessary inline functions
Date: Sun, 22 Jun 2008 21:32:49 +0000
Message-ID: <46d6db660806221432m6a6e2f3egf78faa1510f8d643@mail.gmail.com>
References: <alpine.LFD.1.10.0806221159140.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jun 22 23:33:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAXC0-0003Bc-CK
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 23:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbYFVVcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 17:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754706AbYFVVcv
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 17:32:51 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:49468 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbYFVVcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 17:32:50 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6695362rvb.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=h2cVJSvEPLFQIY4IHk3ilAUEAgQhRU1ZRSReRrdSY/Y=;
        b=juLz76bWYVKrO7Dd6vEgsXCJLIN2HF1R6cD8uBACkBc3pXyB5QzxQ786WVtw6BEjeN
         bLMtjhzDwr2E5rmBXwapZep2lcfD5A9ujxHFcM/8pYPMi3LoFrJR7DRTUbzyQay7ioLr
         /f12GsazKpE4onxzCZZoSlHpFJgOjbUAoFwdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GjhJsNYIPgH9lv8XKmfcja3fp21k0wB9v58RZ1Mqlv/Zefzpvobw4CjIhsLby5wJ6i
         MfbKxXYXnIzhCiLc/doiz3a7NtahxqqEs7Sy+hXbMzsLGLZYC9HaSNKy6zPWbBNVfdSh
         3JTtTEnypo1ILeCkWJYBVCu1QYnWbp7LXOPq4=
Received: by 10.140.127.13 with SMTP id z13mr11529918rvc.194.1214170369075;
        Sun, 22 Jun 2008 14:32:49 -0700 (PDT)
Received: by 10.115.16.17 with HTTP; Sun, 22 Jun 2008 14:32:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806221159140.2926@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85804>

On Sun, Jun 22, 2008 at 9:19 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I was looking at the disgusting size of the git binary, and even with
> the debugging removed, and using -Os instead of -O2, the size of the text
> section was pretty high. In this day and age I guess almost a megabyte of
> text isn't really all that surprising, but it still doesn't exactly make
> me think "lean and mean".

using gcc-3.4.6 and uclibc-0.9.29 (not exactly everyone's
configuration of course...)
I get different numbers with CFLAGS=-Os and NO_CURL, NO_ICONV on plain
git-1.5.6:

sh-3.2# ls -lh git
-rwxr-xr-x    3 root     root       699.7k Jun 22 23:26 git

sh-3.2# size git
   text    data     bss     dec     hex filename
 616544   10960  272272  899776   dbac0 git

after I use your patch, it goes to:

sh-3.2# ls -lh git
-rwxr-xr-x    1 root     root       652.6k Jun 22 23:30 git

sh-3.2# size git
   text    data     bss     dec     hex filename
 568124   10960  272272  851356   cfd9c git

So your patch obviously works here too but I get quite smaller figures too.

curl and iconv are not available on my distro detaolb, maybe it's a
big difference too...

Could your figures come from recent gcc/glibc versions ?

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
