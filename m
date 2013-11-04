From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add the commit.gpgsign option to sign all commits
Date: Mon, 04 Nov 2013 15:43:37 -0800
Message-ID: <xmqqppqfag2e.fsf@gitster.dls.corp.google.com>
References: <1383606881-2979-1-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Tue Nov 05 00:43:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdTo9-0007si-4M
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 00:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343Ab3KDXnl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 18:43:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752010Ab3KDXnk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 18:43:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9790E4DC13;
	Mon,  4 Nov 2013 18:43:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KZCjhzCTH9UCoZO9G0QOsSfPON4=; b=TbEVqd
	odWHRYizmCvz2RDKse0YheDBLHFG1PntiCnDkienTxeFg57jkYNzrcXy75FXhPNY
	b30yECI3RvES45bPaVywCbtLNU2Om+AdHwKeBAWTGxAxidCBA5urSBc4FeS2ygQ2
	p9iKMKQuIgGyUKZya4P5t+8rWMfKIXA+hYSEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l6kfMCFIIDJeg0/2K2TJrv+iHaeD2/5/
	PWEeDBc5HPdU3CRHK88IW6Lh2TPMp1fSG1gjMIjnbX2Aekp5L25Xu6yntK3gxwLP
	jv6a9XE6x3UI1qSmxBXlDHoxk5ScZStCJeVUurwglph4L8BJ5UvZ60RpTJTiFzxq
	n2o5PXLIPSk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 877034DC12;
	Mon,  4 Nov 2013 18:43:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8DDE4DC11;
	Mon,  4 Nov 2013 18:43:38 -0500 (EST)
In-Reply-To: <1383606881-2979-1-git-send-email-boklm@mars-attacks.org>
	(Nicolas Vigier's message of "Tue, 5 Nov 2013 00:14:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EDD7259A-45AA-11E3-A832-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237313>

Nicolas Vigier <boklm@mars-attacks.org> writes:

> If you want to GPG sign all your commits, you have to add the -S option
> all the time. The commit.gpgsign config option allows to sign all
> commits automatically.

I'm somewhat horrified to imagine the end-user experience this
"feature" adds to the system; if one sets htis configuration and
then runs "git rebase" or anything that internally creates or
recreates commits, does one have to sign each and every commit, even
if such a rebase was done merely as a trial run to see if a topic
can be rebased to an older codebase, or something?

>
> Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
> ---
>  Documentation/config.txt | 3 +++
>  builtin/commit-tree.c    | 7 ++++++-
>  builtin/commit.c         | 4 ++++
>  builtin/merge.c          | 3 +++
>  4 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ab26963d6187..4cfa557375a2 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -988,6 +988,9 @@ commit.cleanup::
>  	have to remove the help lines that begin with `#` in the commit log
>  	template yourself, if you do this).
>  
> +commit.gpgsign::
> +	A boolean to specify whether all commits should be GPG signed.
> +
>  commit.status::
>  	A boolean to enable/disable inclusion of status information in the
>  	commit message template when using an editor to prepare the commit
> diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
> index f641ff2a898c..1646d5b25e4f 100644
> --- a/builtin/commit-tree.c
> +++ b/builtin/commit-tree.c
> @@ -12,6 +12,8 @@
>  
>  static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1> <changelog";
>  
> +static const char *sign_commit;
> +
>  static void new_parent(struct commit *parent, struct commit_list **parents_p)
>  {
>  	unsigned char *sha1 = parent->object.sha1;
> @@ -31,6 +33,10 @@ static int commit_tree_config(const char *var, const char *value, void *cb)
>  	int status = git_gpg_config(var, value, NULL);
>  	if (status)
>  		return status;
> +	if (!strcmp(var, "commit.gpgsign")) {
> +		sign_commit = git_config_bool(var, value) ? "" : NULL;
> +		return 0;
> +	}
>  	return git_default_config(var, value, cb);
>  }
>  
> @@ -41,7 +47,6 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
>  	unsigned char tree_sha1[20];
>  	unsigned char commit_sha1[20];
>  	struct strbuf buffer = STRBUF_INIT;
> -	const char *sign_commit = NULL;
>  
>  	git_config(commit_tree_config, NULL);
>  
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 6ab4605cf5c2..cffddf210807 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1406,6 +1406,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>  	}
>  	if (!strcmp(k, "commit.cleanup"))
>  		return git_config_string(&cleanup_arg, k, v);
> +	if (!strcmp(k, "commit.gpgsign")) {
> +		sign_commit = git_config_bool(k, v) ? "" : NULL;
> +		return 0;
> +	}
>  
>  	status = git_gpg_config(k, v, NULL);
>  	if (status)
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 02a69c14e6ab..fea27244557d 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -604,6 +604,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  	} else if (!strcmp(k, "merge.defaulttoupstream")) {
>  		default_to_upstream = git_config_bool(k, v);
>  		return 0;
> +	} else if (!strcmp(k, "commit.gpgsign")) {
> +		sign_commit = git_config_bool(k, v) ? "" : NULL;
> +		return 0;
>  	}
>  
>  	status = fmt_merge_msg_config(k, v, cb);
