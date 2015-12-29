From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 09/10] config: add core.untrackedCache
Date: Tue, 29 Dec 2015 14:35:17 -0800
Message-ID: <xmqqlh8cg9y2.fsf@gitster.mtv.corp.google.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-10-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 23:35:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE2rU-0006p4-OX
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 23:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753826AbbL2WfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 17:35:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752743AbbL2WfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 17:35:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F1FBB3843A;
	Tue, 29 Dec 2015 17:35:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=oSLmaAiwzdeAbk5RTNzawl8SJ1w=; b=RSIdGDgklKNcKMoj1Jt2
	zvS3Qt6+CfQig38XALWHm52++vUBwIMBbrKb0kuKDFCRKFjrlBEMfbjU9ptyr0Lo
	Fq2looTsgJS+fdY0zYzX+Rg74c7EijAwa0eCVQfex81yJaLZv2tz3hj1BR5w9Um2
	IgVmdrtQiKauZq5xNZqpTEQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=sc+VOtVoeKzMktCYMc6m4kpl/lKQHtzXb05VOnX/AzfhxI
	1cRQeXjuSoddtNElQ++lGmC4ywLBJ+L3/BfBCICTF7VMn0iXcLB2GUYoVu57eLQ+
	muQKS9WXwK0WqJlsIGrDaz27b0ufvOBDry5zR87Yk0hJqEq2H4bVw23zubjB8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E94A838439;
	Tue, 29 Dec 2015 17:35:18 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 343A838438;
	Tue, 29 Dec 2015 17:35:18 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7000CE68-AE7C-11E5-9E28-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283155>

Christian Couder <christian.couder@gmail.com> writes:

> +core.untrackedCache::
> +	Determines if untracked cache will be automatically enabled or
> +	disabled. It can be `keep`, `true` or `false`. Before setting
> +	it to `true`, you should check that mtime is working properly
> +	on your system.
> +	See linkgit:git-update-index[1]. `keep` by default.
> +

Before "Before setting it to `true`", the reader needs to be told
what would happen when this is set to each of these three values (as
well as what happens when this is not set at all).

> diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
> index a0afe17..813f6cc 100644
> --- a/Documentation/git-update-index.txt
> +++ b/Documentation/git-update-index.txt
> @@ -174,27 +174,31 @@ may not support it yet.
>  
>  --untracked-cache::
>  --no-untracked-cache::
> -	Enable or disable untracked cache extension. This could speed
> -	up for commands that involve determining untracked files such
> -	as `git status`. The underlying operating system and file
> -	system must change `st_mtime` field of a directory if files
> -	are added or deleted in that directory.
> +	Enable or disable untracked cache extension. Please use
> +	`--test-untracked-cache` before enabling it.

"extension" is a term that is fairly close to the machinery.  In
other parts of the documentation (like the added text below in this
patch), it is called "untracked cache FEATURE", which probably is a
better word to use here as well.

> ++
> +These options cannot override the `core.untrackedCache` configuration
> +variable when it is set to `true` or `false` (see
> +linkgit:git-config[1]). They can override it only when it is unset or
> +set to `keep`. If you want untracked cache to persist, it is better
> +anyway to just set this configuration variable to `true` or `false`
> +directly.

While the above is not wrong per-se, from the point of those who
looked for these options (that is, those who wanted to do a one-shot
enabling or disabling of the feature, perhaps to try it out to see
how well it helps on their system), I think the explanation of the
interaction between the option and the config is backwards.  For
their purpose, setting it to `true` or `false` will be hinderance,
because the options are made no-op by such a setting.  IOW, the
advertisement "once you decided that you want to use the feature,
configuration is a better place to set it" does not belong here.

If I were writing this documentation, I'd probably rephrase the
second paragraph like so:

	These options take effect only when the
	`core.untrackedCache` configuration variable (see
	linkgit:git-config[1]) is set to `keep` (or it is left
	unset).  When the configuration variable is set to `true`,
	the untracked cache feature is always enabled (and when it
	is set to `false`, it is always disabled), making these
	options no-op.

perhaps.

> @@ -385,6 +389,34 @@ Although this bit looks similar to assume-unchanged bit, its goal is
>  different from assume-unchanged bit's. Skip-worktree also takes
>  precedence over assume-unchanged bit when both are set.
>  
> +Untracked cache
> +---------------
> +
> +This cache could speed up commands that involve determining untracked
> +...
> +It is recommended to use the `core.untrackedCache` configuration
> +variable (see linkgit:git-config[1]) to enable or disable this feature
> +instead of using the `--[no-|force-]untracked-cache`, as it is more
> +persistant and visible with a configuration variable.

s/persistant/persistent/; but more importantly, I do not think
persistence has much to do with the choice between the option and
configuration.  Once it is set with `--untracked-cache`, it should
persist until you explicitly use `--no-untracked-cache` to disable
it, no?  Otherwise you have a bug that needs to be fixed.

The reason you'd want to use a configuration is because the effect
of using the `--untracked-cache` option is per repository (rather,
per index-file).

    If you want to enable (or disable) this feature, it is easier to
    use the `core.untrackedCache` configuration variable than using
    the `--untracked-cache` option to `git update-index` in each
    repository, especially if you want to do so across all
    repositories you use, because you can set the configuration
    variable to `true` (or `false`) in your `$HOME/.gitconfig` just
    once and have it affect all repositories you touch.

or something, perhaps.

> +When the `core.untrackedCache` configuration variable is changed, the
> +untracked cache is added to or removed from the index the next time
> +"git status" is run; while when `--[no-|force-]untracked-cache` are
> +used, the untracked cache is immediately added to or removed from the
> +index.

Is it only "git status", or anything that writes/updates the index
file?  The above makes it sound as if you are saying "If you change
the variable, you must run `git status` for the change to take
effect", and if that is indeed the case, perhaps you should say so
more explicitly.  My cursory reading of the code suggests that the
user must run `git status` in a mode that shows untracked files
(i.e. "git status -uno" does not fix)?

I somehow thought, per the previous discussion with Duy, that the
check and addition of an empty one (if missing in the index and
configuration is set to `true`) or removal of an existing one (if
configuration is set to `false`) were to be done when the index is
read by read_index_from(), though.  If you have to say "After
setting the configuration, you must run this command", that does not
sound like a huge improvement over "If you want to enable this
feature, you must run this command".

> +	switch (untracked_cache) {
> +	case UC_UNSPECIFIED:
> +		break;
> +	case UC_DISABLE:
> +		if (use_untracked_cache == 1)
> +			die("core.untrackedCache is set to true; "
> +			    "remove or change it, if you really want to "
> +			    "disable the untracked cache");
>  		remove_untracked_cache();
>  		report(_("Untracked cache disabled"));
> +		break;
> +	case UC_TEST:
> +		setup_work_tree();
> +		return !test_if_untracked_cache_is_supported();
> +	case UC_ENABLE:
> +	case UC_FORCE:
> +		if (use_untracked_cache == 0)
> +			die("core.untrackedCache is set to false; "
> +			    "remove or change it, if you really want to "
> +			    "enable the untracked cache");
> +		add_untracked_cache();
> +		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
> +		break;

I do buy the decision to make these no-op when the configuration
says `true` or `false`, but I am not sure if these deserve die().

Exiting with 0 (= success) after issuing a warning() might be more
appropriate.  I'd especially anticipate that some newbies will
complain that they got "fatal:" when they used the "--force-"
variant, saying "I know what I am doing, that is why I said 'force',
why does stupid Git refuse?".
