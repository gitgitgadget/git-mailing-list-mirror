From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git push: Interpret $GIT_DIR/branches in a Cogito
 compatible way
Date: Mon, 10 Nov 2008 15:25:09 -0800
Message-ID: <7viqqv410q.fsf@gitster.siamese.dyndns.org>
References: <1226353631-3716-1-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Tue Nov 11 00:26:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzg9b-0008N4-O4
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 00:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYKJXZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 18:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbYKJXZ2
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 18:25:28 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42700 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbYKJXZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 18:25:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A550D7BEDB;
	Mon, 10 Nov 2008 18:25:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 983C27BED8; Mon,
 10 Nov 2008 18:25:18 -0500 (EST)
In-Reply-To: <1226353631-3716-1-git-send-email-mkoegler@auto.tuwien.ac.at>
 (Martin Koegler's message of "Mon, 10 Nov 2008 22:47:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DB0AD636-AF7E-11DD-B079-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100587>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> Current git versions ignore everything after # (called <head> in the
> following) when pushing. Older versions (before cf818348f1ab57),
> interpret #<head> as part of the URL, which make git bail out.
>
> Ignoring the <head> part for push (fetch respects them) is unlogical.
> As branches origin from Cogito, it is the best to correct this by
> using the behaviour of cg-push:
>
> push HEAD to remote refs/heads/<head>
>
> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>

This message was addressed to me, but is it meant for inclusion?

I do not recall seeing an agreement on what the desired behaviour should
be from (ex-)Cogito users, if this change of behaviour hurts real world
usage of existing git users, andr if so how we ease this change in to the
release.

While I'd personally agree matching with whatever cg-push used to do might
make the most sense in the end, I am not sure changing of behaviour
abruptly like this is a good idea.

I am also not so sure url#branch is illogical; I'd suggest dropping that
line from the commit log message in any case.

> +
> +Depending on the operation, git will use one of the following
> +refsprecs, if you don't provide one on the command line.
> +`<branch>` is the name of this file in `$GIT_DIR/branches` and
> +`<head>` defaults to `master`.
> +
> +git fetch uses:
> +
> +------------
> +	refs/heads/<head>:refs/heads/<branch>
> +------------
> +
> +git push uses:
>  
>  ------------
> -	refs/heads/<head>:<repository>
> +	HEAD:refs/heads/<head>
>  ------------

Why isn't this "refs/heads/<head>:refs/heads/<head>", by the way?
