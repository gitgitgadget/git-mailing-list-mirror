From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: t9902 fails (Was:  [PATCH] attr: fix off-by-one directory
 component length calculation)
Date: Thu, 17 Jan 2013 16:04:54 -0800
Message-ID: <20130118000454.GI13449@google.com>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <20130115232400.GA16147@sigill.intra.peff.net>
 <50F64597.2070100@web.de>
 <201301172347.50157.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 01:05:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvzSU-0001ps-4a
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 01:05:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab3ARAFA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jan 2013 19:05:00 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:48993 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754925Ab3ARAE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 19:04:59 -0500
Received: by mail-pb0-f53.google.com with SMTP id un1so1053892pbc.40
        for <git@vger.kernel.org>; Thu, 17 Jan 2013 16:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=l0BjemhHgr8MocfDEd9Wu1Kcz6IhjcCMai4ouuWtFLg=;
        b=u9/JtY20e4WPJLANisCQm31pXTqLYajagqw4xMZAbeCg13mkuosFlNtogLRlsJyiHY
         hKtRnFgTwEmB1W/k4/24W/KxRp400M3AVOy4k1WOUuk0FzXEfjyjhgehsrpl5vJt8IX6
         G59P02V4SkTsw08vUI6ezvatOxckSKHhOz0OAppoo4t+UWOBF25xucLYShqgFnS0L/UH
         VLuFL5mya9hdhkz6iK7BVPx1bEgmCpicy8/NBedJyAPxR64lxiQsBH4UQ8xozPvULRZu
         QpQdZQTiX7myhyT8I3eZi5FpAOcmuUneP1YmGvKYYBtGjcXUukZ+Q8LpeLp+Q0jQKq1m
         jwiA==
X-Received: by 10.68.254.195 with SMTP id ak3mr18431489pbd.37.1358467498902;
        Thu, 17 Jan 2013 16:04:58 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id mn4sm1899387pbc.12.2013.01.17.16.04.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Jan 2013 16:04:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201301172347.50157.avila.jn@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213892>

Jean-No=EBl AVILA wrote:

> OK. I have installed practically everything related to git from the p=
ackage=20
> manager and there is a git-checkout-branches utility available.
>
> That result defeats the purpose of the test. This needs a tighter env=
ironment=20
> to work whatever the configuration of the user may be.

Presumably 'git checkout-branches' is from git-stuff.

Here's a patch to make the tested command a little less likely to
conflict with commands from the user's $PATH.  I'm not thrilled with
it because the contents of $PATH are still not tightly controlled, and
this does nothing to avoid problems due to existence of, for example,
a "git cherry-pick-branches" command.

Thoughts?  Maybe it would be enough to check that the intended get
commands are present in the completion list and other git commands are
not, ignoring binaries that might live elsewhere on the $PATH?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9902-completion.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 3cd53f8..06dcfb2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -192,19 +192,19 @@ test_expect_success 'general options' '
 '
=20
 test_expect_success 'general options plus command' '
-	test_completion "git --version check" "checkout " &&
-	test_completion "git --paginate check" "checkout " &&
-	test_completion "git --git-dir=3Dfoo check" "checkout " &&
-	test_completion "git --bare check" "checkout " &&
-	test_completion "git --help des" "describe " &&
-	test_completion "git --exec-path=3Dfoo check" "checkout " &&
-	test_completion "git --html-path check" "checkout " &&
-	test_completion "git --no-pager check" "checkout " &&
-	test_completion "git --work-tree=3Dfoo check" "checkout " &&
-	test_completion "git --namespace=3Dfoo check" "checkout " &&
-	test_completion "git --paginate check" "checkout " &&
-	test_completion "git --info-path check" "checkout " &&
-	test_completion "git --no-replace-objects check" "checkout "
+	test_completion "git --version cherry-p" "cherry-pick " &&
+	test_completion "git --paginate cherry-p" "cherry-pick " &&
+	test_completion "git --git-dir=3Dfoo cherry-p" "cherry-pick " &&
+	test_completion "git --bare cherry-p" "cherry-pick " &&
+	test_completion "git --help cherry-p" "cherry-pick " &&
+	test_completion "git --exec-path=3Dfoo cherry-p" "cherry-pick " &&
+	test_completion "git --html-path cherry-p" "cherry-pick " &&
+	test_completion "git --no-pager cherry-p" "cherry-pick " &&
+	test_completion "git --work-tree=3Dfoo cherry-p" "cherry-pick " &&
+	test_completion "git --namespace=3Dfoo cherry-p" "cherry-pick " &&
+	test_completion "git --paginate cherry-p" "cherry-pick " &&
+	test_completion "git --info-path cherry-p" "cherry-pick " &&
+	test_completion "git --no-replace-objects cherry-p" "cherry-pick "
 '
=20
 test_expect_success 'setup for ref completion' '
--=20
1.8.1
