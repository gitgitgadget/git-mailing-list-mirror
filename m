Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EED5C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:13:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239077AbhLVENJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhLVENI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:13:08 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB3AC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g132so718653wmg.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5IsLAx3W753IYGb6C3FIgexRfsmVRAr6fL83b0gX5s=;
        b=iU6w+3pI6f+NPFYHnQrjtfgLogOT74NC7AwSRkzxtK+RnCdasROXXNqL7YEJRV28tW
         hDe/zPrmOOi16oyk7FAIohM1cqpVXpO3oSx2FHVWZ3OkBJSpW9bZpBbJQ5FcHo+7V777
         yMoqzx5gRcLWvrvP5eM8TopqzSe2Lrzn0S5844NjpMA+O4tJ0amBy1TDSjeYQtn9tFZ4
         PyiItzu4GAW4XvZxEdRzX+CU1zIx0kJw1UNOT1J91aIz+9BsI/3hQoRKmnQgIG5+b6Y9
         NeScblYYQXAVCqCguZA8CWRhErif7WIQ3TTeG5B9xR+Nwlok1lJVmnv4TmyymLnLIEMG
         nHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5IsLAx3W753IYGb6C3FIgexRfsmVRAr6fL83b0gX5s=;
        b=v38VROmADcyN4BahbgVz49p6NJ1GzLJPrq5GTx4qgGTj1pbQuYrF5C0P54bFl/oc+6
         Ie39dEKsdXx3NxB1t4kH0svWHF33DAW5osi+9GiOc84lreDIwfoXNVzlgGCck+/j/B4D
         Sx6XrWv7WCSCyh4uOjAFg0t7I2l3r1WqQpxYifeG5eq6L+WBGJaKJyiHGfh61vpLqFIG
         yDOoFeNvLbbxM9Ur1w6lXy5ZQ8brEnNhRAzrT5hEn3DEgehCzxE/awUFrgIyyntmVkil
         WwddfYRsh5v1DW+vXQ1MZ3ABo7Xhah4U0ZB8kO5Zo3QD5JLs40Jbccazw3SQJXS7Spwb
         gPsA==
X-Gm-Message-State: AOAM533+/vvvvKGUiKUNDWgUlfn97y1WEGVRlWrRHXrDsGLQ7RQknxUm
        wFU7C9Woe0MdHqML+9EWnY/bxXmLKE7ntQ==
X-Google-Smtp-Source: ABdhPJx2jUlzONB5YOcJw7TOoMOHqRBRcEPY15cmoFukB6qJ6HzYSxjmT10egcOcwGa0TRqvO/MPww==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr934401wmi.125.1640146386797;
        Tue, 21 Dec 2021 20:13:06 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm749650wrd.92.2021.12.21.20.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:13:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 00/10] cat-file: better usage UX & error messages
Date:   Wed, 22 Dec 2021 05:12:53 +0100
Message-Id: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
References: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series of patches to cat-file significantly improves the UX of
the -h output, see 08/10. For the v4 see[1], for the new usage output
see [2].

This re-roll addresses a minor s/_/-/ in option name typo out by John
Cai in his review of the series.

1. https://lore.kernel.org/git/cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com/
2. https://lore.kernel.org/git/patch-v5-08.10-16b6bb8aaf2-20211222T041050Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (10):
  cat-file tests: test bad usage
  cat-file tests: test messaging on bad objects/paths
  parse-options API: add a usage_msg_optf()
  cat-file docs: fix SYNOPSIS and "-h" output
  cat-file: move "usage" variable to cmd_cat_file()
  cat-file: make --batch-all-objects a CMDMODE
  cat-file: fix remaining usage bugs
  cat-file: correct and improve usage information
  object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
  cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)

 Documentation/git-cat-file.txt |  10 +-
 builtin/cat-file.c             | 182 ++++++++++++++++++++-------------
 builtin/stash.c                |   4 +-
 cache.h                        |   1 +
 object-name.c                  |   8 +-
 parse-options.c                |  13 +++
 parse-options.h                |  10 ++
 t/t1006-cat-file.sh            |  92 +++++++++++++++++
 t/t8007-cat-file-textconv.sh   |  42 ++++++++
 9 files changed, 282 insertions(+), 80 deletions(-)

Range-diff against v4:
 1:  b3d8ec1697f =  1:  e771bd38792 cat-file tests: test bad usage
 2:  eb6fa584287 =  2:  291312e2fb5 cat-file tests: test messaging on bad objects/paths
 3:  01de6e4305f =  3:  0689dbb248c parse-options API: add a usage_msg_optf()
 4:  aa384803fef =  4:  2a28b39430e cat-file docs: fix SYNOPSIS and "-h" output
 5:  32365ff569b =  5:  2d90c12fe7b cat-file: move "usage" variable to cmd_cat_file()
 6:  473ea3b0394 =  6:  227805d1804 cat-file: make --batch-all-objects a CMDMODE
 7:  878d9052bfb !  7:  e6ea403efe0 cat-file: fix remaining usage bugs
    @@ builtin/cat-file.c: int cmd_cat_file(int argc, const char **argv, const char *pr
     +			       "--buffer");
     +	else if (batch.all_objects)
     +		usage_msg_optf(_("'%s' requires a batch mode"), usage, options,
    -+			       "--batch-all_objects");
    ++			       "--batch-all-objects");
     +
     +	/* Batch defaults */
      	if (batch.buffer_output < 0)
 8:  ebc8dd0a22e =  8:  16b6bb8aaf2 cat-file: correct and improve usage information
 9:  a7447510e4b =  9:  47543c57135 object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
10:  a658099e3e1 = 10:  63920969ca8 cat-file: use GET_OID_ONLY_TO_DIE in --(textconv|filters)
-- 
2.34.1.1146.gb52885e7c44

