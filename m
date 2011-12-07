From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] test: remove a porcelain test that hard-codes commit
 names
Date: Wed, 7 Dec 2011 08:49:29 -0600
Message-ID: <20111207144929.GC30157@elie.hsd1.il.comcast.net>
References: <4EDDD0E4.6040003@st.com>
 <87fwgxwvn9.fsf@gmail.com>
 <7vobvlfowk.fsf@alter.siamese.dyndns.org>
 <7vk469fm9j.fsf@alter.siamese.dyndns.org>
 <20111207144217.GA30157@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Vijay Lakshminarayanan <laksvij@gmail.com>,
	Viresh Kumar <viresh.kumar@st.com>,
	Shiraz HASHIM <shiraz.hashim@st.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 15:49:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYIoW-0008Pg-Aa
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 15:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756187Ab1LGOtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 09:49:35 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40984 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756105Ab1LGOte (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 09:49:34 -0500
Received: by iakc1 with SMTP id c1so1032370iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 06:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GyK0f9ZwuUhpW8G1/yEVU/wk1808cBP9u1wGLmQ2gIc=;
        b=acR7E09bbiKOxykdmfjUYNyk4l6unMsCoZqWisqGrjfqaobcWwLBjeDdwDN4+NybFG
         gRQkTDpSe1uN2XMMG3uQ3AHHWGFodAAQrn6siXw4RQvXJEWtWrzowPWzHj63Y/t/iXe1
         hzV9SwaZAxJGTek+Lc5k+ARRH7zHqlQI0Ue9Q=
Received: by 10.42.163.202 with SMTP id d10mr18905055icy.47.1323269373932;
        Wed, 07 Dec 2011 06:49:33 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p16sm7570234ibk.6.2011.12.07.06.49.33
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 06:49:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111207144217.GA30157@elie.hsd1.il.comcast.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186459>

The rev-list output in this test depends on the details of test_tick's
dummy dates and the choice of hash function.  Worse, it depends on the
order and nature of commits made in the earlier tests, so adding new
tests or rearranging existing ones breaks it.

It would be nice to check that "git commit" and commit-tree name
objects consistently and that commit objects' text is as documented,
but this particular test checks everything at once and hence is not a
robust test for that.  Remove it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hence the odd hunk in the previous patch.

Maybe this doesn't belong in this series, but it's the kind of thing
that drives me batty when writing new tests.

 t/t7501-commit.sh |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index da75abc1..9c507b08 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -144,10 +144,6 @@ test_expect_success PERL \
 	git diff >diff2 &&
 	test_cmp diff1 diff2"
 
-test_expect_success \
-	"showing committed revisions" \
-	"git rev-list HEAD >current"
-
 cat >editor <<\EOF
 #!/bin/sh
 sed -e "s/good/bad/g" < "$1" > "$1-"
@@ -168,22 +164,6 @@ test_expect_success \
 	 echo "Another good message." | EDITOR=./editor git commit -a -F - &&
 	 git show -s --pretty=format:"%s" | grep -q good
 	 '
-# We could just check the head sha1, but checking each commit makes it
-# easier to isolate bugs.
-
-cat >expected <<\EOF
-285fcf7ec0d61b14249dfdb4c1e1fe03eaf15ee0
-0b8148b9afce917b87d71199b900466dc8ea8b6e
-43fb8826314939ce79a856face7953557fdca3d1
-eaa04bc3ae0f0b003f7f1d86bf869ec5d73eaf3e
-ee1963b250ee0f02a3fe37be0e4a02bb5af6a1ad
-b49f306003c627361a0304d151a6b4c8b26af6a1
-402702b49136e7587daa9280e91e4bb7cb2179f7
-EOF
-
-test_expect_success \
-    'validate git rev-list output.' \
-    'test_cmp expected current'
 
 test_expect_success 'partial commit that involves removal (1)' '
 
-- 
1.7.8.rc3
