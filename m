From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] builtin-remote: add set-head verb
Date: Fri, 13 Feb 2009 02:35:51 -0800
Message-ID: <7vhc2yaak8.fsf@gitster.siamese.dyndns.org>
References: <1234515275-91263-1-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-2-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-3-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-4-git-send-email-jaysoffian@gmail.com>
 <1234515275-91263-5-git-send-email-jaysoffian@gmail.com>
 <7vtz6yabsy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, barkalow@iabervon.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 11:37:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXvQI-0002LY-LL
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 11:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbZBMKgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 05:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbZBMKgD
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 05:36:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZBMKgB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 05:36:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 59B092B097;
	Fri, 13 Feb 2009 05:35:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4D7CC2AA9C; Fri,
 13 Feb 2009 05:35:53 -0500 (EST)
In-Reply-To: <7vtz6yabsy.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 13 Feb 2009 02:09:01 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1A6C28C2-F9BA-11DD-A964-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109738>

Junio C Hamano <gitster@pobox.com> writes:

> Also it may be better to be more explicit about both the syntax and the
> semantics of `<branch>`.  Do you expect "refs/remotes/<name>/master" or
> just "master" (I assume the latter)?  Is it an error if the branch does
> not exist in the specified hierarchy?  Can you force to set to a branch
> that does not exist in your tracking side (yet) but you know exists on the
> remote side already?

A few things I forgot (and before I go to bed).

If remotes/<name>/HEAD already points at a branch frotz, and you peek the
remote (i.e. you do not actually run "fetch" to download objects, but just
"ls-remote" it) and find out that "HEAD" does not point at the same commit
as "frotz" but it now points at the same commit as another branch
"nitfol", you probably would want to update it to point at "nitfol", but
it was unclear from the description in the documentation if this option
was meant to perform this kind fo update, or only to set a missing HEAD.

If you meant to do an update, there is one thing to watch out for when you
reuse the logic used by clone.  It favors "master" if more than one
branches point at the same commit as HEAD.  You need to customize it to
favor the one that the HEAD points at on the local side before you start
(iow, try to keep the current value when you can).

For example, if it points at "frotz" locally when the command was started,
and you found out that HEAD now points at the commit at the tip of "frotz"
and "master" branches by peeking, you do not want to repoint HEAD from
"frotz" to "master".
