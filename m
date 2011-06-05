From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Interactive-rebase doesn't pick all children of "upstream"
Date: Sun, 05 Jun 2011 11:16:15 +0200
Message-ID: <4DEB495F.9080900@kdbg.org>
References: <20110517161234.GA21388@sigill.intra.peff.net> <1307251953-25116-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 11:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QT9W0-0005YK-NI
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 11:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510Ab1FEJQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 05:16:19 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:20278 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754747Ab1FEJQT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 05:16:19 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C00D8130050;
	Sun,  5 Jun 2011 11:16:15 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 6BFBE19F399;
	Sun,  5 Jun 2011 11:16:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <1307251953-25116-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175071>

Am 05.06.2011 07:32, schrieb Andrew Wong:
> Consider this graph:
> 
>         D---E    (topic, HEAD)
>        /   /
>   A---B---C      (master)
>    \
>     F            (topic2)
> 
> and the following three commands:
>   1. git rebase -i A
>   2. git rebase -i --onto F A
>   3. git rebase -i B
> 
> Currently, (1) and (2) will pick B, D, C, and E onto A and F,
> respectively.  However, (3) will only pick D and E onto B.  This
> behavior of (3) is inconsistent with (1) and (2), and we cannot modify C
> in the interactive-rebase.

I cannot reproduce your claims:

- (1) and (2) picks B,C,D top A and F, but not E because E is a merge.

- (3) picks C and D, but not E because E is a merge.

> The current behavior also creates a bug if we do:
>   4. git rebase -i C
> 
> In (4), E is never picked. And since interactive-rebase resets "HEAD" to
> "onto" before picking any commits, D and E are lost after the
> interactive-rebase.

(4) picks only D, because E is a merge. I don't understand what you mean
that "D and E are lost"; E is not picked in the first place, but D is in
the todo-list; how can D be lost?

BTW, rebase never picks merges by design. I don't see anything wrong so
far with the current behavior. Please explain!

-- Hannes
