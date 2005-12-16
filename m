From: Don Zickus <dzickus@gmail.com>
Subject: Re: git merge questions
Date: Fri, 16 Dec 2005 16:13:12 -0500
Message-ID: <68948ca0512161313x5b09c65aw36570adb9495cf98@mail.gmail.com>
References: <68948ca0512161205x3d5921bfm3bfcaa64f988eb99@mail.gmail.com>
	 <7vacf0g4ga.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 22:14:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnMtC-00080o-Hn
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 22:13:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbVLPVNP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 16:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVLPVNP
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 16:13:15 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:51184 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932420AbVLPVNO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2005 16:13:14 -0500
Received: by wproxy.gmail.com with SMTP id i3so988260wra
        for <git@vger.kernel.org>; Fri, 16 Dec 2005 13:13:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JgCnwo3f0kgXr3193WwRdc/5HtC5LKFJjLdWAbtfIg1u58HB/2DI6CUHfil2ajNlBFoteBC0TjHaN3t761bnGPnW8gT+tu3RhsFR8srwObN6uSBhJEijBPl74aR8afyXyeGvmTfXb9gl98Q7hSkaNuSeB/B/Lj1QLTbI8w2OYmg=
Received: by 10.65.115.7 with SMTP id s7mr185655qbm;
        Fri, 16 Dec 2005 13:13:13 -0800 (PST)
Received: by 10.65.240.20 with HTTP; Fri, 16 Dec 2005 13:13:12 -0800 (PST)
In-Reply-To: <7vacf0g4ga.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13750>

On 12/16/05, Junio C Hamano <junkio@cox.net> wrote:
> Don Zickus <dzickus@gmail.com> writes:
>
> > Now over the course of 2.6.15 the arch/ppc64 was renamed to
> > arch/powerpc.  Fine. The merge algorithms handled all the unchanged
> > files properly.  However arch/ppc64/Kconfig was modified and the
> > merging was left unresolved.  In fact there is no file no merge
> > against (because it moved).  So 'git-ls-files -u' only shows stage 1+3
> > (no stage 2, of course).
> >
> > How do I merge those changes?  I don't know enough about all the git
> > commands to figure this out, especially how to take advantage of the
> > stage 1, 2, and 3 files.
>
> I do not work on the kernel myself so I'll probably get the
> details wrong, but I am guessing here is what you have:
>
Sorry, I should have been more specific.  How about this:
1) 2.6.14-test branch modifies arch/ppc64/Kconfig
2) master branch renames arch/ppc64/Kconfig to arch/powerpc/Kconfig
3) 2.6.14-test and master branch share a common ancestor v2.6.14
4) Need to merge change arch/ppc64/Kconfig to arch/powerpc/Kconfig

$ git ls-files -u
100644 c658650af429672267409508b02b38754c11a40f 1       arch/ppc64/Kconfig
100644 8abf1118ebbd59954d098d87679114ffda0e75cb 3       arch/ppc64/Kconfig
***Notice no stage 2

$ ls -ld arch/p*
drwxrwxr-x   9 dzickus dzickus 4096 Dec 16 14:12 arch/parisc
drwxrwxr-x  11 dzickus dzickus 4096 Dec 16 14:26 arch/powerpc
drwxrwxr-x  15 dzickus dzickus 4096 Dec 16 14:26 arch/ppc
***Notice no ppc64 (was removed in master branch)

$ ls -ld arch/powerpc/Kconfig*
-rw-rw-r--  1 dzickus dzickus 24279 Dec 16 14:26 arch/powerpc/Kconfig
***Notice no backup or side copy of Kconfig

There were other conflicts with this merge (ones that weren't
automatically resolved) but those were easily merged using vi and
searching for <<<.  However this particular file is providing an
unusual case.

Let me know if this helps or not.

Cheers,
Don
