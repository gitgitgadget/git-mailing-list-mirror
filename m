From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] fetch --all/--multiple: keep all the fetched branch 
 information
Date: Wed, 24 Feb 2010 11:59:03 -0800
Message-ID: <7vy6iil81k.fsf@alter.siamese.dyndns.org>
References: <1267035726-2815-1-git-send-email-gitster@pobox.com>
 <1267035726-2815-2-git-send-email-gitster@pobox.com>
 <7vpr3uqwya.fsf_-_@alter.siamese.dyndns.org>
 <63cde7731002241154o40ad7e6eh26f20017f7854fc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 20:59:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkNOC-0004F4-67
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 20:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757926Ab0BXT7P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 14:59:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757920Ab0BXT7N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 14:59:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A9E129C834;
	Wed, 24 Feb 2010 14:59:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JPzGKEsf/XNMFLo4iVCkN8uYH1k=; b=CFA1TI
	h0+4j3ImuONnJFvRC7Gt25GjFNse3mZehXmvzsfy//OtAwATVBvo10hmJBXexxcu
	DYgqOssL7v+Us9tAhHpH+tH0oI9AOPq1nxTpAzAykz7ENNA3qIK2jwNffCGKUtsr
	7VLk1RJDJag16L90KCItBPnc1jvgGA/Da4gv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MPNTcr0xocRCtg0wc9Uc++tXuju3kVnR
	l6Hgd/gi8SEP3HPAl5eUAJMx4RAltgR13yBELWa2jwwrjoJgtxYeIv7kbH0Sg8sR
	gAnFZUyyvdXuSpKzq4PnvCRpQbXDBe2zDhZP7l2ZQxsCJ9yy7FECwu5KaOpDszpZ
	dwprdMsrLcU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 879FF9C832;
	Wed, 24 Feb 2010 14:59:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C071E9C82F; Wed, 24 Feb
 2010 14:59:04 -0500 (EST)
In-Reply-To: <63cde7731002241154o40ad7e6eh26f20017f7854fc3@mail.gmail.com>
 (Michael Lukashov's message of "Wed\, 24 Feb 2010 22\:54\:18 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 11A8714E-217F-11DF-82ED-E038EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140984>

Michael Lukashov <michael.lukashov@gmail.com> writes:

> Patch 3 does not apply correctly:

It probably has a trivial confict, because there is an added test to the
second patch since I sent it out.  Please add this after applying [2/3].

diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index c18d829..84059d8 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -51,4 +51,25 @@ test_expect_success 'git pull -q -v' '
 	test -s err)
 '
 
+test_expect_success 'git pull --force' '
+	mkdir clonedoldstyle &&
+	(cd clonedoldstyle && git init &&
+	cat >>.git/config <<-\EOF &&
+	[remote "one"]
+		url = ../parent
+		fetch = refs/heads/master:refs/heads/mirror
+	[remote "two"]
+		url = ../parent
+		fetch = refs/heads/master:refs/heads/origin
+	[branch "master"]
+		remote = two
+		merge = refs/heads/master
+	EOF
+	git pull two &&
+	test_commit A &&
+	git branch -f origin &&
+	git pull --all --force
+	)
+'
+
 test_done
