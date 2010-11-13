From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [RFC] rebase: be cleverer with rebased upstream branches
Date: Sun, 14 Nov 2010 00:30:47 +0100
Message-ID: <AANLkTincij4wR4=RhbA0oCwe66OhVry0AkS6GCALVWmz@mail.gmail.com>
References: <1289592713-11786-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, trast@student.ethz.ch, newren@gmail.com
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 00:31:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHPZM-0000AE-8H
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 00:31:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066Ab0KMXbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 18:31:34 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:33921 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115Ab0KMXbe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 18:31:34 -0500
Received: by qyk12 with SMTP id 12so2424882qyk.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 15:31:33 -0800 (PST)
Received: by 10.229.182.5 with SMTP id ca5mr3584431qcb.150.1289691067269; Sat,
 13 Nov 2010 15:31:07 -0800 (PST)
Received: by 10.229.105.76 with HTTP; Sat, 13 Nov 2010 15:30:47 -0800 (PST)
In-Reply-To: <1289592713-11786-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161400>

On Fri, Nov 12, 2010 at 9:11 PM, Martin von Zweigbergk
<martin.von.zweigbergk@gmail.com> wrote:
> Since c85c792 (pull --rebase: be cleverer with rebased upstream
> branches, 2008-01-26), 'git pull --rebase' has used the reflog to try to
> rebase from the old upstream onto the new upstream.
>
> However, if, instead of 'git pull --rebase', the user were to do 'git
> fetch' followed by 'git rebase @{upstream}', the reflog would not be
> walked. This patch teaches "git rebase" the same reflog-walking tricks
> that 'git pull --rebase' already knows.
>
> Apart from making 'git rebase' better aligned with 'git pull --rebase',
> this may also be useful on its own for rebasing one branch against
> another local branch that has been rebased. Currently, you would have to
> do that using 'git rebase --onto' or by configuring it on the branch.
>
> It might seem like most of the related code in git-pull.sh can be
> removed once git-rebase.sh supports reflog walking. Unfortunately, not
> much of it can be removed, though. The reason is that git-pull.sh does
> one step of 'reflog' walking even when the reflog is not used. There are
> at least two cases where the reflog is not used: a) when it is disabled,
> b) when the remote branch was specified on the command line (let's say
> 'git pull --rebase origin master'). In both of these cases, git-pull.sh
> remembers the position of the reference before the fetch and uses that
> in place of '$ref@{1}'.

In the code I don't see when b) is different to call it without
command line branches. And if it is different I suppose it is a bug.

The code must stay in git-pull.sh because there it has more
information (commit before and after fetch) than in git-rebase,
essentially when reflogs are disabled.

> ---
> Junio, don't apply this patch yet, as I will rebase it on top of the
> refactored rebase code once I'm done with that (to make it work with
> interactive rebase as well).

>From a cursory view it looks ok.

Santi
