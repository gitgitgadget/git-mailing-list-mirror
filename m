From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: allow initial sparse checkouts
Date: Mon, 24 Feb 2014 16:17:52 -0800
Message-ID: <xmqqmwhg6o5r.fsf@gitster.dls.corp.google.com>
References: <1393122713-4308-1-git-send-email-robbat2@gentoo.org>
	<CACsJy8BKJ4HzXLcajC8cXviD4hboRPOYhWSen7H5Ta=_JuXNjw@mail.gmail.com>
	<robbat2-20140223T072340-334493350Z@orbis-terrarum.net>
	<CACsJy8ApmVPAnhQmVAsFyXtV49S+9VULsEYZ7W3x7HMMoVtDzA@mail.gmail.com>
	<robbat2-20140223T204934-225383635Z@orbis-terrarum.net>
	<xmqqzjlg9zdn.fsf@gitster.dls.corp.google.com>
	<robbat2-20140224T214733-300290109Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Feb 25 01:18:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI5ij-0003u2-Bu
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 01:18:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753133AbaBYAR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 19:17:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbaBYAR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 19:17:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88E4E6FDAE;
	Mon, 24 Feb 2014 19:17:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YAj8NrdBEFNpiiqLWmhTqSSJ8hE=; b=UdTgA6
	otj7lhFuIxWD9LWX2sVOoE7yCLspt/yGJedvnlmEqpqeZtWQPWpjplkT3b81Ztwp
	FDhobuU2p9ithmtZweRHOWZoA+6pwyiOKWxN9GUx8wWdbYMBtfqR0iMvAAwnqMkw
	Q5c9ldP/rtZUNPmoq50kofmjmaxigsg2NrNGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R5bJxTHJllBgEq5TA2NRp91M0+MHZqL2
	1Fw51F0G2i8SJX9g/AHrti1BfaNKwtW5bXEyQX7gVi1YqrRUzI3fM7UPGjjol2+m
	PDU69kF0mqABmnchIb7Kv+Lv3aEg3LzOql0T/nXlGApkyrqSIzI8EY8WQ1CrxH4b
	gVChicxfJcw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E26E6FDAC;
	Mon, 24 Feb 2014 19:17:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86C336FDAB;
	Mon, 24 Feb 2014 19:17:54 -0500 (EST)
In-Reply-To: <robbat2-20140224T214733-300290109Z@orbis-terrarum.net> (Robin
	H. Johnson's message of "Mon, 24 Feb 2014 21:48:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 456A78AC-9DB2-11E3-94E2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242656>

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> On Mon, Feb 24, 2014 at 09:47:16AM -0800,  Junio C Hamano wrote:
>> "Robin H. Johnson" <robbat2@gentoo.org> writes:
>> > The only other clean alternative would be implementing ONLY
>> > --sparse-checkout-from, and letting uses use fds creatively:
>> > --sparse-checkout-from <(echo X; echo Y)
>> Not all POSIX shells have such an abomination that is process
>> substitution.  You can easily work it around by adopting the usual
>> convention to use "-" to read from the standasrd input, though.
>> 
>> 	(echo X; echo Y) | cmd --sparse-checkout-from -
> Is that a vote that you'd like to see a --sparse-checkout-from variant
> of my patch?

Honestly, I do not particularly care too much about this feature,
regardless of the interface [*1*].

It is just a vote that says "if --something-from form is going to be
implemented, it should be able to read from the standard input with
'-', unless there is a compelling reason not to do so".


[Footnote]

*1* In the longer term, I think sparse checkout is broken as a
concept and I view this "use sparse checkout from the get-go" merely
a stop-gap measure to make the band-aid a bit less painful to use.
What you really want is a narrow clone, which is conceptually cleaner
but a lot harder implentation-wise.

Not that keeping a band-aid usable longer is necessarily bad in the
real world, though---so even I said *I*'m not interested, that is
different from saying I'm not taking a patch on this topic.
