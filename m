From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 2/5] merge: Make '--log' an integer option for
 number of shortlog entries
Date: Mon, 23 Aug 2010 17:25:42 -0500
Message-ID: <20100823222542.GD1308@burratino>
References: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
 <1282494398-20542-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 24 00:27:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnfUM-000308-6i
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 00:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226Ab0HWW13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 18:27:29 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39550 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640Ab0HWW12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 18:27:28 -0400
Received: by vws3 with SMTP id 3so5703993vws.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=CjZggPonAqQp3K6wQYVk/9dpFc3eaRTcZ2BwzMsQ9z0=;
        b=bcCfCyJjY6pWH/UbjpvtDG7PmMOUvytdUVbzuN0apPVo+JxjY76iiNTMs87x8o7TX+
         0SqOD9/3RPPH2ip1GaLL9Pw2yohPCunbAiVtlnUgRJvmcs2iOviVEZ8w5TnUB5E3sjHe
         OeextqzAlWjbKGcvUQyGm2hoOB+9Ti+GQDD6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JMhGNkNbfs79ErvmbxIMsuaXjFjWI1trOgRocQmmg0wi3rMmPTTxwVHROxJ04LfGHY
         4IMiUMCngbUjPgYCaPudWg82Hscl5JRXdE9u1RJ9bB26OJEk2UVjR0JUpfwfpRwvPIaA
         M/s/Au+llf/x+lYe6y/Q/S+o2To6x8BYSYE1g=
Received: by 10.220.125.38 with SMTP id w38mr3698281vcr.49.1282602447279;
        Mon, 23 Aug 2010 15:27:27 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m6sm2086091vcx.0.2010.08.23.15.27.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 15:27:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282494398-20542-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154264>

Ramkumar Ramachandra wrote:

>  Documentation/git-fmt-merge-msg.txt |   10 +++++-----
>  Documentation/merge-options.txt     |    6 +++---
>  builtin/fmt-merge-msg.c             |   25 ++++++++++++++-----------
>  builtin/merge.c                     |   18 ++++++++++--------
>  4 files changed, 32 insertions(+), 27 deletions(-)

Is this on top of "next"?  I had trouble applying it on top of the
update-contrib-example-merge topic.

> --- a/Documentation/git-fmt-merge-msg.txt
> +++ b/Documentation/git-fmt-merge-msg.txt
> @@ -24,10 +24,10 @@ automatically invoking 'git merge'.
>  OPTIONS
>  -------
>  
> ---log::
> +--log[=<n>]::
>  	In addition to branch names, populate the log message with
> -	one-line descriptions from the actual commits that are being
> -	merged.
> +	one-line descriptions from at most <n> actual commits that are
> +	being merged. If omitted, <n> defaults to 20.

The description feels a bit awkward.  Maybe:

	In addition to branch names, populate the log message with
	one-line descriptions from the actual commits that are being
	merged.  At most <n> commits from each merge parent will be
	used (20 if <n> is omitted).  This overrides the `merge.log`
	configuration variable.

> +++ b/Documentation/merge-options.txt
> @@ -16,11 +16,11 @@ inspect and further tweak the merge result before committing.
>  With --no-ff Generate a merge commit even if the merge
>  resolved as a fast-forward.
>  
> ---log::
> +--log[=<n>]::
>  --no-log::
>  	In addition to branch names, populate the log message with
> -	one-line descriptions from the actual commits that are being
> -	merged.
> +	one-line descriptions from <n> actual commits that are being
> +	merged. See also linkgit:git-fmt-merge-msg[1].

Maybe s/<n>/at most <n>/.

> --- a/builtin/fmt-merge-msg.c
> +++ b/builtin/fmt-merge-msg.c
> @@ -7,21 +7,21 @@
>  #include "string-list.h"
>  
>  static const char * const fmt_merge_msg_usage[] = {
> -	"git fmt-merge-msg [-m <message>] [--log|--no-log] [--file <file>]",
> +	"git fmt-merge-msg [-m <message>] [--log[=<n>]|--no-log] [--file <file>]",
>  	NULL
>  };
>  
> -static int merge_summary;
> +static int shortlog_len;

Before: merge_summary is 1 for --log, 0 for --no-log.
After: shortlog_len is 20 for --log, 0 for --no-log, right?

>  static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
>  {
>  	static int found_merge_log = 0;
>  	if (!strcmp("merge.log", key)) {
>  		found_merge_log = 1;
> -		merge_summary = git_config_bool(key, value);
> +		shortlog_len = git_config_bool(key, value);
>  	}
>  	if (!found_merge_log && !strcmp("merge.summary", key))
> -		merge_summary = git_config_bool(key, value);
> +		shortlog_len = git_config_bool(key, value);

So should this say something like

	shortlog_len = git_config_bool(key, value) ?
				DEFAULT_MERGE_LOG_LEN : 0;

?

> @@ -318,10 +318,12 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
>  	const char *inpath = NULL;
>  	const char *message = NULL;
>  	struct option options[] = {
> -		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
> -		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
> -		  "alias for --log (deprecated)",
> -		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
> +		{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
> +		  "populate log with <n> entries from shortlog",
> +		  PARSE_OPT_OPTARG, NULL, 20 },
> +		{ OPTION_INTEGER, 0, "summary", &shortlog_len, "n",
> +                  "alias for --log (deprecated)",
> +		  PARSE_OPT_OPTARG | PARSE_OPT_HIDDEN, NULL, 20 },

Whitespace damage.

> +++ b/builtin/merge.c
> @@ -42,7 +42,7 @@ static const char * const builtin_merge_usage[] = {
>  	NULL
>  };
>  
> -static int show_diffstat = 1, option_log, squash;
> +static int show_diffstat = 1, shortlog_len, squash;
>  static int option_commit = 1, allow_fast_forward = 1;
>  static int fast_forward_only;
>  static int allow_trivial = 1, have_message;
> @@ -177,8 +177,9 @@ static struct option builtin_merge_options[] = {
>  	OPT_BOOLEAN(0, "stat", &show_diffstat,
>  		"show a diffstat at the end of the merge"),
>  	OPT_BOOLEAN(0, "summary", &show_diffstat, "(synonym to --stat)"),
> -	OPT_BOOLEAN(0, "log", &option_log,
> -		"add list of one-line log to merge commit message"),
> +	{ OPTION_INTEGER, 0, "log", &shortlog_len, "n",
> +	  "populate log with <n> entries from shortlog",

The emphasis seems wrong: the important thing is still that --log
uses a shortlog, not the number of entries.  Maybe something like

	  "populate log with (at most <n>) entries from shortlog"

but that might make "git merge -h" use more than 80 columns...

>  	OPT_BOOLEAN(0, "commit", &option_commit,
> @@ -505,7 +506,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  	else if (!strcmp(k, "pull.octopus"))
>  		return git_config_string(&pull_octopus, k, v);
>  	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary"))
> -		option_log = git_config_bool(k, v);
> +		shortlog_len = git_config_bool(k, v);

As before (is this missing a " ? DEFAULT_MERGE_LOG_LEN : 0"?).

Except as noted above,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
