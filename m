From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add missing test file for UTF-16.
Date: Mon, 05 Aug 2013 09:44:54 -0700
Message-ID: <7vtxj4kry1.fsf@alter.siamese.dyndns.org>
References: <1375550791-5823-1-git-send-email-sandals@crustytoothpaste.net>
	<CACsJy8CT3uxp99n9VUXDbL30WEDcuRreeJBaqBcx9Ujici67VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 18:45:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6Nu1-00076M-0a
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 18:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752936Ab3HEQo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 12:44:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab3HEQo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 12:44:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BBF8360DF;
	Mon,  5 Aug 2013 16:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/WNRO2jtfMg/PxV41TaewE85WE4=; b=HqpXeB
	XSzaA4MM7y/rWEBHqJXgnhUs2XwOTdaWuSKVaTyARn3yPl15HE3XzhYmygGHGkrx
	8wwe1kalVQn53yUIOcJN62d3zCsu8t6iR8PO0fl0Xpa0uMQsU+omj1mNlqUPzIS6
	YDo3N/z3hOfIlcCp1Uq9g7CcTlYtWkkE1TpBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sK2HLFpved18IuZzK8ED78VfrkQ7/uJ6
	z6HrwH/2DqKYDA8yAV+/ocxfiEcxlYDb62OevSC6lsP7AaRBv8J/MrBx+rmnDWwr
	DIJ0euiIZuM4oy5nAoB+ySwfRSo9LDBb4JHe8FGLR2DQ7SLsFn5sPuJgHOVVfrUO
	/CM/rtFnBQ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10D7D360DE;
	Mon,  5 Aug 2013 16:44:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DA4C360D8;
	Mon,  5 Aug 2013 16:44:55 +0000 (UTC)
In-Reply-To: <CACsJy8CT3uxp99n9VUXDbL30WEDcuRreeJBaqBcx9Ujici67VA@mail.gmail.com>
	(Duy Nguyen's message of "Sun, 4 Aug 2013 09:31:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B836F9A-FDEE-11E2-82E5-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231677>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Aug 4, 2013 at 12:26 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> The test file that the UTF-16 rejection test looks for is missing, but this went
>> unnoticed because the test is expected to fail anyway; as a consequence, the
>> test fails because the file containing the commit message is missing, and not
>> because the test file contains a NUL byte.  Fix this by including a sample text
>> file containing a commit message encoded in UTF-16.
>
> Tested-by: Duy Nguyen <pclouds@gmai.com>
>
> and sorry, my bad. I think we need your sign-off in this patch.

I think 37576c14 (commit_tree(): refuse commit messages that contain
NULs, 2011-12-15) that marked this test with "test_expect_failure" is
broken with or without this fix.  It should be more like so:

diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index 37ddabb..5e72d72 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -34,9 +34,9 @@ test_expect_success 'no encoding header for base case' '
 	test z = "z$E"
 '
 
-test_expect_failure 'UTF-16 refused because of NULs' '
+test_expect_success 'UTF-16 refused because of NULs' '
 	echo UTF-16 >F &&
-	git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
+	test_must_fail git commit -a -F "$TEST_DIRECTORY"/t3900/UTF-16.txt
 '
 
 
