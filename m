From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] "git name-rev --weight"
Date: Wed, 29 Aug 2012 14:17:21 -0700
Message-ID: <1346275044-10171-1-git-send-email-gitster@pobox.com>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 29 23:18:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6pew-0000Qa-UF
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 23:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab2H2VRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 17:17:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754130Ab2H2VR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 17:17:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B3528CA1;
	Wed, 29 Aug 2012 17:17:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ovj/
	h6ejNsLxy2uKggsUxXjL/58=; b=maAS1GWe8Q8D019f0aqniTwV0iVtMYvsz0a5
	RjRSOLlmu1kGM3oZ3pWuszjbt97L+ocl3Ql4pgdxsK4iVpenH1ERXu9+u4pa9pQ/
	b39z8NzmiusivpCbU/MtHUGoKAYSsKcGu3hKWzmqnEbmcvRyVr7s3MGBB6B0CbBy
	uV+AqZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	nRPQB9U4weKaKtqLF9+cc/lPjb+6dl41uP1/6aBu3aVzsrRsG3l976sIZt0jRVvb
	0H05cXIqatxUoJ845oSJI5cIGx8Z4KqB+OR34C5Kbj0uF6/AARu1LG/84Y0573X4
	l5dNmzkkMr/oDq1PfXA5GRNRmP3hzJmp0bnvPTwpnTc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A3DD8CA0;
	Wed, 29 Aug 2012 17:17:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7CAA58C9F; Wed, 29 Aug 2012
 17:17:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.285.ga3d5fc0
In-Reply-To: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
X-Pobox-Relay-ID: EE15DB54-F21E-11E1-91DF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204505>

So here is an attempt to teach "name-rev" a mode that tries to base
its name on oldest tag that can reach the commit.  It needs the
reset_revision_walk() call recently added to the revision traversal
API, and applies to bcc0a3e (v1.7.11-rc0~111^2~2) or newer.

Note that this can benefit from caching, as the "weight" of the tag
(rather, the commit that is tagged) will never change once a history
is made, but that part is left as an exercise to the reader.

It correctly names 0136db586c in the kernel history as based on
v3.5-rc1 as tags/v3.5-rc1~83^2~81^2~76, not on v3.6-rc1, as we saw
on the list recently.

Once it is verified to operate correctly and updated to perform
properly, we can start passing --weight when "describe --contains"
runs the command.

Junio C Hamano (3):
  name-rev: lose unnecessary typedef
  name_rev: clarify when a new tip-name is assigned to a commit
  name-rev: --weight option (WIP)

 builtin/name-rev.c | 142 ++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 120 insertions(+), 22 deletions(-)

-- 
1.7.12.285.ga3d5fc0
