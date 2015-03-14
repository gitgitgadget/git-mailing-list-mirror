From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] push: allow --follow-tags to be set by config push.followTags
Date: Fri, 13 Mar 2015 23:06:22 -0700
Message-ID: <xmqqh9toxgdd.fsf@gitster.dls.corp.google.com>
References: <20150216061051.GA29895@peff.net>
	<20150216061619.GC32381@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Dave Olszewski <cxreg@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 14 07:20:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWfQk-00061D-CR
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 07:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbbCNGG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 02:06:26 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750841AbbCNGGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 02:06:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B895134714;
	Sat, 14 Mar 2015 02:06:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VyHOB/UbGPPCeH4yJpjrCc4yJGI=; b=F4MLRT
	YCZvm94P9QpSsUDeup4tm87uDl2T1UuRBr1/xhMnwNZXCmDpwGGXm4pVHWNaprQk
	KUmy2bXOyv/JDZmXHNZGtXgTPsO42fIOOTLUjg63XC4+q2jUNffs+cbbS1E0u1WY
	VgKeFWY98gQ6f4IfY0pXloheJB92ourIW53ec=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JeComFpVybrQ16EGhEAKEIAA4hHWKnD3
	1Ei4v1/wiIXcjmjr3jlXZ+IdSCPmjErwG2YoGCzD0pUDw/wqkqce5ZYwWRrmWd9g
	73a6/vsuPk1kpytIExpZ4Hxz4mqhC43RNX58qr7d5LRQjEbKs0UvuEabR8+SZtPY
	1BTO1pTbZ00=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B1BFE34713;
	Sat, 14 Mar 2015 02:06:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2F33234712;
	Sat, 14 Mar 2015 02:06:23 -0400 (EDT)
In-Reply-To: <20150216061619.GC32381@peff.net> (Jeff King's message of "Mon,
	16 Feb 2015 01:16:19 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3DBD4A22-CA10-11E4-817D-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265438>

Jeff King <peff@peff.net> writes:

> From: Dave Olszewski <cxreg@pobox.com>
>
> Signed-off-by: Dave Olszewski <cxreg@pobox.com>
> ---
> Again, this is just a preview. Dave should send the final when he thinks
> it is good.

Dave?

I do not see anything wrong with this version that builds on top of
the previous 2 clean-up.  Personally I find that these clean-up
changes more valuable than I care about this particular feature, and
it is unfortunate that waiting an Ack or reroll of this one kept
them stalled.

I am tempted to throw "Helped-by: Peff" into the log message and
merge the result to 'next', unless I hear otherwise in a few days.

> The if/else I added to the config callback is kind of ugly. I wonder if
> we should have git_config_bit, or even just a function to set/clear a
> bit. Then the OPT_BIT code could use it, too. Something like:
>
>   munge_bit(flags, TRANSPORT_PUSH_FOLLOW_TAGS, git_config_bool(k, v));
>
> Or maybe that is getting too fancy and obfuscated for a simple bit
> set/clear. I dunno.

I think we agreed that the code we have in this series is good.

>  Documentation/config.txt               | 6 ++++++
>  Documentation/git-push.txt             | 5 ++++-
>  builtin/push.c                         | 9 +++++++++
>  contrib/completion/git-completion.bash | 1 +
>  4 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ae6791d..e01d21c 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2079,6 +2079,12 @@ new default).
>  
>  --
>  
> +push.followTags::
> +	If set to true enable '--follow-tags' option by default.  You
> +	may override this configuration at time of push by specifying
> +	'--no-follow-tags'.
> +
> +
>  rebase.stat::
>  	Whether to show a diffstat of what changed upstream since the last
>  	rebase. False by default.
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index ea97576..caa187b 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -128,7 +128,10 @@ already exists on the remote side.
>  	Push all the refs that would be pushed without this option,
>  	and also push annotated tags in `refs/tags` that are missing
>  	from the remote but are pointing at commit-ish that are
> -	reachable from the refs being pushed.
> +	reachable from the refs being pushed.  This can also be specified
> +	with configuration variable 'push.followTags'.  For more
> +	information, see 'push.followTags' in linkgit:git-config[1].
> +
>  
>  --signed::
>  	GPG-sign the push request to update refs on the receiving
> diff --git a/builtin/push.c b/builtin/push.c
> index c25108f..6831c2d 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -482,6 +482,7 @@ static int option_parse_recurse_submodules(const struct option *opt,
>  
>  static int git_push_config(const char *k, const char *v, void *cb)
>  {
> +	int *flags = cb;
>  	int status;
>  
>  	status = git_gpg_config(k, v, NULL);
> @@ -511,6 +512,14 @@ static int git_push_config(const char *k, const char *v, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(k, "push.followtags")) {
> +		if (git_config_bool(k, v))
> +			*flags |= TRANSPORT_PUSH_FOLLOW_TAGS;
> +		else
> +			*flags &= ~TRANSPORT_PUSH_FOLLOW_TAGS;
> +		return 0;
> +	}
> +
>  	return git_default_config(k, v, NULL);
>  }
>  
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c21190d..cffb2b8 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2188,6 +2188,7 @@ _git_config ()
>  		pull.octopus
>  		pull.twohead
>  		push.default
> +		push.followTags
>  		rebase.autosquash
>  		rebase.stat
>  		receive.autogc
