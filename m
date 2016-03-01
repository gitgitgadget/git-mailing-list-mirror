From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] bundle doc: 'verify' is not about verifying the bundle
Date: Tue, 01 Mar 2016 13:36:05 -0800
Message-ID: <xmqqd1rd7uey.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 22:36:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aarxn-0004Ec-Ea
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 22:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbcCAVgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 16:36:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59676 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751541AbcCAVgK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 16:36:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7490A499E4;
	Tue,  1 Mar 2016 16:36:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=s
	EMqXvqUPOFFSVCqKvoyoftJ8Yk=; b=PNSL+WGE7X9/k7IeM5jxdtI/VNFyPTxdK
	2ghLkXQbUpQuuOnChL+gtjg4pDNq+A0HJc37qWiywBXUO9T3DBLz/R83cqFXb0Tv
	EzfWURanXSOw9ogw4NMBixoWSg79vz/Np6AZxBD8E9qgn2jc65idnpkGwx6uAt3S
	ufE6Z5WMI8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=x9f
	D4JRJL5++hx179rC/9EHwPZj6eMZlmUtZYvK6csDdc/xw0I9AMeo8dRTxqY+RFVu
	+x+TjIyN5ezfBt6jcV+Bpcr0jncbO3Ig23eUfvyOcB7Jni8I615VxXg1tR2HjsZ7
	R6zr3bu3n5j8B8Me2HkppsaJ/4xRuzAWUeci+04E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 69D92499E3;
	Tue,  1 Mar 2016 16:36:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 64C0A499E2;
	Tue,  1 Mar 2016 16:36:07 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9B8BBEC6-DFF5-11E5-97A8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288066>

Even though the command does read the bundle header and checks to
see if it looks reasonable, the thin-pack data stream that follows
the header in the bundle file is not checked.  More importantly,
because the thin-pack data does not have a trailing checksum like
on-disk packfiles do, there isn't much "verification" the command
can do without unpacking the objects from the stream even if it
wanted to.

The documentation gives an incorrect impression that the thin-pack
data contained in the bundle is validated, but the command is to
validate that the receiving repository is ready to accept the
bundle, not to check the validity of a bundle file.  Rephrase the
paragraph to clarify this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-bundle.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 3a8120c..c0113a8 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -38,11 +38,10 @@ create <file>::
 	'git-rev-list-args' arguments to define the bundle contents.
 
 verify <file>::
-	Used to check that a bundle file is valid and will apply
-	cleanly to the current repository.  This includes checks on the
-	bundle format itself as well as checking that the prerequisite
-	commits exist and are fully linked in the current repository.
-	'git bundle' prints a list of missing commits, if any, and exits
+	Verifies that the given 'file' has a valid-looking bundle
+	header, and that your repository has all prerequisite
+	objects necessary to unpack the file as a bundle.  The
+	command prints a list of missing commits, if any, and exits
 	with a non-zero status.
 
 list-heads <file>::
-- 
2.8.0-rc0-114-g0b3e5e5
