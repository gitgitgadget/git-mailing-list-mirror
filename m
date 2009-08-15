From: Jeff King <peff@peff.net>
Subject: jc/shortstatus (was: What's cooking in git.git (Aug 2009, #02;
 Wed, 12))
Date: Sat, 15 Aug 2009 03:09:04 -0400
Message-ID: <20090815070904.GA23389@coredump.intra.peff.net>
References: <7vtz0co3xe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 09:09:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McDO9-0003wc-5D
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 09:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbZHOHJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 03:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752054AbZHOHJH
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 03:09:07 -0400
Received: from peff.net ([208.65.91.99]:34242 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958AbZHOHJG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 03:09:06 -0400
Received: (qmail 17904 invoked by uid 107); 15 Aug 2009 07:09:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 15 Aug 2009 03:09:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 15 Aug 2009 03:09:04 -0400
Content-Disposition: inline
In-Reply-To: <7vtz0co3xe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125982>

On Wed, Aug 12, 2009 at 07:14:53PM -0700, Junio C Hamano wrote:

> * jc/shortstatus (Tue Aug 4 23:55:22 2009 -0700) 12 commits
>  - git stat -s: short status output
>  - git stat: pathspec limits, unlike traditional "git status"
>  - git stat: the beginning
>  + wt-status: collect untracked files in a separate "collect" phase
>  + Make git_status_config() file scope static to builtin-commit.c
>  + wt-status: move wt_status_colors[] into wt_status structure
>  + wt-status: move many global settings to wt_status structure
>  + commit: --dry-run
>  + status: show worktree status of conflicted paths separately
>  + wt-status.c: rework the way changes to the index and work tree are
>    summarized
>  + diff-index: keep the original index intact
>  + diff-index: report unmerged new entries
> 
> Slowly progressing.  I've addressed issues pointed out by Jeff in his
> review, and hopefully the whole thing would be ready to go.

I briefly looked over what's in next, and the fixes you made look good
to me. I've been running with this series for a little while, and I was
very pleased when "git status" showed me a more detailed description of
some unmerged paths the other day. :)

For the "git stat" portion still in pu, I have a few comments/questions:

  1. Is "stat" a good name? I worry a little that it is _too_ similar to
     "status", and that will cause confusion while they both exist. So
     something like "git overview" would cause less confusion, and even
     though it sucks to type, it will eventually replace "status" (and
     in the meantime people can make aliases or whatever).

  2. Does it really belong in builtin-commit.c anymore? It seems like
     historical accident that "status" is so closely tied to commit. The
     whole point of the new command is to _not_ be tied; I think of the
     new command more as an extension of 'diff'. Admittedly, users don't
     care where the source is located, but it helps the developers
     understand the relationships between code.

  3. Can you squash in the gitignore patch below? :)

---
diff --git a/.gitignore b/.gitignore
index c446290..14e0f51 100644
--- a/.gitignore
+++ b/.gitignore
@@ -128,6 +128,7 @@ git-show-index
 git-show-ref
 git-stage
 git-stash
+git-stat
 git-status
 git-stripspace
 git-submodule
