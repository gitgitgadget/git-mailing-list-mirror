From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] completion: add git status
Date: Thu, 02 Jun 2016 11:14:33 -0700
Message-ID: <xmqqtwhbtq46.fsf@gitster.mtv.corp.google.com>
References: <20160601141510.Horde.M2zGuJrzBNqf_2zYLo0P2Sx@webmail.informatik.kit.edu>
	<9ef8cfd8fb89bcacd123ddbebc12f961a292ef8b.1464879648.git.thomas.braun@virtuell-zuhause.de>
	<1464880296.3720.0.camel@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Thu Jun 02 20:14:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8X8k-0008L6-2Q
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 20:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161425AbcFBSOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 14:14:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932188AbcFBSOh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 14:14:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BF0D21ED26;
	Thu,  2 Jun 2016 14:14:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iqpjFYpryoGlnq8LFuXnnsXNU8c=; b=yVzwsD
	qxGhnSATz3mJoYem7xRmrjhLMWOXIz+jRrIKVxJs0oUnXUtdmcY454n1wAFrIH/D
	kruWcbIY+ZmNoAvpzXInJSNqBPrA5wFo76SZe966OddbI0yc4Zct3206HQRtmcqF
	Cyu+GrjTfQBFLVzzGRb2Rks1k5QKZ5+W+E0Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a5pAvbEJop9lZ2Q9Fy3WuCN1QLkGLVse
	dBF1V67oNusu2m0YopabKdgnEsg8mP4yY+DZwhK8dRFpdwJEGmsVMUhGT3EHpe/D
	d/iCFN51JYMmZ8A/uaJBU8y6fil1tbHcPtpsCFBAW81Jf8uvrueh7WOz3mE+E97P
	d4SNkJEC178=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B73BB1ED24;
	Thu,  2 Jun 2016 14:14:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 33C8C1ED23;
	Thu,  2 Jun 2016 14:14:35 -0400 (EDT)
In-Reply-To: <1464880296.3720.0.camel@virtuell-zuhause.de> (Thomas Braun's
	message of "Thu, 02 Jun 2016 17:11:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DC7BE1D6-28ED-11E6-A787-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296220>

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> +	untracked_state="$(__git_find_on_cmdline "--untracked-files=no\
> +		--untracked-files=normal --untracked-files=all")"

Just wondering but does this help my use of the command like

	$ git status -uno <TAB>

or do I now have to spell it out like

	$ git status --untracked-files=no <TAB>

to take advantage of it?

> +	untracked_state=${untracked_state##--untracked-files=}
> +
> +	if [ -z "$untracked_state" ]; then
> +		untracked_state="$(git --git-dir="$(__gitdir)" config "status.showUntrackedFiles")"
> +	fi
> +
> +	case "$untracked_state" in
> +		no)
> +			# --ignored option does not matter

Style.  I see existing case/esac statements that use this style, but
our preference is not to indent case arms like this; rather:

	case "$untracked_state" in
        no)
        	# --ignored ...

which saves the indentation one level overall.

> +			complete_opt=
> +			;;
> +		all|normal|*)
> +			complete_opt="--cached --directory --no-empty-directory --others"
> +
> +			if [ -n "$(__git_find_on_cmdline "--ignored")" ]; then

Same question as the "--untracked-files=no vs -uno" applies here.

> +				complete_opt="$complete_opt --ignored --exclude=*"
> +			fi
> +			;;
> +	esac
> +
> +	__git_complete_index_file "$complete_opt"
> +}
> +
>  __git_config_get_set_variables ()
>  {
>  	local prevword word config_file= c=$cword
