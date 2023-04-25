Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF6CC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 18:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjDYSvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 14:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjDYSve (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 14:51:34 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969F517DF0
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:50:58 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-5f95cedb135so26885876d6.1
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682448622; x=1685040622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExOD1zuQlVMzcH2TB4SpjSglrq8X0SSSdYI+5SJaUHU=;
        b=GYjsDuJu+rH7m+F+4CaKDHzQYMixpvSYvEnKL991IqTnrOahnyRPbLHtVz8HtwKL7R
         QYt8k1j758C6QuJ9ReGU9HLWox4o4UzuSk7SBkgZgE1ZWJyISMfQtMgRD0hNWUhmAi3M
         RLYlU9zwOGgMmaO1c5ZDXdE6ckSRtx9hYvwatiQ7SRdn1zp8GavM1YAb9W9jfLrXcnyi
         RmYvvCFxraAo04jal1MoN/01YvvXpxeib8jD0aLLcdjnnEEhi5o9UFCbWIkGhuR8xjqn
         gQcdqKoDrylXZcxoMzAlOCm+7D1Pej3pbMnbRzWcCMLEkSEhDWqU8+FlPyA0o9eY2v9h
         vbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448622; x=1685040622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExOD1zuQlVMzcH2TB4SpjSglrq8X0SSSdYI+5SJaUHU=;
        b=IFYUHpydPn6S+WDHiQlZ3+/FEJvsPglhyF7QiwCB9/8RlVpAHQZ99IJmmwLdzsEPTK
         S8mkQ1vsLkRa2sjcXA4YE53Y5ekUZw4wJpr4wNMT70hgw22HlGNJi5EZoAV5tznCIHwt
         xBxxrf1Y/JuZtIt4WGiUDAA74trTD5QKXnjgmPbldQioqPDWgL/BBnIIhcyvVJgNtTRl
         EydvqnhX/7N8AGRIPMD3We9poyMJruroheBnfUHf1WwWFoMlkKBZcnNPt3VrJkWVdYUv
         1qJAnBLddbO3Oc5VCjsOHanB/lpPYhgS6eHOWxLlcEeKR+R1fz4TzqV/qdxCVRtbXVmV
         bZPQ==
X-Gm-Message-State: AAQBX9dv7s2wjBB+MRZb1VpEuFh+8i51Ioo3uXA1ty076K2W7h4wFSrJ
        TG0zuOMzlGZSjbgV4mfoxuRB2+Dmt4s=
X-Google-Smtp-Source: AKy350a/AbZrDo9vc4QUVnunR5Aex5tzZwe9S4O1vN0HSkJdNT+hr4svLrkMkt60jM3s8TY9/2DSEA==
X-Received: by 2002:a05:6214:404:b0:5ef:4435:f1bb with SMTP id z4-20020a056214040400b005ef4435f1bbmr31745217qvx.28.1682448622258;
        Tue, 25 Apr 2023 11:50:22 -0700 (PDT)
Received: from localhost.localdomain ([2607:fad8:4:3::1003])
        by smtp.gmail.com with ESMTPSA id h11-20020a0cf44b000000b005fd79831ac7sm4050080qvm.84.2023.04.25.11.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:50:21 -0700 (PDT)
From:   Maxim Cournoyer <maxim.cournoyer@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Maxim Cournoyer <maxim.cournoyer@gmail.com>
Subject: [PATCH v3 1/3] send-email: extract execute_cmd from recipients_cmd
Date:   Tue, 25 Apr 2023 14:50:11 -0400
Message-Id: <20230425185013.14351-2-maxim.cournoyer@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425185013.14351-1-maxim.cournoyer@gmail.com>
References: <xmqqcz3s3oz7.fsf@gitster.g>
 <20230425185013.14351-1-maxim.cournoyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This refactor is to pave the way for the addition of the new
'--header-cmd' option to the send-email command.

Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
---
 git-send-email.perl | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index fd8cd0d46f..b8d77ad214 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -2,6 +2,7 @@
 #
 # Copyright 2002,2005 Greg Kroah-Hartman <greg@kroah.com>
 # Copyright 2005 Ryan Anderson <ryan@michonline.com>
+# Copyright 2023 Maxim Cournoyer <maxim.cournoyer@gmail.com>
 #
 # GPL v2 (See COPYING)
 #
@@ -2006,15 +2007,29 @@ sub process_file {
 	}
 }
 
+# Execute a command and return its output lines as an array.
+sub execute_cmd {
+	my ($prefix, $cmd, $file) = @_;
+	my @lines = ();
+	open my $fh, "-|", "$cmd \Q$file\E"
+		or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
+	while (my $line = <$fh>) {
+		last if $line =~ /^$/;
+		push @lines, $line;
+	}
+	close $fh
+	    or die sprintf(__("(%s) failed to close pipe to '%s'"), $prefix, $cmd);
+	return @lines;
+}
+
 # Execute a command (e.g. $to_cmd) to get a list of email addresses
 # and return a results array
 sub recipients_cmd {
 	my ($prefix, $what, $cmd, $file) = @_;
-
+	my @lines = ();
 	my @addresses = ();
-	open my $fh, "-|", "$cmd \Q$file\E"
-	    or die sprintf(__("(%s) Could not execute '%s'"), $prefix, $cmd);
-	while (my $address = <$fh>) {
+	@lines = execute_cmd($prefix, $cmd, $file);
+	for my $address (@lines) {
 		$address =~ s/^\s*//g;
 		$address =~ s/\s*$//g;
 		$address = sanitize_address($address);
@@ -2023,8 +2038,6 @@ sub recipients_cmd {
 		printf(__("(%s) Adding %s: %s from: '%s'\n"),
 		       $prefix, $what, $address, $cmd) unless $quiet;
 		}
-	close $fh
-	    or die sprintf(__("(%s) failed to close pipe to '%s'"), $prefix, $cmd);
 	return @addresses;
 }
 
-- 
2.39.2

