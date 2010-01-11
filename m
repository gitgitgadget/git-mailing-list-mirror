From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to check new commit availability without full fetch?
Date: Mon, 11 Jan 2010 11:20:59 -0800
Message-ID: <7vmy0kjvms.fsf@alter.siamese.dyndns.org>
References: <ee2a733e1001100312j786108fct1b4c8abd0acc5afc@mail.gmail.com>
 <201001110831.28278.robin.rosenberg@dewire.com>
 <7vljg5ukol.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001111257300.10143@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, SLONIK.AZ@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 20:21:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUPpH-0003LS-6V
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 20:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891Ab0AKTVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 14:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890Ab0AKTVO
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 14:21:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab0AKTVN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 14:21:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F3758FAC6;
	Mon, 11 Jan 2010 14:21:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lm+Jn+AVFyg4
	G8Zr0Fu1jGEn5RI=; b=JVScaZKi7VvxPcaayPVp9t9xzkwPQh+xVwv5itHWQVts
	GaGlvYCMmgLKBnV2ENZaC9bYSFSw6Qd+GWW1IzDDSXHVBj4P+GBzrqf2ihzCdssf
	Isk0BxLjXPx3p8BQKhkEg5AhUxcyiIhEV8aJjuNXn/HZBdLsTEl5eMJkOYD6NsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SV9sRk
	W46XhAItc+tAy7sitl6wZxAingY+2rKXlw8AFh41s+6wwFRKFOON1xrGjGVAKDVV
	bvvcs9PKTYPKST7smlnYn8xBEP+QyfFq71Xq9zK24g+S8wACkQ5UnMtzNFT98QUR
	5QqgU9t97m/Lrb21PR7PlEvC4ud+aAfwHfdAc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 258A58FAC5;
	Mon, 11 Jan 2010 14:21:06 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E8A08FAC3; Mon, 11 Jan
 2010 14:21:00 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001111257300.10143@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 11 Jan 2010 12\:59\:24 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 77113F72-FEE6-11DE-A42B-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136654>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Mon, 11 Jan 2010, Junio C Hamano wrote:
>
>> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>>=20
>> > s=C3=B6ndagen den 10 januari 2010 12.12.09 skrev  Leo Razoumov:
>> >> Hi List,
>> >> I am trying to find a way to check availability of new commits
>> >> *before* doing fetch or pull. Unfortunately, neither fetch nor pu=
ll
>> >> take "--dry-run" option (unlike push)
>> >
>> > Fetch has --dry-run. It's a fairly new option. The drawback is tha=
t it
>> > still does the fetch, but it does not update the refs. If you re.r=
un it
>> > again it'll be quicker.
>>=20
>> Doesn't that worry us if it really is quicker?
>>=20
>> If --dry-run doesn't update the refs, why do the objects that were
>> transferred by them not get asked the next time?  There must be a bu=
g
>> somewhere, but it is getting late already, so I'll leave it to exper=
ts in
>> the transfer area to figure it out...
>
> What about builtin-fetch.c:quickfetch() ?

Ahh, you are right.  It walks from objects the remote side told us are =
at
the tip, and stops at what we know are complete (i.e. reachable from ou=
r
tip of objects); immediately after --dry-run slurped objects, the next
fetch will prove everything is locally available and complete before go=
ing
over the network.

But either I am very confused or the use of fields from "struct ref" is
unintuitive in this codepath.

Why does it feed ref->old_sha1?  We are feeding _their_ tip commits to:

    rev-list --objects --stdin --not --all

and expecting it to report failure when some of their tip commits lead =
to
what we don't have yet.  The reason why we have old_sha1[] vs new_sha1[=
]
is because we want to report what changed from what, and also to protec=
t
us from simultaneous updates by doing compare-and-swap using the value =
we
read from our refs when we started in old_sha1[], so I would have expec=
ted
that ref_map elements would have _their_ commits on the new_sha1[] side=
,
but apparently that is not what is happening, and it has been this way =
for
a long time.  The use of old_sha1[] came from 4191c35 (git-fetch: avoid
local fetching from alternate (again), 2007-11-11), so it is a lot more
likely that I am confused than the code is wrong and nobody noticed so
far.

What am I missing?
