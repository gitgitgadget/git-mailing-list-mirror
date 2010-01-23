From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Sat, 23 Jan 2010 21:41:49 +0100
Message-ID: <201001232141.49556.j6t@kdbg.org>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <7vwrz8bnbj.fsf@alter.siamese.dyndns.org> <7viqasbmtc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 21:44:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYmpN-0006l2-Of
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 21:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab0AWUnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 15:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752750Ab0AWUnB
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 15:43:01 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:10904 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751931Ab0AWUm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 15:42:59 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 07BBDA7EAE;
	Sat, 23 Jan 2010 21:42:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id A02F219F6D1;
	Sat, 23 Jan 2010 21:41:49 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7viqasbmtc.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137862>

On Samstag, 23. Januar 2010, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> > I think one issue is what happens when you did this:
> >
> >     cd //server
> >     git --git-dir=//server/repo/repo.git --work-tree=repo
> >
> > Does msysgit implementation figures out that the work tree is located at
> > "//server/repo" when get_git_work_tree() is asked to produce an absolute
> > path so that it can be compared with //server/repo/repo.git with the
> > code? If it does (with the leading double slash), then "doubled slahses
> > fix" is a regression we should do something about it.  If it doesn't,
> > then it probably doesn't matter.
>
> Nah, I wasn't thinking straight.  What happens if you did this?
>
> 	git --git-dir=//git/repo/repo.git --work-tree=/git/repo
>
> where "//git/repo" is on the "git server" and you are working in local
> hierarchy "/git/repo"?

Ah, right, this would not do the right thing. (But I can't verify this claim 
right now.)

The problem is that /git/repo without a drive prefix is a valid path and it 
means the path that begins at the same drive that CWD currently is. I would 
not dismiss this form of paths as too exotic, so we should care about them. 
OTOH, it can be worked around easily by the user (just insert the drive 
prefix). Dunno...

-- Hannes
