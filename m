From: Eli Barzilay <eli@barzilay.org>
Subject: Re: [PATCH] Add `%B' in format strings for raw commit body in `git log' and friends
Date: Sun, 04 Apr 2010 17:37:33 -0400
Message-ID: <m3eiiunbky.fsf@winooski.ccs.neu.edu>
References: <19370.53192.313137.191218@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 04 23:38:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyXW9-0005Tc-Bs
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 23:38:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212Ab0DDVht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 17:37:49 -0400
Received: from lo.gmane.org ([80.91.229.12]:49554 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013Ab0DDVhs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 17:37:48 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NyXVp-00056G-9T
	for git@vger.kernel.org; Sun, 04 Apr 2010 23:37:45 +0200
Received: from winooski.ccs.neu.edu ([129.10.115.117])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 23:37:45 +0200
Received: from eli by winooski.ccs.neu.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Apr 2010 23:37:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: winooski.ccs.neu.edu
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Cancel-Lock: sha1:sInx05TYG11vwAu0WKs8fntXK+4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143949>

A while ago I sent the patch below.  There were no replies.  Is there
anything else that I should do, or is there any problem in doing this?


Eli Barzilay <eli@barzilay.org> writes:

> Also update the documentation text and add a test.
>
> Signed-off-by: Eli Barzilay <eli@barzilay.org>
> ---
>
> This is re a feature request I made a few days ago.  The test is
> trivial, since there are only two commits with a single line.
>
>  Documentation/pretty-formats.txt |    1 +
>  pretty.c                         |    4 ++++
>  t/t6006-rev-list-format.sh       |    9 +++++++++
>  3 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index 1686a54..bd760d3 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -123,6 +123,7 @@ The placeholders are:
>  - '%s': subject
>  - '%f': sanitized subject line, suitable for a filename
>  - '%b': body
> +- '%B': raw body (unwrapped subject and body)
>  - '%N': commit notes
>  - '%gD': reflog selector, e.g., `refs/stash@\{1\}`
>  - '%gd': shortened reflog selector, e.g., `stash@\{1\}`
> diff --git a/pretty.c b/pretty.c
> index 6ba3da8..14c9568 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -797,6 +797,10 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
>  	case 'e':	/* encoding */
>  		strbuf_add(sb, msg + c->encoding.off, c->encoding.len);
>  		return 1;
> +	case 'B':	/* raw body */
> +		/* message_off is always left at the initial newline */
> +		strbuf_addstr(sb, msg + c->message_off + 1);
> +		return 1;
>  	}
>  
>  	/* Now we need to parse the commit message. */
> diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
> index b0047d3..5d15f18 100755
> --- a/t/t6006-rev-list-format.sh
> +++ b/t/t6006-rev-list-format.sh
> @@ -101,6 +101,15 @@ commit 131a310eb913d107dd3c09a65d1651175898735d
>  commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
>  EOF
>  
> +test_format raw-body %B <<'EOF'
> +commit 131a310eb913d107dd3c09a65d1651175898735d
> +changed foo
> +
> +commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
> +added foo
> +
> +EOF
> +
>  test_format colors %Credfoo%Cgreenbar%Cbluebaz%Cresetxyzzy <<'EOF'
>  commit 131a310eb913d107dd3c09a65d1651175898735d
>  foobarbazxyzzy

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
