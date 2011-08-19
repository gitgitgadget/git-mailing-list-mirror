From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] bash-completion: Make use of git status
Date: Fri, 19 Aug 2011 12:10:59 +0200
Message-ID: <201108191210.59538.trast@student.ethz.ch>
References: <1313474948-13531-1-git-send-email-panduwana@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Lee Marlow <lee.marlow@gmail.com>
To: Ron Panduwana <panduwana@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 12:11:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuM2i-0003o2-HT
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 12:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab1HSKLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 06:11:07 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:16993 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054Ab1HSKLF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 06:11:05 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 19 Aug
 2011 12:10:58 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.289.1; Fri, 19 Aug
 2011 12:10:59 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.1-40-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <1313474948-13531-1-git-send-email-panduwana@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179689>

Ron Panduwana wrote:
> $ git add [TAB]path/to/deeply/located/[TAB][TAB]
> path/to/deeply/located/modified-file   path/to/deeply/located/new-file
[...]
> +# __git_files_having_status requires 1 argument
> +__git_files_having_status ()
> +{
> +	echo "$(git status -uall --porcelain . 2>/dev/null | egrep "^$1" | cut -c4-)"
> +}
> +

Some thoughts:

* running git-status for . has some issues: it doesn't work in the
  case of

    cd subdir
    git add ../some/file[TAB]

  It's also inefficient if you are at the top level and

    git add path/to/file/a/few/levels/down[TAB]

  since it wouldn't actually have to look for untracked files in the
  entire repo.

* -uall is not required unless you are looking for untracked files.
   For the other commands you could speed up completion by passing
   -uno instead.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
