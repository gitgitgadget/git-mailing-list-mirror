Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8CFC4332F
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 10:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiJUKaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 06:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJUKaD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 06:30:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6047836F3
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 03:29:56 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w8so1784314edc.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 03:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TBFKK7viAeZs6uFHZN3CE0uEEHrYnuckNfhb+9sB7jM=;
        b=fWDlZZJORaC/oHDrz/C+oMmW0oYXPBi4/AmsIPQY9lowl5zlo8calhL+Uv0kC9VkHT
         XDkvkkfvbOjMI72UsAXnrwQvK5xp9Gu3dob38EeebF5qWUmN3zKZyBaGHMUhUeccbECn
         nRe0+FXIPT49oDwX8nKlVd1VmIBxop/V+xj2FWaREEFeAjbi6v41Ak5BE/XofmO2uv8n
         4opFSk/audti8hTBYBqWPZtTUhgvfbWH9Wkbj2UGIZpDAfbnISO1K2E92GcYxi/cqAtg
         bkK/JJYZKKEQ9vXBuVBTIvkODi1qCgBRSjkTYq3UmtjmmQy9ltRgaL9QVYJcjEvwN6Yq
         wUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TBFKK7viAeZs6uFHZN3CE0uEEHrYnuckNfhb+9sB7jM=;
        b=GFiC+50Z2sk+hUPtlc7Xdql72rKpwrafj67jDbWnsvrDeroDlB6Fgb/N+EgIc4Mvx7
         /h2Ic2u3i7VBlYxOrgoMs5UcPbCE0G09VT9sDZr10HhzNAX+yNcvsdOb2yZTnNuyBqsT
         XmhkKksKAJH+rfDMd1NTo35UduRzOeDExa55bRNTrbGPSMotE6aHj85pJPNoCL0L+VQv
         kb/tVJzouLBVQdJJgJ9k6Ku3ik34qaRR0WlMt0FnLRCNEb9VAdIiDl4F+GNPEZgAX0QA
         Nc0gdEPN81Sw8EQqNJuUl7tgg1rRR/iXbrli+08ju89JpCQ1cRhLnhLPdRFk7lRamjgM
         nbIw==
X-Gm-Message-State: ACrzQf07WlAKWOulvGhnTpVDg8qJtzg3+YsLP3PFknH0ZcLeAzR7f3mL
        K8cvh6oRlmljCLWuhnfICK+Bwh8YBBQ=
X-Google-Smtp-Source: AMsMyM6Nv2QICGwM1VsLtXKJjpNDv4KpzvReEFkm9mAuAioi03iL8bJVxp0fZW5K7FfI7MOZmsiqBg==
X-Received: by 2002:aa7:d614:0:b0:458:f796:f86a with SMTP id c20-20020aa7d614000000b00458f796f86amr16652239edr.294.1666348193912;
        Fri, 21 Oct 2022 03:29:53 -0700 (PDT)
Received: from localhost (94-21-23-71.pool.digikabel.hu. [94.21.23.71])
        by smtp.gmail.com with ESMTPSA id oq19-20020a170906cc9300b0078defb88b0dsm170773ejb.73.2022.10.21.03.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 03:29:53 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] Documentation/build-docdep.perl: generate sorted output
Date:   Fri, 21 Oct 2022 12:29:50 +0200
Message-Id: <20221021102950.539148-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.1.339.gbbb58f2828
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make sure that our manpages are rebuilt when any of the included
source files change and only the affected manpages are rebuilt,
'build-docdep.perl' scans our documentation source files for include
directives, and outputs 'make' dependencies to be included by
'Documentation/Makefile'.  This script relies on Perl's hash data
structures, and generates its output while iterating over them, and
since hashes in Perl are very much unordered, the output varies
greatly from run to run, both the order of targets and the order of
dependencies of each target.

This lack of ordering doesn't matter for 'make', because it cares
neither about the order of targets in a Makefile nor about the order
of a target's dependencies.  However, it does matter to developers
looking into build issues potentially involving these generated
dependencies, as it's rather hard to tell whether there are any
relevant (i.e. not order-only) changes among the dependencies compared
to the previous run.

So let's make 'build-docdep.perl's output stable and ordered by
sorting the keys of the hashes before iterating over them.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/build-docdep.perl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/build-docdep.perl b/Documentation/build-docdep.perl
index ba4205e030..1b3ac8fdd9 100755
--- a/Documentation/build-docdep.perl
+++ b/Documentation/build-docdep.perl
@@ -38,9 +38,10 @@
     }
 }
 
-while (my ($text, $included) = each %include) {
+foreach my $text (sort keys %include) {
+    my $included = $include{$text};
     if (! exists $included{$text} &&
 	(my $base = $text) =~ s/\.txt$//) {
-	print "$base.html $base.xml : ", join(" ", keys %$included), "\n";
+	print "$base.html $base.xml : ", join(" ", sort keys %$included), "\n";
     }
 }
-- 
2.38.1.339.gbbb58f2828

