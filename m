From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Fri, 29 Jan 2016 10:45:08 -0800
Message-ID: <xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com>
References: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Dickson Wong <dicksonwong@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 19:45:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPE2o-000760-Gw
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 19:45:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbcA2SpM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 13:45:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753296AbcA2SpL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 13:45:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 81B843F717;
	Fri, 29 Jan 2016 13:45:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QCKhZy3xZU6pWiDrXuTbgmnbWlM=; b=fv8Fyu
	bF4zjt4dK0Xpu4N52nFNMAvWkjTzkXWn4Es2b57qeQxXJkw2+TkaN8nIBBciJFzR
	v4j43VVhmkM6K9cobZ6bNGf8DeLy4gB7Ki//pComXthY40/itVwji6SjATTgMZpS
	LgmjmgpM9HH0Dp8sFxVJYCyJkvkBY5EGe3rts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=smDoHNaUbBUMppXCj7SxAdP3q44Bi7aJ
	F84AhrVXjPYcq14K4/I/qpVmdpjUOvXb6fBii85AfrfGhw28ooD6SpNYuwaVxC0T
	VxL1753TcuMvU5NFh8Q5Syqil7WGBJHD48nNUZLa9/z3STa+4sSFc+VpCTo29z5U
	+8OPxiYeK5I=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 773603F716;
	Fri, 29 Jan 2016 13:45:10 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EFD503F715;
	Fri, 29 Jan 2016 13:45:09 -0500 (EST)
In-Reply-To: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
	(Dickson Wong's message of "Thu, 28 Jan 2016 18:18:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6C6B92C0-C6B8-11E5-943E-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285085>

Dickson Wong <dicksonwong@gmail.com> writes:

> When invoking default (g)vimdiff three-way merge, the merged file is
> loaded as the first buffer but moved to the bottom as the fourth window.
> This causes a disconnect between vim commands that operate on window
> positions (e.g. CTRL-W_w) and those that operate on buffer index (e.g.
> do/dp).
>
> This change reorders the buffers to have the same index as windows while
> keeping the cursor default to the merged result as the bottom window.
>
> Signed-off-by: Dickson Wong <dicksonwong@gmail.com>
> ---

David, I unfortunately do not use 'mergetools' myself and certainly
not vimdiff.

Opinions?

>  mergetools/vimdiff | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mergetools/vimdiff b/mergetools/vimdiff
> index 1ddfbfc..74ea6d5 100644
> --- a/mergetools/vimdiff
> +++ b/mergetools/vimdiff
> @@ -2,22 +2,22 @@ diff_cmd () {
>  	"$merge_tool_path" -R -f -d \
>  		-c 'wincmd l' -c 'cd $GIT_PREFIX' "$LOCAL" "$REMOTE"
>  }
>  
>  merge_cmd () {
>  	touch "$BACKUP"
>  	case "$1" in
>  	gvimdiff|vimdiff)
>  		if $base_present
>  		then
> -			"$merge_tool_path" -f -d -c 'wincmd J' \
> -				"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
> +			"$merge_tool_path" -f -d -c '4wincmd w | wincmd J' \
> +				"$LOCAL" "$BASE" "$REMOTE" "$MERGED"
>  		else
>  			"$merge_tool_path" -f -d -c 'wincmd l' \
>  				"$LOCAL" "$MERGED" "$REMOTE"
>  		fi
>  		;;
>  	gvimdiff2|vimdiff2)
>  		"$merge_tool_path" -f -d -c 'wincmd l' \
>  			"$LOCAL" "$MERGED" "$REMOTE"
>  		;;
>  	gvimdiff3|vimdiff3)
