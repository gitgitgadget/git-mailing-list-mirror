Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7633C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 17:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444182AbiEFRbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 13:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiEFRbP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 13:31:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5196D944
        for <git@vger.kernel.org>; Fri,  6 May 2022 10:27:31 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 17AAE118AEC;
        Fri,  6 May 2022 13:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=x8mGg88Yvj14EEWIY/q30fhC9
        e2WK/k+RiEHjVEPw1A=; b=ZzsL80cch2m06lgOk1AQ1bFOKLq5Cxbugn4fbgGU2
        iMocLcSfgyxbj15yacEtRa+HuTYATw1lbT2NO5TtMdTbHo1VDM8AzpmZUDQJbeI9
        WNQG5rSxN/tFFsU2kaUJk3zZRIXaLDdKcGb57sPUHDvIxNWAAgrQv19f1jd/zXS7
        G4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FDE7118AEB;
        Fri,  6 May 2022 13:27:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 77089118AEA;
        Fri,  6 May 2022 13:27:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.36.1
Date:   Fri, 06 May 2022 10:27:28 -0700
Message-ID: <xmqqczgqmv0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CE1B2B14-CD61-11EC-A85B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.36.1 is now available at
the usual places.

This is to fix many of the regressions shipped with v2.36.0;
unfortunately, there still are a few known regressions that are not
yet fixed, which have to wait for future maintenance releases.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.36.1'
tag and the 'maint' branch that the tag points at:

  url =3D https://git.kernel.org/pub/scm/git/git
  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.36.1 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fixes since v2.36
-----------------

 * "git submodule update" without pathspec should silently skip an
   uninitialized submodule, but it started to become noisy by mistake.

 * "diff-tree --stdin" has been broken for about a year, but 2.36
   release broke it even worse by breaking running the command with
   <pathspec>, which in turn broke "gitk" and got noticed.  This has
   been corrected by aligning its behaviour to that of "log".

 * Regression fix for 2.36 where "git name-rev" started to sometimes
   reference strings after they are freed.

 * "git show <commit1> <commit2>... -- <pathspec>" lost the pathspec
   when showing the second and subsequent commits, which has been
   corrected.

 * "git fast-export -- <pathspec>" lost the pathspec when showing the
   second and subsequent commits, which has been corrected.

 * "git format-patch <args> -- <pathspec>" lost the pathspec when
   showing the second and subsequent commits, which has been
   corrected.

 * Get rid of a bogus and over-eager coccinelle rule.

 * Correct choices of C compilers used in various CI jobs.

Also contains minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.36.0 are as follows:

Junio C Hamano (4):
      2.36 gitk/diff-tree --stdin regression fix
      2.36 show regression fix
      cocci: drop bogus xstrdup_or_null() rule
      Git 2.36.1

Orgad Shaneh (1):
      submodule--helper: fix initialization of warn_if_uninitialized

Ren=C3=A9 Scharfe (3):
      Revert "name-rev: release unused name strings"
      2.36 format-patch regression fix
      2.36 fast-export regression fix

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
      CI: select CC based on CC_PACKAGE (again)

