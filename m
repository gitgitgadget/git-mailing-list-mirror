From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC/PATCH] t/perf: "make clean" from the top-level to clean results
Date: Mon, 28 Mar 2016 13:16:50 -0700
Message-ID: <xmqqfuvaxsr1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 28 22:16:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akdas-0007ZW-Qj
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 22:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbcC1UQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 16:16:55 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58454 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751537AbcC1UQy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 16:16:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AE0C34FCC4;
	Mon, 28 Mar 2016 16:16:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=3
	ge0Hjj6AiA3Ythjjy18qRxnccc=; b=dBGbytbG2epQNojSV1zTy5knES+e/1GT+
	vJmyaWHMVL+5R6RcVl2zmVEG+ReeGtHXA7Gm89qCnsLSCzarpgEahGGHIAYajEUd
	y+Cb2bXcSIKJA2GyX4ftrI3B0hJiM+kpGPwPU/9qJ3HZgC3YBz7T9ysRUM245BrS
	cRHBVRK12k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=fJc8MdqD0cYjBx4aLgj2bj33GmWX2w7OrrzWkR3ryBP8p/qfSg9VEQ28
	iEjUmHk5tn99ZOFjYtlOe+0XTOGjFAriEkOthHOg/eR0hyDHXTww04aSqzAEf4vC
	ZT7MeNp9hhB8p9TzKHqnrkOKMmUQ68frH4RKeiqsUTD5+i3IOaM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A603D4FCC3;
	Mon, 28 Mar 2016 16:16:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1A85B4FCC2;
	Mon, 28 Mar 2016 16:16:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0250ECE4-F522-11E5-B154-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290062>

Running "make clean" from the top-level after running perf tests
left t/perf/test-results/ directory and tons of files in it.  At
least "make distclean" should turn things back to pristine state.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Perhaps I am missing some reason why this was deliberately left
   out when we added t/perf/Makefile that does have the clean
   target?  Cc'ing the suspects found by "shortlog t/perf".

 t/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/Makefile b/t/Makefile
index 18e2b28..e0aef9a 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -48,6 +48,7 @@ pre-clean:
 clean-except-prove-cache:
 	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
 	$(RM) -r valgrind/bin
+	cd perf && $(MAKE) clean
 
 clean: clean-except-prove-cache
 	$(RM) .prove
