From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git diff --stat" doesn't show added empty file
Date: Mon, 12 Jan 2009 08:13:53 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901120805310.6528@localhost.localdomain>
References: <46dff0320901111936h6343e51fo94750d83e95743dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 17:15:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMPS0-0005KN-BL
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 17:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752838AbZALQN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 11:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbZALQN5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 11:13:57 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37952 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752619AbZALQN5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jan 2009 11:13:57 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0CGDr5n014914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Jan 2009 08:13:54 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n0CGDrvK028973;
	Mon, 12 Jan 2009 08:13:53 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <46dff0320901111936h6343e51fo94750d83e95743dc@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.46 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105354>



On Mon, 12 Jan 2009, Ping Yin wrote:
> $ git diff --stat HEAD^..
>  0 files changed, 0 insertions(+), 0 deletions(-)

In the kernel, we use "git diff --stat --summary" for exactly this reason.

Well, not exactly. 

The thing is, even if the file is _not_ empty, there's a huge difference 
between "added 100 lines to an already-existing file" and "created a new 
100-line file". Which is exactly what "--summary" adds. 

And it sometimes even makes sense to show the summary without the 
diffstat. If you're _only_ interested in create/delete/rename information, 
you can do "git show --summary <cmit>". It won't give you line counts, but 
it will give you information about any changes to filenames, eg in the 
kernel archive, you could see an example of this with

	git show -M --summary 95b482a8d31116f3f5c2a5089569393234d06385

where you have a combination of renames, creates and deletes.

So I think it's already better than what you ask for.

			Linus
