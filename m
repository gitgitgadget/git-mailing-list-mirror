From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: Don't paginate by default with list command
Date: Tue, 30 Aug 2011 12:26:12 -0700
Message-ID: <7vk49u1z1n.fsf@alter.siamese.dyndns.org>
References: <4e5d1e5c.438d9c87.bm000@wupperonline.de>
 <20110830175748.GA19715@rdrz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>,
	git@vger.kernel.org
To: Raphael Zimmerer <killekulla@rdrz.de>
X-From: git-owner@vger.kernel.org Tue Aug 30 21:26:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyTx1-0008VA-5B
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 21:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756150Ab1H3T0R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 15:26:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754183Ab1H3T0Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Aug 2011 15:26:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E7AA473B;
	Tue, 30 Aug 2011 15:26:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bdvJt3UMUzFX
	g4u7B2Yurw6rSoc=; b=QcY3DESll4Baq9k9/Boco4ExY91wUCyWcKZRwyYxPaAG
	2hEZ5PiFgyApbUXS0ml+IIka8flfBtvGWU7KYaCsagxpL/nLco4M6qosODgbX6Hq
	Jo0UiJG00o9PT9S6Rd4ijYojG40+8MHui1ROVnxfZ8iFV2XHaUmM4+4NSiHZkwE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sO7kEg
	J8UjQJklSuspjyW8hvi/B2VixoiAVb8g/qXiLoCOIdK6sGNfvxOCfUHLLoebOYWP
	PfFtKoqyavUDmOMGLeS3+tjYqkHYz18XO3aDHAbo1Y4g6FLnjPmsPysZBQXq3IDe
	ybiNcM+QO6r5L3lWHJLtUJK+PwWVCC4qxU394=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2415E473A;
	Tue, 30 Aug 2011 15:26:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B52B4739; Tue, 30 Aug 2011
 15:26:14 -0400 (EDT)
In-Reply-To: <20110830175748.GA19715@rdrz.de> (Raphael Zimmerer's message of
 "Tue, 30 Aug 2011 19:57:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED0B18D8-D33D-11E0-AC9A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180436>

Raphael Zimmerer <killekulla@rdrz.de> writes:

> On Tue, Aug 30, 2011 at 07:21:18PM +0200, Ingo Br=C3=BCckl wrote:
>> The output of "stash list" is such that piping into a pager
>> normally isn't necessary but annoying, so disable it by default.
>
> Why is the current behaviour annoying?
>
> Here on my (default) setup the pager automatically exits if the entir=
e
> output can be displayed on the screen, as with any other git
> command.

Ben Walton pointed out exactly the same thing, but there needs one bit =
of
caution/consideration. If you tend to use longer and more descriptive
branch name (which is encouraged) and create a lazy stash without givin=
g
any message, the default description of the stash would need a fairly w=
ide
terminal window to fit on one line, e.g.

    "stash@{N}: WIP on some-long-ish-branch-name:" followed by
    "09997df a one line description of the commit your changes are made=
 on"

concatenated on the same line. "S" in "FRSX" (the default value of "LES=
S"
environment variable we give to those who do not have any) is a good th=
ing
to have while reviewing long-ish patches via "git log -p", but having a
long line that "S" causes to be chopped counts as not being able to sho=
w
the entire file on the first screen for the purpose of "F", and introdu=
ces
a minor irritation of having to exit explicitly with a 'q'.
