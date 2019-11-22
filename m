Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5FFC432C3
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA85420708
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dyntopia-com.20150623.gappssmtp.com header.i=@dyntopia-com.20150623.gappssmtp.com header.b="T97QsPp6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKVUXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:23:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37710 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUXT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 15:23:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id p24so4007999pfn.4
        for <git@vger.kernel.org>; Fri, 22 Nov 2019 12:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=494c1RpY3nMSTTvlBsZ1McauFRQYY/QhnA3CHhzlmsk=;
        b=T97QsPp63DXLrnj9zgGUQzG/ie1Q1yDqSYNry6psdAJKomqcEyN2MbWgtMcLmxWq5R
         WKljZRh3/I0H9nnRpLBRBkK81phaGmqjYgaxKl719ByZuLx6heWf52ElC6imffWWGE0I
         ZuohD7DXad+aUY9gPRV/GJK6C9CbhAOawOexo4X4R7DfQKigZpfeE+YtXm6JVcYuapXK
         NOcuOuhIaS/R9Pn+yk8DVvvrmP5DIit2nnh+MBHICevYjVA2aQQFVROv5+Lmv4mXCa+0
         imf8zsI/MyCmLxA/uDbgHK790CX69bZE9vGaO5vzkJ+F6hlUXFWpMwP3lg4/bfYyHtTh
         m8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=494c1RpY3nMSTTvlBsZ1McauFRQYY/QhnA3CHhzlmsk=;
        b=cdzPeItvL/4rrKHZdTC+eDFDbgFfsEizhqxYfu+7azH2dV6LB7vByenVidMmtIDqc6
         wb1tkMzljecYDjC9Be1MSS4GnlvPIEi2bCJyCN2Xltp9KADofc56k46obpe30+2Dq6wU
         beMOqexDDdfQUrFxwdprJWbVPEN7VF7cVvTYapg2BvZ7XkxTpvWQL4tByzmWPSJj5W1P
         tfn8gwdOytmYKeGT2Q4pj3IJ6MM5eTulXip5k6mnoP8hnqLm4T5oXWB2GQdL0wgyFMMH
         24UyYAsBMPrGQQkun4DmTVathsu6H4bRpH20XiJuwIjfgmM4LeaokweoZqDe9zl1AKU/
         9eZA==
X-Gm-Message-State: APjAAAWEqjjKVYXbJjIt/YarNfloOzYC9HPUrf0cLZf9e+WUPtaU/V7g
        6KMwLqRITDht5dW0WKpE0AwuUa7j1xw=
X-Google-Smtp-Source: APXvYqztJB7gxOfxqDpe8JOl2rC3Z6ubOSysJmbzjL+7VdRa1v68sfuDN35/oBajHc3xhGlHzFW42g==
X-Received: by 2002:a62:1951:: with SMTP id 78mr19806474pfz.257.1574454197921;
        Fri, 22 Nov 2019 12:23:17 -0800 (PST)
Received: from localhost ([182.232.178.105])
        by smtp.gmail.com with ESMTPSA id g11sm3791901pjv.8.2019.11.22.12.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 12:23:16 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>
Subject: [PATCH v4 0/2] Limit search for primary fingerprint
Date:   Fri, 22 Nov 2019 20:23:10 +0000
Message-Id: <20191122202312.10120-1-hji@dyntopia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121234336.26300-1-hji@dyntopia.com>
References: <20191121234336.26300-1-hji@dyntopia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of the process of implementing signature verification for git
clone, I decided to refactor/unify the code for commit and merge
verification to make it reusable during clones.

This lead me to discover that git requires merge signatures to be
trusted (as opposed to TRUST_UNKNOWN or TRUST_NEVER).  This is unlike
the behavior of verify-tag and verify-commit.

So, I figured that I'd make the minimum trust level configurable to make
the behavior of merge/commit/tag consistent.  And while doing so, I
noticed that parse_gpg_output() in gpg-interface.c assumes that the
VALIDSIG status line has a field with a fingerprint for the primary key;
but that is only the case for OpenPGP signatures [1].

The consequence of that assumption is that the subsequent status line is
interpreted as the primary fingerprint for X509 signatures.  I'm not
sure if the order is hardcoded in GnuPG, but in my testing the TRUST_
status line always came after VALIDSIG -- and that breaks the config
option to set a minimum trust level (not part of this patch):

,----
| $ git log -n1 --format="primary key: %GP" signed-x509
| gpgsm: Signature made 2019-11-16 14:13:09 using certificate ID 0xFA23FD65
| gpgsm: Good signature from "/CN=C O Mitter/O=Example/SN=C O/GN=Mitter"
| gpgsm:                 aka "committer@example.com"
| primary key: TRUST_FULLY 0 shell
`----

As per suggestion from Hamano, I also introduced a helper function,
replace_cstring().

This patch revision fixes the indentation in the test cases as well as
an erroneous const qualification.

[1]: https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=blob;f=doc/DETAILS;h=6ce340e8c04794add995e84308bb3091450bd28f;hb=HEAD#l483


Hans Jerry Illikainen (2):
  gpg-interface: refactor the free-and-xmemdupz pattern
  gpg-interface: limit search for primary key fingerprint

 gpg-interface.c | 44 ++++++++++++++++++++++++++++++++------------
 t/t4202-log.sh  | 20 ++++++++++++++++++++
 2 files changed, 52 insertions(+), 12 deletions(-)

--
2.24.GIT
