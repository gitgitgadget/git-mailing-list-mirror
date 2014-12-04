From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test/send-email: --[no-]xmailer tests
Date: Thu, 04 Dec 2014 12:09:43 -0800
Message-ID: <xmqq4mtbtbw8.fsf@gitster.dls.corp.google.com>
References: <20141204190845.GA4906@charon.olymp>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Luis Henriques <henrix@camandro.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 21:09:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwcik-0005fF-4i
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 21:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbaLDUJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 15:09:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61891 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754053AbaLDUJp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 15:09:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C97F723B7B;
	Thu,  4 Dec 2014 15:09:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cnuw5tvYDOL9AqLbiBkVEVdxnAM=; b=DcWZPg
	CwiCwQDFdx2U6SrR9sTWSgbAmuMbFCEW80IUGvdCxAJm2PCraG/79yzX0sikvZq7
	Dy1cZvbCCHiDtuLX6NuUzLjbf0INpAZbpKYlTsDsKT12u2wxp0g0Z8Y4UTByoub3
	g7GV9q1XMV3oeSYS29c2gREMQBNrJDSboDESM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bSaAMj5dBU4apG/6vt3wJw0gzGDWaW3n
	y2zlHrayDEu7P4K5IECY2L7QvbIZVCK7s9FmV9eHMkBbE2Estk88HB5wDfPCFQjr
	atuiL7Wiw2CBab0UAj54wavBNtCxIyfWefI9sy2I0QaH+w/Q4/0ns/+tc9d/uMIy
	xJIHKE3picU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C09C123B79;
	Thu,  4 Dec 2014 15:09:44 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4220523B78;
	Thu,  4 Dec 2014 15:09:44 -0500 (EST)
In-Reply-To: <20141204190845.GA4906@charon.olymp> (Luis Henriques's message of
	"Thu, 4 Dec 2014 19:11:30 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7D05E0B2-7BF1-11E4-BC9E-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260793>

Luis Henriques <henrix@camandro.org> writes:

> Add tests for the --[no-]xmailer option.
>
> Signed-off-by: Luis Henriques <henrix@camandro.org>

Thanks.  Let's squash this in, too.  We care about command line
options taking precedence over configured default.

 t/t9001-send-email.sh | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index bcd5bad..bb573ef 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1406,6 +1406,7 @@ test_expect_success $PREREQ 'sendemail.aliasfile=~/.mailrc' '
 	  2>errors >out &&
 	grep "^!someone@example\.org!$" commandline1
 '
+
 do_xmailer_test() {
 	expected=$1
 	params=$2
@@ -1421,22 +1422,23 @@ do_xmailer_test() {
 	return $?
 }
 
-test_expect_success $PREREQ '--xmailer uses X-Mailer header' '
-	do_xmailer_test "1" "--xmailer"
-'
-
-test_expect_success $PREREQ '--no-xmailer supresses X-Mailer header' '
-	do_xmailer_test "0" "--no-xmailer"
+test_expect_success $PREREQ '--[no-]xmailer without any configuration' '
+	do_xmailer_test 1 "--xmailer" &&
+	do_xmailer_test 0 "--no-xmailer"
 '
 
-test_expect_success $PREREQ 'sendemail.xmailer=true uses X-Mailer header' '
-	git config sendemail.xmailer true &&
-	do_xmailer_test "1" ""
+test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=true' '
+	test_config sendemail.xmailer true &&
+	do_xmailer_test 1 "" &&
+	do_xmailer_test 0 "--no-xmailer" &&
+	do_xmailer_test 1 "--xmailer"
 '
 
-test_expect_success $PREREQ 'sendemail.xmailer=false supresses X-Mailer header' '
-	git config sendemail.xmailer false &&
-	do_xmailer_test "0" ""
+test_expect_success $PREREQ '--[no-]xmailer with sendemail.xmailer=false' '
+	test_config sendemail.xmailer false &&
+	do_xmailer_test 0 "" &&
+	do_xmailer_test 0 "--no-xmailer" &&
+	do_xmailer_test 1 "--xmailer"
 '
 
 test_done
