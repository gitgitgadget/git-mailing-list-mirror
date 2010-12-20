From: Maaartin <grajcar1@seznam.cz>
Subject: Re: Commiting automatically (2)
Date: Mon, 20 Dec 2010 05:46:47 +0000 (UTC)
Message-ID: <loom.20101220T062209-24@post.gmane.org>
References: <loom.20101219T090500-396@post.gmane.org> <7vaak1ftin.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 06:48:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUYbo-0002P3-1K
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 06:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838Ab0LTFrC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 00:47:02 -0500
Received: from lo.gmane.org ([80.91.229.12]:50688 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062Ab0LTFrB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 00:47:01 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PUYaJ-0001oU-LY
	for git@vger.kernel.org; Mon, 20 Dec 2010 06:46:59 +0100
Received: from 188-120-198-113.luckynet.cz ([188-120-198-113.luckynet.cz])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 06:46:59 +0100
Received: from grajcar1 by 188-120-198-113.luckynet.cz with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Dec 2010 06:46:59 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.120.198.113 (Opera/9.80 (Windows NT 5.2; U; en) Presto/2.6.30 Version/10.63)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163983>

Junio C Hamano <gitster <at> pobox.com> writes:

> Maaartin <grajcar1 <at> seznam.cz> writes:
> 
> > However, when I use my git-autocom script, those files get marked as 
deleted. 
> > This is quite strange, especially because of them still existing. I'd 
strongly 
> > prefer git-autocom to behave just like git commit (i.e., tracking the 
files).
> >
> > The relevant part of my script follows:
> >
> > export GIT_INDEX_FILE=.git/autocom.tmp
> > git add -A &&
> 
> If you really want "just like commit", then it would be more like "make a
> commit object out of the current index, and put that somewhere outside the
> current branch", and will not involve any "git add", no?

You're right, I was using the wrong term, what I wanted was to take a SNAPSHOT 
of the current working dir (this is called "commit" in csv/svn but not in git, 
I know).

> A useful goal would be "as if I said 'git add -u && git commit' from the
> current state" (alternatively, you could say s/-u/-A/).

Yes, I wonder why it wasn't already implemented. I do something like
make all; git snapshot; send_the_executable_to_the_customer
which is IMHO needed quite often.

> If this autocom.tmp starts out empty, "add" will of course honor what you
> wrote in .gitignore hence would not add ignored files.  You may have '*.o'
> in the ignore mechanism to exclude usual build products.  Until you
> somehow tell git that you care about a vendor-supplied binary blob file
> "binblob1.o" even though it has a name for usual ignored ones, you don't
> want to get it tracked, and once you have done so with "git add -f", you
> do want to get it tracked from that point.  But your script cannot be
> clever enough to selectively say "add -f" for such a file.
> 
> The "from the current state" part of the sentence of your goal (clarified
> by the second paragraph above) fundamentally means you need to start from
> your real index, so "cp -p .git/index $TMP_INDEX" is both appropriate and
> inevitable for your script.

Now it's clear, thank you for the explanation.
