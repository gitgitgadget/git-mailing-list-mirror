From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-completion.bash: remove bashism to fix ZSH
 compatibility
Date: Mon, 11 Mar 2013 09:17:31 -0700
Message-ID: <7v38w1c3ms.fsf@alter.siamese.dyndns.org>
References: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Manlio Perillo <manlio.perillo@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Mar 11 17:18:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UF5QH-0002gF-6O
	for gcvg-git-2@plane.gmane.org; Mon, 11 Mar 2013 17:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab3CKQRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Mar 2013 12:17:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37167 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753540Ab3CKQRe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Mar 2013 12:17:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67DD4BCD8;
	Mon, 11 Mar 2013 12:17:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lbO2LWV+Ogb5wL9ZlQy/UaYcoSU=; b=IFgm+4
	RsRqstdHw0/HVBF2Mh3uJAGSaKCzrwRgGNWdPF+x0pw/47620inkKfL4+trpBund
	Cd9sAo7zmSiE6f5j9dZWiYhd/EZxoI07aY4auuCDae5wAcJChqQGfZ+FUxTj7W9B
	ddz881EKrwUVEljAk0OiJzYXmjyYahTAEon0w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HPFUv4Z7VAHooxvj1Zer1gTXbZbcDhoz
	WyLDemaDXNKNpY2XuupWKucv+LzrK6ShMuvsSjghZ6MNvZUw6svHQ8oNhTtMXmgZ
	Cb4KWUy2HhKig+GfJiS/KEw+t/2CZmBfv8l+MthUT28WXN4tiKxdefdEfrtzZb0q
	h8LZivJc8t0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C4E7BCD7;
	Mon, 11 Mar 2013 12:17:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF15BBCD5; Mon, 11 Mar 2013
 12:17:32 -0400 (EDT)
In-Reply-To: <1363004487-1193-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Mon, 11 Mar 2013 13:21:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DAF3E5A-8A67-11E2-8EB0-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217884>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The function-wide redirection used for __git_ls_files_helper and
> __git_diff_index_helper work only with bash. Using ZSH, trying to
> complete an inexistant directory gave this:
>
>   git add no-such-dir/__git_ls_files_helper:cd:2: no such file or directory: no-such-dir/
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---

This is not bash-ism but POSIX.1, even though it is not very well
known.  I recall commenting on this exact pattern during the review.

  http://thread.gmane.org/gmane.comp.version-control.git/213232/focus=213286

After all, I was right when I said that some implementations may get
it wrong and we shouldn't use the construct X-<.

> These two instances seem to be the only ones in the file.
>
> I'm not sure whether the 2>/dev/null would be needed for the command
> on the RHS of the && too (git ls-files and git diff-index).

It would not hurt to discard their standard error.

>  contrib/completion/git-completion.bash | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index b62bec0..0640274 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -300,8 +300,8 @@ __git_index_file_list_filter ()
>  __git_ls_files_helper ()
>  {
>  	# NOTE: $2 is not quoted in order to support multiple options
> -	cd "$1" && git ls-files --exclude-standard $2
> -} 2>/dev/null
> +	cd "$1" 2>/dev/null && git ls-files --exclude-standard $2
> +}
>  
>  
>  # Execute git diff-index, returning paths relative to the directory
> @@ -309,8 +309,8 @@ __git_ls_files_helper ()
>  # specified in the second argument.
>  __git_diff_index_helper ()
>  {
> -	cd "$1" && git diff-index --name-only --relative "$2"
> -} 2>/dev/null
> +	cd "$1" 2>/dev/null && git diff-index --name-only --relative "$2"
> +}
>  
>  # __git_index_files accepts 1 or 2 arguments:
>  # 1: Options to pass to ls-files (required).
