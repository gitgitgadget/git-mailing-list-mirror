From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Specifying a private key when connecting to a remote SSH repo
Date: Thu, 12 Sep 2013 08:43:53 -0700
Message-ID: <xmqq1u4uqc3q.fsf@gitster.dls.corp.google.com>
References: <CAOgHByvTtNDho50B+pECMeXkq=3FF8EheFbP4iQbKYTiAPTwYw@mail.gmail.com>
	<xmqqeh8ur6uc.fsf@gitster.dls.corp.google.com>
	<20130912051913.GA1977@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Breck Yunits <breck7@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 17:44:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK93p-0007QI-M6
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 17:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab3ILPn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 11:43:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60659 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754828Ab3ILPn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 11:43:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8864040EFB;
	Thu, 12 Sep 2013 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DwOgG07KMZdQa6CLufPyhUxThmg=; b=Pxfi+i
	6ZKCUuPPRrCviPJbKGKyiEqX+dAGf3oJ2qNywjL73WhqVFgphrJO2pnW4iHXl8X/
	p4WEoLAwq3eUJxSm4LW8kN+tmEshrGUHM43MVPJObXnCZZMJ99HlUk79sfDWG9rY
	twB/k31HMo7VNdZQDsJUKLy4N+K5PQqzN8Koc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kpckb8MD+0sxlPwu+BzB+H2cELEkFUAA
	47PqEZwHm775lDIBGlYgCuQ6xVO41eoE8gTwwFwmzaNrIqBTaYBHhVZrSWJ87IUk
	JkrVNQSRYRWiROYiwEK6koilxYoWc4iAuRS6oCpijj4X6XLQACKJ8Up3RJ8eahY8
	ewPwV1PRhoU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C47D40EFA;
	Thu, 12 Sep 2013 15:43:55 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DB43A40EF3;
	Thu, 12 Sep 2013 15:43:54 +0000 (UTC)
In-Reply-To: <20130912051913.GA1977@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 12 Sep 2013 01:19:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 216436EA-1BC2-11E3-9244-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234657>

Jeff King <peff@peff.net> writes:

> We already have GIT_SSH, so I would expect:
>
>   GIT_SSH='ssh -i $HOME/.ssh/id_for_example_com' git push
>
> to work. But sadly, GIT_SSH does not use the shell, unlike most other
> configure git commands. :(

You read me correctly ;-)

> We could consider it a consistency bug and fix it, though I suspect we
> may be annoying people on Windows who have spaces in their paths.

Again, you read me correctly ;-)

> You could write a credential helper shell script that knows about
> classes of remotes (e.g., selecting an identity file based on the
> hostname), and write only a few lines to cover a large number of hosts.

Yes, but the same trick can be used in $HOME/.ssh/config to let one
entry cover the same large number of hosts, so...

> For example:
>
>   #!/bin/sh
>   test "$1" = "get" || exit 0
>   while IFS== read key val; do
>     test "$key" = "host" || continue
>     case "$val" in
>       *.example.com) echo sshident=com_key ;;
>       *.example.net) echo sshident=net_key ;;
>     esac
>   done
>
> But it feels a bit hacky to be using the credential helpers at all for
> ssh connections.

Yeah, perhaps.
