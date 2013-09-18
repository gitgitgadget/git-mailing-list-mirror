From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] clone: test the new HEAD detection logic
Date: Tue, 17 Sep 2013 19:31:29 -0700
Message-ID: <1379471489-26280-7-git-send-email-gitster@pobox.com>
References: <20130906155608.GF12966@inner.h.apk.li>
 <1379471489-26280-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 04:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM7YY-0006bw-Fd
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 04:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735Ab3IRCbq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 22:31:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56967 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696Ab3IRCbo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 22:31:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 533053918E;
	Wed, 18 Sep 2013 02:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/8Ha
	0N4AQaoc6W2LG9Re1rKHDFM=; b=D5Fr7hmh81MFfyeqzFgtgL/rgJFjEi7/aOU0
	f87fGsY0dwR32hYIhRF2XW/lbGuCOW9G5hVuABO+iFSpQfWK1VqZI6BD9a7hXfip
	dLztJEB6jF3gecvWz/+cBPhiaAj9jCdVR2bDQJ7wtnfMVkWJH6umZ4bkloCbIVpT
	eTvmrn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	U3Aas5cSqfNdR8Ojh6ocytpkxYkcd8IYfyX/mZAm1wdADaIxOIHOma692OEbWRLc
	hxt1xiYQzXnxJcKmamzldRundYntGCyfqLOqQyXcVLBpf/AzeW/OPPvdc6VQSxlI
	tCjgOCd/Uq5T+fYRv2soUuQS/wovGv3mYvyA+yfwFb0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 482473918C;
	Wed, 18 Sep 2013 02:31:44 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A83FE3918B;
	Wed, 18 Sep 2013 02:31:43 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <1379471489-26280-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 750FD56E-200A-11E3-932C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234946>

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
