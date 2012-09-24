From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-completion about git p4
Date: Mon, 24 Sep 2012 09:12:05 -0700
Message-ID: <7vbogv1ju2.fsf@alter.siamese.dyndns.org>
References: <1348264271-99395-1-git-send-email-rcumming@ea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ryan Cumming <etaoins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 18:12:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGBGe-0001Lu-8G
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 18:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab2IXQMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 12:12:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755603Ab2IXQMI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 12:12:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EAF98FBB;
	Mon, 24 Sep 2012 12:12:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/d+79DZNe9QmUAgWne4R0YA+iqI=; b=MbG05U
	EH56nGvP74ZbXx0LRVQVW6Luuslqy/gkEY67gpo/zYW1hjZo0RfdMJNFLFiEyQje
	DplkBwx/SjB4sQ/wT5b48WkdzTDLa2FF8MMjI8lLA9E7NUa58NBufyI2ajNAldQ5
	ciMizs3i0rrdQUH6AN1jS1/Zyl1lFBdYJEiuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QEaIu5xAIYcmRQ02EI2IpmtggikgtASg
	1DteJ5myRbJzkolc2lPzfJrLpvckQVK8+SuKy4XSH9OOEh2EPsqPauoxwRF3MRvU
	L+rxihU+BIYXZTwE69HVz+8ogpX+HIgRfDT0SYEMF85clTlxDp0RxuHrEdse9GeF
	ykA2TOifbdE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4790F8FBA;
	Mon, 24 Sep 2012 12:12:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E5E48FB9; Mon, 24 Sep 2012
 12:12:06 -0400 (EDT)
In-Reply-To: <1348264271-99395-1-git-send-email-rcumming@ea.com> (Ryan
 Cumming's message of "Fri, 21 Sep 2012 14:51:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95EF0C5E-0662-11E2-8C4C-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206290>

Ryan Cumming <etaoins@gmail.com> writes:

> From: Ryan Cumming <etaoins@gmail.com>
>
> git p4 was moved out of contrib in 1.7.11 but it git-completion didn't
> know about it. Add git p4 completion based on the existing SVN
> completion. It covers all known subcommands and options except for the
> -/ option for clone which doesn't use the standard -- prefix.
>
> Signed-off-by: Ryan Cumming <etaoins@gmail.com>
> ---

Sounds sensible; thanks.

> +_git_p4 ()
> +{
> +...
> +		local submit_opts="
> +			--origin= -M --preserve-user --export-labels
> +			$common_opts
> +			"
> +
> +		case "$subcommand,$cur" in
> ...
> +		submit,--*)
> +			__gitcomp "$submit_opts"

This is taken when $cur begins with --, but $submit_opts includes
"-M" which doesn't begin with it.  Is that a problem?

> +			;;
> +		submit,*)
> +			__gitcomp "$(__git_refs)"
> +			;;
> +		esac
> +	fi
> +}
