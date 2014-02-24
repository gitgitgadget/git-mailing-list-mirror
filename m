From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2014, #06; Wed, 19)
Date: Mon, 24 Feb 2014 09:06:07 -0800
Message-ID: <xmqqppmcbfuo.fsf@gitster.dls.corp.google.com>
References: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com>
	<BCF58F31-7130-4F4B-BE53-D917C4D50D96@quendi.de>
	<xmqqsird6137.fsf@gitster.dls.corp.google.com>
	<FB0B19C8-65BF-49CF-8EE4-5B9D55BBCE7C@quendi.de>
	<xmqqr46w4a24.fsf@gitster.dls.corp.google.com>
	<8732A8C8-145E-47F5-BD9A-ECD6E9DE07EF@quendi.de>
	<xmqqtxbobg98.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:06:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyyy-0008FW-QV
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbaBXRGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 12:06:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752463AbaBXRGP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 12:06:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34C816C7C6;
	Mon, 24 Feb 2014 12:06:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6QHwbUgr0fj2hzzSfYNvwnlxkss=; b=H/ayXi
	QfaI97D6eHj8COkfaofL0Kr72jPal6wuj3NmU8oN8CUX/uHYNZU7f2WHidsFsOJW
	PUBGNbGIdOwCAMG2L2dFyVxetzJgs5bEl8wuXYFrNy0jMJm7/1F0k5Ov5Z1SmE83
	DuemjontkPfNqXMtjtE0VoRNkg2YvKvDFnx08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HQi/EG7xOEb/i4lAtMY1iOclUEDu5ws7
	8hwUzGJ+Q5qEix+c+hxtcJ5T+spNq/VtyTJRQPRTr8H908CVg/wiSXOAHEDapFSz
	eeKNBdd/j+DQ5WySsCd7VCdaMHUtanqjRtzMn4MsX4yCc0+fkDEqaIaYiv1RshLg
	AKvUD5xPZkU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B6FD6C7C3;
	Mon, 24 Feb 2014 12:06:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA1926C7B7;
	Mon, 24 Feb 2014 12:06:11 -0500 (EST)
In-Reply-To: <xmqqtxbobg98.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 24 Feb 2014 08:57:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F61D828A-9D75-11E3-9BEB-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242613>

Junio C Hamano <gitster@pobox.com> writes:

> But I think I was worried too much into the future---I agree that
> the code can stay as you proposed until such a remote-helper needs
> more support, because "overwrite with zero" is necessary but is
> probably not sufficient---it also may need to be able to tell us
> what the final resulting commit of the push is, for example.

So, here is what I'll queue (with forged s-o-b).

Thanks.

-- >8 --
From: Max Horn <max@quendi.de>
Date: Fri, 21 Feb 2014 10:55:59 +0100
Subject: [PATCH] transport-helper.c: do not overwrite forced bit

If the the transport helper says it was a forced update, then it is
a forced update.  It is however possible that an update is forced
without the transport-helper knowing about it, namely because some
higher up code had objections to the update and needed forcing in
order to let it through to the transport helper.  In other words, it
does not necessarily mean the update was *not* forced, when the
helper did not say "forced update".

Signed-off-by: Max Horn <max@quendi.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 transport-helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index abe4c3c..705dce7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -727,7 +727,7 @@ static int push_update_ref_status(struct strbuf *buf,
 	}
 
 	(*ref)->status = status;
-	(*ref)->forced_update = forced;
+	(*ref)->forced_update |= forced;
 	(*ref)->remote_status = msg;
 	return !(status == REF_STATUS_OK);
 }
-- 
1.9.0-291-g027825b
