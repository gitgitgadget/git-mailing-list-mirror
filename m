From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/23] contrib/subtree: Teach add to store repository
 & branch in .gittrees
Date: Sun, 10 Mar 2013 20:24:05 -0700
Message-ID: <7vsj42bove.fsf@alter.siamese.dyndns.org>
References: <1362958891-26941-1-git-send-email-pcampbell@kemitix.net>
 <1362958891-26941-4-git-send-email-pcampbell@kemitix.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, David Greene <greened@obbligato.org>,
	Matt Hoffman <matt.hoffman@quantumretail.com>,
	"Wayne Walter" <wayne@tickzoom.com>
To: Paul Campbell <pcampbell@kemitix.net>
X-From: git-owner@vger.kernel.org Mon Mar 11 04:24:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEtLo-0000fh-Tq
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 04:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788Ab3CKDYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 23:24:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554Ab3CKDYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 23:24:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4F29CEF6;
	Sun, 10 Mar 2013 23:24:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3XWgNnbHqzDb4PCquxF56j6sWmw=; b=bf8qoF
	zwiVmk91ffbMbNKyb+qKqu4BC+C15AncEof4FyDw+DiqE/8/UOBizTj+5Nuc+Txx
	17QQMiqf6VOjrqFjpFjl9z6HCF0UFOfQuTB/RAJKb3JOmLdZ8dl3nPHGiSlay7kH
	8p4P3Ly80QbuMzjBAACF+UORKqEhsqxWkNt0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qkk+Zmwbd5swfaHZYljGkE9acfiWtC6E
	LIMwIPFvCxBNTNUp+WTzh+CyFWaV5d5JmO8Gj6GRqCZamdkzWPBnr01WTcgfsW2K
	9nR8egDn799h+kqh15/qaHqsj5MzVbRmju49H9Qo+s6y7vcM9Kjoa6QogVmuL+Ba
	EGwNMrJYGiQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5960CEF5;
	Sun, 10 Mar 2013 23:24:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05E0ECEF4; Sun, 10 Mar 2013
 23:24:06 -0400 (EDT)
In-Reply-To: <1362958891-26941-4-git-send-email-pcampbell@kemitix.net> (Paul
 Campbell's message of "Sun, 10 Mar 2013 23:41:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21BC5CFC-89FB-11E2-BD69-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217850>

Paul Campbell <pcampbell@kemitix.net> writes:

> From: Matt Hoffman <matt.hoffman@quantumretail.com>
>
> The repository and branch of a subtree added with the add command is
> stored in the .gittrees file.
>
> Signed-off-by: Paul Campbell <pcampbell@kemitix.net>
> ---
>  contrib/subtree/git-subtree.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index caf4988..7b70251 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -528,6 +528,14 @@ cmd_add_repository()
>  	revs=FETCH_HEAD
>  	set -- $revs
>  	cmd_add_commit "$@"
> +  
> +  # now add it to our list of repos 
> +  git config -f .gittrees --unset subtree.$dir.url
> +  git config -f .gittrees --add subtree.$dir.url $repository
> +  git config -f .gittrees --unset subtree.$dir.path
> +  git config -f .gittrees --add subtree.$dir.path $dir
> +  git config -f .gittrees --unset subtree.$dir.branch
> +  git config -f .gittrees --add subtree.$dir.branch $refspec

Existing code in the function this touches seem to be written
carefully to allow $IFS whitespace in $dir, but this change butchers
it, it seems.

Also, where does $refspec come from?  When this is called from
cmd_add_repository(), there is an assignment to the variable, but it
is not all clear.  As git-subtree declares it won't work with
anything but bash, I think things like this should take advantage of
being written for bash by using "local" and passing arguments
explicitly instead of relying on global variables, which POSIX shell
scripts cannot afford to do but bash scripts can.

>  }
>  
>  cmd_add_commit()
