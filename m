From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH] crlf: Add test showing double warning on commit
Date: Sat, 14 May 2016 12:17:55 +0100
Message-ID: <20160514111755.GG2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 13:18:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1XaG-0002DF-Sf
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 13:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020AbcENLSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 07:18:03 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34126 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbcENLSA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 07:18:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so8449588wmn.1
        for <git@vger.kernel.org>; Sat, 14 May 2016 04:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zu24+8EVBZZ3/SxhYjIBSD69+1VrTa67YWPJ5+pPV/c=;
        b=aV0H0aKG4FZaGJ7f6M5Raw7DWyomZ3YuO7y2pjlvdPALPbW8u/p5cxVDRcqQpkLRA4
         i9WJAbXpdafbUGSk2uDRaZnH4NIJU+LNJ4OE8LMRPQTKKG9KIvwYiXCTKBgTBa53+vlj
         XdvAWRub+pZrfkKRHaV4nc5qWNv+sSPhS0uRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zu24+8EVBZZ3/SxhYjIBSD69+1VrTa67YWPJ5+pPV/c=;
        b=OxJujJK3pfTBI496QUs+2zSbxrz29bofclAopPdrZmmJcoI6fwQsMQBFNkoSpCJ6GJ
         cRhUZ4hs7OyR8LedsWD7qePTPV5IPxuCSVRIzf/hyndkYmp37l+hqXvprVgu4iQbV5zS
         jO+koDFxJG2se7/5+i7dxiN0gmsupEC4yCZDG/OB7glLT5VgsxQQ4o7QxEYce+n1cxkF
         8kA3Ky/2/niQ+ApOr9skw9rHX6i1ySViuxCue5qWQn/12e0ujE/JKTP3Nb9QQjb8E/Vs
         XcBIrfI1sUOaOXEe2RlUFFTk9S1yX9z9bRk29ki+aq1wW7A+bQpA4cyCe2IUx74bM+Hv
         ggdA==
X-Gm-Message-State: AOPr4FUvfYB2nGIppr+OY9P2WI7A+5ut0KIUTDiWhwAPqpB29Xi9WZcoGNgZR+nR1+qyeQ==
X-Received: by 10.28.62.15 with SMTP id l15mr8345586wma.30.1463224679439;
        Sat, 14 May 2016 04:17:59 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id b1sm7835887wma.13.2016.05.14.04.17.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 14 May 2016 04:17:58 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294608>

Add failing test case showing CRLF -> LF rewrite warnings being printed
multiple times when running "git commit".

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 t/t0020-crlf.sh | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index f94120a..188b1dd 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -74,7 +74,7 @@ test_expect_success 'safecrlf: autocrlf=true mixed LF/CRLF' '
 	test_must_fail git add mixed
 '
 
-test_expect_success 'safecrlf: print warning only once' '
+test_expect_success 'safecrlf: print warning only once on add' '
 
 	git config core.autocrlf input &&
 	git config core.safecrlf warn &&
@@ -87,6 +87,20 @@ test_expect_success 'safecrlf: print warning only once' '
 '
 
 
+test_expect_failure 'safecrlf: print warning only once on commit' '
+
+	git config core.autocrlf input &&
+	git config core.safecrlf warn &&
+
+	for w in I am all LF; do echo $w; done >doublewarn2 &&
+	git add doublewarn2 &&
+	git commit -m "nowarn" &&
+	for w in Oh here is CRLFQ in text; do echo $w; done | q_to_cr >doublewarn2 &&
+	git add doublewarn2 2>&1 &&
+	test $(git commit -m Message | grep "CRLF will be replaced by LF" | wc -l) = 1
+'
+
+
 test_expect_success 'safecrlf: git diff demotes safecrlf=true to warn' '
 	git config core.autocrlf input &&
 	git config core.safecrlf true &&
-- 
2.8.1
