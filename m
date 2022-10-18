Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3066FC433FE
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 17:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJRRHa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Oct 2022 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJRRHW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2022 13:07:22 -0400
X-Greylist: delayed 254 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Oct 2022 10:06:14 PDT
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA0CEEA9C;
        Tue, 18 Oct 2022 10:06:14 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E54AD1D38EA;
        Tue, 18 Oct 2022 13:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=I
        kKmOpEPStNaMelI3cfGCmpw8kYhTIhBTRT5Mc3GJhY=; b=MLo2fRJqDKE3XJk7i
        gy85fmhVvaY4W+3ASZCZQ+OyjYtm+EaEmnZjqwtvMzzUxrsUcKUBdYyARX0av4nu
        dcmcNi2FtGR06MI6NDVFHV+j8wxDErLcwf6RK6mTjw94vIOg4dEkIDXcyXe78Oze
        Fd0ZYA+wY59QtCfaZ9RanPArfU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DE2821D38E9;
        Tue, 18 Oct 2022 13:01:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 94C171D38E8;
        Tue, 18 Oct 2022 13:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.38.1 and others
Date:   Tue, 18 Oct 2022 10:01:54 -0700
Message-ID: <xmqq4jw1uku5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92005E3E-4F06-11ED-9265-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A maintenance release v2.38.1, together with releases for older
maintenance tracks v2.30.6, v2.31.5, v2.32.4, v2.33.5, v2.34.5,
v2.35.5, v2.36.3, and v2.37.4, are now available at the usual
places.

These maintenance releases are to address the security issues
identified as CVE-2022-39253 and CVE-2022-39260.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the v2.38.1
tag, as well as the tags for older maintenance tracks for v2.30.6,
v2.31.5, v2.32.4, v2.33.5, v2.34.5, v2.35.5, v2.36.3, and v2.37.4.

  url = https://git.kernel.org/pub/scm/git/git
  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

CVE-2022-39253:
   When relying on the `--local` clone optimization, Git dereferences
   symbolic links in the source repository before creating hardlinks
   (or copies) of the dereferenced link in the destination repository.
   This can lead to surprising behavior where arbitrary files are
   present in a repository's `$GIT_DIR` when cloning from a malicious
   repository.

   Git will no longer dereference symbolic links via the `--local`
   clone mechanism, and will instead refuse to clone repositories that
   have symbolic links present in the `$GIT_DIR/objects` directory.

   Additionally, the value of `protocol.file.allow` is changed to be
   "user" by default.

CVE-2022-39260:
   An overly-long command string given to `git shell` can result in
   overflow in `split_cmdline()`, leading to arbitrary heap writes and
   remote code execution when `git shell` is exposed and the directory
   `$HOME/git-shell-commands` exists.

   `git shell` is taught to refuse interactive commands that are
   longer than 4MiB in size. `split_cmdline()` is hardened to reject
   inputs larger than 2GiB.

Credit for finding CVE-2022-39253 goes to Cory Snider of Mirantis. The
fix was authored by Taylor Blau, with help from Johannes Schindelin.

Credit for finding CVE-2022-39260 goes to Kevin Backhouse of GitHub.
The fix was authored by Kevin Backhouse, Jeff King, and Taylor Blau.
