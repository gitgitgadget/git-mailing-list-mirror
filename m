From: Junio C Hamano <gitster@pobox.com>
Subject: Re: propagating repo corruption across clone
Date: Tue, 26 Mar 2013 20:47:27 -0700
Message-ID: <7vr4j1qzao.fsf@alter.siamese.dyndns.org>
References: <CACBZZX6czzJRF9TEsc8c+=LND6SxaVvrZdbcZ+TfUZTWQOpW0Q@mail.gmail.com>
 <20130324192350.GA20688@sigill.intra.peff.net>
 <CAOx6V3YtM-e8-S41v1KnC+uSymYwZw8QBwiCJRYw0MYJXRjj-w@mail.gmail.com>
 <20130325145644.GA16576@sigill.intra.peff.net>
 <CACsJy8A0eOWEJ2aqPSLof_CodJM6BadFxQHy5Vb0kAwwTSTS3w@mail.gmail.com>
 <20130325155600.GA18216@sigill.intra.peff.net>
 <CAOx6V3a6vGJvJ4HEmAXdTRKKCzRJS23OYd_em1b3aQLzPNEtQA@mail.gmail.com>
 <20130325200752.GB3902@sigill.intra.peff.net>
 <CAOx6V3ZWB1ZpmXcaBeSaPOvHqmAMF3U1rTXuwinFGmEZQwFGYQ@mail.gmail.com>
 <20130326165553.GA7282@sigill.intra.peff.net>
 <1364340037755-7580771.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rich Fromm <richard_fromm@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 04:48:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKhLF-0006HQ-Vq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 04:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595Ab3C0Drb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 23:47:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42509 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633Ab3C0Dra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 23:47:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8460A4C2;
	Tue, 26 Mar 2013 23:47:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ldPodPY77t4MpNp8G7VNWQ+vEn4=; b=itQZI9
	xbifD4NPKH1Bx7rvU1i+H7qG703LeHDz2Z87RC/9puzykNSoWpU4eTZ5qXAMXQ4p
	b9Zl/NzV+FLeC1uk/HrtmZXIsyzJPgLFNRJoYapfyar+lcvkWVfMjTuD6Te/gMfo
	KWcpVGaBvkDZWNBGWWt//00GAsfUJCUuBAgvk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CR2hZuQSVSFD7irORBRphfdJJWXid9g2
	ji6zHZIEhfz9woAd2GT7zYR9bFXhkLHMYWIyPypK+r/fdjJ9P7o8stKMZIj78Uw2
	xFT7zVuY5kg7VNS0xAYQF2pRRrcU7NiScJD2dAnGFAGxXgqTFlQUCXheR3kkXMkJ
	gB8GzHvlXXE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC4B3A4C1;
	Tue, 26 Mar 2013 23:47:29 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02C26A4BE; Tue, 26 Mar 2013
 23:47:28 -0400 (EDT)
In-Reply-To: <1364340037755-7580771.post@n2.nabble.com> (Rich Fromm's message
 of "Tue, 26 Mar 2013 16:20:37 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BFE83C0-9691-11E2-A68E-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219236>

Rich Fromm <richard_fromm@yahoo.com> writes:

> Jeff King wrote
>> Fundamentally the problem is
>> that the --local transport is not safe from propagating corruption, and
>> should not be used if that's a requirement.
>
> I've read Jeff Mitchell's blog post, his update, relevant parts of the
> git-clone(1) man page, and a decent chunk of this thread, and I'm still not
> clear on one thing.  Is the danger of `git clone --mirror` propagating
> corruption only true when using the --local option ?

If you use --local, that is equivalent to "cp -R".  Your corruption
in the source will faithfully be byte-for-byte copied to the
destination.  If you do not (and in your case you have two different
machines), unless you are using the long deprecated rsync transport
(which again is the same as "cp -R"), transport layer will notice
object corruption.  See Jeff's analysis earlier in the thread.

If you are lucky (or unlucky, depending on how you look at it), the
corruption you have in your object store may affect objects that are
needed to check out the version at the tip of the history, and "git
checkout" that happens as the last step of cloning may loudly
complain, but that just means you can immediately notice the
breakage in that case.  You may be unlucky and the corruption may
not affect objects that are needed to check out the tip. The initial
checkout will succeed as if nothing is wrong, but the corruption in
your object store is still there nevertheless.  "git log -p --all"
or "git fsck" will certainly be unhappy.

The difference between --mirror and no --mirror is a red herring.
You may want to ask Jeff Mitchell to remove the mention of it; it
only adds to the confusion without helping users.  If you made
byte-for-byte copy of corrupt repository, it wouldn't make any
difference if the first "checkout" notices it.

To be paranoid, you may want to set transfer.fsckObjects to true,
perhaps in your ~/.gitconfig.
