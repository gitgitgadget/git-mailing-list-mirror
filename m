Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3C11F404
	for <e@80x24.org>; Mon, 27 Aug 2018 22:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeH1CBe (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 22:01:34 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:55310 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbeH1CBe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 22:01:34 -0400
Received: by mail-qk0-f201.google.com with SMTP id z18-v6so467429qki.22
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=ALNRdXb/WMqkisG4/Vm7AR5PD41ZRO1nJa1J7L6p53o=;
        b=ASG48kD82pPxNOY6AHf9YJ0Yjw95oaKHaD8dljfJiH8BYtEkz3qCTmYnF28xMH8kgs
         XbUu1Lxw+hBrnPZ/fW3QvrUQ/Xkc+wROAuX4oHVFJuK9rHOHu4ih3JZ6VytV86ZaRj0S
         fEY5GEQQ50l8tw0zBx4uu/tpm3gwdtWw0/HFAXtIBklHQ6Q4mrTfDMC+r7c55IXFxU26
         m7L9UJ/QM0AgXmq2AR+8Jernv43rK4fFHw6Fk1vC3yotO5wJa/TaT00nik5BZ9lFovPw
         BLRhKDLoPZZ9vKgZHFWxb+fr5j98vhcS46qB+9JSRZr4lS8YO6uUPCJJOUREIwldChqF
         H5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=ALNRdXb/WMqkisG4/Vm7AR5PD41ZRO1nJa1J7L6p53o=;
        b=KFi4VHnZ86DsegYSjdBB2kFb83FtumqFh3gKFsXRUoRUzDpUlIM4ms5zDlyckZBUDC
         nerQkeAcKzHreflQTpyHm3KZmBy2FJ9G8zhA/GSce7xcyCcGlklAwzr5FpmTBzzX+vhN
         J69zHIc36dFYEmYVzVcsLBtexc3ZdgNKm2GV6Hw1jJycOCDB68GzbL9/ub0kN0Yj7Wr+
         2iDmhm1h4r2Vlm43oFbdMX9Hx4UC9YoHteT9EXoUZhvtIQz+hZb7Mpxt49iwvmaR6jYS
         HX6obbhwyU3+KX7nlYQeReuOkEGpiGRv6PMC3OFkVfLN6AlhLLDQSflmEnKm8cUnBHUD
         1o9w==
X-Gm-Message-State: APzg51ASYbSh4SznwLMgpwxXSgnr4U21BCkkxlMieNzszP5y2nOX5nnn
        tmuN8/R5FIsmTCRXiSDqiD7pcVxgRL9dKlRGhuBm4F3f3vgmNIYf/S87jjm3SP3Qmpx4134ZyfF
        qhWBq3bmSESHIA7WHPbZory/ycj2mRQuSm5Y6PIlSutm4WRo0cPMt2lOt1O7w
X-Google-Smtp-Source: ANB0VdYBLdMZm0ozeYjMOJPfR1KMSK+VebaoV7YcsenrJK6BB+PVrmmjyhklcN3ozYJPkIIek9T26vwMZujw
MIME-Version: 1.0
X-Received: by 2002:a37:9c90:: with SMTP id f138-v6mr415912qke.51.1535407981775;
 Mon, 27 Aug 2018 15:13:01 -0700 (PDT)
Date:   Mon, 27 Aug 2018 15:12:56 -0700
Message-Id: <20180827221257.149257-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0
Subject: [PATCH 1/2] t2013: add test for missing but active submodule
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cloning a superproject with the option
 --recurse-submodules='.', it is easy to find yourself wanting
a submodule active, but not having that submodule present in
the modules directory.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t2013-checkout-submodule.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule.sh
index 6ef15738e44..c69640fc341 100755
--- a/t/t2013-checkout-submodule.sh
+++ b/t/t2013-checkout-submodule.sh
@@ -63,6 +63,30 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
 	! test -s actual
 '
 
+test_expect_success 'setup superproject with historic submodule' '
+	test_create_repo super1 &&
+	test_create_repo sub1 &&
+	test_commit -C sub1 sub_content &&
+	git -C super1 submodule add ../sub1 &&
+	git -C super1 commit -a -m "sub1 added" &&
+	test_commit -C super1 historic_state &&
+	git -C super1 rm sub1 &&
+	git -C super1 commit -a -m "deleted sub" &&
+	test_commit -C super1 new_state &&
+	test_path_is_missing super1/sub &&
+
+	# The important part is to ensure sub1 is not in there any more.
+	# There is another series in flight, that may remove an
+	# empty .gitmodules file entirely.
+	test_must_be_empty super1/.gitmodules
+'
+
+test_expect_failure 'checkout old state with deleted submodule' '
+	test_when_finished "rm -rf super1 sub1 super1_clone" &&
+	git clone --recurse-submodules super1 super1_clone &&
+	git -C super1_clone checkout --recurse-submodules historic_state
+'
+
 KNOWN_FAILURE_DIRECTORY_SUBMODULE_CONFLICTS=1
 test_submodule_switch_recursing_with_args "checkout"
 
-- 
2.18.0

