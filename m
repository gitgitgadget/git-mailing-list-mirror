From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V3 4/5] Help.c: add list_common_guides_help() function
Date: Tue, 02 Apr 2013 16:10:15 -0700
Message-ID: <7vobdw8r6w.fsf@alter.siamese.dyndns.org>
References: <1364942392-576-1-git-send-email-philipoakley@iee.org>
 <1364942392-576-5-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, "W. Trevor King" <wking@tremily.us>,
	David Aguilar <davvid@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Apr 03 01:10:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNALu-0005E3-Si
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 01:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756999Ab3DBXKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 19:10:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab3DBXKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 19:10:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BCC512AAA;
	Tue,  2 Apr 2013 23:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g+2EwQ/kaDge8alceo7FK/lnq9A=; b=itgRJa
	SmhC2lfb3F6QxFnaI7Aob+4o2TdLVMNCfAHmSeDgLw4mO8Pxm4UlHMxvvNdCTqwH
	sTjzpkjd1xTOmRGayPI3kcFcbsv3TTIvdPp6sdEOWQ61ZpqYehJ9ltmJGnk6ys9m
	c9fnHVJX46sc9BUHca7V92cZ3P0nOgPO0/tZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V8pvSJkNzrORXTXixgWQhDlpWps6sJNe
	XTeGHWnJE0N/YTc3aeRkC6yi0ObVWUip0hI8Ibr1PXajtoKuJrMJrhLrbE5WwMO6
	qUiGRe6y48qyWzB8gRLJmDnslAJGL7Xpm63kK1LLil+/luMnrNeY1dd6Ux2zS4g9
	KXzSehZsX7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22B6612AA9;
	Tue,  2 Apr 2013 23:10:18 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 40BAF12AA8; Tue,  2 Apr
 2013 23:10:17 +0000 (UTC)
In-Reply-To: <1364942392-576-5-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Tue, 2 Apr 2013 23:39:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B97B586-9BEA-11E2-BC78-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219901>

Philip Oakley <philipoakley@iee.org> writes:

> Re-use list_common_cmds_help but simply change the array name.
> Candidate for future refactoring to pass a pointer to the array.
>
> The common-guides.h list was generated with a simple variant of the
> generate-cmdlist.sh and command-list.txt.
>
> Do not list User-manual and Everday Git which not follow the naming
> convention, nor gitrepository-layout which doesn't fit within the
> name field size.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>  builtin/help.c  |  3 ++-
>  common-guides.h | 11 +++++++++++
>  help.c          | 18 ++++++++++++++++++
>  help.h          |  1 +
>  4 files changed, 32 insertions(+), 1 deletion(-)
>  create mode 100644 common-guides.h
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 03d432b..91a6158 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -433,7 +433,8 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  	}
>  
>  	if (show_guides) {
> -		/* do action - next patch */
> +		list_common_guides_help();
> +		printf("\n");
>  	}

This looks funny.  If you look at list_commands() that this patch is
mimicking, you will notice that the "trailing blank for clarity" is
done as part of the function, not done by the caller.  I think it is
better done the same way.

> diff --git a/common-guides.h b/common-guides.h
> new file mode 100644
> index 0000000..0e94fdc
> --- /dev/null
> +++ b/common-guides.h
> @@ -0,0 +1,11 @@
> +/* re-use struct cmdname_help in common-commands.h */
> +
> +static struct cmdname_help common_guides[] = {
> +  {"attributes", "defining attributes per path"},
> +  {"glossary", "A GIT Glossary"},
> +  {"ignore", "Specifies intentionally untracked files to ignore"},
> +  {"modules", "defining submodule properties"},
> +  {"revisions", "specifying revisions and ranges for git"},
> +  {"tutorial", "A tutorial introduction to git (for version 1.5.1 or newer)"},
> +  {"workflows", "An overview of recommended workflows with git"},
> +};

The _only_ reason we have common-cmds.h as a separat file even
though it defines data (hence should not be included in more than
one *.c file) is because it is a generated file.

For this array, there is no reason to have it in a separate header
file.  Just define it immediately before list_common_guies_help()
function that is the sole user of the array.

The function can live in builtin/help.c as a static, without
touching global help.c nor help.h, no?  Is there a reason why it
should be callable from other places?

> diff --git a/help.c b/help.c
> index 1dfa0b0..e0368ca 100644
> --- a/help.c
> +++ b/help.c
> @@ -4,6 +4,7 @@
>  #include "levenshtein.h"
>  #include "help.h"
>  #include "common-cmds.h"
> +#include "common-guides.h"
>  #include "string-list.h"
>  #include "column.h"
>  #include "version.h"
> @@ -240,6 +241,23 @@ void list_common_cmds_help(void)
>  	}
>  }
>  
> +void list_common_guides_help(void)
> +{
> +	int i, longest = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
> +		if (longest < strlen(common_guides[i].name))
> +			longest = strlen(common_guides[i].name);
> +	}
> +
> +	puts(_("The common Git guides are:\n"));
> +	for (i = 0; i < ARRAY_SIZE(common_guides); i++) {
> +		printf("   %s   ", common_guides[i].name);
> +		mput_char(' ', longest - strlen(common_guides[i].name));
> +		puts(_(common_guides[i].help));
> +	}
> +}
> +
>  int is_in_cmdlist(struct cmdnames *c, const char *s)
>  {
>  	int i;
> diff --git a/help.h b/help.h
> index 0ae5a12..4ae1fd7 100644
> --- a/help.h
> +++ b/help.h
> @@ -17,6 +17,7 @@ static inline void mput_char(char c, unsigned int num)
>  }
>  
>  extern void list_common_cmds_help(void);
> +extern void list_common_guides_help(void);
>  extern const char *help_unknown_cmd(const char *cmd);
>  extern void load_command_list(const char *prefix,
>  			      struct cmdnames *main_cmds,
