From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/17] merge: do not fast-forward when merging a tag
Date: Wed, 09 Nov 2011 05:39:32 -0800
Message-ID: <7v39dxwh2j.fsf_-_@alter.siamese.dyndns.org>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
 <7v8vnpwhxl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 14:39:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO8NQ-0001eO-7T
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 14:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899Ab1KINjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 08:39:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752500Ab1KINjf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 08:39:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FFB94528;
	Wed,  9 Nov 2011 08:39:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HaTlJbqMafq1TGwsfzkqMSbU3PA=; b=diYgzR
	kUDeu4Z4kRnxQLwPCGfEHXX+1vbqgaCzYLsMnVevRqqdsen2azjO8gPkAtZUmi7t
	zhJHkSVnnNaSjjTQv1TGGBV4+v+wFIlVWetXKXNASJzeoRGSXrh5vBTw4IUvqngh
	CLrCpHcS34vRkBDlKQjPek7ewrqlLGbLSOU3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xpB9loVG0yRCca1OjfuFpJL1YYL+9Oef
	fEmLGIcA7pZgbRLRfEOEjCiECbAwvwgsWUpnaa9y2s7DArN0SVkpcahthh/RUl5n
	gcAPDSbOPA1MqLcZo6x6iLr/ah2tuew1p0WD6/FZFuIa4ByH8KbOW/PkIlQMfd3V
	nM+Fm2g+cmY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 778AF4527;
	Wed,  9 Nov 2011 08:39:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEEAF4525; Wed,  9 Nov 2011
 08:39:33 -0500 (EST)
In-Reply-To: <7v8vnpwhxl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 09 Nov 2011 05:20:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4240B6E2-0AD8-11E1-A0DE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185158>

Merging a signed or an annotated tag is meant to trigger the editor for
the integrator to leave a meaningful merge commit log in the history.
Disallow fast-forwarding the merge in such a case to ensure that a merge
commit is always recorded.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 3b3e374..99f1429 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1255,8 +1255,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		strbuf_reset(&buf);
 		if (merge_remote_util(commit) &&
 		    merge_remote_util(commit)->obj &&
-		    merge_remote_util(commit)->obj->type == OBJ_TAG)
+		    merge_remote_util(commit)->obj->type == OBJ_TAG) {
 			option_edit = 1;
+			allow_fast_forward = 0;
+		}
 	}
 
 	if (!use_strategies) {
