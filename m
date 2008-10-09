From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Implementing commit signing
Date: Thu, 9 Oct 2008 11:00:26 -0700
Message-ID: <20081009180026.GX8203@spearce.org>
References: <E74D836C8B2CEF4A89F47E8ACECEEF9B748DCD@maildub1.misys.global.ad>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Balasubramaniam, Arunan" <Arunan.Balasubramaniam@misys.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 20:02:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnzpT-0003P8-PT
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 20:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbYJISA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 14:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbYJISA1
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 14:00:27 -0400
Received: from george.spearce.org ([209.20.77.23]:45095 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754310AbYJISA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 14:00:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7F1813835F; Thu,  9 Oct 2008 18:00:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <E74D836C8B2CEF4A89F47E8ACECEEF9B748DCD@maildub1.misys.global.ad>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97870>

"Balasubramaniam, Arunan" <Arunan.Balasubramaniam@misys.com> wrote:
> Shawn O. Pearce wrote:
> 
> > But as I think about it more, if you signed the diff, excluding the
> > line offsets in the hunk headers (so file paths, context and -/+
> > lines), the "author" line and the message, leaving out the other
> > fields of the commit message, it may be possible to still include
> > the signature in an email formatted patch and carry it through a
> > "git format-patch | git am" pipeline and still have it verify.
> 
> Would this be dangerous? If you were to leave out the parent fields in
> the commit message, surely you could then reapply an old commit (that
> say introduced a bug)?

Well, the idea was to sign the diff, but in a way that would
reasonably allow it to be applied with limited fuzz, such as what
git-apply would accept.  Thus signed changes could be emailed out
by git format-patch and git send-email, and applied with git am,
and the signature is still valid so long as the committer didn't
mess with the patch.

Obviously if a commit was reverted and then reapplied again later,
yes, the signature on the reapply may actually be valid, as the
parents weren't taken into consideration.

If the format-patch output was modified to include the parent when
the signature was included then git am could be trained to verify
HEAD == parent before applying the commit.  Then you can include
the parent as part of the signature, but still enable a format-patch
and am based workflow.
 
> > Yes, absolutely, so long as the implementation in Java was reasonably
> > sane.  E.g. we'd prefer you used a pure Java implementation of
> > GnuPG
> 
> I don't think that there is a Java GPG implementation about, some
> searching
> didn't find any live looking projects .

Bouncy Castle:  http://www.bouncycastle.org/java.html

> Would a JNI wrapper to say GPGME
> (http://www.gnupg.org/related_software/gpgme/index.en.html) be
> acceptable?

No, JNI isn't "pure Java".

-- 
Shawn.
