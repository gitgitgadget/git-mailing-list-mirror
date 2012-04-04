From: Junio C Hamano <gitster@pobox.com>
Subject: Re: displaying subtree merges
Date: Wed, 04 Apr 2012 14:09:17 -0700
Message-ID: <7vehs38arm.fsf@alter.siamese.dyndns.org>
References: <4F7C787A.6050905@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed Apr 04 23:09:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFXSI-0005ZX-9d
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 23:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167Ab2DDVJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Apr 2012 17:09:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59331 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944Ab2DDVJV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Apr 2012 17:09:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32FAF3548;
	Wed,  4 Apr 2012 17:09:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PCZ7MB1pzE62
	bh6wquYo83DVZWo=; b=nGlIwYzWVN1FOgpFCsqqUToKoslg0rxwIChzac9Xqvn/
	pL8JVKVDfBQiQloqprzGyix8XLR9rRw8qttOnFlw4nUMOxDGG7aUvEvibnkq8lHO
	xvDDmbFF3Qmofz76KB4Z/k2jZyQy72gKONY9rCsx0y9QQw0OAx0BqScGzmmkthM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=d7rEYd
	yXiWvfA+xLrBBIpXLfUrz5bjrd30I5I8lmAqpAmgsim37tw19544ovXveFoMX9ID
	ZDjDYkYoNRDgRTpimFYYutGL0ApV8A1CDv+pOg1NwFNpSNrrdp1Vcq/sLxU7Rlgu
	gdUxpcQFUgAfY8iwxwNH2lrgf9AVmxh+We0U0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A9A03547;
	Wed,  4 Apr 2012 17:09:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86B083546; Wed,  4 Apr 2012
 17:09:19 -0400 (EDT)
In-Reply-To: <4F7C787A.6050905@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Wed, 04 Apr 2012 18:36:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 71B5B6BC-7E9A-11E1-9596-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194741>

Zbigniew J=C4=99drzejewski-Szmek  <zbyszek@in.waw.pl> writes:

> what is the best way to display merge commits of two branches with
> separate roots?
> ...
> % git log --oneline --follow -- src/udevd.c
> 4309599 warn about deprecated RUN+=3D"socket:" use
> e64fae5 udevd: kill hanging event processes after 30 seconds
> 912541b tabs are as useful as a hole in the head
> ad29a9f merge udev/, libudev/, systemd/ files in src/; move extras/ t=
o src/
> ...
>
> [src/udev/src/udevd.c is the original path]

I am absolutely sure I wrote on how to look at gitk and gitweb part of =
the
history on this list in the past few months, but my archive digging ski=
ll
seems to be failing me today X-<.

I'd do something like this

	(
		echo ^v1.7.9
		git rev-list --first-parent --parents \
                	v1.7.9..master -- gitk-git |
	        sed -e 's/.* //'
	) | xargs git log

when I want to see a more detailed history than

	git log v1.7.9..master -- gitk-git

would give me.  The inner rev-list grabs the tips of the gitk history a=
s
of each merge points between v1.7.9..master, and the first echo ^v1.7.9
excludes the part of gitk history that were already in v1.7.9.

> Is there a way to follow the history also in the subtree?

In any case, from the point of view of the history that is merged into =
the
other history as its subpart, each and every merge looks like a humongo=
us
rename with bunch of new additions.  It is a known limitation of the
"subtree" merge, which was an ugly hack I invented before submodules ha=
ve
become ready.  It does not help that the "--follow" is merely a checkbo=
x
hack and does not keep track of different set of paths for each individ=
ual
traversal point is digging the history for; improving "--follow" to do =
so
will make it more useful but nobody has bothered.
