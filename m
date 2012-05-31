From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] Read from XDG configuration file, not write
Date: Thu, 31 May 2012 13:13:31 -0700
Message-ID: <7vr4u05ct0.fsf@alter.siamese.dyndns.org>
References: <1338412775-22840-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338475242-21770-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Lucien KONG <Lucien.Kong@ensimag.imag.fr>,
	Valentin DUPERRAY <Valentin.Duperray@ensimag.imag.fr>,
	Thomas NGUY <Thomas.Nguy@ensimag.imag.fr>,
	Franck JONAS <Franck.Jonas@ensimag.imag.fr>
To: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu May 31 22:13:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaBkZ-0000nm-HA
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 22:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809Ab2EaUNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 16:13:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44651 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964792Ab2EaUNe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 16:13:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9099B8464;
	Thu, 31 May 2012 16:13:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ktk6exkrn1oa4evcfllpNfI6nw=; b=rxENbI
	7YFfpft9qCplgYEEeAhVwhV1Uo+ME48My6hNz5sawBsnObqHxmNvDPwV+o8gciBC
	EE+d1ksdGmH4yWqYcgGN7rE1y/H86ZIANmowFNG3gvjoD1lJpB89r9IixyjWfVJ/
	R/r7Yl5v/pN/a7dor0McF0ESS2E3NXo7e3I2c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fIMdWm25J+368A6ej6GUGdmuSwv+oMZR
	S2FPARK+ZPVKbrIl5eRylItOj7H9AeVdjcLLRUNmobrHyg90CnawOgtiF8ZINzF7
	8p5M077H01d1Nuk3J4KXIMblOlB/fmL0cP/yt3W+GOFVTPFDP18uDD7wqCPmTrGK
	BQp8BDsmaSY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 873F48462;
	Thu, 31 May 2012 16:13:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C6F948460; Thu, 31 May 2012
 16:13:32 -0400 (EDT)
In-Reply-To: <1338475242-21770-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 (Huynh Khoi Nguyen NGUYEN's message of "Thu, 31 May 2012 16:40:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1877016A-AB5D-11E1-A76F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198944>

Huynh Khoi Nguyen NGUYEN  <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
writes:

> From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
>
> Git will be able to read in $XDG_CONFIG_HOME/git/config, a new

Getting nicer.

> @@ -172,7 +172,9 @@ static int get_value(const char *key_, const char *regex_)
>  		const char *home = getenv("HOME");
>  		local = repo_config = git_pathdup("config");
>  		if (home)
> -			global = xstrdup(mkpath("%s/.gitconfig", home));
> +			gitconfig_global = xstrdup(mkpath("%s/.gitconfig", home));
> +		if (xdg_git_path("config"))
> +			xdg_global = xdg_git_path("config");
>  		if (git_config_system())
>  			system_wide = git_etc_gitconfig();
>  	}

Hrm, xdg_git_path() returns allocated memory, and each call site
leaks its return value, no?

I didn't mean a micro-helper function like xdg_git_path() when I
suggested refactoring.  I meant a helper that figures out all the
necessary bits in one go.  For example, can't the above call site
look more like this?

        static int get_value(const char *key_, const char *regex_)
        {
                int ret = -1;
                char *global = NULL, *xdg = NULL, *repo_config = NULL;
                const char *system_wide = NULL, *local;
                struct config_include_data inc = CONFIG_INCLUDE_INIT;
                config_fn_t fn;
                void *data;

                local = given_config_file;
                if (!local) {
                        local = repo_config = git_pathdup("config");
                        if (git_config_system())
                                system_wide = git_etc_gitconfig();
			home_config_paths(&global, &xdg);
                }
		...

And then the config.c::home_config_paths() may look like:

	void home_config_paths(char **global, char **xdg)
	{
		char *xdg_home = getenv("XDG_CONFIG_HOME");
                char *home = getenv("HOME");
                char *to_free = NULL;
		
                if (!home) {
			*global = NULL;
		} else {
			if (!xdg_home) {
	                        to_free = strdup(mkpath("%s/.config", home));
				xdg_home = to_free;
			}
			*global = xstrdup(mkpath("%s/.gitconfig", home));
		}
                
                if (!xdg_home)
                	*xdg = NULL;
		else
			*xdg = xstrdup(mkpath("%s/git/config", xdg_home));
		free(to_free);
	}


> diff --git a/t/t1306-read-xdg-config-file.sh b/t/t1306-read-xdg-config-file.sh
> new file mode 100755
> index 0000000..4cab38b
> --- /dev/null
> +++ b/t/t1306-read-xdg-config-file.sh
> @@ -0,0 +1,87 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Valentin Duperray, Lucien Kong, Franck Jonas,
> +#		     Thomas Nguy, Khoi Nguyen
> +#		     Grenoble INP Ensimag
> +#
> +
> +test_description='possibility to read $XDG_CONFIG_HOME/git/config file'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'read automatically: xdg file exists and ~/.gitconfig doesn'\''t' '
> +	mkdir -p .config/git &&
> +	echo "[advice]" >.config/git/config &&
> +	echo "	statushints = false" >>.config/git/config &&
> +	cat >expect <<-\EOF &&
> +	# On branch master
> +	#
> +	# Initial commit

Use of "status" output as test vector is not such a good idea for
multiple reasons.

 - You are aware that the "status hints" feature is currently in
   flux (somebody nearby is working on a patch);

 - Even without another topic that currently works on it, "git
   status" output is for human consumption and subject to
   improvement and also l10n.

 - "status" output lists tracked and untracked paths, which makes it
   harder to later introduce new file to the test directory that are
   needed for later tests, or rename ones that were used in earlier
   versions of the test, without having to update all of these test
   vectors.

> +	#
> +	# Untracked files:
> +	#	.config/
> +	#	expect
> +	#	output

This is a good example that shows why using "status" output as a
test vector is not a good idea.

Notice you listed "expect" and "output" here.  As my next suggestion
is to rename "output" to "actual" (we typically "test_cmp expect actual"),
use of "git status" output as a test vector would mean you would
have to update them whenever such a change is needed.

> +	nothing added to commit but untracked files present
> +	EOF
> +	git status >output &&
> +	test_cmp expect output
> +'
