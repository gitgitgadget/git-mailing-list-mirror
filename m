From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Post-receive hook for "git pull"
Date: Mon, 07 Dec 2015 11:54:43 -0800
Message-ID: <xmqqio4am3uk.fsf@gitster.mtv.corp.google.com>
References: <jwv4mful6nu.fsf-monnier+gmane.comp.version-control.git@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Monnier <monnier@iro.umontreal.ca>
X-From: git-owner@vger.kernel.org Mon Dec 07 20:54:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a61s3-0000BW-I8
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 20:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbbLGTyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 14:54:47 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932359AbbLGTyq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 14:54:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 624A431424;
	Mon,  7 Dec 2015 14:54:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T6vRzxXVrNYc1lCfDEFrnwShZg4=; b=DmZUC8
	8txVaF6Ri568IzOX3B9BAD0S4MCkKA+3hi+SqbJG7CPyPpkS+YsKWNn7f8f0O/ic
	BDMLrlry7CIMM+CpMCMBGswAlbHxspVENNmAni5fX4+AYGWoWy6utx9cbfnBtcNO
	lmp3QupleNyWYyrgC2IzJut+hc3tPIYllAWJY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q5uibsBDkmpjPWR1UOY9Rn5R0fsNt9GG
	x1+gUPc3AMIML2BHzt0DaGt5maBEfB/Wgh66prr8P9C0BNhR9f0hMz+bocm93cWP
	g4Pw4d2HXWqRYIlCjZdg27TlGK9wwqKhVBQXs7X9CMA640bxYxBzalkHjO3xW9N6
	FJajn5i4Omc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A7AD31423;
	Mon,  7 Dec 2015 14:54:46 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D60C03141F;
	Mon,  7 Dec 2015 14:54:45 -0500 (EST)
In-Reply-To: <jwv4mful6nu.fsf-monnier+gmane.comp.version-control.git@gnu.org>
	(Stefan Monnier's message of "Mon, 07 Dec 2015 08:47:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D8DE39A-9D1C-11E5-A1C5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282112>

Stefan Monnier <monnier@iro.umontreal.ca> writes:

> I have a system here where it can be quite common to have thousands of
> branches in the remote repository, and where I'd like to update some
> local state according to the appearance of new branches (or updates of
> pre-existing ones).
>
> Currently, I use a "git for-each-ref" after pulling and then check (for
> each one of those refs) if an update is warranted, but this can get slow
> with that many branches.  Is there some way to get something like the
> post-receive hook to be run for "git pull", so that the script gets told
> directly which (remote tracking) branches have been modified/created?

I do not think there is.  But you could easily script along the
lines of...

    #!/bin/sh
    git for-each-ref | sort >prestate
    git pull "$@"
    git for-each-ref | sort >poststate
    comm -12 prestate poststate

... or something like that, no?
