Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6615D2055E
	for <e@80x24.org>; Wed, 25 Oct 2017 22:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbdJYWqi (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 18:46:38 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:53234 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbdJYWqd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 18:46:33 -0400
Received: by mail-io0-f193.google.com with SMTP id f20so2703524ioj.9
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 15:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iWnBjYlmT55Kqpnryee3gWKH115/sZwBJFhduN3dQ5A=;
        b=dJvhq1bRa7Zfv8yqwkfzhV5tMPxsvPGdwDAOdSYStIg0kI5U0eJRiQ7Sh7Gl81A3I1
         h05w+irT2bAAhvKNb3GA8dAEif2hbr+Yrp6eY6fgEvatRPtk+jpcBw+kE/+0tvpoiXjp
         YgRoeMO/ANrOp1opxceL3uZ4WGE+lMYT8jzdROFv0+PCpTjkSkY6JRDv2ILB2qt1fV91
         vX2xLHIDOHqYmFCgAr7qEw2Tsq2VAq1RbxKR87ZWREwMTp42ZaCf2qwqWNkGbFC0inDk
         1Qwwhtn+ZG0CLvj30Y5JZP97jKDZdPY6wYQNfht7yPjRB5mAAmEfwSK6TfD46hhjE5AR
         gXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iWnBjYlmT55Kqpnryee3gWKH115/sZwBJFhduN3dQ5A=;
        b=QM/bAKrkHBX6rPrIFiOUMC9XeBz4djYTG0HwpvFwwG1VoFJ/cud6P7i6+dHGFK303Q
         QcDqrdxgUb2rDk9Zpv65Y3HWeJpBhp4pHTYX7Gm73DvwWOEtbHFz2zoMVRoWzjI/XLVn
         zuNafN3lXyQlEndJC393plSo879YVCx/5enECqXYQo0gIBkG77rjLSDY3C1O0ub3knZv
         sXoSd56noyiGi2Ig4GhGVcN85UmAeQxmRjCg2INjICCF1i8wunJWz6FPdNH97iOgxEJp
         if+wFqdf0Gd2XKZ+M4KV2ySvQpkeyMIbJ4hYiETGIiACHeZMtAowpbAOqLUb3hGdLibs
         8J0Q==
X-Gm-Message-State: AMCzsaXhqtBHEFukCO5DTktuJ35I8W40pgc0lLb7oyQ1b9q8X0xwepqC
        OEUhGxPiJrJlO5n8Lvy00OV3EzjgseU=
X-Google-Smtp-Source: ABhQp+QtwuwCaaSA+da3ZLDCvl+uMadYq/pzJY8NLLdklT9H9chkJF0jqmnhJgsd+O1ajIxo8mhsjw==
X-Received: by 10.107.47.17 with SMTP id j17mr26138604ioo.96.1508971592381;
        Wed, 25 Oct 2017 15:46:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:4d7b:dd00:69b5:edeb])
        by smtp.gmail.com with ESMTPSA id 196sm1722865ioe.66.2017.10.25.15.46.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 15:46:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] diff.c: ignore all white space changes by default in the move detection
Date:   Wed, 25 Oct 2017 15:46:20 -0700
Message-Id: <20171025224620.27657-3-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.6.g953226eb5f
In-Reply-To: <20171025224620.27657-1-sbeller@google.com>
References: <20171025224620.27657-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The coloring of moved lines is currently only related to the presentation,
as there are no options to export the move detection information into
the patch format. Hence we can be very loose about the default, so let's
ignore any white space change for the move detection. If a user really
cares about move detection detecting only lines moved byte-for-byte,
they can exercise the --color-moved-no-ignore-* options.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt | 4 +++-
 diff.c                         | 1 +
 t/t4015-diff-whitespace.sh     | 6 ++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 1000b53b84..fdf40cbefc 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -269,14 +269,16 @@ dimmed_zebra::
 	Ignore whitespace when comparing lines when performing the move
 	detection for --color-moved.  This ignores differences even if
 	one line has whitespace where the other line has none.
+	This is on by default.
 --color-moved-[no-]ignore-space-change::
 	Ignore changes in amount of whitespace when performing the move
 	detection for --color-moved.  This ignores whitespace
 	at line end, and considers all other sequences of one or
 	more whitespace characters to be equivalent.
+	This is on by default.
 --color-moved-[no-]ignore-space-at-eol::
 	Ignore changes in whitespace at EOL when performing the move
-	detection for --color-moved.
+	detection for --color-moved. This is on by default.
 
 --word-diff[=<mode>]::
 	Show a word diff, using the <mode> to delimit changed words.
diff --git a/diff.c b/diff.c
index 2580315ab9..fef4874169 100644
--- a/diff.c
+++ b/diff.c
@@ -4105,6 +4105,7 @@ void diff_setup(struct diff_options *options)
 	}
 
 	options->color_moved = diff_color_moved_default;
+	options->color_moved_ignore_space = XDF_WHITESPACE_FLAGS;
 }
 
 void diff_setup_done(struct diff_options *options)
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 4ef4d6934a..a4ffc84f41 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1813,6 +1813,12 @@ test_expect_success 'move detection only ignores white spaces' '
 	 Qbar();<RESET>
 	 Q// more unrelated stuff<RESET>
 	EOF
+	test_cmp expected actual &&
+
+	# test that this is the default:
+	git diff --color --color-moved |
+		grep -v "index" |
+		test_decode_color >actual &&
 	test_cmp expected actual
 '
 
-- 
2.15.0.rc2.6.g953226eb5f

