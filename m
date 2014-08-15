From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Git on Mac OS X 10.4.10
Date: Fri, 15 Aug 2014 00:46:11 -0700
Message-ID: <273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c>
References: <53ECA7DB.7060407@jump-ing.de> <53ECCA14.40900@web.de> <53ED0257.3070505@jump-ing.de> <xmqqppg21wyk.fsf@gitster.dls.corp.google.com>
Cc: Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 09:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XICDR-0005Wh-9Z
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 09:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344AbaHOHqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 03:46:21 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:40645 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbaHOHqU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 03:46:20 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so2922554pdj.26
        for <git@vger.kernel.org>; Fri, 15 Aug 2014 00:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pjL7s5t9mchtcUCapJHvOfpc5RD5hwrCBqwQvd7XYcc=;
        b=smlGjsZJq34hVRIbpPONTFmNVb3u3oKLCOZCaIDoEM8eEGIH8ih1AbOTnKMGqoQhp8
         Zq44Z2V20vn/7aiDOsVvzmUjQ2CAiWfdaJ+ATCi8CXr13JgXXfJSBWjmHadB8Fu/ctID
         eci/qzwtUKNxv7V8i/tc1kLRUsV+vVfFxoT+WvmzD5vgzDHNT0dpkeWzCNRs6svldEuU
         UtO9HfciyPAbfgvCnlAm1d1upleDLtPXMucCgdBfGk3xkQEz58nVK9LlkXuIlOOC6nQw
         ZJmtwaU+2cH2Z9qbUwEP/hk5CdFss2fRGMTWr5KecKIDFNtJO9I1mncjMxvgxZb93jo9
         hr9w==
X-Received: by 10.70.55.228 with SMTP id v4mr10842475pdp.117.1408088776956;
        Fri, 15 Aug 2014 00:46:16 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id np15sm10942821pdb.84.2014.08.15.00.46.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Aug 2014 00:46:16 -0700 (PDT)
In-Reply-To: <xmqqppg21wyk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255282>

On Aug 14, 2014, at 16:18, Junio C Hamano wrote:

> Markus Hitter <mah@jump-ing.de> writes:
>
>>> The  <CommonCrypto/CommonHMAC.h> is in Mac OS X 10.6 .. 10.9,
>>> but not in 10.4 (I don't know about 10.5).

That header is new with 10.5

> Is this about platform dependency, or what the end user happens to
> choose to install (in other words, is there an add-on users of 10.4
> can choose to add, which allows them to use that header)?

Nope, it's a platform dependency.  Not available prior to 10.5.

The below patch does the right thing.  Conveniently there's already
a test for 10.4 and earlier so only a single line need be added.

--Kyle

---- 8< ----
Subject: [PATCH] config.mak.uname: set NO_APPLE_COMMON_CRYPTO on older systems

Older MacOS systems prior to 10.5 do not have the CommonCrypto
support Git uses so set NO_APPLE_COMMON_CRYPTO on those systems.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 7846bd76..f8e12c96 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -88,6 +88,7 @@ ifeq ($(uname_S),Darwin)
 	NEEDS_LIBICONV = YesPlease
 	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
 		OLD_ICONV = UnfortunatelyYes
+		NO_APPLE_COMMON_CRYPTO = YesPlease
 	endif
 	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
 		NO_STRLCPY = YesPlease
-- 
1.8.5
