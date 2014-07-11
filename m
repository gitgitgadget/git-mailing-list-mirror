From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 v4] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 08:04:30 -0700
Message-ID: <xmqqion4543l.fsf@gitster.dls.corp.google.com>
References: <1405036334-8093-1-git-send-email-jacob.e.keller@intel.com>
	<1405036334-8093-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 17:04:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5cNO-00029y-UD
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 17:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbaGKPEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 11:04:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50913 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbaGKPEi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 11:04:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5334A25704;
	Fri, 11 Jul 2014 11:04:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RLGEq1Ra+4o1tzMVHtCkfRhmOxk=; b=ElGgXI
	VvZg17u+NbbIYplcXx3B5rih2AOVnpmM/S7BfFQS+MuzrMVzJLdYBloPwU4qCdp6
	jvpkFkUFNQLMLOGcXsnWjOxLXQYokQUBxJmYHB/H36tOELUQEslgv7Co0NPrF/r0
	jGYEYaF4gKx21iEj42RqZ1PZNnOSZKMDfV/SQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AvHu/9dFaaXJBDY/iXsBoIi4JGWlw5bH
	WaDoZ5HjE1dH5cagGaxI04h8e6qNDiteIoe6G6EzSGg/IW2UHCdwFm5LOV1jjdd5
	shnPKxx+nm6kN0QjoaBUvorN6nsqSV9X+QViDRLPvG43vT9kSKYBr0hxrUXLtYTS
	qBPf4DTJfDg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 49D7725703;
	Fri, 11 Jul 2014 11:04:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D0B95256FA;
	Fri, 11 Jul 2014 11:04:16 -0400 (EDT)
In-Reply-To: <1405036334-8093-2-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Thu, 10 Jul 2014 16:52:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A0B8A33A-090C-11E4-B738-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253281>

Jacob Keller <jacob.e.keller@intel.com> writes:

> Add support for configuring default sort ordering for git tags. Command
> line option will override this configured value, using the exact same
> syntax.
>
> Cc: Jeff King <peff@peff.net>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> - v4
> * base on top of suggested change by Jeff King to use skip_prefix instead
>
>  Documentation/config.txt  |  6 ++++++
>  Documentation/git-tag.txt |  1 +
>  builtin/tag.c             | 46 ++++++++++++++++++++++++++++++++--------------
>  t/t7004-tag.sh            | 21 +++++++++++++++++++++
>  4 files changed, 60 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 1d718bdb9662..ad8e75fed988 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2354,6 +2354,12 @@ submodule.<name>.ignore::
>  	"--ignore-submodules" option. The 'git submodule' commands are not
>  	affected by this setting.
>  
> +tag.sort::
> +	This variable is used to control the sort ordering of tags. It is
> +	interpreted precisely the same way as "--sort=<value>". If --sort is
> +	given on the command line it will override the selection chosen in the
> +	configuration. See linkgit:git-tag[1] for more details.
> +

This is not technically incorrect per-se, but the third sentence
talks about "--sort" on "the command line" while this applies only
to "the command line of the 'git tag' command" and nobody else's
"--sort" option.

Perhaps rephrasing it like this may be easier to understand?

	When "git tag" command is used to list existing tags,
        without "--sort=<value>" option on the command line,
	the value of this variable is used as the default.

This way, it would be clear, without explicitly saying anything,
that the value will be spelled exactly the same way as you would
spell the value for the --sort option on the command line.

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index b424a1bc48bb..2d246725aeb5 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -317,6 +317,7 @@ include::date-formats.txt[]
>  SEE ALSO
>  --------
>  linkgit:git-check-ref-format[1].
> +linkgit:git-config[1].

It is not particularly friendly to readers to refer to
"git-config[1]" from any other page, if done without spelling out
which variable the reader is expected to look up.  Some addition
to the description of the "--sort" option is needed if this SEE ALSO
were to be any useful, I guess?

	--sort=<type>::
                ... (existing description) ...
                When this option is not given, the sort order
                defaults to the value configured for the `tag.sort`
                variable, if exists, or lexicographic otherwise.

or something like that, perhaps?

> diff --git a/builtin/tag.c b/builtin/tag.c
> index 7ccb6f3c581b..a53e27d4e7e4 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -18,6 +18,8 @@
>  #include "sha1-array.h"
>  #include "column.h"
>  
> +static int tag_sort = 0;

Please do not initialize variables in bss segment to 0 by hand.

If this variable is meant to take one of these *CMP_SORT values
defined as macro later in this file, it is better to define this
variable somewhere after and close to the definitions of the macros.
Perhaps immediately after the "struct tag_filter" is declared?

> @@ -346,9 +348,33 @@ static const char tag_template_nocleanup[] =
>  	"Lines starting with '%c' will be kept; you may remove them"
>  	" yourself if you want to.\n");
>  
> +static int parse_sort_string(const char *arg)
> +{
> +	int sort = 0;
> +	int flags = 0;
> +
> +	if (skip_prefix(arg, "-", &arg))
> +		flags |= REVERSE_SORT;
> +
> +	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
> +		sort = VERCMP_SORT;
> +
> +	if (strcmp(arg, "refname"))
> +		die(_("unsupported sort specification %s"), arg);

Hmm.  I _thought_ we try to catch unsupported option value coming
from the command line and die but at the same time we try *not* to
die but warn and whatever is sensible when the value comes from the
configuration, so that .git/config or $HOME/.gitconfig can be shared
by those who use different versions of Git.

Do we already have many precedences where we see configuration value
that our version of Git do not yet understand?

Not a very strong objection; just something that worries me.

> +	sort |= flags;
> +
> +	return sort;
> +}
> +
>  static int git_tag_config(const char *var, const char *value, void *cb)
>  {
> -	int status = git_gpg_config(var, value, cb);
> +	int status;
> +
> +	if (!strcmp(var, "tag.sort")) {
> +		tag_sort = parse_sort_string(value);
> +	}
> +

Why doesn't this return success after noticing that the variable is
to be interpreted by this block and nobody else?

When there is no reason to have things in a particular order, it is
customary to add new things at the end, not in the front, unless the
new thing is so much more important than everything else---but then
we are no longer talking about the case where there is no reason to
have things in a particular order ;-).

Remainder of the changes to builtin/tag.c looks good.

> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index e4ab0f5b6419..1e8300f6ed7c 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -1423,6 +1423,27 @@ EOF
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'configured lexical sort' '
> +	git config tag.sort "v:refname" &&
> +	git tag -l "foo*" >actual &&
> +	cat >expect <<EOF &&
> +foo1.3
> +foo1.6
> +foo1.10
> +EOF
> +	test_cmp expect actual
> +'

Please write the above like so:

	...
	cat >expect <<-\EOF &&
        foo1.3
        ...
        EOF
        test_cmp expect actual

The dash immediately after the here-doc redirection lets us indent
the data with HT to allow the test boundaries easier to spot, and by
quoting the token to end here-doc, we relieve the readers from
having to wonder if there are variable substitutions going on that
they need to be careful about.

Overall, I think this is done well.  Thanks for working on it.
