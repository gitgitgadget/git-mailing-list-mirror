From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 16:14:59 -0500
Message-ID: <4aca3dc20712111314wf4525l790120dce29a9bc5@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	 <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
	 <alpine.LFD.0.9999.0712111122400.25032@woody.linux-foundation.org>
	 <alpine.LFD.0.9999.0712111146200.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 22:16:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2CSM-0000ge-8J
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 22:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbXLKVPC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 16:15:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbXLKVPB
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 16:15:01 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:4362 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbXLKVPA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 16:15:00 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1322958nze
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 13:15:00 -0800 (PST)
Received: by 10.143.174.4 with SMTP id b4mr1667435wfp.1197407699374;
        Tue, 11 Dec 2007 13:14:59 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Tue, 11 Dec 2007 13:14:59 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712111146200.25032@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67943>

On 12/11/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Tue, 11 Dec 2007, Linus Torvalds wrote:
> >
> > We do that. The expense for git is that we don't do the revisions as a
> > single file at all. We'll look through each commit, check whether the
> > "gcc" directory changed, if it did, we'll go into it, and check whether
> > the "ChangeLog" file changed - and if it did, we'll actually diff it
> > against the previous version.
>
> And, btw: the diff is totally different from the xdelta we have, so even
> if we have an already prepared nice xdelta between the two versions, we'll
> end up re-generating the files in full, and then do a diff on the end
> result.

This is what SVN does as well.

>
> Of course, part of that is that git logically *never* works with deltas,
> except in the actual code-paths that generate objects (or generate packs,
> of course). So even if we had used a delta algorithm that would be
> amenable to be turned into a diff directly, it would have been a layering
> violation to actually do that.

Right. SVN has the same problem.

>
> Other systems can sometimes just re-use their deltas to generate the
> diffs and/or blame information. I dunno whether SVN does that. CVS does,
> afaik.

CVS does because it's delta is line based, so it's easy.

You theroetically can generate blame info from SVN/GIT's block deltas,
but you of course, have the problem GIT does, which is that the delta
is not meant to represent the actual changes that occurred, but
instead, the smallest way to reconstruct data x from data y.
This only sometimes has any relation to how the file actually changed
