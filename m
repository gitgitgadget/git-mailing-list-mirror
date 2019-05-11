Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5591F45F
	for <e@80x24.org>; Sat, 11 May 2019 00:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfEKATJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 20:19:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46239 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfEKATJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 20:19:09 -0400
Received: by mail-io1-f68.google.com with SMTP id q21so2640280iog.13
        for <git@vger.kernel.org>; Fri, 10 May 2019 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aerspiHr2SjpRKyczMPz2OEeJUBA7wpMmqlrJUyutXI=;
        b=EyTgiQ2m+cmGDLPRKdhOTYNeOzBKibyVbCVp1B+lQUa3xPk1rnWsLXeHOwE4zGv0zH
         hnHAYwUGIiRe1LlAFWMk49m4EK/8bnBqwl01hEbm3AGqxZbbXDzhzOuZIHl8J+U6gz4V
         geC83J585BqvyJzHh9RXugPG4bhpN0wihZQFDp6auIDmAH4nNYHzN2sPkbms6ePmzBBU
         kVyu4RuJyr85ahT918PgntlaCuIkF1Bl6s1WNtymy9plN9itp3Ui8jOpW6qGDec0ndki
         NWuMFjgRxsT68Kixa0uiMKvjyPstYWH8yG2s1gMIqz4RZ32Ok+/dEfhgwgF4/593JkzK
         ArhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aerspiHr2SjpRKyczMPz2OEeJUBA7wpMmqlrJUyutXI=;
        b=nzHZW35/iHHt3WO+lkHhPd0UryOeHSHD3zMqGnKvK0TD9fdFnC3DGvigkJkVgc3Dw5
         LVejuYKi5zc3eAj8Lh7MR43Lfos2EyEXSDnm/GBe8k/NihM3+vQJUzj/Lr+DuvKq1/IV
         88/opk6AVYTGwnAVUuWvgp5F4/wzljStmOja/0zH0TZnVp4SLcWFn+0enkbqeVfNXeuu
         Mfl9+rV1EPv4BVSUDevOeJHnhdBlcoR1Py87uBXc6MA0H7a71FKtMUXSvqMD2iFK48p2
         4UAJWkMcvG5s7pN4Ql2ZXC1c+85DY7R7e8N6li8RqZygwl7TS1QBw8/FQwmkt5/Vz8hR
         yyHQ==
X-Gm-Message-State: APjAAAUKS99Vw7EfEL5aJOeh15vXuP96rgkUpMSvXVNigNvnFZKFmUlM
        JAUv+rjP3B8cG10pmGs18dQY4FrL
X-Google-Smtp-Source: APXvYqzD/kW/NzZ9wOAWQtC+oldlv+y8FqH9jrWIzveBmH59rnxLnlmrTpKufVTvICAns2toY02ooA==
X-Received: by 2002:a5d:9e17:: with SMTP id h23mr8973279ioh.106.1557533947822;
        Fri, 10 May 2019 17:19:07 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id m142sm3143120itb.31.2019.05.10.17.19.06
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 10 May 2019 17:19:06 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeffrey Walton <noloader@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] check-non-portable-shell: support Perl versions older than 5.10
Date:   Fri, 10 May 2019 20:18:53 -0400
Message-Id: <20190511001853.23011-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.21.0.1090.g8b4b5564af
In-Reply-To: <20190509102037.27044-1-sunshine@sunshineco.com>
References: <20190509102037.27044-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For thoroughness when checking for one-shot environment variable
assignments at shell function call sites, check-non-portable-shell
stitches together incomplete lines (those ending with backslash). This
allows it to correctly flag such undesirable usage even when the
variable assignment and function call are split across lines, for
example:

    FOO=bar \
    func

where 'func' is a shell function.

The stitching is accomplished like this:

    while (<>) {
        chomp;
        # stitch together incomplete lines (those ending with "\")
        while (s/\\$//) {
            $_ .= readline;
            chomp;
        }
        # detect unportable/undesirable shell constructs
        ...
    }

Although this implementation is well supported in reasonably modern Perl
versions (5.10 and later), it fails with older versions (such as Perl
5.8 shipped with ancient Mac OS 10.5). In particular, in older Perl
versions, 'readline' is not connected to the file handle associated with
the "magic" while (<>) {...} construct, so 'readline' throws a
"readline() on unopened filehandle" error. Work around this problem by
dropping readline() and instead incorporating the stitching of
incomplete lines directly into the existing while (<>) {...} loop.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is a re-roll of [1]. The only change since v1 is to drop
localization of $_ as suggested by Ævar in [2], and rewriting the commit
message to avoid misleadingly talking about $_ as being problematic.

[1]: http://public-inbox.org/git/20190509102037.27044-1-sunshine@sunshineco.com/
[2]: http://public-inbox.org/git/87ftpnhknn.fsf@evledraar.gmail.com/

 t/check-non-portable-shell.pl | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 166d64d4a2..38bfeebd88 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -27,14 +27,14 @@ sub err {
 	close $f;
 }
 
+my $line = '';
 while (<>) {
 	chomp;
+	$line .= $_;
 	# stitch together incomplete lines (those ending with "\")
-	while (s/\\$//) {
-		$_ .= readline;
-		chomp;
-	}
+	next if $line =~ s/\\$//;
 
+	$_ = $line;
 	/\bcp\s+-a/ and err 'cp -a is not portable';
 	/\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -n, -e, -f)';
 	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf)';
@@ -48,6 +48,7 @@ sub err {
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
+	$line = '';
 	# this resets our $. for each file
 	close ARGV if eof;
 }
-- 
2.21.0.1090.g8b4b5564af

