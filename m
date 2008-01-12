From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] git-submodule: New subcommand 'summary' (1) - code framework
Date: Sat, 12 Jan 2008 00:18:19 -0800
Message-ID: <7vmyrbv4ms.fsf@gitster.siamese.dyndns.org>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
	<f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 09:18:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDbZw-0008D5-QO
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 09:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758501AbYALIS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 03:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758499AbYALIS2
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 03:18:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757812AbYALIS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 03:18:27 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5544F4FE7;
	Sat, 12 Jan 2008 03:18:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CF5CE4FE6;
	Sat, 12 Jan 2008 03:18:20 -0500 (EST)
In-Reply-To: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	(Ping Yin's message of "Sat, 12 Jan 2008 15:37:11 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70296>

Ping Yin <pkufranky@gmail.com> writes:

> +	# get modified modules which have been checked out (i.e. cared by user)
> +	modules=$(git diff $cache_option --raw $head -- "$@" |
> +		grep '^:160000\|:000000 160000' |
> +		while read mod_src mod_dst sha1_src sha1_dst status name
> +		do

You are listing paths that were already submodule in HEAD, or
newly added submodule.  What about a path that used to be a blob
but is being made into submodule with the next commit (i.e. RHS
is 160000 but LHS is not 000000)?

> +	# TODO: quote module names containing space or tab

Yes, you would need to worry about *un*quoting them.

> +	test -n "$modules" &&
> +	echo "# Submodules modified: "$modules &&
> +	echo "#"
> +	cd "$cwd"

Hmmmmmm.... 

> -case "$add,$init,$update,$status,$cached" in
> -1,,,,)
> +case "$add,$init,$update,$summary,$status,$cached" in
> +1,,,,,)
>  	module_add "$@"
>  	;;

This is simply unsustainable.

Please see the other thread with Imran M Yousuf regarding the
command dispatcher.  I think that should be the first thing to
fix before doing any change.
