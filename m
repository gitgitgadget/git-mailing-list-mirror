From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Fri, 20 Nov 2009 01:44:48 -0800
Message-ID: <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
References: <1258681154-2167-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 10:45:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBQ36-0006Fn-AP
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 10:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753384AbZKTJow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 04:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbZKTJow
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 04:44:52 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46440 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbZKTJov (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 04:44:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 05A6B81BA5;
	Fri, 20 Nov 2009 04:44:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=1iziGk9d3XuRkXzztSMiF3BqIAE=; b=I5nMauNUcG7tTnVOk8hKsyM
	4y41xyoAjH/KEwhN+yiV2sIHdMNwnnOdy8cwa3wI8SbPLFwN6m3fdcl+qfXCHKfw
	2idES0lOYQj1IFNVvGgo5IkHWeQ7y8tNt/WMH38362A4kMdZG9wWNiEk6SERfbbS
	9u3FJwBxcr8BaBM4zzYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=W45m+WYSkiAgLxpxYv4KUAyP+wwv8M1B7juEMzwWVVRjTBwZa
	4yiwp5t3R7oFGKjm02jjwOI7YZQrZbMGlLVECQ5DvQLl6eLP+uPW3dbFrxVE/p25
	PTgXkhLWLCdIqFa5EhO2S+cFa2/lXaiYsaQaC2Jw8boe0VlNTlkctsxHCA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9A9B81BA4;
	Fri, 20 Nov 2009 04:44:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B27A781BA3; Fri, 20 Nov
 2009 04:44:49 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5ACAF5C0-D5B9-11DE-906F-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133320>

Johan Herland <johan@herland.net> writes:

> Here is the 8th iteration of the git-notes series. Changes in this
> iteration are as follows:
>
> Changes to existing patches:
> - Rebased onto current 'next', dropping the early part of this series
>   which has now been merged to 'next'.
> - Patch 8 (was patch 22): Major rewrite of fast-import's notes handling
>   code based on comments from Shawn.
>
> New patches:
> - Patch 9: Rename t9301 to t9350, to make room for more fast-import tests
> - Patch 10: More fast-import tests
>
> TODO:
> - Builtin-ify git-notes shell script to take advantage of notes API
> - Garbage collect notes whose referenced object is unreachable (gc_notes())
> - Handle note objects that are not blobs, but trees

Thanks.

While I try my best not to break other people's patches while applying, I
prefer to see a re-rolled series based on the same commit while replacing
an existing series, unless the re-roll truly depends on the newer base, so
that people can more easily see what got updated.

So here is what I did tonight.

Step 0.  Apply as you specified on top of 'next'

    $ git checkout next^0
    $ git am -s your-10-patches
    $ M=$(git describe)

Step 1.  Rebase back to the bottom of the old series

    $ git checkout next...jh/notes
    $ git rebase --onto HEAD next $M
    $ N=$(git describe)

Step 2.  Compare old and new series

    $ git show-branch jh/notes HEAD
    $ for i in 7 6 5 4 3 2 1 0
      do
        git diff jh/notes~$i HEAD~$(( $i + 2 ))
      done
    $ make -j test

Step 3.  Make sure the result is what you intended to feed me.

    $ git merge next
    $ git diff $M

Step 4.  Replace the tip of jh/notes

    $ git branch -f jh/notes $N
