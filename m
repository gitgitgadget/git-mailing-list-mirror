Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27B6C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64CD2206BF
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 16:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Q78Q9JmT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgD0Q1z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727104AbgD0Q1z (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 12:27:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7194C0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:27:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so7169843plo.7
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GsxVJfJFxd1aK9rUuAOF5ahCKbKGkOBxjVO0W39Hz5Y=;
        b=Q78Q9JmTUt251ngs7rF1rWLvw4BbIHE2hBXQuYZB2IBIia+dBp7QQFBcYhCtY5EwnO
         2UzctfpmLb33fsc+7Nrc72nBbMUAYi3s5O75SdgNt0wCvt7cssvMEZNqKP9qilLQByoy
         zfdPL7V3tsaXA+lUWS0jK+4sSxU7NTtntLZhU3QZouvfzLHmWyjpwibPWV0WutEdaJQB
         +1F6dz1K6dFWcE+9hbvfFhCsSZkjsQQMNTEGjT4eXjBDuSI3wDGJFQEmMzrunRlUlP/w
         Z1PvUPy5piDKFLxB8/6h6G+g96d0MALIoaSA/OmgsPNpJPv+BXkeRR1uMIKwrJCKbZu2
         UnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GsxVJfJFxd1aK9rUuAOF5ahCKbKGkOBxjVO0W39Hz5Y=;
        b=Cr3JrQeugnqp9RZNiQZ9MbgVaKcAQVARQ+AqxUTA2+bqpp0BjC2Z+YZRYIIFCrfo8y
         kRBKVzB21dTebMigSD3FBixfyhaze7MmUFku3s4xJxrdj9e/NHAGGGo1cBhoQGwbgTdM
         +P1Dvp6rxRIYHbGl7dQGua0lkYNFY6xXdzYlRygLiqxDbACEA8+Snnfi9ZzoG445dxP+
         ZZ+q6JuuduGVgcqPxdCPRQK/XF3J6pNVQlRIViZVBU67dgACkXUg9WD530S/xFP5FELE
         SdIi2D0Mg9C+COvyrMPDHQd/6Go99Bp+0VW7xL7xpbDqBhxvymb5mQmwSAADOjb5tklX
         ByQA==
X-Gm-Message-State: AGi0PuYhfIRbPRnvDty8ifSNcPAjFBxa5PuU6fNcYHJRsHfqtDvNGvBh
        QefTQPz6rr5BFfY53TIjDmFk4+Ok0LK1uw==
X-Google-Smtp-Source: APiQypI2oJCYNxcyockzt+wa0j4NlLjCZLK8MpcmyomSxFk5oojMsHL1uCiouxeoWwH6Oqp76FioSQ==
X-Received: by 2002:a17:902:bd02:: with SMTP id p2mr11457771pls.72.1588004872609;
        Mon, 27 Apr 2020 09:27:52 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id e7sm13222580pfh.161.2020.04.27.09.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:27:51 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:27:49 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        mhagger@alum.mit.edu
Subject: [PATCH v2 0/4] commit-graph: write non-split graphs as read-only
Message-ID: <cover.1588004647.git.me@ttaylorr.com>
References: <cover.1587422630.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1587422630.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's an updated version of my series to resolve a difference between
the permissions that split- and non-split commit-graphs are written
with.

Not much has changed since last time, since the main discussion revolved
around differences between what mode the user passes and how that
interacts with 'adjust_shared_perm' as well as why split-graphs are
always read-only for everybody.

Patches 1-3 remain mostly the same, with only some additional
documentation in the patches and headers about the interaction between
the 'mode' parameter and the umask and 'core.sharedRepository'. The
fourth patch is new, and makes sure that split-graphs are also
respecting 'core.sharedRepository' (and never have permissions above
0444).

The end-state of this is that both split- and non-split graphs have at
most permission 0444, and both respect core.sharedRepository.

Thanks in advance for another look.


Taylor Blau (4):
  tempfile.c: introduce 'create_tempfile_mode'
  lockfile.c: introduce 'hold_lock_file_for_update_mode'
  commit-graph.c: write non-split graphs as read-only
  commit-graph.c: ensure graph layers respect core.sharedRepository

 commit-graph.c                |  9 ++++++++-
 lockfile.c                    | 18 ++++++++++--------
 lockfile.h                    | 32 ++++++++++++++++++++++++++++----
 t/t5318-commit-graph.sh       | 11 ++++++++++-
 t/t5324-split-commit-graph.sh | 18 ++++++++++++++++++
 t/t6600-test-reach.sh         |  2 ++
 tempfile.c                    |  6 +++---
 tempfile.h                    | 10 +++++++++-
 8 files changed, 88 insertions(+), 18 deletions(-)

Range-diff against v1:
1:  aa86e8df40 ! 1:  03c975b0bd tempfile.c: introduce 'create_tempfile_mode'
    @@ Commit message
         creates a temporary file with global read-write permissions, introduce a
         variant here that allows specifying the mode.

    +    Note that the mode given to 'create_tempfile_mode' is not guaranteed to
    +    be written to disk, since it is subject to both the umask and
    +    'core.sharedRepository'.
    +
         Arguably, all temporary files should have permission 0444, since they
         are likely to be renamed into place and then not written to again. This
         is a much larger change than we may want to take on in this otherwise
    @@ tempfile.c: static void deactivate_tempfile(struct tempfile *tempfile)

      ## tempfile.h ##
     @@ tempfile.h: struct tempfile {
    +  * Attempt to create a temporary file at the specified `path`. Return
       * a tempfile (whose "fd" member can be used for writing to it), or
       * NULL on error. It is an error if a file already exists at that path.
    ++ * Note that `mode` will be further modified by the umask, and possibly
    ++ * `core.sharedRepository`, so it is not guaranteed to have the given
    ++ * mode.
       */
     -struct tempfile *create_tempfile(const char *path);
     +struct tempfile *create_tempfile_mode(const char *path, int mode);
2:  dad37d4233 ! 2:  c1c84552bc lockfile.c: introduce 'hold_lock_file_for_update_mode'
    @@ Commit message
         functions, and leave the existing functions alone by inlining their
         definitions in terms of the new mode variants.

    -    Note that even though the commit-graph machinery only calls
    +    Note that, like in the previous commit, 'hold_lock_file_for_update_mode'
    +    is not guarenteed to set the given mode, since it may be modified by
    +    both the umask and 'core.sharedRepository'.
    +
    +    Note also that even though the commit-graph machinery only calls
         'hold_lock_file_for_update', that this is defined in terms of
         'hold_lock_file_for_update_timeout', and so both need an additional mode
         parameter here.
    @@ lockfile.c: NORETURN void unable_to_lock_die(const char *path, int err)
      			unable_to_lock_die(path, errno);

      ## lockfile.h ##
    +@@
    +  * functions. In particular, the state diagram and the cleanup
    +  * machinery are all implemented in the tempfile module.
    +  *
    ++ * Permission bits
    ++ * ---------------
    ++ *
    ++ * If you call either `hold_lock_file_for_update_mode` or
    ++ * `hold_lock_file_for_update_timeout_mode`, you can specify a suggested
    ++ * mode for the underlying temporary file. Note that the file isn't
    ++ * guaranteed to have this exact mode, since it may be limited by either
    ++ * the umask, 'core.sharedRepository', or both. See `adjust_shared_perm`
    ++ * for more.
    +  *
    +  * Error handling
    +  * --------------
     @@ lockfile.h: struct lock_file {
    -  * timeout_ms is -1, retry indefinitely. The flags argument and error
    -  * handling are described above.
    +  * file descriptor for writing to it, or -1 on error. If the file is
    +  * currently locked, retry with quadratic backoff for at least
    +  * timeout_ms milliseconds. If timeout_ms is 0, try exactly once; if
    +- * timeout_ms is -1, retry indefinitely. The flags argument and error
    +- * handling are described above.
    ++ * timeout_ms is -1, retry indefinitely. The flags argument, error
    ++ * handling, and mode are described above.
       */
     -int hold_lock_file_for_update_timeout(
     +int hold_lock_file_for_update_timeout_mode(
3:  622fd92cee ! 3:  86cf29ce9c commit-graph.c: write non-split graphs as read-only
    @@ Commit message
         commit-graph.c: write non-split graphs as read-only

         In the previous commit, Git learned 'hold_lock_file_for_update_mode' to
    -    allow the caller to specify the permission bits used when acquiring a
    -    temporary file.
    +    allow the caller to specify the permission bits (prior to further
    +    adjustment by the umask and shared repository permissions) used when
    +    acquiring a temporary file.

         Use this in the commit-graph machinery for writing a non-split graph to
         acquire an opened temporary file with permissions read-only permissions
         to match the split behavior. (In the split case, Git uses
    -    'git_mkstemp_mode' for each of the commit-graph layers with permission
    +    git_mkstemp_mode' for each of the commit-graph layers with permission
         bits '0444').

         One can notice this discrepancy when moving a non-split graph to be part
-:  ---------- > 4:  f83437f130 commit-graph.c: ensure graph layers respect core.sharedRepository
--
2.26.0.113.ge9739cdccc
