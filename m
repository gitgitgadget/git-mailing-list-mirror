From: =?UTF-8?B?IkFuZHLDqXMgRy4gQXJhZ29uZXNlcyI=?= <knocte@gmail.com>
Subject: [PATCHv3] transport: Catch non positive --depth option value
Date: Thu, 21 Nov 2013 16:27:28 +0100
Message-ID: <528E2660.6020107@gmail.com>
References: <5283A380.9030308@gmail.com>	<xmqqzjp1bqm3.fsf@gitster.dls.corp.google.com>	<528A9877.4060802@gmail.com> <xmqq61ro9utf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 16:27:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjWAY-0000gR-21
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 16:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753974Ab3KUP1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 10:27:46 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:46057 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041Ab3KUP1p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 10:27:45 -0500
Received: by mail-wi0-f177.google.com with SMTP id hq4so1211689wib.16
        for <git@vger.kernel.org>; Thu, 21 Nov 2013 07:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=hakbM+5zo1A6nltEr5j9z9elEB4f8tanNSBBm8wfuqc=;
        b=vpjlwfxsSv8g8VEfQbbJO5F8jG6rpsdSfeGNdV3E88QbktuKoq50Q9ny3Nq3M5SMlx
         HZ5ZV6IsCvQfhbeWE4wYvuDxvisyjbPajPCmNMiEC9+SZjdqUA00kq9pVF39CGciGb9u
         Oth7JlD7x8X6QsrocSOXeQ0AJJDEhTTtx9NUAX/+nqPDXlIioWb75xKPuLgahV/h2BRx
         oM5iSCdTSSkuno1fTo8zcdDwUAzhH6gTsTQRr3aH4E0okLh/3J8Yh1buQ7recTaUBdM2
         bSf0UhBmZuGKPiV2bnErOYR+l8F53ARPk2BB2Zz7IbK6Uok1EhfcxVuoFnTWM6Ido4Zv
         5C8w==
X-Received: by 10.194.63.228 with SMTP id j4mr5996599wjs.34.1385047664511;
        Thu, 21 Nov 2013 07:27:44 -0800 (PST)
Received: from [192.168.0.151] (147.Red-88-23-71.staticIP.rima-tde.net. [88.23.71.147])
        by mx.google.com with ESMTPSA id je17sm6195125wic.4.2013.11.21.07.27.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 21 Nov 2013 07:27:43 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqq61ro9utf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238126>

>From 99e387151594572dc136bf1fae45593ee710e817 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Andr=C3=A9s=20G=2E=20Aragoneses?= <knocte@gmail.com>
Date: Wed, 13 Nov 2013 16:55:08 +0100
Subject: [PATCH] transport: Catch non positive --depth option value

Instead of simply ignoring the value passed to --depth
option when it is zero or negative, now it is caught
and reported.

This will let people know that they were using the
option incorrectly (as depth<0 should be simply invalid,
and under the hood depth==0 didn't have any effect).

Signed-off-by: Andres G. Aragoneses <knocte@gmail.com>
Reviewed-by: Duy Nguyen <pclouds@gmail.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com> 
---
 transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/transport.c b/transport.c
index 7202b77..edd63eb 100644
--- a/transport.c
+++ b/transport.c
@@ -483,6 +483,8 @@ static int set_git_option(struct git_transport_options *opts,
 			opts->depth = strtol(value, &end, 0);
 			if (*end)
 				die("transport: invalid depth option '%s'", value);
+			if (opts->depth < 1)
+				die("transport: invalid depth option '%s' (must be positive)", value);
 		}
 		return 0;
 	}
-- 
1.8.1.2
