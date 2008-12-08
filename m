From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] diff: allow turning on textconv explicitly for
 plumbing
Date: Sun, 07 Dec 2008 19:55:12 -0800
Message-ID: <7vfxkz9v8f.fsf@gitster.siamese.dyndns.org>
References: <20081208025700.GB22072@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 08 04:57:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9XFR-0006Cl-OA
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 04:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716AbYLHDzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 22:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754542AbYLHDzT
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 22:55:19 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbYLHDzS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 22:55:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CB3C85233;
	Sun,  7 Dec 2008 22:55:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5539D85231; Sun,
  7 Dec 2008 22:55:14 -0500 (EST)
In-Reply-To: <20081208025700.GB22072@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 7 Dec 2008 21:57:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 067D56B4-C4DC-11DD-A334-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102525>

Jeff King <peff@peff.net> writes:

> I know this is not strictly a bugfix and we are in -rc, but:
>
>   1. It is an enhancement to a previously unreleased feature, and
>      shouldn't affect anything outside of that.
>
>   2. It affects the scripting interface to textconv, so I would like to
>      get it in before textconv is ever released so that it is always the
>      "right way" to turn text conversion off or on.

I'd agree with #1, especially if you said "doesn't" instead of
"shouldn't".

But I am not 100% sure if the scripting part is "the right way".

If a script wants to take whatever Porcelain users are happy as the
"presentation for human consumption" and pass that through as its own
output to the end user, maybe it is better off reading from Porcelain,
instead of reading from the plumbing (the latter of which requires making
the plumbing output less reliable)?

When we later enhance textconv output from the "diff" Porcelain to benefit
interactive users, it will automatically help the script that passes
through the "diff" output to the end users.

You can certainly argue that this "textconv" feature that is grafted from
Porcelain into plumbing is a special case in that its output is subject to
change any time to help human consumption and we never strive for its
stability as we do for other features in the plumbing to support machine
readability by scripts.  You can propagate the later enhancement of
textconv diff output we'd make for Porcelain to the scripted users that
reads from the plumbing that way.

But then wouldn't it be the same for these scripts that do value the
"presentation meant for human consumption" over "machine readability" to
read from Porcelain?  That would not have to blur the distinction between
the Porcelain and plumbing like the approach you are suggesting here.
