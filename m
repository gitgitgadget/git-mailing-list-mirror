From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [BUG] log: Non-zero exit code?
Date: Sat, 21 Aug 2010 11:52:00 +0530
Message-ID: <20100821062158.GJ6211@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 21 08:24:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmhUm-0001x0-Gh
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 08:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab0HUGX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 02:23:56 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56057 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab0HUGXz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 02:23:55 -0400
Received: by pwi7 with SMTP id 7so1330794pwi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 23:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=aTNWsyrkDJEm4M5HSGpqQCnhgxzrD/zyujlV50qL6zk=;
        b=de4LTzJ3QERV3ROXouEN91IflHifvvAhumlrj5eSPUl1EPFTMMbdV+qMdVrBw4HBj1
         e1Rxb9m/ToahZnq+DSStiBQzEkuzZpEansXssAESIDeSExSBkoexXtACRjsKKGe+Cza4
         OaAdQ6o9FysiKEvSV6UIlNV54QiiZ612zkhf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=lKatxhtjMPcmM/ke6nMZ88mSwBGRZH9GarRusPciE5nrmtMcCMY2Xfr5zda94ZhdSp
         Y3tgM9ZKJ9Z9mn2cVLz+obHxbcmhxlAvAbwaWZQmMr/il+6c41A/+KzcZQ3YPTse8E0g
         xzPghVYvqF+uPxh6zbMgI8U12vshZTfZ9flmY=
Received: by 10.142.140.20 with SMTP id n20mr1826851wfd.334.1282371834811;
        Fri, 20 Aug 2010 23:23:54 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 23sm4359960wfa.10.2010.08.20.23.23.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 23:23:53 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154115>

Hi,

Here's a quick patch to illustrate the bug report. I initially thought
Bo Yang's series was at fault, but a quick checkout-make tells me that
the problem is much deeper- Am I doing something wrong? How did we not
notice this problem for so long?

-- 8< --
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Sat, 21 Aug 2010 11:44:13 +0530
Subject: [PATCH] log: test to check exit code

Add a test to check the exit code of a simple 'git log'
invocation. The test currently fails: the exit code seems to be 141,
instead of the expected 0.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t4202-log.sh |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 2e51356..bd05bc9 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -37,6 +37,12 @@ test_expect_success setup '
 
 '
 
+test_expect_success 'exit code' '
+
+        git log
+        test_cmp $? 0
+'
+
 printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial" > expect
 test_expect_success 'pretty' '
 
-- 
1.7.2.2.409.gdbb11.dirty
