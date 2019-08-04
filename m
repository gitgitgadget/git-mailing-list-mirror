Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5BE41F731
	for <e@80x24.org>; Sun,  4 Aug 2019 21:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfHDVPh (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 17:15:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44291 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfHDVPh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 17:15:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so38595325pgl.11
        for <git@vger.kernel.org>; Sun, 04 Aug 2019 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9HGTCDc1RksXgaQnjo9dpVj9nWyeja7RVeFEjMrNtM=;
        b=B/f+GV7s/F9DMYQ/Mbk1PMtp2xSIc5fqQFKcd0+NCiIOjTWtggfd+mo+Se9kSccblI
         Q5Gctf5Ayn4SWkOLIo/CNplxJibCzZU9i2NFfshCUkfT8RROxG1L6lvCBuut0yG1svIW
         ooS5ZZniBa/ulZXa87nTmhxzUzCQouMWCHSX8kZ/oUC42gExakAI8Vwpl59wkghV+YmG
         O6PPQ0O5RKgd8CYpfKL4Xvm5RvpvFWRuX5ZdU249QYDA2BST4V+ADCgbdiCEOwrbW/pt
         TkCzPZ0lR4l8kCRyZ3Fv27580HOHO35BUqBdWux17ouzIApDuxTH+QUiEi06NsauDEUF
         Qtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9HGTCDc1RksXgaQnjo9dpVj9nWyeja7RVeFEjMrNtM=;
        b=Rceuen/ce5TG4aetO6I2nDpyToumOoX+XfGQnFxMhMDPu993zUCXcyvDKG2siC+Gi4
         AwncvigHiZOHBrSARxfoaIW7+4YNQHeHHF9dCD2jqYT9zmtBewoDqNTFEkswHNTdrPyF
         ELBShprfIo+rLRisTTgGzKcdPDayyR83IFbVKxtkDRXpqMHDVTH//lHWMLEkhqqE5FJR
         4ECiSbt+Si3hghPSHJXeFevKfY1dE4t6pq6S5/eJcRD8sp2343DLzcPnCeIgJ9S/ZYEc
         q3Tld/+gKfFzROdAVGJTbVfAfKu+7dGwMnwIxMnSgOXdwo4VBG37AXoiKXOI/lq2QViV
         UPuA==
X-Gm-Message-State: APjAAAVPYbC2OC/gT0ttO1LbGzLVN2sHtcTBETtdBvA9ZxnjNhA8F0bh
        7LyO0N3szUa9mztEumgRoMUkNyrDg5OPJw==
X-Google-Smtp-Source: APXvYqzVQEKZLfeh4+Q2L55o3jZm4w6lDYD5WkhjzdNlB8WfeNtlfCPV4UZ4JuPcvDVUqPZbuLMj2A==
X-Received: by 2002:a17:90a:d791:: with SMTP id z17mr14215279pju.40.1564953336138;
        Sun, 04 Aug 2019 14:15:36 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id o130sm139031138pfg.171.2019.08.04.14.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Aug 2019 14:15:35 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     frekui@gmail.com, michael.osipov@siemens.com,
        ibrahim.vanak@hpe.com, matheus.bernardino@usp.br,
        vleschuk@accesssoftek.com
Subject: [RFC PATCH 2/2] grep: make default number of threads reflect runtime
Date:   Sun,  4 Aug 2019 14:15:09 -0700
Message-Id: <20190804211509.39229-3-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190804211509.39229-1-carenas@gmail.com>
References: <20190804211509.39229-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

5b594f457a (Threaded grep, 2010-01-25) added a hardcoded number of
threads(8) to use in grep and 89f09dd34e (grep: add --threads=<num>
option and grep.threads configuration, 2015-12-15) made it configurable
through a knob as a workaround for systems where that default was not
effective.

Use instead the industry standard of 2x number of CPUs (to allow for
IO wait) for the default.

Using Debian 10 amd64 in a 2 CPU VirtualBox running in macOS 10.14.6
and that might had been representative of the original author environment
shows an overall performance improvement by avoiding thread trashing:

Test                                                origin/maint        HEAD
-----------------------------------------------------------------------------------------------
7810.1: grep worktree, fixed regex (no match)       0.52(0.43+0.49)     0.50(0.44+0.46) -3.8%
7810.2: grep worktree, fixed regex (common)         0.94(1.20+0.50)     0.91(1.24+0.44) -3.2%
7810.3: grep -I, fixed non binary regex (common)    0.98(1.24+0.51)     0.94(1.30+0.44) -4.1%
7810.4: grep -i, fixed caseless regex (common)      0.97(1.31+0.45)     0.93(1.18+0.56) -4.1%
7810.5: grep --no-index, fixed regex (common)       1.02(1.28+0.50)     0.97(1.14+0.59) -4.9%
7810.6: grep worktree, simple regex (common)        0.77(0.96+0.45)     0.73(0.88+0.48) -5.2%
7810.7: grep -I, simple non binary regex (common)   0.78(0.96+0.48)     0.73(0.94+0.43) -6.4%
7810.8: grep -i, simple caseless regex (common)     0.87(1.11+0.48)     0.82(1.16+0.38) -5.7%
7810.9: grep worktree, expensive regex              10.37(19.67+0.76)   10.20(19.46+0.76) -1.6%
7810.10: grep --cached, fixed regex                 4.48(4.37+0.10)     4.63(4.54+0.09) +3.3%
7810.11: grep --cached, expensive regex             23.74(23.61+0.11)   23.39(23.28+0.09) -1.5%

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 Documentation/git-grep.txt | 2 +-
 builtin/grep.c             | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 2d27969057..5d72e03b2e 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -60,7 +60,7 @@ grep.extendedRegexp::
 
 grep.threads::
 	Number of grep worker threads to use.  If unset (or set to 0),
-	8 threads are used by default (for now).
+	2 threads per core are used by default.
 
 grep.fullName::
 	If set to true, enable `--full-name` option by default.
diff --git a/builtin/grep.c b/builtin/grep.c
index 580fd38f41..0ed8da30f8 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -32,7 +32,6 @@ static char const * const grep_usage[] = {
 
 static int recurse_submodules;
 
-#define GREP_NUM_THREADS_DEFAULT 8
 static int num_threads;
 
 static pthread_t *threads;
@@ -1068,7 +1067,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	} else if (num_threads < 0)
 		die(_("invalid number of threads specified (%d)"), num_threads);
 	else if (num_threads == 0)
-		num_threads = HAVE_THREADS ? GREP_NUM_THREADS_DEFAULT : 1;
+		num_threads = HAVE_THREADS ? online_cpus() * 2 : 1;
 
 	if (num_threads > 1) {
 		if (!HAVE_THREADS)
-- 
2.23.0.rc1

