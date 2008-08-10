From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule - Add 'foreach' subcommand
Date: Sun, 10 Aug 2008 15:37:55 -0700
Message-ID: <7vsktczebg.fsf@gitster.siamese.dyndns.org>
References: <1218386647-2348-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 00:39:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSJZ4-0003Ld-Os
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 00:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbYHJWiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 18:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753684AbYHJWiD
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 18:38:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbYHJWiB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 18:38:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4E0CD506FA;
	Sun, 10 Aug 2008 18:37:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id BEBBE506F8; Sun, 10 Aug 2008 18:37:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FBE1A294-672C-11DD-A328-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91896>

Mark Levedahl <mlevedahl@gmail.com> writes:

> This utility is inspired by a number of threads on the mailing list
> looking for ways to better integrate submodules in a tree and work
> with them as a unit.

Thanks for keeping the topic going

> +foreach::
> +	Executes an arbitrary list of commands in each checked out submodule.
> +	$path is the name of the submodule directory relative to the
> +	superproject, and $sha1 is the commit as recorded in the superproject.
> +	And submodules defined in the superproject but not checked out are
> +	ignored by this command, and an empty command-list provides no output.
> ++
> +As an example, "git submodule foreach 'echo $path `git rev-parse HEAD`' will
> +show the path and currently checked out commit for each submodule.

I think this is a sensible building block to have.

> +cmd_foreach()
> +{
> +	git ls-files --stage | grep '^160000 ' |
> +	while read mode sha1 stage path
> +	do
> +		if test -e "$path"/.git
> +		then
> +			(cd "$path" && eval "$@")
> +		fi
> +	done
> +}

I suspect we may want to stop the loop upon failure from eval (any user
that wants to run command in all submodules no matter what could add '||:'
to the cmd list), but other than that this is a simple enough and good
addition.
