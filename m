From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/24] Add reflog_expire() to the references API
Date: Fri, 12 Dec 2014 12:58:30 -0800
Message-ID: <xmqqegs4bn61.fsf@gitster.dls.corp.google.com>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 12 21:58:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzXIR-00076r-AF
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 21:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966511AbaLLU6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 15:58:36 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757042AbaLLU6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 15:58:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 90098238E7;
	Fri, 12 Dec 2014 15:58:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nNcwLklksBZSMXv5KGo7pry0w6w=; b=uaWkvL
	aY9ufv8WpaAQRNa8CTeITI4NAFcynpIMyS9Fs2wKsZNWviBFSStZeiIW+h5F/FyU
	2wH//LoXlqsenWbQ8TYK3l3cB4tuWazv/62bjsw/ZjNkz27BnohxurhUzsqyHyR4
	Axlm3+Wq6ax8W19RBofzXD6vtl6JjY3Y95AkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dZIIZKF4Dr3ZElm4/b9PHEsjJXfMR5Iv
	axMXFVZJAKmBPW4cg440VCC8cZcZC4A7YmQOjgXhYtazTY+kkEarcEzkGj0s1XbL
	6vVHVgSuAPXfIp2ljORlsijq3UDiNnlnSQJp1tJ6jciYC/y7EgRsNJEfa4khhfkV
	7vwSo2c0sjk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86B6A238E6;
	Fri, 12 Dec 2014 15:58:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06006238E5;
	Fri, 12 Dec 2014 15:58:32 -0500 (EST)
In-Reply-To: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 12 Dec 2014 09:56:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1739B0A-8241-11E4-B4FE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261372>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This is v2 of the series. Thanks to Jonathan, Stefan, Junio, and
> Ronnie for their feedback on v1 [1]. I think I have addressed all of
> the issues that were raised.
>
> Changes since v1:
>
> * Several improvements to commit messages and comments; added some
>   Reviewed-by comments from the mailing list.
>
> * Change the signature of expire_reflog() early in the series to cast
>   off its heritage as an each_ref_fn.
>
> * Move the static lock_file object into expire_reflog(), and explain
>   the locking policy better.
>
> * Report errors if hold_lock_file_for_update() or fdopen_lock_file()
>   fails.
>
> * Fix the capitalization in some error messages.
>
> * When "enum expire_reflog_flags" is first introduced, put its
>   definition earlier in the file so that a later patch in the series
>   doesn't have to move it.
>
> * Rename reflog_expiry_select_fn to reflog_expiry_should_prune_fn.
>
> * Append Stefan's patch 24/24 "refs.c: let fprintf handle the
>   formatting"

All looked reasonable (three patches in the series somehow stood out
in a funny way in shortlog output, though).

Will queue.  I think a few topics from Stefan I have in 'pu' can
safely be dropped as the early part of this series has the same.

Thanks.


>
> This branch is also available on GitHub:
>
>     https://github.com/mhagger/git.git, branch reflog-expire-api-v2
>
> Michael
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/260812
>
> Michael Haggerty (18):
>   expire_reflog(): it's not an each_ref_fn anymore
>   expire_reflog(): rename "ref" parameter to "refname"
>   expire_reflog(): return early if the reference has no reflog
>   expire_reflog(): use a lock_file for rewriting the reflog file
>   Extract function should_expire_reflog_ent()
>   expire_reflog(): extract two policy-related functions
>   expire_reflog(): add a "flags" argument
>   expire_reflog(): move dry_run to flags argument
>   expire_reflog(): move updateref to flags argument
>   Rename expire_reflog_cb to expire_reflog_policy_cb
>   struct expire_reflog_cb: a new callback data type
>   expire_reflog(): pass flags through to expire_reflog_ent()
>   expire_reflog(): move verbose to flags argument
>   expire_reflog(): move rewrite to flags argument
>   Move newlog and last_kept_sha1 to "struct expire_reflog_cb"
>   expire_reflog(): treat the policy callback data as opaque
>   reflog_expire(): new function in the reference API
>   lock_any_ref_for_update(): inline function
>
> Ronnie Sahlberg (4):
>   refs.c: make ref_transaction_create a wrapper for
>     ref_transaction_update
>   refs.c: make ref_transaction_delete a wrapper for
>     ref_transaction_update
>   refs.c: add a function to append a reflog entry to a fd
>   refs.c: remove unlock_ref/close_ref/commit_ref from the refs api
>
> Stefan Beller (2):
>   refs.c: don't expose the internal struct ref_lock in the header file
>   refs.c: let fprintf handle the formatting
>
>  builtin/reflog.c | 259 ++++++++++++++++++++++--------------------------------
>  refs.c           | 263 ++++++++++++++++++++++++++++++++++++++-----------------
>  refs.h           |  75 ++++++++++------
>  3 files changed, 332 insertions(+), 265 deletions(-)
