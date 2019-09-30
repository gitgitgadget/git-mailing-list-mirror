Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653581F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfI3Bvt (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:51:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39552 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbfI3Bvt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:51:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so6411620qki.6
        for <git@vger.kernel.org>; Sun, 29 Sep 2019 18:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JS/RrePUGZe/cr8DroQGq0RI4LOSZ3t+Db1OrFTxxGA=;
        b=YMGzzhU0XpWWIqLMrNYBNRPG/cQjz2rtbZ0hcuvsBUZFrdecqFP9oLnmfXPxAe0j24
         E8mBbJgMh4hORW29HXqiISIyhKYk/8D+PXMby7IZf+dVpyq0xjBQyMpS0I8WG5HCq0tG
         r5nP5LFZYVDNGHpyAOd+ky9VqNV5dsIvkHDl2h+w9dPxY4sscgCm37c3iSLYY9vdRBk5
         4WUS7YvhPu/91lSj02B7CZiOKRgbLz19BOgPZeykfyO0EzyNZP1eAWaZdH4EMMDjdUIt
         23wT6IS1OGbHEx+iFsOcDE8v5wou+7lOU+2vd1QxsXCTk9wWOVHp0bf9PNBw/cPK1LZW
         DBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JS/RrePUGZe/cr8DroQGq0RI4LOSZ3t+Db1OrFTxxGA=;
        b=gl6lEPmh5DIdahomFaxu7WJIHgkIq+ESu+lBE3JAkyK0ijtVT4OKMXaL0oL45yXJcq
         l67gs3UiKZ+F+GjxvdDnsvGMSvHgBypjDrW5J20B76ozHzHfYjqhmr2W9Kty6eG5zmWq
         +MOG7Kf3hmlkNttwljoeMcoSHm+5a0Gix+Z9uJLKyQp2JLTrtaee7+zgHE8/qalUw0Nt
         bCsV45RXFpVwSlQZFr+kJMFF9aYV6dJ+9TL9MUP+YD8dsXGbiBQflQt2vX+WMVhfyXSQ
         wr3WMbvhiQmJW5Wv6Yd/VLS6awaWxYKVX11l173QNV0tOocLR3t0qEnkqXgLt+Mb68B2
         gwQg==
X-Gm-Message-State: APjAAAVoQUcr397m/fwpXdV9POR2OnYEdGUkpf1bhCo6OAwSSDcsRUq+
        t1ovnCc2yLR7cFVMjRe8tqnqx3GAlTc=
X-Google-Smtp-Source: APXvYqz+hOhs6LJDdLys59mlfIGx+RSWBNx7wQrFDQQdFoJl1Jg1B02I8oUxcPy++icxkTIH9aoB0A==
X-Received: by 2002:a37:a2c3:: with SMTP id l186mr16024219qke.461.1569808306764;
        Sun, 29 Sep 2019 18:51:46 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::3])
        by smtp.gmail.com with ESMTPSA id f11sm4706954qkk.76.2019.09.29.18.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 18:51:46 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, olyatelezhnaya@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Manav Rathi <mnvrth@gmail.com>
Subject: [PATCH v2 10/11] grep: re-enable threads in non-worktree case
Date:   Sun, 29 Sep 2019 22:50:56 -0300
Message-Id: <c1fe6545a90563419731932b0bb17869dab1cda7.1569808052.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569808052.git.matheus.bernardino@usp.br>
References: <cover.1569808052.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They were disabled at 53b8d93 ("grep: disable threading in non-worktree
case", 12-12-2011), due to observable performance drops (to the point
that using a single thread would be faster than multiple threads). But
now that zlib inflation can be performed in parallel we can regain the
speedup, so let's re-enable threads in non-worktree grep.

Grepping 'abcd[02]' ("Regex 1") and '(static|extern) (int|double) \*'
("Regex 2") at chromium's repository[1] I got:

 Threads |   Regex 1  |  Regex 2
---------|------------|-----------
    1    |  17.2920s  |  20.9624s
    2    |   9.6512s  |  11.3184s
    4    |   6.7723s  |   7.6268s
    8**  |   6.2886s  |   6.9843s

These are all means of 30 executions after 2 warmup runs. All tests were
executed on an i7-7700HQ (quad core w/ hyper-threading), 16GB of RAM and
SSD, running Manjaro Linux. But to make sure the optimization also
performs well on HDD, the tests were repeated on another machine with an
i5-4210U (dual core w/ hyper-threading), 8GB of RAM and HDD (SATA III,
5400 rpm), also running Manjaro Linux:

 Threads |   Regex 1  |  Regex 2
---------|------------|-----------
    1    |  18.4035s  |  22.5368s
    2    |  12.5063s  |  14.6409s
    4**  |  10.9136s  |  12.7106s

** Note that in these cases we relied on hyper-threading, and that's
   probably why we don't see a big difference in time.

Unfortunately, multithreaded git-grep might be slow in the non-worktree
case when --textconv is used and there're too many text conversions.
Probably the reason for this is that the object read lock is used to
protect fill_textconv() and therefore there is a mutual exclusion
between textconv execution and object reading. Because both are time
consuming operations, not being able to perform them in parallel can
cause performance drops. To inform the users about this (and other
threading detais), let's also add a "NOTES ON THREADS" section to
Documentation/git-grep.txt.

[1]: chromium’s repo at commit 03ae96f (“Add filters testing at DSF=2”,
     04-06-2019), after a 'git gc' execution.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 Documentation/git-grep.txt | 11 +++++++++++
 builtin/grep.c             |  2 +-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 2d27969057..00fc59d565 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -330,6 +330,17 @@ EXAMPLES
 `git grep solution -- :^Documentation`::
 	Looks for `solution`, excluding files in `Documentation`.
 
+NOTES ON THREADS
+----------------
+
+The `--threads` option (and the grep.threads configuration) will be ignored when
+`--open-files-in-pager` is used, forcing a single-threaded execution.
+
+When grepping the object store (with `--cached` or giving tree objects), running
+with multiple threads might perform slower than single threaded if `--textconv`
+is given and there're too many text conversions. So if you experience low
+performance in this case, it might be desirable to use `--threads=1`.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/grep.c b/builtin/grep.c
index 0947596bcd..163f14b60d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1054,7 +1054,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (recurse_submodules && (!use_index || untracked))
 		die(_("option not supported with --recurse-submodules"));
 
-	if (list.nr || cached || show_in_pager) {
+	if (show_in_pager) {
 		if (num_threads > 1)
 			warning(_("invalid option combination, ignoring --threads"));
 		num_threads = 1;
-- 
2.23.0

