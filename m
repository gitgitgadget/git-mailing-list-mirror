From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] git status: refresh the index
Date: Fri, 02 Apr 2010 11:56:09 -0700
Message-ID: <7v6349bs52.fsf@alter.siamese.dyndns.org>
References: <1270211241-10795-1-git-send-email-markus.heidelberg@web.de>
 <1270211241-10795-5-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 02 20:56:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxm2Z-0001sV-T0
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 20:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653Ab0DBS4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 14:56:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40145 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab0DBS4R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 14:56:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 51DB9A7678;
	Fri,  2 Apr 2010 14:56:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KO1ZYapnhvucHQ4AtPyjWgB/w6Y=; b=YL2B3x
	F7MEbxXPEF6WYQEohBfTmubaYLMHa3dl86JgAs8mrlya087/tEU7na7ZUpfxGg7q
	6WMlI139z4pDDoVqNKh4n+EgzNygLIfHwGA3v71gDu0kToOh6V7rxJ+d1Ye/Hfi+
	lpk2CnUc8B2r4x3RIPbQytNw/NDeenErSRG0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PDJYVqAPc4CPM9cWdk1tWtCDVZxuY8UW
	sxN8SRvwyU8lmVLOP+4kpfN0wq92ch0ZGxj5iLd0rOII9TmYKjg143AhtmiEg+lB
	Q2dLfvQhJdkj82QovC/WART9ZtFHU8j25IOPpGdOZsQ5e/CnXs8WHiXwDuOm29Ok
	ATleoKOApLA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FF31A7677;
	Fri,  2 Apr 2010 14:56:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E0AEA7676; Fri,  2 Apr
 2010 14:56:11 -0400 (EDT)
In-Reply-To: <1270211241-10795-5-git-send-email-markus.heidelberg@web.de>
 (Markus Heidelberg's message of "Fri\,  2 Apr 2010 14\:27\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69407574-3E89-11DF-B7F6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143834>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> This was already the case before commit 9e4b7ab6 (git status: not
> "commit --dry-run" anymore, 2009-08-15) and got lost during the
> conversion, which was meant to only change behaviour when invoked with
> arguments.
>
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> ---
>  builtin/commit.c  |    5 +++++
>  t/t7508-status.sh |    2 +-
>  2 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index c5ab683..2262734 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1017,6 +1017,7 @@ static int git_status_config(const char *k, const char *v, void *cb)
>  int cmd_status(int argc, const char **argv, const char *prefix)
>  {
>  	struct wt_status s;
> +	int fd;
>  	unsigned char sha1[20];
>  	static struct option builtin_status_options[] = {
>  		OPT__VERBOSE(&verbose),
> @@ -1050,6 +1051,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
>  
>  	read_cache_preload(s.pathspec);
>  	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, s.pathspec, NULL, NULL);
> +	fd = hold_locked_index(&index_lock, 1);
> +	if (write_cache(fd, active_cache, active_nr) ||
> +	    commit_locked_index(&index_lock))
> +		die("unable to write new_index file");

This is a regression, I think.

The first two patches are trivially correct and I'll queue them to
'master'.

Thanks.
