From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] *.sh: drop useless use of "env"
Date: Thu, 06 Mar 2014 15:20:17 -0800
Message-ID: <xmqq1tyex6by.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 00:20:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLhaY-00056S-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 00:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbaCFXUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 18:20:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65227 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbaCFXUU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 18:20:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 236037212A;
	Thu,  6 Mar 2014 18:20:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=l
	hXPObe3PeeKHqypf+R/oZ9EEDc=; b=OORfYLOuqKAmntf7/Uu4JbTeEGYOT7bOv
	vpCMSOfMk95hf676N8gv9r6u4YxRLNDy8gyhkVh4E8R68o9LQndxvdYGEkO/Q0tK
	3ELBNV0Tv5ZgLq+CZOA3LJ0PSrKgNoYYjD/dhnQJAkxRq9Cj3gRHTGSJfu1rpCDD
	pR674ZzmpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=xQQ
	g6beSrT6NVHMFY3gU08mWXLmZBoNMGU0klsQNEcu95zHFSLRmYrKpvBNzx690UCK
	S+KAXHSh6qi0Xy/MMpCIh8GpVUsbikAZn+Rl3q/3gKEv6eTgNQBXgBBfjtDFkGG4
	dcZ9Gh0Ge2xMpv/8MZWZl5VHUwQ/nVXEop9IYF9g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07AC572129;
	Thu,  6 Mar 2014 18:20:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2171572127;
	Thu,  6 Mar 2014 18:20:19 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1F5B30A-A585-11E3-9BA7-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243572>

In a bourne shell script, "VAR=VAL command" is sufficient to run
'command' with environment variable VAR set to value VAL without
affecting the environment of the shell itself; there is no reason to
say "env VAR=VAL command".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Just something I noticed while reading existing tests...

 t/t1020-subdirectory.sh | 2 +-
 t/t9001-send-email.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 1e2945e..6902320 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -148,7 +148,7 @@ test_expect_success 'GIT_PREFIX for built-ins' '
 	(
 		cd dir &&
 		printf "change" >two &&
-		env GIT_EXTERNAL_DIFF=./diff git diff >../actual
+		GIT_EXTERNAL_DIFF=./diff git diff >../actual
 		git checkout -- two
 	) &&
 	test_cmp expect actual
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 3119c8c..1ecdacb 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -409,7 +409,7 @@ test_expect_success $PREREQ 'Valid In-Reply-To when prompting' '
 	(echo "From Example <from@example.com>"
 	 echo "To Example <to@example.com>"
 	 echo ""
-	) | env GIT_SEND_EMAIL_NOTTY=1 git send-email \
+	) | GIT_SEND_EMAIL_NOTTY=1 git send-email \
 		--smtp-server="$(pwd)/fake.sendmail" \
 		$patches 2>errors &&
 	! grep "^In-Reply-To: < *>" msgtxt1


	
