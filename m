Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3413C433EF
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 10:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A3786187D
	for <git@archiver.kernel.org>; Sun,  3 Oct 2021 10:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhJCK4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Oct 2021 06:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJCK4U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 06:56:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAD6C0613EC
        for <git@vger.kernel.org>; Sun,  3 Oct 2021 03:54:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u7so11969509pfg.13
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ok0mNwfQLFVlg+LFfFDC/1UGO2g/lVsfjmL+3KkFV9Y=;
        b=dotKvhXP9kDWL9u3WaSfw1AL7QgEWYHX96WwETsLmcGBa+2SVIWjojzUow2+lDYgkU
         d99Xsi1IHW6PXdEZBwDyfAH0lhhbcwsHBpdAfIiTh/ipBJ+l5Mo6rgYlCQauseR2JXhh
         INXDiY5Mi20sZkme2PjetC13ta3vf9WvDSB1gO9r9tdqq2Zol1amIG+t4vseb8d2yOJt
         qYSPKHYlCLEX7RmH4GK4ncms5JyxBP2TRTN+1m5H/H+Ac28ZzfAC7uGXRkbT/5VqCGfc
         8qF5vxZlJTkpO2i0M9w+McPbCmlxlp38ZYX2aRgARO1eY7aX4kp4wjPsATlLHWQWNlnO
         YrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ok0mNwfQLFVlg+LFfFDC/1UGO2g/lVsfjmL+3KkFV9Y=;
        b=IBQVSAR4UL7Gy4qUO3HgsFbD7J/4bCs5fYxAa5NtNb4NVyE5q+xlc3TU4RNCNdlEYK
         fhCWtroJjkdFLM2RsFGaKPbAgUydhuwjP/g4fDDr9UyplPG5u61PQtYWPQpAnFInemtL
         N3ZQFUdr8+KfE+LDh0Tdk5U2Kbp+T6yPCcsTFmpWzyTeuRtv8uNWbBahE7yvwBvJjNhK
         ODR3w9K7XtNUrpP/oc5V3/cSELi6GDIFdvglAF2M9ecZ1XQPCgOrCpb5+xhvnEnmXQlt
         s4ltNFTjb3O0kq4WQpNWxLMdilJGPk8Cp8RhxGzDU2Vp1RLX8pT56Rfv1MT0JueDCasr
         lK4w==
X-Gm-Message-State: AOAM531fwbwZong+jwbSGvL6QKL9S69Ojw9zHYoxZwyuOg1Zhs10h7Pt
        /UNOOdlMuBnqlWzO7oK1n9EmSrr8Nlgriw==
X-Google-Smtp-Source: ABdhPJxFuNtiZfIqjvnxJ1kFrmg67S2VaaD0/ORVMvMUxdUJJMMYt1o5SJAHT5XVrypyVmIHTLyuRw==
X-Received: by 2002:a05:6a00:c3:b0:43d:e6be:b2a6 with SMTP id e3-20020a056a0000c300b0043de6beb2a6mr19477124pfj.34.1633258473142;
        Sun, 03 Oct 2021 03:54:33 -0700 (PDT)
Received: from ubuntu.mate (subs03-180-214-233-29.three.co.id. [180.214.233.29])
        by smtp.gmail.com with ESMTPSA id u1sm11263163pju.2.2021.10.03.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 03:54:32 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Dr . Matthias St . Pierre" <m.st.pierre@ncp-e.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v4 0/2] blame: documentation update
Date:   Sun,  3 Oct 2021 17:53:26 +0700
Message-Id: <20211003105327.215996-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document the default output format for git-blame(1), as well as the
--color-* options which are currently undocumented but mentioned in
usage help.

Changes since v3 [1]:
  - grammatical and wording fixes (suggested by Eric and Junio)
 
Bagas Sanjaya (2):
  blame: describe default output format
  blame: document --color-* options

 Documentation/blame-options.txt | 13 +++++++++++++
 Documentation/config/color.txt  | 33 ++++++++++++++++++---------------
 Documentation/git-blame.txt     | 17 +++++++++++++++--
 3 files changed, 46 insertions(+), 17 deletions(-)

Range-diff against v3:
1:  2478909d67 ! 1:  976c17a485 blame: Describe default output format
    @@ Metadata
     Author: Bagas Sanjaya <bagasdotme@gmail.com>
     
      ## Commit message ##
    -    blame: Describe default output format
    +    blame: describe default output format
     
         While there is descriptions for porcelain and incremental output
         formats, the default format isn't described. Describe that format for
    @@ Documentation/git-blame.txt: include::blame-options.txt[]
     +`git blame` will output annotation for each line with:
     +
     +- abbreviated object name for the commit the line came from;
    -+- author ident (by default author name and date unless `-s` or `-e` is
    ++- author ident (by default author name and date, unless `-s` or `-e` is
     +specified); and
     +- line number
     +
2:  a6f75786ec < -:  ---------- blame: document --color-* options
-:  ---------- > 2:  517dc2cb3d blame: document --color-* options

[1]:
https://lore.kernel.org/git/20211001113725.13354-1-bagasdotme@gmail.com/T/#t

base-commit: cefe983a320c03d7843ac78e73bd513a27806845
-- 
An old man doll... just what I always wanted! - Clara

