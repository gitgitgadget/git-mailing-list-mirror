From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/5] Use variables for the lists of tools that support
 merging / diffing
Date: Mon, 23 Jul 2012 09:46:24 -0700
Message-ID: <7vvchemnmn.fsf@alter.siamese.dyndns.org>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com>
 <500CFAB4.4050905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 18:46:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StLmD-0005oS-1m
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 18:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754413Ab2GWQq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 12:46:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63314 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316Ab2GWQq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 12:46:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CD7567DD;
	Mon, 23 Jul 2012 12:46:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4aOnNrM4BB5cxmG0Lr4szJ+ESdk=; b=TbZYzZ
	JqevSf6aqxI5btTb2rqQvHcte9IcL0fv0Pzvbxsr98XP5QQ51cGcSGoTczOyGRj6
	hG7Lsyvhnbp54ogDVSkNFfY21xMpDqKrfH+IADau63ORI7v9r1kLar4f7mvqTo+s
	QT62jfrasD7YuEuXVmU/frLMGVvn3uZsU5p5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lNrXOfRkxau5Ru6mtzWWHi4vVCw7L2NY
	5OklG3POcKecCX7GDSi84VryOI9scxJDMRu7E8Rs6wWbeuobU+waRrXp5RIWFqmp
	nBztUFaKYb2ChxC6Yq6bs+GJoYCfoVUfedZuAxwcmKOPqNLSXAP9XgBDEdLKq3jN
	BYb9xQeRUmk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A26667DC;
	Mon, 23 Jul 2012 12:46:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A66B67DA; Mon, 23 Jul 2012
 12:46:26 -0400 (EDT)
In-Reply-To: <500CFAB4.4050905@gmail.com> (Sebastian Schuberth's message of
 "Mon, 23 Jul 2012 09:18:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1994E9C-D4E5-11E1-826C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201939>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Also, add a few comments that clarify the meaning of these variables.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  contrib/completion/git-completion.bash | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index f2c4894..6b9b79d 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1325,17 +1325,24 @@ _git_diff ()
>  	__git_complete_revlist_file
>  }
>  
> +# Tools that support both merging and diffing.
>  __git_mergetools_common="araxis bc3 diffuse ecmerge emerge gvimdiff
>  			kdiff3 meld opendiff p4merge tkdiff vimdiff xxdiff
>  "

As the set of merge capable tools is not a superset of diff capable
tools (tortoise can only merge but not diff), perhaps rename this to
__git_diffmerge_tools or something?

> +# Tools that support diffing.
> +__git_difftools="$__git_mergetools_common kcompare"
> +
> +# Tools that support merging.
> +__git_mergetools="$__git_mergetools_common tortoisemerge"
> +

This patch makes sense to me, but at the same time makes [PATCH 1/5]
a "Meh", methinks.

>  _git_difftool ()
>  {
>  	__git_has_doubledash && return
>  
>  	case "$cur" in
>  	--tool=*)
> -		__gitcomp "$__git_mergetools_common kompare" "" "${cur##--tool=}"
> +		__gitcomp "$__git_difftools" "" "${cur##--tool=}"
>  		return
>  		;;
>  	--*)
> @@ -1623,7 +1630,7 @@ _git_mergetool ()
>  {
>  	case "$cur" in
>  	--tool=*)
> -		__gitcomp "$__git_mergetools_common tortoisemerge" "" "${cur##--tool=}"
> +		__gitcomp "$__git_mergetools" "" "${cur##--tool=}"
>  		return
>  		;;
>  	--*)
