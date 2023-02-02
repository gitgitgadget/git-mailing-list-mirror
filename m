Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21F4C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 20:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjBBU1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 15:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBBU1F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 15:27:05 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2266F22038
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 12:27:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y1so2821072wru.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 12:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zN4LD3T0tKH/dTCPuUoZ4pEXhMehGtOMJFuytitl/RY=;
        b=WzoFUrCZ1i3iDpvhaV+zj9drYuOHhN+J2NyDM+ryUwUUjAnnWXOi7+b94kXNtClnbB
         FlJmLTw28UwaH1NuUDFJLvxmh6mcPk9lGswDjDOd/tWgNB4oRrUYx6iUI5asueWYulLv
         b6OHQ0b65moth7CwUXaqr5SuEOH0F7h4menvlJmTZBsPaCnomyv3hf2hv49JHvZXEacL
         c1bFz4HVabRNM4ud3iHCh4pUTA+uCLP9fPlv3VeY6p6EJeIwdTSM/zO8h3n2jBgXT6vt
         LcWbjpIXq2v5c4UPjqNjlhL+jcBoGjM1BxXPh8PeGD+RnmvNZthXlKuDHIU10/b9lp3k
         tv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zN4LD3T0tKH/dTCPuUoZ4pEXhMehGtOMJFuytitl/RY=;
        b=zfhMSF/LCFKIbY9zuCrYmpbD+zcNe9MWdrC01tmgMU1zbYhmVWgdRNzFHlPs2ZIAUo
         Ku34RW6346H+om6AkngccFW3mTleoJ1XIjmEE0z04t0bNNYAOfDM1WDu5xoS6wRgVmgc
         J6A75hAuov66pIj0pYE+1CHJffp21AxgRf/aQx2lgO3sufUjktgtVPBTvg0RXtVD58E9
         S6ZNET0CyN0eAAeHrJa4NI2mOd7TFC2aZ6TzN/lEZMwgSZQzy2BHYcdRM35SIEmj2c5I
         +OpVCHKKswhTrnDghF0U7lmnM4uhhB3rsfJxdYwphQJ3q0ReY9bE5n/9PO9Is9dhLjPT
         6TNA==
X-Gm-Message-State: AO0yUKUQ8iJCyp1Av77HNNZCeGB+5xZhCE+6HPjdPV8vieMEMgt07jTW
        ZGIrnn5n1uCnXofp94Rna+G0nSYBvxQ=
X-Google-Smtp-Source: AK7set/OjzeWGj4KOjlA6SpAVSZ56BgBNoxppBegCpWq/ooXMAkZq37+0ef5FgFTgl0vxlaD3IeR4w==
X-Received: by 2002:a5d:4d47:0:b0:2bf:b4d1:af03 with SMTP id a7-20020a5d4d47000000b002bfb4d1af03mr6456375wru.30.1675369622035;
        Thu, 02 Feb 2023 12:27:02 -0800 (PST)
Received: from localhost.localdomain (cpc93780-hari17-2-0-cust124.20-2.cable.virginm.net. [77.98.244.125])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d6d8a000000b002bfb5bda59asm367735wrs.25.2023.02.02.12.27.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 Feb 2023 12:27:01 -0800 (PST)
From:   Kostya Farber <kostya.farber@gmail.com>
To:     git@vger.kernel.org
Cc:     Kostya Farber <kostya.farber@gmail.com>
Subject: [GSoC][PATCH] t/t5000-tar-tree: add helper function
Date:   Thu,  2 Feb 2023 20:25:57 +0000
Message-Id: <20230202202557.19297-1-kostya.farber@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the helper function test_file_path_exists to the
interpret pax header test. This change makes it clearer
as to what the test is trying to check, in this case whether
a file path exists.

Signed-off-by: Kostya Farber <kostya.farber@gmail.com>
---
Hello all. I'd like to introduce myself. My name is 
Kostya, I am new to the git open source community.

I am a data engineer by trade, but have recently gotten
into (and am really enjoying) the open source world.
My main contributions have been in the scientific 
python space (https://github.com/kostyafarber).

I have read MyFirstContribution, documentation in 
t/README and the general GSoC page. I have really 
started to enjoy low-level programming and have
been going through The C Programming Language (Second
Edition) and the Linux Programming Interface.

I am planning to submit a proposal for GSoC (hopefully) and 
want to try help out and contribute to a tool I've been using
for a long time and have love for.

Keen to speak to you all soon. 

 t/t5000-tar-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index d473048138..19d5bd0c04 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -73,7 +73,7 @@ check_tar() {
 			for header in *.paxheader
 			do
 				data=${header%.paxheader}.data &&
-				if test -h $data || test -e $data
+				if test -h $data || test_file_path_exists $data
 				then
 					path=$(get_pax_header $header path) &&
 					if test -n "$path"
-- 
2.39.0

