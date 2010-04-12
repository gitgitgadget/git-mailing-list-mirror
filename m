From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Mon, 12 Apr 2010 19:39:17 +0200
Message-ID: <201004121939.17562.j6t@kdbg.org>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com> <4BC0D87E.70001@kdbg.org> <20100412105034.GC30605@mageo.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Michal Vitecek <fuf@mageo.cz>
X-From: git-owner@vger.kernel.org Mon Apr 12 19:41:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Ndm-0007rl-Mc
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 19:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab0DLRlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 13:41:36 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:54931 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751432Ab0DLRlg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 13:41:36 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B95712C4014;
	Mon, 12 Apr 2010 19:41:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A9C9819F581;
	Mon, 12 Apr 2010 19:39:17 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20100412105034.GC30605@mageo.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144758>

On Montag, 12. April 2010, Michal Vitecek wrote:
>  Is there any chance for merge to behave the same? I really like that I
>  don't have to do a checkout prior rebasing.

If you mean "prior to merging", i.e., you want a "git merge --into master", 
you can do it this way:

# we are on branch 'topic' here
git checkout HEAD^0	# detach
git merge master
git reset --soft master	# keep index(!!!) and worktree
git checkout master	# re-attach
git merge topic

The point is that the second merge will succeed even with a dirty index 
because for each file the result of the merge is identical to the index!

If you have conflicts during the merge, resolve them in the first merge and 
commit to prime the rerere database; the second merge will fail for each 
conflicting file; just 'git checkout HEAD -- the/conflicting/file' and retry. 
rerere will resolve the conflicts for you.

You can of course get away with only one merge, but then you will have to do 
extra work to switch the parents around and to fix the commit message.

-- Hannes
