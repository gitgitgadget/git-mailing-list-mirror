Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E8120288
	for <e@80x24.org>; Fri, 21 Jul 2017 18:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754155AbdGUSnU (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 14:43:20 -0400
Received: from avasout05.plus.net ([84.93.230.250]:44344 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbdGUSnU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 14:43:20 -0400
Received: from [10.0.2.15] ([143.159.212.52])
        by avasout05 with smtp
        id nWjH1v00118PUFB01WjJD7; Fri, 21 Jul 2017 19:43:18 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Iav3YSia c=1 sm=1 tr=0
 a=CKmocqUIrzA4K3l9YJ19NQ==:117 a=CKmocqUIrzA4K3l9YJ19NQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=gfaPxlEIx6O8Qk94YawA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] config.mak.uname: set FREAD_READS_DIRECTORIES for cygwin
Message-ID: <506cb9f2-cf59-2df6-2d4c-30c82dfbf85b@ramsayjones.plus.com>
Date:   Fri, 21 Jul 2017 19:43:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

My 'make test' run for the v2.14.0-rc0 on cygwin turned up a new
test failure (over and above the v2.13.0 failures), namely t1308.23.
Running the test in the debugger showed that cygwin was fopen-ing
the 'a-directory' without problem.

On one occasion, while in the debugger, I did see fopen return NULL
while trying to open a directory. So, I created a test program which
showed reliably that fopen succeeds on a directory. (So, maybe I was
just seeing things! :-D ).

t1308 was reliably failing before this patch, afterwards it reliably
passes, so ...

[I have a full test run going at the moment, but it won't finish for
about 3 hours.]

ATB,
Ramsay Jones

 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 551e465a7..6604b130f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -185,6 +185,7 @@ ifeq ($(uname_O),Cygwin)
 	SPARSE_FLAGS = -isystem /usr/include/w32api -Wno-one-bit-signed-bitfield
 	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	COMPAT_OBJS += compat/cygwin.o
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),FreeBSD)
 	NEEDS_LIBICONV = YesPlease
-- 
2.13.0
