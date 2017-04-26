Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,PI_IMPORTANCE_HIGH,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A829D207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 04:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1948099AbdDZELX (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 00:11:23 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34182 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034583AbdDZELV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 00:11:21 -0400
Received: by mail-pf0-f193.google.com with SMTP id g23so13819463pfj.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 21:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:importance:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=s3HgFc4x7cwf+1C8L0plQAN1oIe8KLujCe8LJ6mcMUY=;
        b=ZVR/ZIUcY6EpHH+o5zQk9FZxXcEOi99E0UPTa/v4TnhODp2PE24dsiIrbjB4I34u2+
         ZV8cUpqnZAYFrCI04WCHFYf8txcgcky0mIBbJgrcGg7CkYy/9mn1uqoUBGcQwZePlA1m
         dzJ9g1AKToZMnQPylOkTU0UsWXDRGIt4biLhr3PnkOUKlNchFz0NIq68FHqjijB7RlTe
         /Nz5lxXULsggaqfYNr1wFiVnsOsrEL/iKY2Fz0nP3vh67AdiWNBRQhkI8UrvpakyEOay
         +1MuVM9s59pAckMe8Q4F/4TqB0FF7JyjvCy1gKHC1+MjgivEW8MdBtRjGPEh0tdQqnTC
         Zhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:importance
         :date:in-reply-to:message-id:user-agent:mime-version;
        bh=s3HgFc4x7cwf+1C8L0plQAN1oIe8KLujCe8LJ6mcMUY=;
        b=nz21K6xoVsTCidp//GLrnZOntyZNQss3SKejeT/MavUzn1F7TiERNJhpdzTAdb3wse
         cKeyAkGcYsNcvrSzNklIZvMtCLIbVy6OXWNWu6Eo1E2Dxt1wCNIfah1qnkLYTNr/Hizf
         6DlydsY/NYCKK9uzwAmXlawhSkcgx/POpB50otydFy9yy7cbjL382fl55XKY+xyhNv4o
         C13YhDYtZpmiAAEfmMl0OU1xeVwxSISbwjkfanyjo+ivT7TE4xkspJI/JZRWTxy5UTA2
         pkSW2ardn0y+DR2SNwPtVdKBxlzVtg/P0NdD/jH2N5X0dITougLNOT2kwc9B9DIqHOyJ
         QbOg==
X-Gm-Message-State: AN3rC/6tFr+fgEIRc8dj6MGN12Enu01VKLpYuHMQbmsHw1ZUcl4iHBpr
        JWf2dgXNOhHiGB8d1lg=
X-Received: by 10.98.166.197 with SMTP id r66mr30940940pfl.5.1493179880256;
        Tue, 25 Apr 2017 21:11:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id y78sm38982639pff.107.2017.04.25.21.11.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 21:11:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net, j6t@kdbg.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v8] read-cache: call verify_hdr() in a background thread
References: <20170425184109.46168-1-git@jeffhostetler.com>
Importance: high
Date:   Tue, 25 Apr 2017 21:11:18 -0700
In-Reply-To: <20170425184109.46168-1-git@jeffhostetler.com>
        (git@jeffhostetler.com's message of "Tue, 25 Apr 2017 18:41:08 +0000")
Message-ID: <xmqqd1bzst95.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Version 8 of this patch converts the unit test to use
> perl to corrupt the index checksum (rather than altering
> a filename) and also verifies the fsck error message as
> suggested in response to v7 on the mailing list.
>
> If there are no other suggestions, I think this version
> should be considered final.

Oops.  The earlier one has already been in 'master' for a few days.
Let's make this an incremental update.  

Is the description in the following something you are OK with (so
that I can add your sign-off)?

Thanks.

-- >8 --
From: Jeff Hostetler <jeffhost@microsoft.com>
Date: Tue, 25 Apr 2017 18:41:09 +0000
Subject: t1450: avoid use of "sed" on the index, which is a binary file

The previous step added a path zzzzzzzz to the index, and then used
"sed" to replace this string to yyyyyyyy to create a test case where
the checksum at the end of the file does not match the contents.

Unfortunately, use of "sed" on a non-text file is not portable.
Instead, use a Perl script that seeks to the end and modifies the
last byte of the file (where we _know_ stores the trailing
checksum).


---
 t/t1450-fsck.sh | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 677e15a7a4..eff1cd68e9 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -689,16 +689,35 @@ test_expect_success 'bogus head does not fallback to all heads' '
 	! grep $blob out
 '
 
+# Corrupt the checksum on the index.
+# Add 1 to the last byte in the SHA.
+corrupt_index_checksum () {
+    perl -w -e '
+	use Fcntl ":seek";
+	open my $fh, "+<", ".git/index" or die "open: $!";
+	binmode $fh;
+	seek $fh, -1, SEEK_END or die "seek: $!";
+	read $fh, my $in_byte, 1 or die "read: $!";
+
+	$in_value = unpack("C", $in_byte);
+	$out_value = ($in_value + 1) & 255;
+
+	$out_byte = pack("C", $out_value);
+
+	seek $fh, -1, SEEK_END or die "seek: $!";
+	print $fh $out_byte;
+	close $fh or die "close: $!";
+    '
+}
+
+# Corrupt the checksum on the index and then
+# verify that only fsck notices.
 test_expect_success 'detect corrupt index file in fsck' '
 	cp .git/index .git/index.backup &&
 	test_when_finished "mv .git/index.backup .git/index" &&
-	echo zzzzzzzz >zzzzzzzz &&
-	git add zzzzzzzz &&
-	sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
-	mv .git/index.yyy .git/index &&
-	# Confirm that fsck detects invalid checksum
-	test_must_fail git fsck --cache &&
-	# Confirm that status no longer complains about invalid checksum
+	corrupt_index_checksum &&
+	test_must_fail git fsck --cache 2>expect &&
+	grep "bad index file" expect &&
 	git status
 '
 
