Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8128D20899
	for <e@80x24.org>; Thu, 10 Aug 2017 10:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbdHJKYH (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 06:24:07 -0400
Received: from mout.web.de ([217.72.192.78]:57671 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752012AbdHJKYF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 06:24:05 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8iLA-1dlDjc170O-00C7mE; Thu, 10
 Aug 2017 12:23:48 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] win32: plug memory leak on realloc() failure in syslog()
Message-ID: <245410ce-1f4c-f2a9-fd8d-98ff2d2c0335@web.de>
Date:   Thu, 10 Aug 2017 12:23:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:2NYblIMp4jJww6dgRjYP89rRVCxTKBgBZZwBkQj+nCI9EfT5HGg
 WWIewb8ItGCrwbP+B8RcxJnh/ovv4tLbKB64bJbXm5j+pfDSfk43BUZI96xGBULG9SSjBAI
 UgfxhvcH2Lgu6wO6T88EdTIWsHHTrzlb6PHl87no51HJANQIU8FLTCtoTLzQMpzcR5Jgpnu
 HeJ/vVzicsD7eZApmalag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dl4PSVJCDaE=:VtGnie7RtINznLvE84UbbZ
 iISuUL7qwhjwQczpaJ0qDBd8Pd/7Ilf3nx0PkYa2w0upow+8HSDrdY8LZjvp/NuBB4oPF4J2J
 tVnLEwPdzSDOLQB1UE+wQnDVx6a286UIXu51fD7VhPXvaNkkD1qkGj0Xw9xymEuelkI7dsF8J
 xT12RjlWRANbTSAu0aSAOmpe9VlLbNw64H5CgRAdgwTm+crLXe/d9n6Nv0fNCH+2HPF7zoJjm
 hXFAKoZE2EcpK6UGEJhbh0il0DhI2/J4U8jV4gLldPoWAM9MTX5Szn3OduIQcOZxkW2hirQS1
 JvltUgbik76xxt69/7iptC67x3qvUjDe+hg2DWLnCuTBAdjfhCQf4qZOvFtNwXujV9NVlggrC
 W5yXYgt6cfTgvZsDO9KnsBTRRky75Q1pKvTJLci7lsRWlj5AqISzW8/7VU4JUtOR3iffgarl8
 FDT3FLXO3AyE1oGD6iY9rIYknlbGbpqq6vntUECIm66R9FvR8Ij4CvatZeHUM+3sTcdAAE85A
 EcnmVEyc5VwKoThxGd785SrALJnT6Bx8S4zHZFhLqDEqqrKJgVP0UWT0Rebs6K8EXx8OWbBrp
 M8S9Nz9CzDZVmFSOPPz8IrOfT0AARVPaxseguZkPX3V00ouVSJkZxxA/xkVKHtLZ5EQlAaXtF
 6IHa4iEpx9HkqJZJKr607dIE6oTke5rmCZ6rmo9jlTE4EF1y5i+5IIHwGrzTPbk3TWhn0oC8z
 ep9OtegLjc3MGjYCxdqhaM6OLKFeq9rS1EAxUxacRuH1rTYUNTlTp9v6qEbh2dBm/sIRv2Xee
 HYQoKCOOxQ4KBEnZyiB9eLtTY+rX0f6p4McjCWGCX3odvWmZo8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If realloc() fails then the original buffer is still valid.  Free it
before exiting the function.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 compat/win32/syslog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/win32/syslog.c b/compat/win32/syslog.c
index 6c7c9b6053..161978d720 100644
--- a/compat/win32/syslog.c
+++ b/compat/win32/syslog.c
@@ -43,8 +43,10 @@ void syslog(int priority, const char *fmt, ...)
 	va_end(ap);
 
 	while ((pos = strstr(str, "%1")) != NULL) {
+		char *oldstr = str;
 		str = realloc(str, st_add(++str_len, 1));
 		if (!str) {
+			free(oldstr);
 			warning_errno("realloc failed");
 			return;
 		}
-- 
2.14.0
