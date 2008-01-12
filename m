From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sat, 12 Jan 2008 14:48:52 -0800
Message-ID: <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 23:49:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDpAM-0000vm-M4
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 23:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759437AbYALWs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 17:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759383AbYALWs7
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 17:48:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759350AbYALWs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 17:48:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ACB58169C;
	Sat, 12 Jan 2008 17:48:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 10824169A;
	Sat, 12 Jan 2008 17:48:53 -0500 (EST)
In-Reply-To: <47893E1A.5020702@gmail.com> (Mark Levedahl's message of "Sat, 12
	Jan 2008 17:24:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70363>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Basically, I think an important (but not complete) test of the design
> is that
>
>    git clone -o frotz git://frotz.foo.bar/myproject.git
>    cd myproject
>    git submodule init
>    git submodule update
>
> work, with origin = frotz throughout the submodules, and with the
> whole project correctly checked out even if the entire project was
> rehosted onto a different server.

I like that.  This is a very good argument, especially because
it clarifies very well that the issue is not about "'submodule
init' misbehaves" but "fetch/pull/merge does not play well with
clone -o".

The only remaining (minor) doubt I have (not in the sense that
"I object to it!", but in the sense that "I wish there could be
a better alternative, but I do not think of one offhand") is
polluting the core.* namespace with this configuration variable.

Looking at Documentation/config.txt, I realize that we already
have made a mistake of allowing core.gitproxy, but other than
that single mistake, everything in core.* is still about things
that apply to the use of git even when the repository does not
talk with any other repository.  If we deprecate and rename away
that one mistake, we can again make core.* to mean things that
are _really_ core, but using core.origin for "the default remote
is not called 'origin' but 'frotz' here" is a step backwards
from that ideal.

But that's a minor naming issue.
