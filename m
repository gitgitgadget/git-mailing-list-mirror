From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: do not paginate output of git commands
Date: Tue, 30 Jun 2009 11:28:26 -0700
Message-ID: <7vtz1x7f05.fsf@alter.siamese.dyndns.org>
References: <1246361606-20457-1-git-send-email-mmarek@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Michal Marek <mmarek@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jun 30 20:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLi4M-0006IA-Jk
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 20:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbZF3S2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 14:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752223AbZF3S2Z
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 14:28:25 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:56127 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbZF3S2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 14:28:24 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090630182826.GKJI20430.fed1rmmtao105.cox.net@fed1rmimpo03.cox.net>;
          Tue, 30 Jun 2009 14:28:26 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id AJUS1c0084aMwMQ04JUSm9; Tue, 30 Jun 2009 14:28:26 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=hoH3GwZHzGIA:10 a=A_hsRCitNmSAoCGyOFsA:9
 a=i2SrGXJkCFW0JeckpoTSqHTayPEA:4
X-CM-Score: 0.00
In-Reply-To: <1246361606-20457-1-git-send-email-mmarek@suse.cz> (Michal Marek's message of "Tue\, 30 Jun 2009 13\:33\:26 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122527>

Michal Marek <mmarek@suse.cz> writes:

> git request-pull called inside a terminal prints part of the output to
> the terminal and other parts are piped through the pager. Fix this.
>
> Signed-off-by: Michal Marek <mmarek@suse.cz>
> ---

Having said all that, I noticed this gem in the context in your patch.

>  git-request-pull.sh |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-request-pull.sh b/git-request-pull.sh
> index a2cf5b8..b3aaded 100755
> --- a/git-request-pull.sh
> +++ b/git-request-pull.sh
> @@ -45,13 +45,13 @@ fi
>  PAGER=
>  export PAGER
>  echo "The following changes since commit $baserev:"

Looking at ff06c74 (Improve request-pull to handle non-rebased branches,
2007-05-01), it introduced these specifically to address the issue you are
bringing up, but it is ineffective.

I'd suggest to replace your patch with the attached instead.

---

 git-request-pull.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index a2cf5b8..f86d8fd 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -42,8 +42,8 @@ if [ -z "$branch" ]; then
 	status=1
 fi
 
-PAGER=
-export PAGER
+GIT_PAGER=cat
+export GIT_PAGER
 echo "The following changes since commit $baserev:"
 git shortlog --max-count=1 $baserev | sed -e 's/^\(.\)/  \1/'
 
