From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] refactoring diff-index
Date: Tue, 19 Jul 2011 11:13:04 -0700
Message-ID: <1311099186-16482-1-git-send-email-gitster@pobox.com>
References: <7vzkkh2yfu.fsf@alter.siamese.dyndns.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 19 20:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjEnF-0001Vj-Dn
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 20:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421Ab1GSSNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 14:13:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51835 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072Ab1GSSNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 14:13:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2708135EC
	for <git@vger.kernel.org>; Tue, 19 Jul 2011 14:13:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=WB1m
	DscEe3l9WifcOlCH0FLke3Y=; b=uoahjEjwKlHnDQKqttN3naG6FoGvaC95p88h
	up5sPSoHPjUXt5WYJl5u15J42xP0VHHDjfHzZTUgmXFujNyt+KYCAxB8/mi42rAG
	DF1ilqpqSUEeYzm2rGml2O9vqa4LaS6B+Bi7muxGQePBQvVwAtpaHBFKszRYKFS1
	COCtgwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=yFGkCU
	smPao9iTd62t5xmmLEGU9Gt4zdI4GniqOMAkjjzPUo8igj0O+xIUkbfYzQnLAhrv
	tGxtklXMD1bQwR6hSc+otDjOs4/PcyHPlQG0p/JbjbM17vJguDwyWVjDANGKbdRj
	0v2N4nwsdwRztY5z0DvdLv2bodIA5+UX97dJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F59935EB
	for <git@vger.kernel.org>; Tue, 19 Jul 2011 14:13:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9322135EA for
 <git@vger.kernel.org>; Tue, 19 Jul 2011 14:13:07 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.178.g55272
In-Reply-To: <7vzkkh2yfu.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: C0EF0DF8-B232-11E0-9599-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177488>

While I was looking at a rather ancient bug in "git reset" reported by
John Nowak recently, I noticed that we can reduce duplicated code in the
diff_index() codepath.

Junio C Hamano (2):
  diff-lib: simplify do_diff_cache()
  diff-lib: refactor run_diff_index() and do_diff_cache()

 diff-lib.c |   71 ++++++++++++++++-------------------------------------------
 1 files changed, 19 insertions(+), 52 deletions(-)

-- 
1.7.6.178.g55272
