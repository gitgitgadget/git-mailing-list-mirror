From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: t3306 failure with v1.7.5-rc1
Date: Fri, 08 Apr 2011 11:03:56 +0200
Message-ID: <4D9ECF7C.6010709@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 08 09:04:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q85jm-0007sn-KP
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 09:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab1DHHED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 03:04:03 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42552 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754567Ab1DHHEC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 03:04:02 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 82A41209A7
	for <git@vger.kernel.org>; Fri,  8 Apr 2011 03:04:01 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 08 Apr 2011 03:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:subject:content-type:content-transfer-encoding; s=smtpout; bh=gAGrfg6xOUb75MQj78XxJWLEo2c=; b=I0QShGLlZzVrjAHs5E0xLZYbizDioGnh80TKFJdw37XA5Kl94raUzJ78b5F+UVB/ErCj5biRfiLH8M5oVxXGV7RI+uBz2K0+uXswwhrsW2PdcJQ99nBXmcT8Ky4NXVbwhqBwnVuMM7PPgPgiopBlCdytVoMenEWZ3zSytGEt9Ro=
X-Sasl-enc: tiPyQG6iXIQ8Hk7LDILrJqrcpzHPaYqniJCRmaCz3GK5 1302246241
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D9A84406CC7
	for <git@vger.kernel.org>; Fri,  8 Apr 2011 03:03:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171109>

Heya,

I get this stupid test failure in test 3 of t3306. The problem is that a
dangling commit does not get pruned away when it should:

3rd
test_must_fail: command succeeded: git cat-file -p
5ee1c35e83ea47cd3cc4f8cbee0568915fbbbd29
not ok - 4 verify that commits are gone

It's a system where make complains about funny clock (I dunno why) but
can we make this more robust? The following helps with "sleep 5" but not
with "sleep 4". test_tick does not help. What's going on?

---

diff --git i/t/t3306-notes-prune.sh w/t/t3306-notes-prune.sh
index c428217..da76463 100755
--- i/t/t3306-notes-prune.sh
+++ w/t/t3306-notes-prune.sh
@@ -62,7 +62,9 @@ test_expect_success 'remove some commits' '

 	git reset --hard HEAD~1 &&
 	git reflog expire --expire=now HEAD &&
+	sleep 5 &&
 	git gc --prune=now
 '

 test_expect_success 'verify that commits are gone' '
