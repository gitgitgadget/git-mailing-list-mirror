From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] git-C: Add test to check "git -C ''"
Date: Thu, 05 Mar 2015 13:39:29 -0800
Message-ID: <xmqq1tl32kfi.fsf@gitster.dls.corp.google.com>
References: <1425553031-22264-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 22:39:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTdUd-0006Ep-Ov
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 22:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbbCEVjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 16:39:39 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751378AbbCEVji (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 16:39:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 272303DD1C;
	Thu,  5 Mar 2015 16:39:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=6sawBsWCkdwyPZuXBjjLglR7F4Q=; b=UW/Yw5gxTLyrymgFcnyo
	v51y1pphWSc0zNY+FfS6cDKdtBGUZIetxzEriU1h6+BwjkdjkaOFM4PPXZ92c5ds
	gK1PAE5IP/rR6O1zRykk+z7ZnfOwjv9uyJDfGS+hRtca+DWyKioy5H8UF9vJQyaf
	C/wq61SlMZ3hiWJA7cEkhbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wb7QFPR5xHcetwgyOOlF7teDSmqiDUcTLAkAy+NVsgQo0L
	S2f/reJqQK3XbPtAf0s7zQvcuoO1RSNsnYtY+nVEKQ2jIfZo2MiY8iAEVlVsvfdx
	6Cwbi4Esl67dJd4L0QdJaq+PKVyYUXaeggICPLmXwYVEedkkuF3XrZ7numo1U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B6903DD1B;
	Thu,  5 Mar 2015 16:39:38 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 18F0B3DD16;
	Thu,  5 Mar 2015 16:39:31 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B6A49C0-C380-11E4-99FB-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264871>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add a test to check whether "git -C ''" works without giving an
> error. This is achieved by adding a commit and checking the log
> using "git -C ''" and comparing the log message with the commit
> message.

Why choose something complex like commit and log, though?

Wouldn't something like this match the series of current tests
better?  Also I think a small change with a small test like these
should be in a single patch, not two separate ones.

Thanks.

 t/t0056-git-C.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t0056-git-C.sh b/t/t0056-git-C.sh
index 99c0377..551d806 100755
--- a/t/t0056-git-C.sh
+++ b/t/t0056-git-C.sh
@@ -14,6 +14,16 @@ test_expect_success '"git -C <path>" runs git from the directory <path>' '
 	test_cmp expected actual
 '
 
+test_expect_success '"git -C <path>" with an empty <path> is a no-op' '
+	(
+		mkdir -p dir1/subdir &&
+		cd dir1/subdir &&
+		git -C "" rev-parse --show-prefix >actual &&
+		echo subdir/ >expect
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'Multiple -C options: "-C dir1 -C dir2" is equivalent to "-C dir1/dir2"' '
 	test_create_repo dir1/dir2 &&
 	echo 1 >dir1/dir2/b.txt &&
