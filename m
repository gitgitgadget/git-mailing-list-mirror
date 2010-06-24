From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Thu, 24 Jun 2010 13:17:57 +0200
Message-ID: <20100624111757.GB3453@pvv.org>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 13:18:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORkRe-0004Qg-In
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 13:18:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911Ab0FXLSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 07:18:04 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:44184 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754706Ab0FXLSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 07:18:03 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1ORkRR-0007Ai-KZ; Thu, 24 Jun 2010 13:17:57 +0200
Content-Disposition: inline
In-Reply-To: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149581>

On Wed, Jun 23, 2010 at 03:09:32PM -0700, Junio C Hamano wrote:

> * eb/double-convert-before-merge (2010-06-16) 1 commit
>  - ll-merge: Normalize files before merging
> 
> If running git-to-worktree and then worktree-to-git _fixes_ something, it
> means that these are not roundtrip operations; there is something that is
> fundamentally wrong.  The commit log message doesn't help explaining it,
> either.

If .gitattributes is different on the different sides, or if you
enable autocrlf, the current repo contents may change after
git-to-worktree and worktree-to-git again. This is most easily seen if
you add some eol attributes, but also with clean/smudge filters, ident
and so on.

Assume you start out with a repo that has a lot of text files with
CRLF checked in (A).

  C----
 /     \
A---B---D

B: Add "* text=auto" to .gitattributes and normalize all files to LF
only in repo

D: try to merge C

Without this patch you will get a ridiculous number of lf/crlf
conflicts when trying to merge C into D, since the repository contents
for C are "wrong" wrt the new .gitattributes file.

- Finn Arne
