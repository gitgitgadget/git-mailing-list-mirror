From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] git-send-email --expand-aliases
Date: Mon, 23 Nov 2009 16:42:00 -0800
Message-ID: <7v6390sqhz.fsf@alter.siamese.dyndns.org>
References: <20091123221628.GE26810@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 01:42:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCjU0-0005rv-Rm
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 01:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbZKXAmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 19:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbZKXAmE
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 19:42:04 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40331 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbZKXAmE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 19:42:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BB588265F;
	Mon, 23 Nov 2009 19:42:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a5/uPn0+169zlQINKt2JfMIldrk=; b=l58IsS
	XcnFm+sfcidfCSAeCNNWLSWyfHk1OIzkD+lu2+dWqQrwAplJhibmV8W+5Cbqi+WA
	GoQVyGY1YQmnXGHDyUv15QAIgSvnEgpJbUSM0tVxz8DdXZ+RsH9R0SzjNlaSrC/h
	bnFSur4l4S5lHDVp9aC7k5xgtXeQ0pLKDUonE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jjrSd4BlZJnL2wvcLD0Urn5GgwErOXve
	eAAJ2Q7AdsHbdJVY07nvwFwzZLJvpIFhuE9eEr9dXsWQXWVTcNDIUyMGU0ACHQP5
	0EYDHnLXmZYsWY9HLnxb0YHesX9IxeJRXxQrTHJr3lApS1HGzG9/8H3Ws2512V60
	Vgkv/hyc/vs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE92F8265E;
	Mon, 23 Nov 2009 19:42:05 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 668E68265D; Mon, 23 Nov
 2009 19:42:01 -0500 (EST)
In-Reply-To: <20091123221628.GE26810@ldl.fc.hp.com> (Alex Chiang's message of
 "Mon\, 23 Nov 2009 15\:16\:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30756F86-D892-11DE-92BD-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133547>

Alex Chiang <achiang@hp.com> writes:

> I'm an StGit user, and while StGit has its own 'stg mail'
> feature, it doesn't know how to expand email aliases (yet).
>
> Certainly, one way to solve that problem would be to hack stgit
> so that it can parse alias files, but to me, that seems silly
> when git-send-email can already do that.
>
> This patch teaches git-send-email to only expand email addresses
> so that other git porcelains don't have to roll their own mail
> alias parsers.

Certainly, one way to solve that would be to hack _both_ stgit and
send-email so that the former runs the latter _only_ to ask for the
expansion and then send the message out, but to me, that seems silly
when git-send-email can already do both expanding aliases and sending
the message ;-)

If you are changing StGit to call git-send-email anyway, why not arrange
stgit to call git-send-email to send the message out instead, instead of
sending messages on its own?

> I imagine the internal implementation of stg mail to work
> something like:
>
> 	call git-send-email --expand-aliases repeatedly, once for
> 	all the combined --to= args, then for all the combined --cc= args,
> 	and finally for all the combined --bcc= args (all passed
> 	to stg mail), read from stdout until EOF

I imagine the internal implementation of stg mail would work something
like:

    prepare messages to send out
    call git-send-email and have it send them

What am I missing?
