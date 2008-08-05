From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH 2/2] tg-create.sh: Introduce
	topgit.subjectprefix config option
Date: Wed, 6 Aug 2008 00:18:37 +0200
Message-ID: <20080805221837.GU10151@machine.or.cz>
References: <1217963610-15195-1-git-send-email-bert.wesarg@googlemail.com> <1217963610-15195-2-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 00:20:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQUsk-0006MI-TP
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 00:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756962AbYHEWSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 18:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758905AbYHEWSp
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 18:18:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43982 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752307AbYHEWSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 18:18:44 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 169C6393A2DF; Wed,  6 Aug 2008 00:18:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217963610-15195-2-git-send-email-bert.wesarg@googlemail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91466>

  Hi,

On Tue, Aug 05, 2008 at 09:13:30PM +0200, Bert Wesarg wrote:
> Set the topgit.subjectprefix config option to prepend the string to the [PATCH]
> field in the Subject: line of the '.topmsg' file.
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

  hmm, the patch does not apply as-is because $1 -> $name got changed in
t/fix-subject-line-in-.topmsg which you didn't submit (I *instantly*
knew adding the depends line to the patch will be good idea ;-).

  Actually, the line was always meant to be just empty, but putting the
patch name there does no harm. I will change that.

> ---
>  README       |    7 ++++---
>  tg-create.sh |    3 ++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/README b/README
> index bd4f17a..f821bab 100644
> --- a/README
> +++ b/README
> @@ -204,9 +204,10 @@ tg create
>  
>  	After `tg create`, you should insert the patch description
>  	to the '.topmsg' file, which will already contain some
> -	pre-filled bits. You can set topgit.to, topgit.cc and topgit.bcc
> -	configuration variables in order to have `tg create`
> -	add these headers with given default values to '.topmsg'.
> +	pre-filled bits. You can set topgit.subjectprefix, topgit.to,
> +	topgit.cc and topgit.bcc configuration variables in order to
> +	have `tg create` use this subject prefix and add these headers
> +	with the given default values to '.topmsg', respectively.
>  
>  	The main task of `tg create` is to set up the topic branch
>  	base from the dependencies. This may fail due to merge conflicts.
> diff --git a/tg-create.sh b/tg-create.sh
> index 0bf329c..c2b38bf 100644
> --- a/tg-create.sh
> +++ b/tg-create.sh
> @@ -107,7 +107,8 @@ author_addr="${author%> *}>"
>  	! header="$(git config topgit.to)" || echo "To: $header"
>  	! header="$(git config topgit.cc)" || echo "Cc: $header"
>  	! header="$(git config topgit.bcc)" || echo "Bcc: $header"
> -	echo "Subject: [PATCH] $name"
> +	subject_prefix="$(git config topgit.subjectprefix)" && subject_prefix="$subject_prefix "
> +	echo "Subject: [${subject_prefix}PATCH] $name"
>  	echo
>  	cat <<EOT
>  <patch description>

  I have converted this to the ||-form since that's much clearer with
set -e.

  Thanks,

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
