From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 11:50:08 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712111146200.25032@woody.linux-foundation.org>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>  <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org> <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
 <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:51:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2B7z-0006rQ-8f
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbXLKTuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbXLKTuU
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:50:20 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50441 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754074AbXLKTuR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 14:50:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBJo8Eu024742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Dec 2007 11:50:15 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBBJo8wM006015;
	Tue, 11 Dec 2007 11:50:08 -0800
In-Reply-To: <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67925>



On Tue, 11 Dec 2007, Linus Torvalds wrote:
> 
> We do that. The expense for git is that we don't do the revisions as a 
> single file at all. We'll look through each commit, check whether the 
> "gcc" directory changed, if it did, we'll go into it, and check whether 
> the "ChangeLog" file changed - and if it did, we'll actually diff it 
> against the previous version.

And, btw: the diff is totally different from the xdelta we have, so even 
if we have an already prepared nice xdelta between the two versions, we'll 
end up re-generating the files in full, and then do a diff on the end 
result.

Of course, part of that is that git logically *never* works with deltas, 
except in the actual code-paths that generate objects (or generate packs, 
of course). So even if we had used a delta algorithm that would be 
amenable to be turned into a diff directly, it would have been a layering 
violation to actually do that.

Other systems can sometimes just re-use their deltas to generate the 
diffs and/or blame information. I dunno whether SVN does that. CVS does, 
afaik.

			Linus
