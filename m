From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Mon, 22 Mar 2010 13:19:11 -0700
Message-ID: <7vljdk85z4.fsf@alter.siamese.dyndns.org>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com>
 <3F619EAA-288D-4310-B9C6-8121FE00E7B0@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erick Mattos <erick.mattos@gmail.com>, git@vger.kernel.org
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 21:19:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nto5y-0007zG-Sn
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 21:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab0CVUTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 16:19:25 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab0CVUTY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 16:19:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA741A4CFC;
	Mon, 22 Mar 2010 16:19:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z+INg85FELNfYMHhS/cwB69SwTo=; b=QIImbm
	sqtTmHGfzlv09GvqqQEhjGA1pDOo1J3/dkSm505P++Kb35HDbhYwUn599cZiMLkC
	+sHM5/07YG3bMEIHAv+RayKcLAbvGq13R7fhr+l20todhb/fyYoFl1nWPuh3USo2
	UTRmNsujIBooQtxpiC3DKH/QUBmbuPz4v4Ss4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xo94fg90RvMFh98ghsFA5+yv3swIhvco
	B55ofArHIiYZFQUttZYiiu7QczSvAkpnFP4vwyqcNRQu2E4e41E1cvozmPnV2ZlG
	po2QPxDsYnIU3Cc0vASIZDVZteX/L5sENSxHGrhN+ANyONxEHUWMu6gXd7fd/N38
	nj7BNIawkwQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F683A4CF9;
	Mon, 22 Mar 2010 16:19:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B251A4CF2; Mon, 22 Mar
 2010 16:19:13 -0400 (EDT)
In-Reply-To: <3F619EAA-288D-4310-B9C6-8121FE00E7B0@pobox.com> (Chris
 Johnsen's message of "Mon\, 22 Mar 2010 07\:43\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 31DE6380-35F0-11DF-99C6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142963>

Chris Johnsen <chris_johnsen@pobox.com> writes:

> --orphan::
> 	Create a new, 'orphan' branch named <new_branch>, and start it
> 	at <start_point>. The first commit made on this new branch will
> 	have no parents (it will be the root of a new history that is
> 	not connected to any the other branches or commits).
> +
> An orphan branch allows you to start a new history that records a set of
> paths similar to <start_point>.

Strictly speaking, an orphan branch allows you to start a new history that
does not have any existing commit as its ancestry, and that is all there
to it.  While the "mostly common paths" aspect is worth mentioning, as it
is the use case it primarily targets, it is still secondary to the
description of "what it does."  "What it is used for" should come after
the reader is told "what it does."

It would probably be better to say that the index and the working tree is
kept intact during --orphan process as part of "what it does", before
talking about "mostly common paths":

	Create a new branch <new_branch> and switch to it.  The first
	commit you will make on this branch will become the root of a new
	history, disconnected from any of existing commits.  

	The index and the working tree is adjusted as if you ran "git
	checkout <start_point>" (without -b nor paths), to allow you to
	easily record the root commit of the new history that records a
	set of paths similar to <start_point>.

> This can be useful when you want to publish the tree from a commit
> without
> exposing its full history.
> You might want to do this to publish an open source branch of a project
> whose current tree is "clean", but whose full history contains
> proprietary
> or otherwise encumbered bits of code.

Good.

> +
> If you want to start a disconnected history that records a set of paths
> that is totally different from <start_point>, you may want to clear the
> index and the working tree after creating the orphan branch.
> Run `git rm -rf .` from the top level of the working tree, then prepare
> your new files by copying them from elsewhere, extracting a tarball, or
> otherwise populating the working tree.

Good, even though I am tempted to suggest rephrasing it further:

        If you want to start a disconnected history that records a set of
        paths that is totally different from <start_point>, you could
        clear the index and the working tree after creating the orphan
        branch by running `git rm -rf .` from the top level of the working
        tree.  Then prepare your new files by copying them from elsewhere,
        extracting a tarball, or otherwise populating the working tree.
	In general, however, it is cleaner and easier to create such an
        unrelated history in a separate repository than creating in the
        same repository.
