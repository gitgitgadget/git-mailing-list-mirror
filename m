From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 02/39] api-lockfile: revise and expand the documentation
Date: Fri, 26 Sep 2014 11:33:02 -0700
Message-ID: <xmqqlhp68c69.fsf@gitster.dls.corp.google.com>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
	<1411726119-31598-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 26 20:33:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXaKV-0002rP-BT
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 20:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbaIZSdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 14:33:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58782 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770AbaIZSdH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2014 14:33:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D72323C951;
	Fri, 26 Sep 2014 14:33:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OEdkfrBQlPrXsiFuOSWodky+RfM=; b=V+LydB
	lbdfJgnUj+MxjkVyfzS12vFcRocbkaw/XBhl0+uBg4rDZdr3OcivZK5n/YAu8uvi
	Q11GfERRpZ3rDIFFomU+BwQskrmfsTPBYDL9UzVBVrPAIeOCp0ZF62l1Cxl8y23p
	999/QSbOvrzeC9u14nAyAWmgHj2tutRGDtWK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WXBdiD7s0V8zyBEz22qjUt5mt2o4eplV
	TIxkCPxwWR/mXxt3B//wfgnBL90Z98nfO3qsHF9wdMaPgkUyY/Uz04tBK46Sw2Nk
	OTN6H32lOl6RRKdkvozBz+5fsAHvkWw3YpXJSKlGuZbVg/awajXjcBtvaUzoXtr5
	EkEo3f/duFI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB3A73C950;
	Fri, 26 Sep 2014 14:33:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 20D553C94F;
	Fri, 26 Sep 2014 14:33:04 -0400 (EDT)
In-Reply-To: <1411726119-31598-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 26 Sep 2014 12:08:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8D69332C-45AB-11E4-AE6A-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257548>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Document a couple more functions and the flags argument as used by
> hold_lock_file_for_update() and hold_lock_file_for_append().
> Reorganize the document to make it more accessible.
>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  Documentation/technical/api-lockfile.txt | 199 ++++++++++++++++++++++---------
>  1 file changed, 145 insertions(+), 54 deletions(-)

Nicely done.

> +* Mutual exclusion and atomic file updates. When we want to change a
> +  file, we create a lockfile `<filename>.lock`, write the new file
> +  contents into it, and then rename the lockfile to its final
> +  destination `<filename>`. We create the `<filename>.lock` file with
> +  `O_CREAT|O_EXCL` so that we can notice and fail if somebody else has
> +  already locked the file.


You may want to say

	then atomically rename the lockfile to its final destination
	to commit the changes and unlock the file.

here; that way, your mention of "commit" in the next paragraph would
become easier to understand.

> +* Automatic cruft removal. If the program exits after we lock a file
> +  but before the changes have been committed, we want to make sure
> +  that we remove the lockfile.




> +Calling sequence
> +----------------
> +
> +The caller:
> +
> +* Allocates a variable `struct lock_file lock` in the bss section or
> +  heap, initialized to zeros. It cannot be an auto variable allocated
> +  on the stack. Because the `lock_file` structure is used in an
> +  `atexit(3)` handler, its storage has to stay throughout the life of
> +  the program, even after the file changes have been committed or
> +  rolled back.

It is easier to read if you pushed the second sentence (which is a
rephrase of the first one) and third sentence (which explains why
the second sentence is true) out of line as a side-note, I think, or
probably remove them from here (see below).

> +* Attempts to create a lockfile by passing that variable and the path
> +  of the final destination (e.g. `$GIT_DIR/index`) to
> +  `hold_lock_file_for_update` or `hold_lock_file_for_append`.
> +
> +* Writes new content for the destination file by writing to the file
> +  descriptor returned by those functions (also available via
> +  `lock->fd`).
> +
> +When finished writing, the caller can:
> +
> +* Close the file descriptor and rename the lockfile to its final
> +  destination by calling `commit_lock_file`.
> +
> +* Close the file descriptor and remove the lockfile by calling
> +  `rollback_lock_file`.
> +
> +* Close the file descriptor without removing or renaming the lockfile
> +  by calling `close_lock_file`, and later call `commit_lock_file` or
> +  `rollback_lock_file`.
> +
> +At this point, the `lock_file` object must not be freed or altered,
> +because it is still registered in the `lock_file_list`. However, it
> +may be reused; just pass it to another call of
> +`hold_lock_file_for_update` or `hold_lock_file_for_append`.

It feels a bit conflicting between "must not be freed or ALTERED"
and "it may be REUSED".  Drop "or altered" to reduce confusion?  And
this repeats the third sentence I suggested to remove from the first
paragraph (above 'see below' refers here).

Is it allowed to tell the name of this lock_file to other people and
let them read from it?  The answer is yes but it is not obvious from
this description.

Also mention how the above interact with reopen_lock_file() here?

> +If the program exits before you have called one of `commit_lock_file`,
> +`rollback_lock_file`, or `close_lock_file`, an `atexit(3)` handler
> +will close and remove the lockfile, essentially rolling back any
> +uncommitted changes.

s/essentially //;

> +Error handling
> +--------------
> +
> +The `hold_lock_file_*` functions return a file descriptor on success
> +or -1 on failure (unless `LOCK_DIE_ON_ERROR` is used; see below). On
> +errors, `errno` describes the reason for failure. Errors can be
> +handled by passing `errno` to one of the following helper functions:

s/handled by/reported by/; probably.  None of these will help you
"handle" errors in the sense to (attempt to) recover from it.

> +unable_to_lock_message::
> +
> +	Append an appropriate error message to a `strbuf`.
> +
> +unable_to_lock_error::
> +
> +	Emit an appropriate error message using `error()`.
> +
> +unable_to_lock_die::
> +
> +	Emit an appropriate error message and `die()`.
