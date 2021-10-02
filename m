Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FD4C433EF
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5591A61A81
	for <git@archiver.kernel.org>; Sat,  2 Oct 2021 09:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhJBJVM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Oct 2021 05:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhJBJVM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Oct 2021 05:21:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EA9C061775
        for <git@vger.kernel.org>; Sat,  2 Oct 2021 02:19:26 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so13223649wmc.0
        for <git@vger.kernel.org>; Sat, 02 Oct 2021 02:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tsj/CdPrcMCcstAGlcvv1VnKBV9aOzBJ6NaGP3wA4mw=;
        b=azaQrbt3pjoGeZoRd0C8KFDkTJ4XeI6kwWuEDKqhUEBlo2cD7BMMPI9Wq2BzlSI9sk
         LfnqQ9I3I+kfofVHQPreNsXcgsR3vT3LogH6PmUX3f/aThMcpc1xfxbcAJL39Pbe90pc
         I1RfPVbh7/9qX77fq/pR7O08cCaNNQNhh0xscHcww0RBzp3BR3WUCEiGUIynAn6YVtWM
         nh+vFnDt/yaVYcnfE5EttZcIW3Ve0AftGQ8xDD6fK6awEebW5JTEj4e1kg9OuMExpYIp
         Fk5oAWkqbkBIwKbUIQ12GDtPdRx3nG01qcTM0DifJ2iqKoclfjWT/BNXuJiS7APO/mqs
         uszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tsj/CdPrcMCcstAGlcvv1VnKBV9aOzBJ6NaGP3wA4mw=;
        b=SpoEzcTnuRYZaLvRg2/PjdhZU5SjIcu1Us6lYqZBMNT8KBdzCVhUHmwgydlFWKviBy
         M+wPQddRRBqiJ5phSZ6382EP/Fba9SRpldIqS3D3HMwe7uV05l16ta+KfDN4OZDj6HbE
         RWYkLUXbVw6af7ShUiXEjnj4jhiDnJsByKcD04J126nuyeobnkc5/2K0hm3WWhSHD1gl
         AzG2oJKbk6mU86wbievrm/jZbk32YFjWoyGIKDk3ayeEtUZ5qhR4OYOjJHIaDfGg60+q
         tUKCRg2EUSnF9rkSKjKIoR21CgrfBSMLTugmpwJsme8f9G0OPFdPOVDKmqehaHQDrUow
         0V+g==
X-Gm-Message-State: AOAM5316v+BcYdPt+S0hgX9zAB/1ihQkPIl0SHE/aopjyX70ttS9sbiy
        QfBuGWPhlCNbyUJptn7+nb1pKi3/i03ysg==
X-Google-Smtp-Source: ABdhPJz8wxwBa3Wws57iZrD2S2P7feM6QAuS7EK3XVX63nb/P6HVCYLImSFZ8ij9WFNreI01VPodwA==
X-Received: by 2002:a1c:7f11:: with SMTP id a17mr8722927wmd.166.1633166364980;
        Sat, 02 Oct 2021 02:19:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm6735805wrv.97.2021.10.02.02.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 02:19:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] COPYING: modernize, steal boilerplate from linux.git
Date:   Sat,  2 Oct 2021 11:19:15 +0200
Message-Id: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1380.g193143c62ce
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's patches to git.git to add a BSD-licensed reftable/ directory
with its own "COPYING" file[1]. I think that for such a thing to be
in-tree we should have some note in the top-level "COPYING" explaining
git's license, but that subdirectories or other files could be under
their own licenses.

This series reaches the end-state of pretty much stealing linux.git's
"COPYING" file, including specific wording they have. linux.git used
to have pretty much git.git's "COPYING" file (as git.git's was derived
from an older version), but has since diverged.

In linux.git there's a reference to
"Documentation/process/license-rules.rst", this new COPYING file
covers the relevant parts inline, but like linux.git's the end-state
is that the GPLv2 is not inline in the "COPYING" file anymore, instead
it's split into a GPL-2.0" and referenced by it.

The "meaty" part of this series (which I've CC'd Linus, Greg & Mauro,
who were involved in the linux.git changes) is 3-5/5. The first two
patches are just dealing with the implementation detail that git.git's
"COPYING" file happened to be used by its test suite as test data, it
couldn't be changed significantly without changing those (mostly "git
diffdiff") tests.

1. https://lore.kernel.org/git/xmqqtui4k1j5.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (5):
  "lib-diff" tests: make "README" and "COPYING" test data smaller
  tests: stop using top-level "README" and "COPYING" files
  COPYING: remove mention of GPLv3, clarify sub-project COPYING
  COPYING: move GPL text to a "GPL-2.0" file
  GPL-2.0: update to byte-for-byte match the FSF's version

 COPYING                           | 377 ++----------------------------
 t/lib-diff/COPYING => GPL-2.0     |  60 ++---
 t/.gitattributes                  |   1 -
 t/lib-diff-data.sh                |  22 ++
 t/lib-diff.sh                     |   2 +
 t/lib-diff/README                 |  46 ----
 t/t4003-diff-rename-1.sh          |   4 +-
 t/t4005-diff-rename-2.sh          |   4 +-
 t/t4007-rename-3.sh               |   5 +-
 t/t4008-diff-break-rewrite.sh     |   4 +-
 t/t4009-diff-rename-4.sh          |   4 +-
 t/t4022-diff-rewrite.sh           |   6 +-
 t/t4023-diff-rename-typechange.sh |  11 +-
 t/t7001-mv.sh                     |   5 +-
 t/t7101-reset-empty-subdirs.sh    |  11 +-
 15 files changed, 89 insertions(+), 473 deletions(-)
 rename t/lib-diff/COPYING => GPL-2.0 (92%)
 create mode 100644 t/lib-diff-data.sh
 delete mode 100644 t/lib-diff/README

-- 
2.33.0.1380.g193143c62ce

