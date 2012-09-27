From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: introduce GIT_GLOBAL_CONFIG to override
 ~/.gitconfig
Date: Thu, 27 Sep 2012 10:27:19 -0700
Message-ID: <7vvcezqsug.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nYnyaoOsH_x8U96ADZT7VuP-pR36+RRcjTw39Kp1qCnw@mail.gmail.com>
 <1348757171-3223-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>,
	Anurag Priyam <anurag08priyam@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THHs6-0005I7-1X
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 19:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab2I0R1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 13:27:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376Ab2I0R1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 13:27:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9D1E9914;
	Thu, 27 Sep 2012 13:27:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VACjFaSJ92+6YWzSipkIOFn5Enk=; b=aNrhO2
	2kZYkeHdOUHTtvjC6x3RxiXX26nNqHCNa9tIFOD3EcG0F/qtQ10hZg3LolZU3YWF
	Nih6HCwHPjpMOhK0pbIQghs5ATpI53hzPTsyIiqgBUq5CrbEHIN9d/R1sQLyd6kZ
	ZtrI/xcUd6Hn04Fcr1HRFt14T/CJmHV8yGuxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YUz/G8RJaOBnQiYaIuwenqCiDyNXc78P
	ntIr7wVU7eQ85cZsmAxzYF+4QOXwJLf1Yhh213Y2ZGWDhTZ77KIcAOcg22jfsif/
	/4wIIoNc0tiL64F4rAitKSXtAVdRyKKCfUtU4GBIIZAUmgCD/qsEXrV97i2ibEA5
	UAUE0tYEoa4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D69C49913;
	Thu, 27 Sep 2012 13:27:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDBB19912; Thu, 27 Sep 2012
 13:27:20 -0400 (EDT)
In-Reply-To: <1348757171-3223-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 27 Sep 2012 20:16:11 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97CDAA40-08C8-11E2-A80D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206492>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-config.txt |    3 +++
>  path.c                       |    5 +++++
>  t/t1306-xdg-files.sh         |    8 ++++++++
>  3 files changed, 16 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index eaea079..c8db03f 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -205,6 +205,9 @@ $GIT_DIR/config::
>  	User-specific configuration file. Also called "global"
>  	configuration file.
>  
> +$GIT_GLOBAL_CONFIG::
> +	Overrides the path of the global configuration file.
> +

Why is this even a good idea?

  - Does it make sense not to read $HOME/.gitconfig or XDG stuff
    when this is set?  Why skip them?  If it makes sense to skip
    them, why doesn't it also skip $GIT_DIR/config and/or
    /etc/gitconfig?

  - Why is it not "the third user-specific configuration file" instead?

  - Why is it not "a list of paths to read configurations from"?

  - Where does it end?

Not overly impressed, I'd have to say.

> diff --git a/path.c b/path.c
> index cbbdf7d..9b09cee 100644
> --- a/path.c
> +++ b/path.c
> @@ -131,10 +131,15 @@ char *git_path(const char *fmt, ...)
>  
>  void home_config_paths(char **global, char **xdg, char *file)
>  {
> +	char *global_config = getenv("GIT_GLOBAL_CONFIG");
>  	char *xdg_home = getenv("XDG_CONFIG_HOME");
>  	char *home = getenv("HOME");
>  	char *to_free = NULL;
>  
> +	if (global_config) {
> +		*global = mkpathdup("%s", global_config);
> +		return;
> +	}
>  	if (!home) {
>  		if (global)
>  			*global = NULL;
> diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
> index 8b14ab1..5b0e08e 100755
> --- a/t/t1306-xdg-files.sh
> +++ b/t/t1306-xdg-files.sh
> @@ -28,6 +28,14 @@ test_expect_success 'read config: xdg file exists and ~/.gitconfig exists' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'read config: $GIT_GLOBAL_CONFIG is set and ~/.gitconfig exists' '
> +	>.gitconfig &&
> +	echo "[alias]" >.gittestconfig &&
> +	echo "	myalias = !echo in_gitconfig" >>.gittestconfig &&
> +	echo in_gitconfig >expected &&
> +	GIT_GLOBAL_CONFIG=~/.gittestconfig git myalias >actual &&

How is this tilde expanded and by whom?
