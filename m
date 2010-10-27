From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 5/6] commit: --squash option for use with rebase
 --autosquash
Date: Wed, 27 Oct 2010 15:35:59 -0700
Message-ID: <7veibbb6wg.fsf@alter.siamese.dyndns.org>
References: <1287689637-95301-1-git-send-email-patnotz@gmail.com>
 <1287689637-95301-6-git-send-email-patnotz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Pat Notz" <patnotz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 00:36:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBEbP-0005Ub-0C
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 00:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757447Ab0J0WgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 18:36:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab0J0WgG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 18:36:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A2374114C;
	Wed, 27 Oct 2010 18:36:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=LUQcQhDAdOrRyVRLMoCjBTqu/Dk=; b=BJjkJdgdggBxWUYY3sDIjha
	IzERuVnYUX2HjfyKSqZZhUDcLM8hkc34VcNUO5xijGCeHxXQEZLh7wk8CKNXe0Gs
	TqaKFP5RC8FYn7GkfU/XewSdd6br7tqcRMFJgptx+FQdjl4K18up1APDrrfTRNG0
	gYYWPfO77eDEAjwBRZjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=vIsmKv72HlKTojo48ksc5DwkW9tte8lWngq2tC+EalQ/ZlL7a
	wKjNJIMiMIOjoGEKCPgDW9p9yT4lhp0n3OiQcB8e1npzXIIaMswrozETf0+eR+Cp
	6z1InvDKmlYBftm24CigZ9rUNUM51CP5t3q+rSl9zqEFzGkTsjPHBbVhEc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8031E1145;
	Wed, 27 Oct 2010 18:36:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE5C91143; Wed, 27 Oct
 2010 18:36:00 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 94A01E60-E21A-11DF-A46A-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160133>

"Pat Notz" <patnotz@gmail.com> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index c82108c..0608b76 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -567,6 +568,23 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
>  		return 0;
>  
> +	if (squash_message) {
> +		/*
> +		 * Insert the proper subject line before other commit
> +		 * message options add their content.
> +		 */
> +		struct pretty_print_context ctx = {0};
> +		struct commit *commit;
> +		const char *out_enc;
> +		commit = lookup_commit_reference_by_name(squash_message);
> +		out_enc = get_commit_output_encoding();

Same comment as the one for 3/6 applies here.
