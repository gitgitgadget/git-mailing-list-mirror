Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A84C2BA2B
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 04:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F260921744
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 04:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=blastwave.org header.i=@blastwave.org header.b="PwlBS3gd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDSE7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 00:59:51 -0400
Received: from mail.oetec.com ([108.160.241.186]:51500 "EHLO mail.oetec.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgDSE7u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 00:59:50 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Apr 2020 00:59:50 EDT
X-oetec-MailScanner-From: dclarke@blastwave.org
X-oetec-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-1.199, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
        DKIM_SIGNED 0.10, DKIM_VALID -0.10, DKIM_VALID_AU -0.10,
        DKIM_VALID_EF -0.10, URIBL_BLOCKED 0.00)
X-oetec-MailScanner: Found to be clean
X-oetec-MailScanner-ID: 03J4qKxl028763
X-oetec-MailScanner-Information: Please contact oetec for more information
Received: from [172.16.35.3] (CPEf81d0f84cb23-CMf81d0f84cb20.cpe.net.cable.rogers.com [99.253.169.68])
        (authenticated bits=0)
        by mail.oetec.com (8.15.2/8.15.2/Debian-8) with ESMTPSA id 03J4qKxl028763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 00:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blastwave.org;
        s=default; t=1587271941;
        bh=5O/Ff32lv7Imkpfw7mzKQbM28O807sK+rHpXj0ZMQbM=;
        h=To:From:Subject:Date:From;
        b=PwlBS3gd5RDWFOzkln+8uK4M4Rh0I9E8sktKq3JZYciX8dLIUXKO+hLQLiZ/egY8X
         gAc79+fadCb7BcEp6VjJxzK1UdT3asyFAh/8TDLVMscAWFO3hoO3baqQyl5tEicbaP
         qNtAdwRfpm/6HmrVigk8JhWMvRA3X+xfAvyLRsI+sUZNcV2E6KUYmtIhVJsjwIH4TW
         D/d8NIS7ErxZymAGRHsEhEVRm7vaamdSljd2bfiEbSFuyYHuS/oWr/tsWohFtcImfK
         M2xuuxl3MbW+xDx4O9fSZqIwli/SelW+KL5gDDhqPzO2nlNG0kNeeSRREcvB5BNdf+
         V6wnTcjnlJffA==
To:     git@vger.kernel.org
From:   Dennis Clarke <dclarke@blastwave.org>
Subject: minor patch required to compile git 2.26.1 on Oracle Solaris 10 with
 Oracle Studio
Message-ID: <6bf94982-71c4-78e9-0f4d-7fa4e485c417@blastwave.org>
Date:   Sun, 19 Apr 2020 04:52:20 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Very minor patch required :


--- ./compat/inet_ntop.c.orig   Tue Apr 14 01:51:03 2020
+++ ./compat/inet_ntop.c        Sun Apr 19 04:16:39 2020
@@ -168,7 +168,7 @@
   *     Paul Vixie, 1996.
   */
  const char *
-inet_ntop(int af, const void *src, char *dst, size_t size)
+inet_ntop(int af, const void *src, char *dst, unsigned int size)
  {
         switch (af) {
         case AF_INET:
--- ./git-compat-util.h.orig    Tue Apr 14 01:51:03 2020
+++ ./git-compat-util.h Sun Apr 19 03:56:17 2020
@@ -795,7 +795,7 @@
  #endif

  #ifdef NO_INET_NTOP
-const char *inet_ntop(int af, const void *src, char *dst, size_t size);
+const char *inet_ntop(int af, const void *src, char *dst, unsigned int 
size);
  #endif

  #ifdef NO_PTHREADS
#
# exit

That allows compile to proceed beatly with :

alpha$
alpha$ cc -V
cc: Studio 12.6 Sun C 5.15 SunOS_sparc 2017/05/30



-- 
Dennis Clarke
RISC-V/SPARC/PPC/ARM/CISC
UNIX and Linux spoken
GreyBeard and suspenders optional
