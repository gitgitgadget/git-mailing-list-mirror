From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "add -p" + filenames with UTF-8 multibyte characters = "No
 changes"
Date: Sun, 15 Feb 2009 20:00:03 -0800
Message-ID: <7v63jbf2v0.fsf@gitster.siamese.dyndns.org>
References: <2b8265360902151040t49711942udd4862cc9df01da5@mail.gmail.com>
 <87tz6vr0g4.fsf@iki.fi>
 <2b8265360902151100n2eca0182odf9543c1dd8a7f98@mail.gmail.com>
 <87prhjqzwb.fsf@iki.fi> <20090216033634.GA12461@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 16 05:01:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYufs-0004HN-81
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 05:01:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948AbZBPEAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 23:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbZBPEAL
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 23:00:11 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbZBPEAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 23:00:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 537B02B398;
	Sun, 15 Feb 2009 23:00:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6F0ED2B383; Sun,
 15 Feb 2009 23:00:05 -0500 (EST)
In-Reply-To: <20090216033634.GA12461@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 15 Feb 2009 22:36:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4D8B389E-FBDE-11DD-96F1-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110130>

Jeff King <peff@peff.net> writes:

> But what is the right encoding to specify? We can guess that it is
> whatever the commit message is in (defaulting to utf-8). It is by no
> means correct, but it would probably work pretty well in practice.
>
> On the other hand, we already have the same problem for encoded file
> _contents_. So maybe it is not a big problem in practice.

I did not spell the specifics out because this change won't happen in any
near future anyway, but my thinking was to give a way for "add -p" to
either (1) internally run without quotepath regardless of the user's
settings or (2) unquote the paths correctly when it learns the set of
paths affected by the change.

I think the right approach is (2), because you need to unquote pathnames
with some byte values that even with core.quotepath=false will not pass
unquoted *anyway*.

I also happen to think that it may be a good idea to ignore core.quotepath
settings in format-patch, but that is a separate topic.
