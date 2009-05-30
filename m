From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v2] add --abbrev to 'git cherry'
Date: Sat, 30 May 2009 18:26:11 +0200
Message-ID: <200905301826.11924.markus.heidelberg@web.de>
References: <20090530140349.GA25265@unpythonic.net>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Sat May 30 18:26:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MARO7-00050s-Tp
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 18:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759961AbZE3Q0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 12:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759784AbZE3Q0M
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 12:26:12 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:57233 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758642AbZE3Q0L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 12:26:11 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 068BEFE7610B;
	Sat, 30 May 2009 18:26:13 +0200 (CEST)
Received: from [89.59.100.180] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MARNs-0003NH-00; Sat, 30 May 2009 18:26:12 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090530140349.GA25265@unpythonic.net>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+bNRs42p9UoJFR4HbqjkqdSFiwUf2zONcS3mj6
	5LrTSPEV8HCvS2X9Po3O1A/r5+Z8r/eVa+cwEJb/tp+bQGt6+O
	tHnLChWn/WCxDJh7SVnQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120357>

Jeff Epler, 30.05.2009:
>  Documentation/git-cherry.txt |    5 ++++-
>  builtin-log.c                |   24 +++++++++++++++++++-----
>  2 files changed, 23 insertions(+), 6 deletions(-)

You could also add --abbrev= to the bash completion.

> diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
> index 7deefda..5c03da0 100644
> --- a/Documentation/git-cherry.txt
> +++ b/Documentation/git-cherry.txt
> @@ -49,6 +49,9 @@ OPTIONS
>  -v::
>  	Verbose.
>  
> +--abbrev[=<n>]::
> +	Abbreviate commit ids to the given number of characters

The full stop is missing :)
And you could add "The default value is 7." as in the git-branch docs.
Or even copy the whole description from there for consistency, it also
mentions that this sets the minimum length, the displayed SHA1 may be
longer, but more about this below.

> diff --git a/builtin-log.c b/builtin-log.c
> index f10cfeb..1f3093e 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -1218,12 +1232,12 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
>  			struct strbuf buf = STRBUF_INIT;
>  			pretty_print_commit(CMIT_FMT_ONELINE, commit,
>  			                    &buf, 0, NULL, NULL, 0, 0);
> -			printf("%c %s %s\n", sign,
> +			printf("%c %.*s %s\n", sign, abbrev,
>  			       sha1_to_hex(commit->object.sha1), buf.buf);
>  			strbuf_release(&buf);
>  		}
>  		else {
> -			printf("%c %s\n", sign,
> +			printf("%c %.*s\n", sign, abbrev,
>  			       sha1_to_hex(commit->object.sha1));
>  		}

There is no test for unique ids. "git cherry --abbrev=4" always prints 4
chars per SHA1, so "git show" on these SHA1s mostly gives "error: short
SHA1 xxxx is ambiguous." in git.git.

find_unique_abbrev() will help.

Markus
