From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] fix shell command line in example
Date: Fri, 23 Dec 2011 17:56:48 +0100
Message-ID: <8739cbi5v3.fsf@thomas.inf.ethz.ch>
References: <20111223164128.GA21918@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Dec 23 17:57:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Re8QX-0006SS-HV
	for gcvg-git-2@lo.gmane.org; Fri, 23 Dec 2011 17:57:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416Ab1LWQ45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Dec 2011 11:56:57 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:3514 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754302Ab1LWQ44 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2011 11:56:56 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Dec
 2011 17:56:51 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (80.219.158.96) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 23 Dec
 2011 17:56:54 +0100
In-Reply-To: <20111223164128.GA21918@gnu.kitenet.net> (Joey Hess's message of
	"Fri, 23 Dec 2011 12:41:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [80.219.158.96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187634>

Joey Hess <joey@kitenet.net> writes:

> The comma was probably intended to be a semicolon so that the
> two commands can be run by cut-n-paste.
[...]
>  ------------------------------------------------
> -$ git pull, git pull origin
> +$ git pull; git pull origin
>  ------------------------------------------------

Would it ever make sense to run the two in sequence?

But upon closer reading, it seems to be a pretty terrible example
anyway.  It reads:

  * Update the remote-tracking branches for the repository
    you cloned from, then merge one of them into your
    current branch:
  +
  ------------------------------------------------
  $ git pull, git pull origin
  ------------------------------------------------
  +
  Normally the branch merged in is the HEAD of the remote repository,
  but the choice is determined by the branch.<name>.remote and
  branch.<name>.merge options; see linkgit:git-config[1] for details.

But that "normally" is no longer true: with default configs, the user
would only ever have branches with tracking already set up.  So
*normally*, 'git pull' will merge the @{upstream}.

'git pull origin' is even worse: with tracking configured, it goes out
of its way to verify that the specified remote (origin) is actually what
HEAD tracks[*].  So 'git pull origin' with default configs means "please
pull, but double-check me on the choice of remote".  Do we want to give
that to a user as the second example?

So I'm thinking it should just read

  * Update the upstream origin of the current branch, then merge the
    tracked branch into the current one:
  +
  --------------------------------------------------
  $ git pull
  --------------------------------------------------

modulo avoiding confusion around upstream/tracking.


[*] a8c9bef (pull: improve advice for unconfigured error case,
2009-10-05) has a long explanation on the subject.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
