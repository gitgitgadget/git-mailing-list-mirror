From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] completion: add git status
Date: Mon, 06 Jun 2016 10:57:16 -0700
Message-ID: <xmqqmvmyxksj.fsf@gitster.mtv.corp.google.com>
References: <xmqq8tymp385.fsf@gitster.mtv.corp.google.com>
	<20160603183426.13140-1-thomas.braun@virtuell-zuhause.de>
	<20160603183426.13140-4-thomas.braun@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Mon Jun 06 19:57:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9ymF-0004oO-LW
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 19:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbcFFR5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 13:57:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52792 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753036AbcFFR5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 13:57:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E1A12220E;
	Mon,  6 Jun 2016 13:57:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=liGztXycyTGLAamtUdPDkctrRYg=; b=XZeXo9
	HvaFbWhoCpKrGA8rQKZElhiVETuxnPs13IDOtSnT66CDZYUBrxF98JKMFPl1nrd5
	fH8exW/Io/Ys+P8TXmhhVpZr036MdjYd6zgcR0x9i5ku8ylSZuso6qi6m1llJTv9
	85qjA6K99jF8m+W3s0VYxoqdPWf4Nb3acv4Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hqgbpJKhcGPZ++80Ae3fvKlL3sGgyRGJ
	ZwQmVJ9KIeAVGhveEZmc+7KXaCNE8NIDbzj2T3oJH4SX9589y5Qn6IhTpEz14t0Y
	cu4galSX8BQuUi9NTzRNb2OBvCrxC8uj7As75EGyg1MkLFotaMp9SFwaytP/huUC
	i1CxnU/sBhA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 15CCE2220D;
	Mon,  6 Jun 2016 13:57:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A51442220C;
	Mon,  6 Jun 2016 13:57:18 -0400 (EDT)
In-Reply-To: <20160603183426.13140-4-thomas.braun@virtuell-zuhause.de> (Thomas
	Braun's message of "Fri, 3 Jun 2016 20:34:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C468300-2C10-11E6-B526-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296543>

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> +	case "$cur" in
> +	--ignore-submodules=*)
> +		__gitcomp "none untracked dirty all" "" "${cur##--ignore-submodules=}"
> +		return
> +		;;
> +	--untracked-files=*)
> +		__gitcomp "$__git_untracked_file_modes" "" "${cur##--untracked-files=}"
> +		return
> +		;;
> +	--column=*)
> +		__gitcomp "
> +			always never auto column row plain dense nodense
> +			" "" "${cur##--column=}"
> +		return
> +		;;
> +	--*)
> +		__gitcomp "
> +			--short --branch --porcelain --long --verbose
> +			--untracked-files= --ignore-submodules= --ignored
> +			--column= --no-column
> +			"
> +		return
> +		;;
> +	esac
> +
> +	untracked_state="$(__git_get_option_value "-u" "--untracked-files="\

If you have a SP before that backslash, you can avoid getting
misunderstood that you are attempting to extend that string
"--untracked-files=".  The backslash is telling the shell that there
are more arguments to come, and it is misleading to rely on the fast
that the next line happens to begin with a whitespace.

> +		"$__git_untracked_file_modes" "status.showUntrackedFiles")"


> +	case "$untracked_state" in
> +	no)
> +		# --ignored option does not matter
> +		complete_opt=
> +		;;
> +	all|normal|*)
> +		complete_opt="--cached --directory --no-empty-directory --others"
> +
> +		if [ -n "$(__git_find_on_cmdline "--ignored")" ]; then
> +			complete_opt="$complete_opt --ignored --exclude=*"
> +		fi
> +		;;
> +	esac
> +
> +	__git_complete_index_file "$complete_opt"
> +}
> +
>  __git_config_get_set_variables ()
>  {
>  	local prevword word config_file= c=$cword
