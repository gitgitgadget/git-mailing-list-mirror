From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: add 'deinit' command
Date: Sun, 02 Dec 2012 23:58:37 -0800
Message-ID: <7vhao31s9e.fsf@alter.siamese.dyndns.org>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de>
 <20121130175309.GA718@odin.tremily.us>
 <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com>
 <50BA2892.7060706@web.de> <50BA3412.60309@web.de>
 <7vy5hhmcwp.fsf@alter.siamese.dyndns.org> <50BBB22A.7050901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 08:59:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfQvZ-0000ku-5o
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 08:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab2LCH6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 02:58:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48804 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768Ab2LCH6l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 02:58:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 686A7895A;
	Mon,  3 Dec 2012 02:58:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=OSn6ezJUAg1979X/foI1VEJlIlU=; b=mygriGpDwr7yDEHfodeu
	0kEvyFWFZAh3VIbXhK5dHtgD3g5dkhAf+yTU8/gO9RMVci6HNyBa71sAU1hQuAAZ
	2nrn7gCD7wQG3YpGf6N0J6R0HR+DyHuuZafEwl+nEkIU2g2gdyT0Pl3GdFfQxpT6
	chdGTShWngwkxxOjZqqlXtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=v8v3FHevhgwYPFRfG7oz+OkekA1rjsANfSGQWt8sr4iC7y
	Yfy0rplN5I2TRlN1krRaBZshp/Rz++pOpY6lIlvx7IpZEtYszOuQ1n7j1FD0SGGi
	S1d0qJ5ZIJKo3eN+uyJ6u/LOpCVtT8AXn/XvBrKZyxTpoIpUQqrjJwfFAMal4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5470D8959;
	Mon,  3 Dec 2012 02:58:40 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BBE4D8958; Mon,  3 Dec 2012
 02:58:39 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3FCA5D30-3D1F-11E2-B601-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211032>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Maybe the principle of least surprise is better followed when we
> nuke the whole section, as it might surprise the user more to have
> a setting resurrected he customized in the last life cycle of the
> submodule than seeing that after an deinit followed by an init all
> former customizations are consistently gone. So I tend to think now
> that removing the whole section would be the better solution here.

I tend to agree; I suspect that a "deinit" would be mostly done
either to

 (1) correct mistakes the user made during a recent "init" and
     perhaps "sync"; or

 (2) tell Git that the user has finished woing with this particular
     submodule and does not intend to use it for quite a while.

For both (1) and (2), I think it would be easier to users if we gave
them a clean slate, the same state as the one the user who never had
ran "init" on it would be in.  A user in situation (1) is asking for
a clean slate, and a user in situation (2) is better served if he
does not have to worry about leftover entries in $GIT_DIR/config he
has long forgotten from many months ago (during which time the way
the project uses the particular submodule may well have changed)
giving non-standard experience different from what other project
participants would get.

If there were a sane workflow where it makes sense to frequently run
"deinit" followed by some operation followed by "init", it may be
helpful to have an option to keep the other customization.  And one
consideration when implementing that "deinit --keep-customization"
option might be to introduce the submodule.$name.activated boolean;
that way, the operation can keep the customized upstream URL.

In any case, it needs to be shown that such a workflow exists in the
first place to justify "deinit --keep-customization".  I think the
default should be to remove the submodule.$name section.
