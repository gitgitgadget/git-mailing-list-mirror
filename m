From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: BUG when trying to delete symbolic refs
Date: Thu, 18 Oct 2012 13:59:07 +0200
Message-ID: <507FEF0B.1060309@lsrfire.ath.cx>
References: <CALKQrgfnvV+1XHjeSytj+LxkAabZJK3hewxH7WT0nkX-ewOKUA@mail.gmail.com> <507D315E.8040101@lsrfire.ath.cx> <7vr4oytn4q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 13:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOolI-0007gq-3K
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 13:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323Ab2JRL7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 07:59:23 -0400
Received: from india601.server4you.de ([85.25.151.105]:44727 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297Ab2JRL7V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2012 07:59:21 -0400
Received: from [192.168.2.105] (p4FFDA222.dip.t-dialin.net [79.253.162.34])
	by india601.server4you.de (Postfix) with ESMTPSA id 0134296;
	Thu, 18 Oct 2012 13:59:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <7vr4oytn4q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207996>

Am 16.10.2012 18:09, schrieb Junio C Hamano:
> Having said all that, I think your patch is going in the right
> direction.  If somebody had a symbolic ref in refs/heads/, the
> removal should remove it, not the pointee, which may not even
> exist.  Does "branch -d sym" work correctly with your patch when
> refs/heads/sym is pointing at something that does not exist?

No, it doesn't, neither with nor without the patch.  But we can make it
work, and also address a UI issue.  This series starts with two patches
that only move code around, then follows the patch you commented on, a
patch addressing dangling symrefs and finally a change to the way
deleted symrefs are reported by git branch.

  branch: factor out check_branch_commit()
  branch: factor out delete_branch_config()
  branch: delete symref branch, not its target
  branch: skip commit checks when deleting symref branches
  branch: show targets of deleted symrefs, not sha1s

 builtin/branch.c  | 75 ++++++++++++++++++++++++++++++++++++-------------------
 t/t3200-branch.sh | 19 ++++++++++++++
 2 files changed, 68 insertions(+), 26 deletions(-)

-- 
1.7.12
