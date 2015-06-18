From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 11/19] fsck: Add a simple test for receive.fsck.<msg-id>
Date: Thu, 18 Jun 2015 22:08:59 +0200
Organization: gmx
Message-ID: <0477fc78ad957fa2debd48664a7e290eb4fbf86c.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:09:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g7n-0003Qd-IK
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757063AbbFRUJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:09:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:62861 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756931AbbFRUJD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:09:03 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Md3Eg-1ZMnWr2t1u-00IBwF; Thu, 18 Jun 2015 22:08:59
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:emOEImuJ3JnM6WyrJ9Hon3YzMmd8IoD1+8wU1p9eTHKyVzrht2/
 VjsBx3JNtvG0eQTaz1b6lYVeVB0G4WfbNZZo+obYppvRvdGsmQiWLYtEsuI2zCouHv3UF9V
 Vt9bEgWb8vUrNoiOwvIpdSUgzgGXinVp5HOERrEZdQ41blpA2Vq/n+671DNG09gZoMqWl4w
 57b/tR3GEW6sQjQG0634Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3tdoVJm5gGk=:YjkJkPHsZsnVZPOgesMck3
 AQiISrsMZGS8z7+bM8g+zYWofDZ+RCVIXJwlhZzLBYfhLiah9nWqTTlUkdz3axLSHRoG5rEZc
 BGz2lL0PmzC4wYbORmkeF2T37msiUpGDJIoZM9tMKkE4qQQ1zEJLkJVymamvyhdIC5EfZWbVo
 rlmyfWUTM08b3nFkTCO1LtDy1dg/bR+jB7eoDOSXmxeeMwzC2W772JWScmJOVfiNv6XB6lu8i
 lpD85+dMKTjrk4t1+BK2fiVx4t53dUTCqKKB2aBVwKyB6T7BfUNOWVMIkOzBkFOzV1ouwFfnW
 VT4PDBsknD/lNLxLYbVoEl9r6tIlMoWYPKA9cQWGchpi8rNudPCoou9uQ5IYuH+DL2TB+mO94
 rvxuAsliJ2MQfbtAEKsqlrcp7v8qfQsY7U5k9mX4Bb2QI1FNB7kk2YbpDuU2zWQOgkTAyW5Q8
 Ll0KGEvffOzaBuYV4KxYthHXDcnpiQm9mMvzjMrw8luAMZ4yJXMIk9Z+ve6WSboivBXGrlEXE
 AqRnn3EAm19W3qzGY9XAgkku3DRuBM/smSkHBjK2C86giat+RdKrHVk7di2obK/x+bYmoErXQ
 XPWb6TW+uGmA5xpDLg8ZiEjM+HSkkmPaJN9qJ/P5gt7lLwdl5lR4mzuuB2RKfv2qYE4gHw93b
 I8xZXIMvx3gQP8l3hoD9YOujiav52fUfWmXBkuWm++cPiPsbmCQIzyqoMx+rYgCEBOIM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272052>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5504-fetch-receive-strict.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 69ee13c..3f7e96a 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -115,4 +115,25 @@ test_expect_success 'push with transfer.fsckobjects' '
 	test_cmp exp act
 '
 
+cat >bogus-commit <<\EOF
+tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+author Bugs Bunny 1234567890 +0000
+committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+This commit object intentionally broken
+EOF
+
+test_expect_success 'push with receive.fsck.missingemail=warn' '
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config \
+		receive.fsck.missingemail warn &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	grep "missingemail" act
+'
+
 test_done
-- 
2.3.1.windows.1.9.g8c01ab4
