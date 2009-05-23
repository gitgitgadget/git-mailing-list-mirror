From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] mergetool--lib: add support for araxis merge
Date: Sat, 23 May 2009 16:29:49 +0200
Message-ID: <200905231629.49569.markus.heidelberg@web.de>
References: <1242616700-26022-1-git-send-email-davvid@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 23 16:31:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7sGL-0001F1-Ue
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 16:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbZEWO3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 10:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613AbZEWO3u
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 10:29:50 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:40992 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522AbZEWO3t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 10:29:49 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 519B8FE10697;
	Sat, 23 May 2009 16:29:50 +0200 (CEST)
Received: from [89.59.125.192] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1M7sEQ-0003V5-00; Sat, 23 May 2009 16:29:50 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1242616700-26022-1-git-send-email-davvid@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18I5cVHa4YKKEHpDDgNFTSsem66dYcoS/S/d1V8
	xrhoy+X1kO4Lzq1VOKYo1ACDeZbjSXXm0m89JN9NqbWgvnPeAM
	WyYq+jH/kXnpueiBjxzg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119777>

David Aguilar, 18.05.2009:
> Araxis merge is now a built-in diff/merge tool.
> This adds araxis to git-completion and updates
> the documentation as well.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> 
> This applies on top of the da/mergetool-lib branch
> currently in pu.
> 
> This is a rework of a patch to add araxis support
> to mergetool which originated on the msysgit list.
> The commented-out "-titleN:" options were
> intentionally left out of this patch because
> no amount of shell-quoting could get it to work
> when the title contained spaces.
> 
> http://groups.google.com/group/msysgit/browse_thread/thread/fa353fa2240594d7
> 
>  Documentation/git-difftool.txt         |    2 +-
>  Documentation/git-mergetool.txt        |    2 +-
>  Documentation/merge-config.txt         |    2 +-
>  contrib/completion/git-completion.bash |    2 +-
>  git-mergetool--lib.sh                  |   24 ++++++++++++++++++++++--
>  5 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
> @@ -263,6 +266,23 @@ run_merge_tool () {
>  			status=1
>  		fi
>  		;;
> +	araxis)
> +		if merge_mode; then

Here this is missing:
			touch "$BACKUP"

I had already mentioned it in a reply to your mail from May 03, maybe
you have overseen it. But looking in my sent-mail I just noticed that my
suggestion had an off-by-one-line error. Now it is correct.

> +			if $base_present; then
> +				"$merge_tool_path" -wait -merge -3 -a1 \
> +					"$BASE" "$LOCAL" "$REMOTE" "$MERGED" \
> +					>/dev/null 2>&1
> +			else
> +				"$merge_tool_path" -wait -2 \
> +					"$LOCAL" "$REMOTE" "$MERGED" \
> +					>/dev/null 2>&1
> +			fi
> +			check_unchanged
> +		else
> +			"$merge_tool_path" -wait -2 "$LOCAL" "$REMOTE" \
> +				>/dev/null 2>&1
> +		fi
> +		;;
>  	*)
>  		merge_tool_cmd="$(get_merge_tool_cmd "$1")"
>  		if test -z "$merge_tool_cmd"; then
