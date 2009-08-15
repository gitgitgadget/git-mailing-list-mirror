From: Junio C Hamano <gitster@pobox.com>
Subject: Re: jc/shortstatus
Date: Sat, 15 Aug 2009 14:23:23 -0700
Message-ID: <7v7hx4bwl0.fsf@alter.siamese.dyndns.org>
References: <7vtz0co3xe.fsf@alter.siamese.dyndns.org>
 <20090815070904.GA23389@coredump.intra.peff.net>
 <7v8whltrqj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 15 23:23:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McQiw-0007XA-AC
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 23:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbZHOVX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2009 17:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbZHOVX3
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Aug 2009 17:23:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbZHOVX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2009 17:23:28 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5BCAB2A6AF;
	Sat, 15 Aug 2009 17:23:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 46A162A6AD; Sat, 15 Aug 2009
 17:23:24 -0400 (EDT)
In-Reply-To: <7v8whltrqj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 15 Aug 2009 01\:18\:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DFD23B08-89E1-11DE-8AA7-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126030>

Junio C Hamano <gitster@pobox.com> writes:

> A few points I haven't managed to think about, decide, nor test, are:
>
>  - What should its exit code be?  Should it be consistent with the
>    traditional "git status" at least when no paths are given, signallying
>    failure when nothing is staged for committing, so that ancient out of
>    tree scripts people may have written would not break too badly when we
>    make the switch?
>
>  - What should its default mode of output be?  Do people prefer "svn st"
>    style short-format output, or should we stay verbose and explanatory?
>
>  - Is it handling corner cases correctly?  e.g. Does it operate correctly
>    when run from a subdirectory?  How should it handle submodules?  Before
>    the initial commit?  Use of colors?

Just a quick status update, lest others waste too much time staring at the
series I posted last night.

 - Leading and trailing comments (e.g. "On branch foo", "Initial commit",
   "# No changes", ...) were missing.
 - Did not honor -v to show "diff --cached".
 - Subdirectory behaviour (status.relativepath configuration) was broken.

I have a version that fixes the above, and exits 0 when there is no error
(i.e. does not exit non-zero on clean index).  There are existing tests
that expect "git status" erroring out on clean index and there are some
that depends on "git status paths..." to show preview of a partial commit,
which needed to be replaced with "git commit --dry-run", but as far as I
can tell, I've took care of them all.

I am still feeling uneasy about the exit status change (the test scripts
are sources of how people who script around git take their inspirations
after all), but I'll send the result out for a review later without
changing that back to "exit failure when there is nothing to commit".
