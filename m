Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC714C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9459D205F4
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tY02Rvc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgCLVby (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:31:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46795 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgCLVby (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 17:31:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id n15so9423911wrw.13
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 14:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZKwNVDBg8f8XBbGDGJCnON4U4t5+XDM3/v7hLGq5IlE=;
        b=tY02Rvc3kpuMyckJHLyN6pQl4GEd68jfp8/ST3RWK3WL5EgpvOMIlE5rItU1gMLcV/
         aLvIkCzBq8Pl/pebL1WdZ0dbQ54/x+0knlud9noc6ou1EHfPkqdCwHWwqluqVjjD9d04
         y9d6Y0nKHpHAvbxQahAf94Eg2Cp2SmE9uH+l393PVd3k7tMTV5kCbMDOtDe9fqPFKTeX
         ZdH3QYg072s98lBTLLA6zpSVriptHhUjpHBEoCiYK6SOnHOLTHDXovdEZEPVopIDJ3Qx
         tv+zRIolwWdhNW5oHfkO3sXSduJre4leUCCFFg6qyDfEXwdQsUqS2zorGVcRZj3RittZ
         R4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZKwNVDBg8f8XBbGDGJCnON4U4t5+XDM3/v7hLGq5IlE=;
        b=PQwn7wk1ZR4X3fZc4ORoYi+Be/LpNj6o/yQwcGu2zMwIUhdIXDB8QKoQ/QOBJkzLRc
         fnAVpxwqBMqtqlLRBBaKdOYV4Eg5m3zeLXNu4d4iPM90+LE+Yr8OB8zTBX1GlJXsphzU
         wjOly6jRofpswpxv8hXr1wbAksYKKYCACChXG75dSMp7wJhpH7yvqZ/RC2tecIQQnoBl
         Ul6G6dXJQ3QmO2kjg5+LZlbtgOp90kDfqJyUCFIfa5QBcQpp1hbPUB+1SuIQCujpqk9h
         Zd0z6NHzx00UdJ97SZYeKb5wBLwvivFkHWBOvFWWvrQFI2GUvc1S4T1AbQdZ1ISirxcN
         H5wA==
X-Gm-Message-State: ANhLgQ2D7IWzzcMwyFK9utWSzKlXoQ6kQY70JV5tT0G94721kOWgdNFE
        iSP8NUyggdMWCZp7ZWget7pCjyAi
X-Google-Smtp-Source: ADFU+vtAuWBITkR2kcO76d/KyvPrIQwDSrmfF2rEnNK5dZV25WM3YJ/EnQeFvKs2O2BQuv3ZlRFMhw==
X-Received: by 2002:a05:6000:370:: with SMTP id f16mr13322860wrf.9.1584048711760;
        Thu, 12 Mar 2020 14:31:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm6790188wrr.17.2020.03.12.14.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:31:51 -0700 (PDT)
Message-Id: <pull.578.v2.git.1584048710895.gitgitgadget@gmail.com>
In-Reply-To: <pull.578.git.1583954676691.gitgitgadget@gmail.com>
References: <pull.578.git.1583954676691.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Mar 2020 21:31:50 +0000
Subject: [PATCH v2] git-gui--askpass: coerce answers to UTF-8 on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Luke Bonanomi <lbonanomi@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Bonanomi <lbonanomi@gmail.com>

This addresses the issue where Git for Windows asks the user for a
password, no credential helper is available, and then Git fails to pick
up non-ASCII characters from the Git GUI helper.

This can be verified e.g. via

	echo host=http://abc.com |
	git -c credential.helper= credential fill

and then pasting some umlauts.

The underlying reason is that Git for Windows tries to communicate using
the UTF-8 encoding no matter what the actual current code page is. So
let's indulge Git for Windows and do use that encoding.

This fixes https://github.com/git-for-windows/git/issues/2215

Signed-off-by: Luke Bonanomi <lbonanomi@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Fix git-gui--askpass on Windows
    
    Windows has this odd thing where there is an active code page (somewhat
    like LC_CTYPE) and there is no real UTF-8 code page. So we need to help 
    git-gui--askpass along a bit to be of use when asking for credentials.
    
    Changes since v1:
    
     * Fixed indentation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-578%2Fdscho%2Fgit-gui--askpass-utf-8-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-578/dscho/git-gui--askpass-utf-8-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/578

Range-diff vs v1:

 1:  3beec773772 ! 1:  7891941486d git-gui--askpass: coerce answers to UTF-8 on Windows
     @@ -20,6 +20,7 @@
          This fixes https://github.com/git-for-windows/git/issues/2215
      
          Signed-off-by: Luke Bonanomi <lbonanomi@gmail.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       diff --git a/git-gui--askpass b/git-gui--askpass
     @@ -30,7 +31,7 @@
       	}
       
      +	# On Windows, force the encoding to UTF-8: it is what `git.exe` expects
     -+		if {$::tcl_platform(platform) eq {windows}} {
     ++	if {$::tcl_platform(platform) eq {windows}} {
      +		set ::answer [encoding convertto utf-8 $::answer]
      +	}
      +


 git-gui--askpass | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-gui--askpass b/git-gui--askpass
index 4277f30c411..1c99ee8ca20 100755
--- a/git-gui--askpass
+++ b/git-gui--askpass
@@ -56,6 +56,11 @@ proc finish {} {
 		}
 	}
 
+	# On Windows, force the encoding to UTF-8: it is what `git.exe` expects
+	if {$::tcl_platform(platform) eq {windows}} {
+		set ::answer [encoding convertto utf-8 $::answer]
+	}
+
 	puts $::answer
 	set ::rc 0
 }

base-commit: 63a58457e094c9c9bbf562b872009d32f1f88133
-- 
gitgitgadget
