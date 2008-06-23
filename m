From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: Shrink the git binary a bit by avoiding unnecessary inline functions
Date: Mon, 23 Jun 2008 01:01:46 +0000
Message-ID: <46d6db660806221801j7207e6b0sdf91c2243fad5349@mail.gmail.com>
References: <alpine.LFD.1.10.0806221159140.2926@woody.linux-foundation.org>
	 <46d6db660806221432m6a6e2f3egf78faa1510f8d643@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 23 03:03:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAaSb-0003zd-FQ
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 03:03:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYFWBBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 21:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752220AbYFWBBs
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 21:01:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:40190 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbYFWBBr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 21:01:47 -0400
Received: by rv-out-0506.google.com with SMTP id k40so6769102rvb.1
        for <git@vger.kernel.org>; Sun, 22 Jun 2008 18:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=DjVm816aj2NIN2SdKMFVR3OIaUQw8lw+V17QI5Zb7FU=;
        b=PJNhZ9jFDqTVbqcNQHI5afb5jazZJXk+oJA2Abb+n2uJDmBJ/7Lhd89yPPLcbvzcVw
         y0VHYOUdW1yC06WtG3Cr84jcnlWGi3L7wzHj8RLYXuk856FKlgk5OFmz4V3J4+08EaNB
         XWy2sM/3BV38PZVBCXJLloPUHDG18aSDGGhtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BNvVuHLgIHNlq47J7UDAc3qNckjIBIdPfJZTbztcTOPaSnPQSKePr5YhuAzI8mii6y
         agUUxCRU3+H8z5SvfEbpX/twALc5YKUmd+PY+RWhi/zvM1jsqYHvV+GyHMW5pmHcZN8O
         5EEXWLEIT6H4yc4YT/ythuXyAOjET5SInBFJ8=
Received: by 10.141.23.7 with SMTP id a7mr11765384rvj.58.1214182906078;
        Sun, 22 Jun 2008 18:01:46 -0700 (PDT)
Received: by 10.115.16.17 with HTTP; Sun, 22 Jun 2008 18:01:46 -0700 (PDT)
In-Reply-To: <46d6db660806221432m6a6e2f3egf78faa1510f8d643@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85821>

On Sun, Jun 22, 2008 at 9:32 PM, Christian MICHON
<christian.michon@gmail.com> wrote:
> using gcc-3.4.6 and uclibc-0.9.29 (not exactly everyone's
> configuration of course...)
> I get different numbers with CFLAGS=-Os and NO_CURL, NO_ICONV on plain
> git-1.5.6:
>
> sh-3.2# ls -lh git
> -rwxr-xr-x    3 root     root       699.7k Jun 22 23:26 git
>
> sh-3.2# size git
>   text    data     bss     dec     hex filename
>  616544   10960  272272  899776   dbac0 git
>
> after I use your patch, it goes to:
>
> sh-3.2# ls -lh git
> -rwxr-xr-x    1 root     root       652.6k Jun 22 23:30 git
>
> sh-3.2# size git
>   text    data     bss     dec     hex filename
>  568124   10960  272272  851356   cfd9c git
>
> So your patch obviously works here too but I get quite smaller figures too.
>
> curl and iconv are not available on my distro detaolb, maybe it's a
> big difference too...
>
> Could your figures come from recent gcc/glibc versions ?
>

Linus,

I've put my hands on a usb stick with ubuntu (gcc-4.2.3 and
glibc-2.7), containing all packages needed for a pristine compilation
of git-1.5.6.

I only changed CFLAGS to -Os, no debug info compiled.

ubuntu@ubuntu:~/Desktop/git-1.5.6$ ls -lh git
-rwxr-xr-x 1 ubuntu ubuntu 718K 2008-06-23 00:47 git

ubuntu@ubuntu:~/Desktop/git-1.5.6$ size git
   text	   data	    bss	    dec	    hex	filename
 616606	   9876	 270812	 897294	  db10e	git

There's more than 80k difference with your figures (I have not even
applied your patch yet).
May I ask which version of gcc you're using ? The numbers you provided
were really with -Os ?

Once your patch is applied, these are the final figures:

ubuntu@ubuntu:~/Desktop/git-1.5.6$ ls -lh git
-rwxr-xr-x 1 ubuntu ubuntu 692K 2008-06-23 00:59 git

ubuntu@ubuntu:~/Desktop/git-1.5.6$ size git
   text	   data	    bss	    dec	    hex	filename
 591554	   9876	 270812	 872242	  d4f32	git

-- 
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git inside !
