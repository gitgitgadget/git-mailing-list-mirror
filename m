From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 00/39] Lockfile correctness and refactoring
Date: Fri, 26 Sep 2014 12:10:05 -0700
Message-ID: <xmqqd2ai8agi.fsf@gitster.dls.corp.google.com>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 26 21:10:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXauO-0006tV-35
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 21:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753513AbaIZTKT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Sep 2014 15:10:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53658 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457AbaIZTKS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 15:10:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E98B13B345;
	Fri, 26 Sep 2014 15:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UcerEOPEaQ7g
	AWrc5vyXHv6dT48=; b=EJ4Rz69y/bhcdKhVsdTdLZUe/fZs5hSns0A4dhP6DDBc
	5h/jNi+3RkuPZIcCTjsQ4ZvDMl3unSt+wtOc9S7TKCbZ3Yfx1U+qDyVB93l5bAbn
	BxKRudTGKpQzPjtXSBOwzwVqfg8ljteiPfk2eb6Mn1nTYJXYFy7MCQ9QktpfNTE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cTR7Nk
	U/whB/haTyA1XiRsnNHzibZWFg52v4U+pZnS8N9jXlg+CgYpVG8p+4vOkSU4Qa7d
	RRMA0VAnNJMF1jM+VRst4VxbsWMImdmMGXrAYRvodSeqNiHWbp6PH5u5vb05IVh/
	LIptQA4Rrii/4Phxx5ygu323T6CdM7CVeYm/c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B1BB3B340;
	Fri, 26 Sep 2014 15:10:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8A2493B339;
	Fri, 26 Sep 2014 15:10:06 -0400 (EDT)
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 26 Sep 2014 12:08:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA150220-45B0-11E4-9888-D931C4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257550>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Next iteration of my lockfile fixes and refactoring. Thanks to
> Jonathan Nieder and Torsten B=C3=B6gershausen for their comments abou=
t v5.
>
> I believe that this series addresses all of the comments from v1 [1],
> v2 [2], v3 [3], v4 [4], and v5 [5].

Looked quite good.  Will replace---let's aim to merge this topic to
'next' soonish.

Thanks.

>
> Changes since v4:
>
> * Revise API documentation.
>
> * Split out a separate header file for the lockfile API: lockfile.h.
>
> * Change close_lock_file() to rollback on errors and make it into a
>   NOOP if the file is already closed.
>
> * Don't set lk->on_list until the lock_file object is completely on
>   the lock_file_list.
>
> * Delete some information from the docstring in lockfile.c (now
>   lockfile.h) that is redundant with the API docs in api-lockfile.txt=
=2E
>
> * Remove the accidental extra call of git_config_clear() in
>   git_config_set_multivar_in_file() when commit_lock_file() fails.
>
> * Adjust some comments, error messages, and commit messages.
>
> * Rebase to current master.
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/245609
> [2] http://thread.gmane.org/gmane.comp.version-control.git/245801
> [3] http://thread.gmane.org/gmane.comp.version-control.git/246222
> [4] http://thread.gmane.org/gmane.comp.version-control.git/256564
> [5] http://thread.gmane.org/gmane.comp.version-control.git/257159
>
> Michael Haggerty (39):
>   unable_to_lock_die(): rename function from unable_to_lock_index_die=
()
>   api-lockfile: revise and expand the documentation
>   close_lock_file(): exit (successfully) if file is already closed
>   rollback_lock_file(): do not clear filename redundantly
>   rollback_lock_file(): exit early if lock is not active
>   rollback_lock_file(): set fd to -1
>   lockfile: unlock file if lockfile permissions cannot be adjusted
>   hold_lock_file_for_append(): release lock on errors
>   lock_file(): always initialize and register lock_file object
>   lockfile.c: document the various states of lock_file objects
>   cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
>   delete_ref_loose(): don't muck around in the lock_file's filename
>   prepare_index(): declare return value to be (const char *)
>   write_packed_entry_fn(): convert cb_data into a (const int *)
>   lock_file(): exit early if lockfile cannot be opened
>   remove_lock_file(): call rollback_lock_file()
>   commit_lock_file(): inline temporary variable
>   commit_lock_file(): die() if called for unlocked lockfile object
>   close_lock_file(): if close fails, roll back
>   commit_lock_file(): rollback lock file on failure to rename
>   api-lockfile: document edge cases
>   dump_marks(): remove a redundant call to rollback_lock_file()
>   git_config_set_multivar_in_file(): avoid call to rollback_lock_file=
()
>   lockfile: avoid transitory invalid states
>   struct lock_file: declare some fields volatile
>   try_merge_strategy(): remove redundant lock_file allocation
>   try_merge_strategy(): use a statically-allocated lock_file object
>   commit_lock_file(): use a strbuf to manage temporary space
>   Change lock_file::filename into a strbuf
>   resolve_symlink(): use a strbuf for internal scratch space
>   resolve_symlink(): take a strbuf parameter
>   trim_last_path_component(): replace last_path_elm()
>   Extract a function commit_lock_file_to()
>   Rename LOCK_NODEREF to LOCK_NO_DEREF
>   lockfile.c: rename static functions
>   get_locked_file_path(): new function
>   hold_lock_file_for_append(): restore errno before returning
>   Move read_index() definition to read-cache.c
>   lockfile.h: extract new header file for the functions in lockfile.c
>
>  Documentation/technical/api-lockfile.txt | 220 ++++++++++++++++++---=
---
>  builtin/add.c                            |   1 +
>  builtin/apply.c                          |   1 +
>  builtin/checkout-index.c                 |   2 +-
>  builtin/checkout.c                       |   2 +-
>  builtin/clone.c                          |   1 +
>  builtin/commit.c                         |  17 +-
>  builtin/describe.c                       |   1 +
>  builtin/diff.c                           |   1 +
>  builtin/gc.c                             |   2 +-
>  builtin/merge.c                          |  16 +-
>  builtin/mv.c                             |   2 +-
>  builtin/read-tree.c                      |   1 +
>  builtin/receive-pack.c                   |   1 +
>  builtin/reflog.c                         |   4 +-
>  builtin/reset.c                          |   1 +
>  builtin/rm.c                             |   2 +-
>  builtin/update-index.c                   |   3 +-
>  bundle.c                                 |   1 +
>  cache-tree.c                             |   1 +
>  cache.h                                  |  20 +--
>  config.c                                 |  16 +-
>  credential-store.c                       |   1 +
>  fast-import.c                            |   5 +-
>  fetch-pack.c                             |   1 +
>  lockfile.c                               | 284 +++++++++++++++++----=
----------
>  lockfile.h                               |  84 +++++++++
>  merge-recursive.c                        |   1 +
>  merge.c                                  |   1 +
>  read-cache.c                             |  21 ++-
>  refs.c                                   |  30 ++--
>  rerere.c                                 |   1 +
>  sequencer.c                              |   1 +
>  sha1_file.c                              |   1 +
>  shallow.c                                |   7 +-
>  test-scrap-cache-tree.c                  |   1 +
>  36 files changed, 492 insertions(+), 263 deletions(-)
>  create mode 100644 lockfile.h
