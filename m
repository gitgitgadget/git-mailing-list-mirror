From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/7] clone: test the new HEAD detection logic
Date: Tue, 17 Sep 2013 22:14:23 -0700
Message-ID: <1379481263-29903-8-git-send-email-gitster@pobox.com>
References: <1379481263-29903-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 07:14:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMA6J-0006Dp-Q2
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 07:14:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750Ab3IRFOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 01:14:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38079 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751719Ab3IRFOk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 01:14:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3C2C3C95D;
	Wed, 18 Sep 2013 05:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/8Ha
	0N4AQaoc6W2LG9Re1rKHDFM=; b=jVe930xaRTZ/VnUKRZ4M/j83NJQxxHotK+4N
	Pl8B5jO1X1E6Oaq/sziuQL2KZQKRcPIscd11QOQUq1u/o2RHZmxChfzQqFCqrGpJ
	k0RareWJZs5irLpBhSqFyCfEbZoyilRQ0fNasdXqhZt4Vi+ztXIBD6QisX1Dlb0E
	2Zs8MVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	LL0ji21WSaJlOSPwT4fmjwE6xkMk3PxJM//hyOqqsACdD6rkJne52V3WXsdhRKTH
	gwFj58wL4c4Plu8AFE6Bm6gfDRBlc/nRseBpUPkNSu59AsRM+ASsI+OIgQPQo2no
	XTAHxrpeR/S53561IAQla8tqsadhdjXRAwwFy748N5E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 978AA3C95B;
	Wed, 18 Sep 2013 05:14:39 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11D6F3C95A;
	Wed, 18 Sep 2013 05:14:38 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <1379481263-29903-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 37A4F1D4-2021-11E3-8237-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234954>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5601-clone.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0629149..ccda6df 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -285,4 +285,15 @@ test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' '
 	git clone "./foo:bar" foobar
 '
 
+test_expect_success 'clone from a repository with two identical branches' '
+
+	(
+		cd src &&
+		git checkout -b another master
+	) &&
+	git clone src target-11 &&
+	test "z$( cd target-11 && git symbolic-ref HEAD )" = zrefs/heads/another
+
+'
+
 test_done
-- 
1.8.4-585-g8d1dcaf
