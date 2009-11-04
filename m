From: Junio C Hamano <gitster@pobox.com>
Subject: Re: thoughts on setting core.logAllRefUpdates default true for bare
 repos
Date: Wed, 04 Nov 2009 11:49:33 -0800
Message-ID: <7v3a4ugjea.fsf@alter.siamese.dyndns.org>
References: <slrnhf2uep.7d3.sitaramc@sitaramc.homelinux.net>
 <alpine.DEB.1.00.0911041422170.2788@felix-maschine>
 <vpqzl729j72.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Nov 04 20:50:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5lrm-0000NL-27
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 20:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbZKDTtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 14:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbZKDTtm
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 14:49:42 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44658 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbZKDTtk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 14:49:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E287F92495;
	Wed,  4 Nov 2009 14:49:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8XRIKd3b8PNg6icObLC0NDaqw/s=; b=TVNwYM
	VEs4Es/TS3cPfPirhzFFTmsOAV86LvyZrNmQ8+jSaAkMJFpNnVYz2hqe55a+Vu39
	pdmhjBPLtBEOTWF3XFHcaWVm752lrV2tQ9Xu7Wwxn8pM6c+zfb0v1MPoHEyMQ+eO
	2LPKm/xIzeOQAWJlbzF6gEd+PeMDAxXAYhP2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bQ7iUDSpi99JzH/liekgxOAKoq7aXECF
	PKUCxbyQt9wtf/FjPZ02haWCOPv84h2TzPW6VMGjLfWMU2YGz8ZHMwEksbciS/dM
	LojNnKv1I8zrL82DmqyQQNyjjGrxsKps5EMig5kmAbH7dUun9agDMrKadLs1fJvS
	C718vLFflkg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE36292493;
	Wed,  4 Nov 2009 14:49:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D98DE92490; Wed,  4 Nov 2009
 14:49:34 -0500 (EST)
In-Reply-To: <vpqzl729j72.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Wed\, 04 Nov 2009 20\:35\:45 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 30EB53CA-C97B-11DE-B83D-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132124>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I can't think of any, and I just tried launching two
>
> while true; do git pull; date > foo.txt ; git add .; git commit -m "xxx"; git push; done
>
> in parallel, with two different users pushing to a --bare --shared
> repository, and it did work well. But I may very well have missed
> something.
>
> (and actually, if it causes problem, it's an argument in favor of
> defaulting to false when core.shared is true, not when core.bare).
>
> Unless I missed something, I think core.logAllRefUpdates should be
> enabled for bare repos.

Your experiment justifies "could be enabled safely" and saying "should be"
based on that is a bit too strong and also premature.

The single most common reason why a bare repository is bare is because
nobody regularly logs in to the machine that hosts it and goes there to
access its contents.  As reflog is a local thing, and not exposed to
outside world, enabling it alone would not help a lot to people who do not
have such a direct access to the bare repository, which by definition is
the majority because the reason why the repository is bare to begin with.

Once we add ways to expose information kept in reflog of a bare repository
more effectively and conveniently, the argument could become "should be
enabled now it would be very useful to have one".

I mentioned a possible option to show reflog entry annotations in gitweb.
That was an example of such an addition of "a way to expose".

It also is plausible to teach git-daemon a remote "log" request; similar
to "git fetch" running "upload-pack" on the other end in the bare
repository, a "git log --remote" command may run "upload-log" on the other
end and this service may allow passing the "-g" option when it does so.
That would be another addition of "a way to expose".
