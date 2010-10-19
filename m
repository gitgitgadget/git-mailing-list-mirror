From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-send-email.perl: fix In-Reply-To for second and
 subsequent patches
Date: Tue, 19 Oct 2010 11:45:24 -0700
Message-ID: <7vzkuayqbf.fsf@alter.siamese.dyndns.org>
References: <20101015095651.b75c4b54.ospite@studenti.unina.it>
 <1287481964-8883-1-git-send-email-ospite@studenti.unina.it>
 <7v4oci11k6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Tue Oct 19 20:45:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8HC0-0004LO-RZ
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 20:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622Ab0JSSpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 14:45:43 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56003 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0JSSpm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 14:45:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CD138E05BB;
	Tue, 19 Oct 2010 14:45:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OnrUSeShm8mLSg/jkakd5pgA8Bw=; b=lrpTNQ
	Q2PAv9/fdgNo6ktSbxPRzoxw60UfT0/I9+xCSK9l7mG8MFgFzs0AAjO7p4FqTp18
	2J/9j9RH2VQ0eW77kTt3khhBT1lX/QNP8r1LuzvRNrLvNq34uqviBEBdsp4hlpZN
	ObWTSli9PaW2s9jOzDlEsDYvnjxn4rpR/J//k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uELSKbBEe18x41ZCeDtW+1LVo05wG59R
	hmUd3z09CaJwVhFToWU04Xl0cdqK3UkvX+754oL23W81peKMap+Hx92VSZKSgMLf
	sLYMHdqI01d639AFC9HGP7C1gCy6GaDDXiPsmBxtj7RFnmckO0gCtAjoVwfT6Yqn
	mvved3BXEBQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6842CE05AE;
	Tue, 19 Oct 2010 14:45:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3D41E05A7; Tue, 19 Oct
 2010 14:45:25 -0400 (EDT)
In-Reply-To: <7v4oci11k6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 19 Oct 2010 11\:26\:33 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0DEC845E-DBB1-11DF-8BC0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159352>

Junio C Hamano <gitster@pobox.com> writes:

>> +		$patches $patches \
>> +		2>errors
>
> You are breaking the && chain here.
>
>> +        # The second patch should be seen as reply to the first one
>> +        test $(sed -n -e "s/^In-Reply-To:\(.*\)/\1/p" msgtxt2) = $(sed -n -e "s/^Message-Id:\(.*\)/\1/p" msgtxt1)
>> +'
>
> You would need to test the interaction with --chain-reply-to as well, so
> there should be another test, and you would probably need three messages
> fed to send-email not just two to see the effect of the interaction.

IOW, the test part of the patch should look something like this.

Note that the below uses the current semantics (3a. in the previous
message), not your version of the definition.

I would suggest using this one as the first patch in your series, perhaps
with a documentation update to clarify the semantics of 3b. in my previous
message.  Then change git-send-email and update the test, as your change
will break the expected behaviour of the first test added here, and
document the change of semantics 3a. in the second patch in your series.

 t/t9001-send-email.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 07c50c7..c7e5c93 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -295,6 +295,47 @@ test_expect_success $PREREQ 'Valid In-Reply-To when prompting' '
 	! grep "^In-Reply-To: < *>" msgtxt1
 '
 
+test_expect_success $PREREQ 'In-Reply-To without --chain-reply-to' '
+	clean_fake_sendmail &&
+	echo "<unique-message-id@example.com>" >expect &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--no-chain-reply-to \
+		--in-reply-to="$(cat expect)" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches $patches $patches \
+		2>errors &&
+	# All the messages are replies to --in-reply-to
+	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
+	test_cmp expect actual &&
+	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
+	test_cmp expect actual &&
+	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success $PREREQ 'In-Reply-To with --chain-reply-to' '
+	clean_fake_sendmail &&
+	echo "<unique-message-id@example.com>" >expect &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--chain-reply-to \
+		--in-reply-to="$(cat expect)" \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		$patches $patches $patches \
+		2>errors &&
+	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt1 >actual &&
+	test_cmp expect actual &&
+	sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt1 >expect &&
+	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt2 >actual &&
+	test_cmp expect actual &&
+	sed -n -e "s/^Message-Id: *\(.*\)/\1/p" msgtxt2 >expect &&
+	sed -n -e "s/^In-Reply-To: *\(.*\)/\1/p" msgtxt3 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success $PREREQ 'setup fake editor' '
 	(echo "#!$SHELL_PATH" &&
 	 echo "echo fake edit >>\"\$1\""
