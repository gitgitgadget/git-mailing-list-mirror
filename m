From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] completion: clarify ls-tree, archive, show completion
Date: Mon, 03 Jun 2013 10:33:33 -0700
Message-ID: <7vehcjgkuq.fsf@alter.siamese.dyndns.org>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
	<1370181822-23450-7-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 19:33:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjYdZ-0007up-Bl
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 19:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758911Ab3FCRdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 13:33:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59232 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab3FCRdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 13:33:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDB242446E;
	Mon,  3 Jun 2013 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Scj8CDsVPPH+Q2GnoZbnXalbZxw=; b=aI/woC
	MaLHwAw/0eFZEAcTg1WUGE3+jC+mi7af56R92+gv4RddCIIylVtJA3icD2fRwRFj
	isF75b14Kl9Xyxizicq7RA3ymt5NwluezD3y2brLT8/tVmjb+EEcjAri6Kle2d2m
	LWEnFmHWBa+yvYVQSJXci1QYuzolBSimwaYyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ip4cPuwZJEoqgctbfRUz/DWJ4kOeJ0Ce
	uiN8X9tj4igBcYoB/L45zkuWz77FXFmgUs6agWqvY+mmmrLPKGWcl7vk0LzSg7X+
	hsRlyuETk0P9ZEocq/M+h14t7wMKCB5eTOceQ+9blwvsmFNEb3ybkkX+z2Dc2eR0
	YOq8cXystAs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B296C2446D;
	Mon,  3 Jun 2013 17:33:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C563424465;
	Mon,  3 Jun 2013 17:33:34 +0000 (UTC)
In-Reply-To: <1370181822-23450-7-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Sun, 2 Jun 2013 19:33:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B79A59BC-CC73-11E2-ACF9-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226245>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Currently, the 'git ls-tree', 'git archive', and 'git show' completions
> use __git_complete_file (aliased to __git_complete_revlist_file).
>
> In the case of 'git ls-tree' and 'git archive', they necessarily require
> a tree-ish argument (and optionally a pathspec filter, or "file
> argument"):
>
>   $ git ls-tree hot-branch git.c
>   $ git archive HEAD~4 git.c
>
> So, __git_complete_file is a misleading name.
>
> In the case of 'git show', it can take a pathspec and default the
> revision to HEAD like:
>
>   $ git show git.c
>
> (which is useful if git.c was modified in HEAD)
>
> However, this usage is not idiomatic at all.  The more common usage is
> like:
>
>   $ git show HEAD~1
>   $ git show origin/pu:git.c
>
> So, __git_complete_file is again a poor name.
>
> Replace these three instances of __git_complete_file with
> __git_complete_revlist_file, without making any functional changes.
>
> Remove __git_complete_file, as it has no other callers.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

I think this is the same as 5/6 and better explained in a single
patch, as the rationale is the same: these commands can all take the
usual revs and then paths, so using misnamed complete_FILE helper is
wrong.

Mind if I squashed them together?


>  contrib/completion/git-completion.bash | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 8d70c30..84d1548 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -592,11 +592,6 @@ __git_complete_diff_index_file ()
>  	esac
>  }
>  
> -__git_complete_file ()
> -{
> -	__git_complete_revlist_file
> -}
> -
>  __git_complete_revlist ()
>  {
>  	__git_complete_revlist_file
> @@ -1007,7 +1002,7 @@ _git_archive ()
>  		return
>  		;;
>  	esac
> -	__git_complete_file
> +	__git_complete_revlist_file
>  }
>  
>  _git_bisect ()
> @@ -1476,7 +1471,7 @@ _git_ls_remote ()
>  
>  _git_ls_tree ()
>  {
> -	__git_complete_file
> +	__git_complete_revlist_file
>  }
>  
>  # Options that go well for log, shortlog and gitk
> @@ -2382,7 +2377,7 @@ _git_show ()
>  		return
>  		;;
>  	esac
> -	__git_complete_file
> +	__git_complete_revlist_file
>  }
>  
>  _git_show_branch ()
