From: Vasily Titskiy <qehgt0@gmail.com>
Subject: Re: [PATCH v1 2/2] Ignore dirty submodule states during stash
Date: Tue, 17 May 2016 03:40:50 +0000
Message-ID: <20160517034050.GC2782@gmail.com>
References: <20160517033632.GA2782@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 05:41:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2VsP-0000e0-9F
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbcEQDkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:40:53 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35410 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbcEQDkw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:40:52 -0400
Received: by mail-yw0-f196.google.com with SMTP id v81so554066ywa.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pLyDzEnDIElvba3mAjplnV9YEd+hmpdn41oaLoONugk=;
        b=VvbLMMeV9QLnl9HmF+dGzLeBwDP464uR6zc80TQMAfEZyUgDzPRdw5K5U43+muZRIN
         3QWC3/eBfwb0Vl271x/4C/SR8Zxlr6zMoB8wklI2PpXwgqIK7PrqzINe7QYfcoRP4a3C
         jX9ELbpQ/qkb89YMCHMOMCYEcQXQkvoOkZoYh1Nwk/nJDF4IphmQBjsjH4GiCUM77tvt
         mDNfB5JFpK8PHW/udHp8eenWrztLttnzmhfVSUg+iSo9EMgivkSSa/yMJ1YAFGoeoueH
         dzyg2SW7uswcDx2y3sOtJxEH33yd7AuwxuAO0r5lRuiXhiCCZVCs/JJmr2GAxVKPIrIm
         c8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pLyDzEnDIElvba3mAjplnV9YEd+hmpdn41oaLoONugk=;
        b=dca+kBqUzmGYucgjx/i7EUJNI0ST/Mgm95qMShLeDsIphIkIfmm3sRDQPM0VUDDbZH
         KWfVBM4g89qtnkkyTBzkrRxie3eZhGd3iix0+XVDej1d5Ery6F1KUZyZDsGIusg6Tfvc
         pa3PhlZDQ/sQwRO3tD+yvHXRHYPvKMvhOl8pkyXPGxOnOvgifY71ojIKSBhdXmNxWklV
         +YZipgqQRkM2llBIN6ZsE+Tb3otcMdkEtengNvg6yJAi3ZdcNhKf+37Gy5/QRlHTCtQD
         FQVMpunjxaFcBfvjHjdf4xdfsIgEuzQK72YdmcWi4wna2YeiibOyjFCoLdFzKK4/acp0
         Bysw==
X-Gm-Message-State: AOPr4FUsUICqxhCJlcpDS9C4Al4VUoyGvMLRN0n7btRTbQZFC0nhyiJU2O5urMLXgyQ1Fw==
X-Received: by 10.37.13.214 with SMTP id 205mr2063711ybn.44.1463456452136;
        Mon, 16 May 2016 20:40:52 -0700 (PDT)
Received: from gmail.com ([2600:3c02::f03c:91ff:fe96:da77])
        by smtp.gmail.com with ESMTPSA id l188sm525999ywc.0.2016.05.16.20.40.51
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2016 20:40:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160517033632.GA2782@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294846>

It checks if 'stash pop' does not trigger merge conflics
in submodules.
---
 t/t3903-stash.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 2142c1f..e48a5b5 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -731,4 +731,39 @@ test_expect_success 'stash list --cc shows combined diff' '
 	test_cmp expect actual
 '
 
+test_expect_success 'stash ignores changes in submodules' '
+	git submodule init &&
+	git init sub1 &&
+	(
+		cd sub1 &&
+		echo "x" > file1 &&
+		git add file1 &&
+		git commit -a -m "initial sub1"
+	) &&
+	git submodule add ./. sub1 &&
+	echo "main" > file1 &&
+	git add file1 &&
+	git commit -a -m "initial main" &&
+	# make changes in submodule
+	(
+		cd sub1 &&
+		echo "y" >> file1 &&
+		git commit -a -m "change y"
+	) &&
+	git commit sub1 -m "update reference" &&
+	# switch submodule to another revision
+	(
+		cd sub1 &&
+		echo "z" >> file1 &&
+		git commit -a -m "change z"
+	) &&
+	# everything is prepared, check if changes in submodules are ignored
+	echo "local change" >> file1 &&
+	git stash save &&
+	git checkout HEAD~1 &&
+	git submodule update &&
+	git stash pop
+'
+
+
 test_done
-- 
2.1.4
