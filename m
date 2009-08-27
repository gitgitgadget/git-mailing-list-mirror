From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Using git to track my PhD thesis, couple of questions
Date: Thu, 27 Aug 2009 22:55:15 +0200
Message-ID: <vpqk50pasek.fsf@bauges.imag.fr>
References: <20090827203402.GC7168@kisimul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: seanh <seanh.nospam@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 22:55:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgm0H-0007c1-UE
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 22:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbZH0UzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 16:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbZH0UzT
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 16:55:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42932 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752100AbZH0UzS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 16:55:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n7RKrPP5004410
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Aug 2009 22:53:25 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mgm03-0004Dv-GQ; Thu, 27 Aug 2009 22:55:15 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mgm03-0004sj-F7; Thu, 27 Aug 2009 22:55:15 +0200
In-Reply-To: <20090827203402.GC7168@kisimul> (seanh's message of "Thu\, 27 Aug 2009 21\:34\:02 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 27 Aug 2009 22:53:25 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n7RKrPP5004410
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252011205.71135@T+Ve0fSTwuVRfafb4Etkrw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127208>

seanh <seanh.nospam@gmail.com> writes:

> I'm planning to use git to track my PhD thesis as I work on it and to 
> let my supervisors track it. I've setup a git repository and a gitweb 
> instance showing it. There are a couple of specific requirements.
>
> 1. My supervisors don't want to see all the little commits that I make 
> day by day.

I'm not sure I understand why you want that. From what you say, your
supervisors won't be looking at the LaTeX source, so they won't read
the diffs for the commits. Instead, they will be looking at regular
snapshots in PDF. So, how is that disturbing to keep the intermediate
commits ?

> So I'll commit to a dev branch, then whenever I've made 
> significant progress will merge it into a trunk branch. I want the trunk 
> branch to get all the changes but as one big commit, not inherit all the 
> little commits like a normal merge would do. I think this is a `git 
> merge --squash`.

It is, but this also means _you_ will somehow lose your intermediate
commits. Well, you may not really lose them, but after a merge
--squash, you have two options to continue working: work on top of the
squashed commit (and then your ancestry doesn't contain the small
ones), or work on top of your previous branches (and then, you don't
have a proper merge tracking, and you'll get spurious conflicts if you
try another merge --squash).

> 2. They don't want to look at the latex source but the PDFs built from 
> it, which they're going to annotate with their comments. So I need an 
> easy way for them to get the PDF of each commit from gitweb without 
> having to checkout the repo and build it themselves.

Well, they never need a PDF other than the latest version, will they?
Then, you don't need Git to send them your PDFs, just upload the PDFs
somewhere where your supervisors can grab them periodically, and
you're done.

The issue is when they start modifying the LaTeX files: then you have
to think of merging, and you'd better do that with a revision control
system.


I also used a revision control system to write my Ph.D (Git was born
after I started writting, so it wasn't Git yet), and my reviewing
system has been all the more simple: when a chapter is done, send an
email with the PDF attached, and "Hi, chapter $n is done, can you have
a look?". That just works.

> Normally I wouldn't commit the PDF files into the repo because
> they're compiled files not source files, but it seems that just
> building a PDF and committing it along with each commit to trunk
> would be by far the easiest way to achieve this. But will git store
> the PDFs efficiently, or will the repo start to get really big?

Git will do delta-compression as it can, but I don't think PDFs will
delta-compress very well, so your repository may grow rather quickly,
yes. If possible, commit the PDFs on a separate branch so that you can
easily keep your clean history small in disk space, and discard the
PDFs if needed.

-- 
Matthieu
