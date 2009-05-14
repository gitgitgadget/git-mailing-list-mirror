From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Eliminate redirection to stdout and stderr when quiet option  is available
Date: Thu, 14 May 2009 00:27:20 -0700
Message-ID: <7vzldgw3dz.fsf@alter.siamese.dyndns.org>
References: <6f5a4e780905140013g75d85558tfaa3c85430f8a8a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Dan Loewenherz <daniel.loewenherz@yale.edu>
X-From: git-owner@vger.kernel.org Thu May 14 09:27:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4VLl-0003o5-Ia
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759897AbZENH1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 03:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759890AbZENH1U
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:27:20 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43825 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759650AbZENH1U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 03:27:20 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514072721.RNEF18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Thu, 14 May 2009 03:27:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id rKTL1b00D4aMwMQ04KTLSE; Thu, 14 May 2009 03:27:20 -0400
X-Authority-Analysis: v=1.0 c=1 a=niVw-RcDjGMA:10 a=ZfPivtQJXQgA:10
 a=bAoijfT97LRH23W0PIoA:9 a=cRgw18bFw5ouaSeSI7xmNh1RwjkA:4
X-CM-Score: 0.00
In-Reply-To: <6f5a4e780905140013g75d85558tfaa3c85430f8a8a3@mail.gmail.com> (Dan Loewenherz's message of "Thu\, 14 May 2009 03\:13\:02 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119161>

Dan Loewenherz <daniel.loewenherz@yale.edu> writes:

> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> index f6e536e..e1106c9 100755
> --- a/git-add--interactive.perl
> +++ b/git-add--interactive.perl
> @@ -158,7 +158,7 @@ my $status_head = sprintf($status_fmt, 'staged',
> 'unstaged', 'path');
>  {
>  	my $initial;
>  	sub is_initial_commit {
> -		$initial = system('git rev-parse HEAD -- >/dev/null 2>&1') != 0
> +		$initial = system('git rev-parse -q HEAD -- ') != 0

Isn't this conversion wrong?

	$ git rev-parse -q HEAD --
        95405ba6cf7adeaa4a066e8a3a1b76b73f7b9341

> diff --git a/git-am.sh b/git-am.sh
> index 6d1848b..8a86d05 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -36,7 +36,7 @@ cd_to_toplevel
>  git var GIT_COMMITTER_IDENT >/dev/null ||
>  	die "You need to set your committer info first"
>
> -if git rev-parse --verify -q HEAD >/dev/null
> +if git rev-parse --verify -q HEAD

Likewise.

Should I spend more time myself, or will you double check the patch and
resubmit?
