From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] rebase --preserve-merges keeps empty merge commits
Date: Mon, 14 Jan 2013 09:02:49 -0500
Message-ID: <20130114140249.GA2373@hmsreliant.think-freely.org>
References: <1358023561-26773-1-git-send-email-hordp@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, phil.hord@gmail.com,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 15:03:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TukdM-0000Y6-GW
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 15:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924Ab3ANODG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 09:03:06 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:40508 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756175Ab3ANODF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 09:03:05 -0500
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1Tukck-0008B5-7N; Mon, 14 Jan 2013 09:02:57 -0500
Content-Disposition: inline
In-Reply-To: <1358023561-26773-1-git-send-email-hordp@cisco.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213488>

On Sat, Jan 12, 2013 at 03:46:01PM -0500, Phil Hord wrote:
> Since 90e1818f9a  (git-rebase: add keep_empty flag, 2012-04-20)
> 'git rebase --preserve-merges' fails to preserve empty merge commits
> unless --keep-empty is also specified.  Merge commits should be
> preserved in order to preserve the structure of the rebased graph,
> even if the merge commit does not introduce changes to the parent.
> 
> Teach rebase not to drop merge commits only because they are empty.
> 
> A special case which is not handled by this change is for a merge commit
> whose parents are now the same commit because all the previous different
> parents have been dropped as a result of this rebase or some previous
> operation.
> ---
>  git-rebase--interactive.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 44901d5..8ed7fcc 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -190,6 +190,11 @@ is_empty_commit() {
>  	test "$tree" = "$ptree"
>  }
>  
> +is_merge_commit()
> +{
> +	git rev-parse --verify --quiet "$1"^2 >/dev/null 2>&1
> +}
> +
>  # Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
>  # GIT_AUTHOR_DATE exported from the current environment.
>  do_with_author () {
> @@ -874,7 +879,7 @@ git rev-list $merges_option --pretty=oneline --abbrev-commit \
>  while read -r shortsha1 rest
>  do
>  
> -	if test -z "$keep_empty" && is_empty_commit $shortsha1
> +	if test -z "$keep_empty" && is_empty_commit $shortsha1 && ! is_merge_commit $shortsha1
>  	then
>  		comment_out="# "
>  	else
> -- 
> 1.8.1.dirty
> 
> 
Seems reasonable 
Acked-by: Neil Horman <nhorman@tuxdriver.com>
