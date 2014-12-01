From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: add a config option to always use the depth argument
Date: Mon, 01 Dec 2014 12:39:34 -0800
Message-ID: <xmqqzjb7nlyx.fsf@gitster.dls.corp.google.com>
References: <1417460823-17295-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 21:39:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvXkz-00011H-9r
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 21:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbaLAUjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2014 15:39:37 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752885AbaLAUjg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2014 15:39:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BBCD821756;
	Mon,  1 Dec 2014 15:39:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fBpXaeHyNZDPE+BHLpcrIvWyeC0=; b=x5PCQD
	fO0fTbDogZybWA4NA0wnjKQ6zFoCMY9WW0/vA93lUqLlq4n6I+es3d3PGkIb97GM
	L8AVEAFv4Q7oHqNpQkKWCbz91v6D3g2JkAlcDSQo3ubIIIASdDFTcUj7jPS+LS1X
	Gp/PCksQ6+SjfNQ5MQ0J/Sf6mArQ3Hdvl6dXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nYCxoFbdqWkL6Oryz7diUN1cOhWpm5Pu
	EpwDrzXQPK64EvM51RRQc3rjfwhs+nb60tXftHpJtDq1XXYbdv0PqANH0SpTnRkm
	ioBeV3LkGFhDOv1UC7vx0vCgJMDWkocGyapp8KQOrFntCZPS8Zg+H70Xt8u5MMVp
	LqHlhsXrTYs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B3F6D21755;
	Mon,  1 Dec 2014 15:39:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B65B21754;
	Mon,  1 Dec 2014 15:39:35 -0500 (EST)
In-Reply-To: <1417460823-17295-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 1 Dec 2014 11:07:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2948BA52-799A-11E4-991D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260511>

Stefan Beller <sbeller@google.com> writes:

> When having a repository, which deals with large amounts of data, i.e.
> graphics, music, films, you may want to keep the git directory at
> the smallest size possible.
>
> The depth option helped us in achieving this goal by removing the sizable
> history and just keep recent history around. In the case of having large
> amounts of data around, you probably want to use the depth option at any
> fetch you do, so it would be convenient to have an option for this.
>
> Change-Id: I45a569239639f20e24fbae32fb2046bc478c5f07
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/config.txt        | 6 ++++++
>  Documentation/fetch-options.txt | 2 ++
>  builtin/fetch.c                 | 5 +++++
>  3 files changed, 13 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 9220725..418e21f 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1106,6 +1106,12 @@ fetch.prune::
>  	If true, fetch will automatically behave as if the `--prune`
>  	option was given on the command line.  See also `remote.<name>.prune`.
>  
> +fetch.depth::
> +	If set, fetch will automatically behave as if the `--depth`
> +	option was given on the command line.  This allows users to keep
> +	the git directory at low space requirements, and thus comes in handy
> +	for users with large binary files in the repository.
> +

Hmm, is this something a user would typically want repository-wide?
I am wondering if "remote.$nick.fetchDepth" or something scoped to
remote is more appropriate.

>  format.attach::
>  	Enable multipart/mixed attachments as the default for
>  	'format-patch'.  The value can also be a double quoted string
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
> index b09a783..81131d0 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -12,6 +12,8 @@
>  	`git clone` with `--depth=<depth>` option (see linkgit:git-clone[1])
>  	to the specified number of commits from the tip of each remote
>  	branch history. Tags for the deepened commits are not fetched.
> +	You can configure git to always use the depth option, see
> +	`fetch.depth` in linkgit:git-config[1]
>  
>  --unshallow::
>  	If the source repository is complete, convert a shallow
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7b84d35..30fa15b 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -68,6 +68,11 @@ static int git_fetch_config(const char *k, const char *v, void *cb)
>  		fetch_prune_config = git_config_bool(k, v);
>  		return 0;
>  	}
> +	if (!strcmp(k, "fetch.depth")) {
> +		if (git_config_string(&depth, k, v))
> +			return -1;
> +		return 0;
> +	}
>  	return git_default_config(k, v, cb);
>  }
