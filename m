From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] add: listen to --ignore-errors for submodule-errors
Date: Mon, 25 Jun 2012 21:09:45 -0700
Message-ID: <7v395iemt2.fsf@alter.siamese.dyndns.org>
References: <1340666519-41804-1-git-send-email-kusmabite@gmail.com>
 <7vfw9ieqvh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 26 06:14:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjN9v-0001dF-GI
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 06:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab2FZEKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 00:10:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111Ab2FZEJt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 00:09:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B21EE9C4B;
	Tue, 26 Jun 2012 00:09:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Yzmy4eubMZ8kNqg9Xi3iDd3INU=; b=qinkPx
	jFkPhTnL3Adh24LSml7tlvX93yyc3Tngbb2leQvFi56ko+w+XnKIBbJUg8nX5EGR
	ovc/Sv+T84NMSWbYTbCs5P8LSnTHhrm0hqYeQ09fGvvDGKLnKGnM5fceuSXM9xZo
	S5KMw/lq0HHdMmuqFcKT7DJosu30izPrUYkLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R7LAndosRCHZ06jlGPMDaNjUZIB5UlUe
	6ydpjYrPMAaW+krCoyfxQmmWHOk1LZgs8H1L59h5BuecG/tcxv8lh+DpvvnTHJNI
	Lq6U01M08krnSNQc/8SKsLFjm2gQoM4+npvYkUgZuPVP/rdFV1LftRzV66J70+YI
	DRY184OeDgQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 693E09C4A;
	Tue, 26 Jun 2012 00:09:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF7879C49; Tue, 26 Jun 2012
 00:09:46 -0400 (EDT)
In-Reply-To: <7vfw9ieqvh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 25 Jun 2012 19:41:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C44357B4-BF44-11E1-9808-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200627>

Junio C Hamano <gitster@pobox.com> writes:

> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> I recently tried to do the following in the msysGit-repo:
>>
>>  $ git add --ignore-errors -- */.gitignore
>>  fatal: Path 'src/git-cheetah/.gitignore' is in submodule 'src/git-cheetah'
>>
>> I was a bit puzzled by this; I explicitly specified --ignore-errors
>> because I did not want to be stopped due to src/git-cheetah/.gitignore
>> being located in a submodule.
>
> If I recall correctly, originally --ignore-errors was added was by
> those who (arguably misguidedly) wanted to randomly run "git add"
> that can potentially race with ongoing working tree updates
> (i.e. think of a poor-man's unreliable snapshotting filesystem), to
> which "git add" will notice that the working tree file it was asked
> to index changed while it was reading and error out.  Also on some
> systems, "git add" on files that are currently open may not be able
> to read from them, which would also cause a run-time error.  The
> kind of errors the option was meant to ignore were "these paths are
> perfectly OK to add, but for some reason, adding them fails at this
> moment, and for the purpose of poor-man's unreliable snapshot, it is
> OK not to pick the exact current state up, as we will pick it up the
> next round", not your kind of request that will lead to an error of
> the "adding this path will break the structural integrity of the
> repository and git should error out" kind.
>
>> The documentation seems to suggest that this is what is supposed to
>> happen, and this seems like the most likely behavior that the user
>> wanted. After all, there's no good reason submodules are special
>> in this regard, no?
>
> How does "git add .git" or "git add .git/config" behave with your
> patch applied?  It is exactly the same kind of error that breaks the
> structural integrity of the repository as adding src/cheetah/.gitignore
> to the top-level project repository, and there is no good reason to
> special case submodules, either.

For that matter, running "git add ../../foo" from the top-level of
the working tree falls into the same category.  There are boundaries
in both upward and downward directions that define the area you
could add to the index.

Now, I am not saying that "--ignore-errors" should _never_ mean to
ignore errors of this kind.  I was merely giving the historical
background for the semantics you are observing.  I personally think
it might even be an improvement if you made the option to instruct
the command to consistently ignore requests to add these paths
outside the working tree boundary in any direction (not just the
downwards boundary defined by the presense of a submodule, but the
downwards boundary defined by the ".git" directory, and the upward
boundary at the root of the working tree), and add only remaining
valid paths to the index.  I do not think it is the right thing to
special case only the submodules, though.
