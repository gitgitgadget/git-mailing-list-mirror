From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 00/25] refs backend pre-vtable
Date: Tue,  3 Nov 2015 08:39:44 +0100
Message-ID: <cover.1446534991.git.mhagger@alum.mit.edu>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:40:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWCc-00078B-5F
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbbKCHkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:40:17 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62314 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751433AbbKCHkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:40:16 -0500
X-AuditID: 1207440c-f79e16d000002a6e-cf-563864df9a2e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 85.28.10862.FD468365; Tue,  3 Nov 2015 02:40:15 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDcv016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:14 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsUixO6iqHs/xSLM4M8yXYuuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7Y834+c8FjhYp986wbGPdJ
	djFyckgImEjM/faNCcIWk7hwbz1bFyMXh5DAZUaJOT+es0I4x5gktm3/wwpSxSagK7Gopxms
	Q0RATWJi2yEWEJtZwEFi8+dGRhBbWMBQ4unu82A2i4CqxORZM9lAbF4Bc4nVU98zQmyTk5hy
	vx1sDqeAp8S9Y+vA4kICHhKNV2ayTmDkXcDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11Av
	N7NELzWldBMjJFR4djB+WydziFGAg1GJh/fHMvMwIdbEsuLK3EOMkhxMSqK862IswoT4kvJT
	KjMSizPii0pzUosPMUpwMCuJ8BYEAuV4UxIrq1KL8mFS0hwsSuK8qkvU/YQE0hNLUrNTUwtS
	i2CyMhwcShK8s5OBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBkRFfDIwNkBQP
	0N6VIO28xQWJuUBRiNZTjLocT+Zf2sMkxJKXn5cqJc47GaRIAKQoozQPbgUsMbxiFAf6WJh3
	IkgVDzCpwE16BbSECWhJ+DZTkCUliQgpqQZGEW2HqNu10et3+/SI+iyQ2eUcfK80kUtXPnqR
	lomCLOcRkav/m6/HfPZV7kpRkeHcxXA2J+cFZ0UMk9C/BSp1bQLFMgHvNszrTnE1r9W/fXdR
	oHHZ00mnbM+/svw6ack/kdsRM2fysnPcmWI/YePpt5I+sqXKzRc5l4ZtcX82u1Ig 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280754>

This is a proposed revision of David Turner's refs-backend-pre-vtable
v5 [1]. It incorporates all of the changes I suggested when reviewing
that series, plus it moves the refs-related code to a subdirectory and
creates a new header file refs/refs-internal.h for declarations meant
to be used within the refs module but not by other code. I've retained
the authors of the original patches because most of what I've done is
just shift things around and adjust some includes and comments
accordingly.

This branch proposes the following file layout for the refs module:

    refs.h
    refs/refs.c
    refs/refs-internal.h
    refs/files-backend.c
    refs/lmdb-backend.c   <- suggested name for the upcoming LMDB code

I changed the name of "refs-be-files.c" to "refs/files-backend.c"
because otherwise the "refs" would have been redundant with the
subdirectory name, and now there is room in the filename to spell out
"backend".

Summary of changes in my branch vs. your v5:

* Rename refs-be-files.c to refs/files-backend.c
* Rename refs.c to refs/refs.c
* Introduce a new header file, refs/refs-internal.h, to hold
  declarations that are needed by other refs backends but shouldn't
  be used by non-refs code. The end result is that refs.h is almost
  unchanged by this series.
* Adjust commit messages for the new file locations.
* Instead of making verify_refname_available() public, move it to
  refs/refs-internal.h. (I think this function will only be needed
  by other refs backends and not by other code.) This change
  required your patch 03/26 to be moved later in the series.
* Add a missing LF in your patch 18/26.
* Touch up the log message and comments in your patch 25/26.
* Drop patch 26/26, Peff's "introduce "extensions" form of
  core.repositoryformatversion", as that patch is already in master.

These patches are also available as the `refs-backend-pre-vtable`
branch in my GitHub repo [2].

I don't want to hijack this patch series or anything, but it seemed
simpler to express my suggestions as code. Feel free to pick and
choose what you like and submit a v7 if that is your preference.

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/280325
[2] https://github.com/mhagger/git

David Turner (9):
  refs: make is_branch public
  refs: move transaction functions to the common code
  refs: move refname_is_safe to the common code
  refs: move copy_msg to the common code
  refs: move peel_object to the common code
  refs: move should_autocreate_reflog to common code
  initdb: make safe_create_dir public
  files_log_ref_write: new function
  refs: break out ref conflict checks

Ronnie Sahlberg (16):
  refs/files-backend.c: new file, renamed from refs.c
  refs: add a new file, refs/refs.c, to hold common refs code
  refs: move update_ref to refs/refs.c
  refs: move delete_pseudoref and delete_ref to the common code
  refs: move read_ref_at to the common refs file
  refs: move the hidden refs functions to the common code
  refs: move dwim and friend functions to the common refs code
  refs: move warn_if_dangling_symref* to the common code
  refs: move read_ref, read_ref_full and ref_exists to the common code
  refs: move resolve_refdup to common
  refs: move check_refname_format to the common code
  refs: move is_branch to the common code
  refs: move prettify_refname to the common code
  refs: move ref iterators to the common code
  refs: move head_ref_namespaced to the common code
  refs: create a shared version of verify_refname_available

 Makefile                       |    5 +-
 builtin/init-db.c              |   12 -
 cache.h                        |    8 +
 path.c                         |   12 +
 refs.h                         |    2 +
 refs.c => refs/files-backend.c | 1291 ++--------------------------------------
 refs/refs-internal.h           |  200 +++++++
 refs/refs.c                    | 1073 +++++++++++++++++++++++++++++++++
 8 files changed, 1348 insertions(+), 1255 deletions(-)
 rename refs.c => refs/files-backend.c (75%)
 create mode 100644 refs/refs-internal.h
 create mode 100644 refs/refs.c

-- 
2.6.2
