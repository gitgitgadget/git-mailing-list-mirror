From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] commit::print_summary(): set
 rev_info.always_show_header to 1
Date: Fri, 28 May 2010 18:10:52 -0700
Message-ID: <7vd3wf5x7n.fsf@alter.siamese.dyndns.org>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
 <1274974492-4692-1-git-send-email-rctay89@gmail.com>
 <1274974492-4692-2-git-send-email-rctay89@gmail.com>
 <1274974492-4692-3-git-send-email-rctay89@gmail.com>
 <1274974492-4692-4-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 03:11:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIAZz-0005YP-0z
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 03:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756030Ab0E2BLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 21:11:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab0E2BLC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 21:11:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED563B77BA;
	Fri, 28 May 2010 21:11:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=iHCdXnN68/qu4NbVDCpBgaQx0VI=; b=Y/S/cA5MsMhfwn6DjuqYli0
	LUvr5J5QirE8LloIxFH2JSZcwAbYHV8AEehTm7nKiJsv3L/4ic/4gDAGhUx/Gppt
	vokei3Xndsho5J6vN+oYjS7xvBAFTEljpJzhFK0IYFsKXxXBh9SAFXvbScN0lHpS
	9yxfcnTwefQp+/IeFYIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=SMtVk5lCsuXat5EdxbVotdkcbQ6giXq64b/PQhuJ4kvt+sywF
	5j5LM771jfvPfW/XA4vBBpGCFE+y7wLt8T2N49GaGmIuO+73VFdiENiieAfWBJa6
	V3s54bI8Z5h2g350B5c/HhuO5Y7t+SZnXqwRCZ8v1FT5DPQ9jZRuz79glA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 71809B77B8;
	Fri, 28 May 2010 21:10:58 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75262B77B6; Fri, 28 May
 2010 21:10:53 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A0D3044-6ABF-11DF-91FB-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147945>

Tay Ray Chuan <rctay89@gmail.com> writes:

> This attempts to fix a regression in git-commit, where non-abbreviated
> SHA-1s were printed in the summary.
>
> One possible fix would be to set ctx.abbrev to DEFAULT_ABBREV in the
> `if` block. However, we remove this codeblock altogether, and set
> rev.always_show_header.
>
> This way, we use back the same show_log() mechanism (instead of
> format_commit_message()).

I like the removal of the handcrafted call to f-c-m.  Thanks.

> Quoting log-tree.c:560:
>
> 	shown = log_tree_diff(opt, commit, &log);
> 	if (!shown && opt->loginfo && opt->always_show_header) {
> 		log.parent = NULL;
> 		show_log(opt);
> 		shown = 1;
> 	}
>
> This is the only area that always_show_header is checked, so the
> setting of this flag should only affect this area.

Hmm, but also setting this flag would affect anything that changes
behaviour depending on the value of log.parent, no?

> +	if (!log_tree_commit(&rev, commit))
> +		die("unable to print summary");

When always_show_header is set, what are the situations where
log_tree_commit() might return false?  I think your fix depends on the
fact that it will never return false (which I think is a correct thing to
assume---after all that is what "always_show" means ;-).
