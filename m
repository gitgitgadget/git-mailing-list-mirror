From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/14] Add git-check-ignore sub-command
Date: Wed, 26 Sep 2012 07:03:35 -0700
Message-ID: <7vy5jwubig.fsf@alter.siamese.dyndns.org>
References: <7vvcfwf937.fsf@alter.siamese.dyndns.org>
 <1348170383-15751-1-git-send-email-git@adamspiers.org>
 <1348170383-15751-15-git-send-email-git@adamspiers.org>
 <505BFED7.5030203@viscovery.net> <7vk3vhvg5b.fsf@alter.siamese.dyndns.org>
 <50629765.2060107@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 26 16:03:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGsDO-0007z4-3D
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 16:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088Ab2IZODk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 10:03:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753039Ab2IZODi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 10:03:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB68648C;
	Wed, 26 Sep 2012 10:03:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1XX2pqqxReCUV9l3C4sLXGVXJpQ=; b=APtzze
	kO4OrdqzjBRZNAUPGvN8ylsH7IcRWQNXq2i710D0FgJsgMRx9sz5IaPCSjJy7CVY
	2XFdS4iJcThVokypOHeizREdnoSoFJMd6qXyYx9QxgdmLbAPqMy/IzRECZ1oeVNA
	in6cdwl6uM4/HVQoz3VG06m4KWVTjkCg6oSzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LeQw7Ds+sGPXJ4CMaim/3wCbYcwoJYfd
	1GGOiJ8276OpVv94G3vtDEBNGzEWrT67Ij6qk1Yyb0WmA+zNtjBUYo4u2vriTWgE
	duWb/beEbxtseB4ASSwd0I9fcslEzPAEdAtmbq+YRRKkNCKGX4cHXT4iWye6/fnX
	LZLooc5qUoY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8A64648B;
	Wed, 26 Sep 2012 10:03:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05F11648A; Wed, 26 Sep 2012
 10:03:36 -0400 (EDT)
In-Reply-To: <50629765.2060107@viscovery.net> (Johannes Sixt's message of
 "Wed, 26 Sep 2012 07:49:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7778A88-07E2-11E2-BEB5-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206414>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> These days, we do not add random subcommands willy-nilly (I still
>> doubt if check-ignore needs to be a separate debugging command, or a
>> new mode of operation of ls-files or something), so the approach to
>> use a blacklist makes more sense.  "help -a" is designed to show
>> whatever the users throw in their ~/bin (assuming that is on $PATH)
>> under git-whatever name, and we _do_ want to complete "git wh<TAB>"
>> to that custom command, so a whitelist-based solution is unwieldy to
>> construct.
>
> We already have 'git check-attr', but it is obviously not among the
> autocompleted commands, otherwise the above test would not have passed.
> IMO, 'git check-ignore' falls into the same category as 'git check-attr'
> with regard to completion.

Exactly.

Actually I think what happened was that the submitter didn't have
change to contrib/completion/ in earlier private versions, saw the
test fail and updated t9902 without thinking.  The patch posted has
addition to contrib/completion/ that blacklists check-ignore the
same way as check-attr, which made the change to t9902 unnecessary
but because the update was done without thinking, it wasn't even
realized that the test would have passed without the patch to it.

Reverting the part that touches t9902 should still pass, I would
think.

 t/t9902-completion.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git c/t/t9902-completion.sh w/t/t9902-completion.sh
index cce51ac..92d7eb4 100755
--- c/t/t9902-completion.sh
+++ w/t/t9902-completion.sh
@@ -213,19 +213,19 @@ test_expect_success 'general options' '
 '
 
 test_expect_success 'general options plus command' '
-	test_completion "git --version checko" "checkout " &&
-	test_completion "git --paginate checko" "checkout " &&
-	test_completion "git --git-dir=foo checko" "checkout " &&
-	test_completion "git --bare checko" "checkout " &&
+	test_completion "git --version check" "checkout " &&
+	test_completion "git --paginate check" "checkout " &&
+	test_completion "git --git-dir=foo check" "checkout " &&
+	test_completion "git --bare check" "checkout " &&
 	test_completion "git --help des" "describe " &&
-	test_completion "git --exec-path=foo checko" "checkout " &&
-	test_completion "git --html-path checko" "checkout " &&
-	test_completion "git --no-pager checko" "checkout " &&
-	test_completion "git --work-tree=foo checko" "checkout " &&
-	test_completion "git --namespace=foo checko" "checkout " &&
-	test_completion "git --paginate checko" "checkout " &&
-	test_completion "git --info-path checko" "checkout " &&
-	test_completion "git --no-replace-objects checko" "checkout "
+	test_completion "git --exec-path=foo check" "checkout " &&
+	test_completion "git --html-path check" "checkout " &&
+	test_completion "git --no-pager check" "checkout " &&
+	test_completion "git --work-tree=foo check" "checkout " &&
+	test_completion "git --namespace=foo check" "checkout " &&
+	test_completion "git --paginate check" "checkout " &&
+	test_completion "git --info-path check" "checkout " &&
+	test_completion "git --no-replace-objects check" "checkout "
 '
 
 test_done
