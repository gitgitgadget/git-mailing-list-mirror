From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: merge only some of the changed files?
Date: Fri, 19 Mar 2010 15:01:57 +0100
Message-ID: <201003191501.58045.trast@student.ethz.ch>
References: <20100319134028.GA2318@comppasch2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "fkater@googlemail.com" <fkater@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 15:02:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nscm7-0003Bt-Nd
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 15:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab0CSOCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 10:02:01 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:25253 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab0CSOCA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 10:02:00 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 19 Mar
 2010 15:01:58 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 19 Mar
 2010 15:01:58 +0100
User-Agent: KMail/1.13.1 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.1; x86_64; ; )
In-Reply-To: <20100319134028.GA2318@comppasch2>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142595>

fkater@googlemail.com wrote:
> If I want to merge branch B into A, however not all of the
> changed files in B, how do I do that?
> 
> In other words: 'git diff --name-only A..B' lists 10 files
> but I want to merge only 5 of them.

First of all, these are not the differences that would be merged: if
you're on A and run 'git merge B', it will merge the changes since the
merge-base(s) of A and B.  Assuming you only have a single merge-base,
this is

  git diff $(git merge-base A B) B

which you can write more conveniently (see man git-diff) as

  git diff A...B

(note the three dots!).

Second, you can't really do a "half merge" because that would be a
lie.  A merge promises to bring all changes from all parents, which
you don't want to do.  You can either split out the relevant changes
from your branch (use e.g. git-cherry-pick or 'git rebase -i' on a new
branch B1 started from B) on the branch, and merge that.  Or you can
do a "squashed merge" of only the files you want by saying e.g.

  git diff A...B -- file1 file2 | git apply

and then committing that with a suitable message.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
