From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH, resend] git-commit: colored status when color.ui is set
Date: Fri, 09 Jan 2009 01:00:41 -0800
Message-ID: <7viqoo26rq.fsf@gitster.siamese.dyndns.org>
References: <200901081953.01418.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Jan 09 10:02:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLDGK-0005HA-IZ
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 10:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbZAIJAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 04:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbZAIJAv
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 04:00:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753868AbZAIJAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 04:00:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 26EF71C1CB;
	Fri,  9 Jan 2009 04:00:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 03C861BBC8; Fri, 
 9 Jan 2009 04:00:43 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 026A63BE-DE2C-11DD-A5A0-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104990>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> When using "git commit" and there was nothing to commit (the editor
> wasn't launched), the status output wasn't colored, even though color.ui
> was set. Only when setting color.status it worked.
>
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ---
>  builtin-commit.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-commit.c b/builtin-commit.c
> index e88b78f..2d90f74 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -945,6 +945,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_commit_config, NULL);
>  
> +	if (wt_status_use_color == -1)
> +		wt_status_use_color = git_use_color_default;
> +
>  	argc = parse_and_validate_options(argc, argv, builtin_commit_usage, prefix);
>  
>  	index_file = prepare_index(argc, argv, prefix);

My first reaction was:

	When the editor does get launched, what would the new code do with
	your patch?  Would we see bunch of escape codes in the editor now?

But we do disable color explicitly when we generate contents to feed the
editor in that case since bc5d248 (builtin-commit: do not color status
output shown in the message template, 2007-11-18), so that fear is
unfounded.

Thanks for a reminder, will queue.
