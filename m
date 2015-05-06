From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH] t5540: skip under NO_CURL=NoThanks
Date: Wed, 06 May 2015 09:58:06 -0700
Message-ID: <xmqq6185d4o1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 06 18:58:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yq2ec-0007Nt-MB
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 18:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbbEFQ6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2015 12:58:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751823AbbEFQ6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2015 12:58:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EB0A74DAF0;
	Wed,  6 May 2015 12:58:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=/
	skhAU87gP71L+KJNYHf5OLJ+uw=; b=qbvtVMfwsC9d0h2gPVSE4HMcEfJ11Sp6m
	S3N1s2+fETckY/zpZR3z047zY3RH9WXtEKt2QLoezJfpKYExATZ67BJfLW4mmUhY
	jboRVbpt5VUMP79TLDnxeuXgos3mOioL6Qj+ZYUiz3zqntNCWpE8pGbLJc41w/cP
	I6VkhT/8T8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Aow
	yl6i5KtM+DCoiVx2q6XCfbh6D3GEYvsc0NlIDfu7ZB3A6Yn5naA4wjRtT8J/XYWf
	0psQ2dlWQ2FIGTieavXGvYIkIe3bq+nteBibUHAIcWR/MNvez9cyY3iDRNKIwfJ3
	gfd4F4bE067jdyhz0z1BYJKtImw4+sXHL8UVH+mw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E482E4DAEF;
	Wed,  6 May 2015 12:58:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6BC974DAEE;
	Wed,  6 May 2015 12:58:07 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1194B568-F411-11E4-95ED-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268467>

All the other tests in t5xxx series that require http support check
NO_CURL and skip the test, but this one forgot to do so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5540-http-push-webdav.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t5540-http-push-webdav.sh b/t/t5540-http-push-webdav.sh
index 8d7b3c5..e6aec36 100755
--- a/t/t5540-http-push-webdav.sh
+++ b/t/t5540-http-push-webdav.sh
@@ -9,6 +9,12 @@ This test runs various sanity checks on http-push.'
 
 . ./test-lib.sh
 
+if test -n "$NO_CURL"
+then
+	skip_all='skipping test, git built without http support'
+	test_done
+fi
+
 if git http-push > /dev/null 2>&1 || [ $? -eq 128 ]
 then
 	skip_all="skipping test, USE_CURL_MULTI is not defined"
-- 
2.4.0-312-gc04835c
