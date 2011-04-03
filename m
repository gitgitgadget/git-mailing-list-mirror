From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git diff -D: omit the preimage of deletes
Date: Sat, 02 Apr 2011 23:38:56 -0700
Message-ID: <7vpqp3g7pb.fsf@alter.siamese.dyndns.org>
References: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
 <b6975fdc80a338e47c1426e8bf8450b68130b84a.1301664623.git.git@drmicha.warpmail.net> <7vbp0pg4d7.fsf@alter.siamese.dyndns.org> <7vtyefg8fi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Apr 03 08:39:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Gxx-00024D-AK
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 08:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab1DCGjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 02:39:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab1DCGjF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 02:39:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E9BC226F8;
	Sun,  3 Apr 2011 02:40:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lMCsRvSP66UZNYQa3tnQpBhZEsc=; b=xBaiKD
	+b6wgzQPLnh+NqAEXHl8yPw02BN1nJioeM2fXUlkpiMUJR+6uVgvH9aHW3qayp4g
	y6y4hNyLPriq4jzHtqWE8IG/CI3Kp7+7z8pPk+JxzL7zGM3nIxaBcmbWAZ8sWnl/
	FfAbTRCYCD/Ht/zlAKAWp+XHoge9bP/digUaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXHovn87MpfEPjJKc2+e4SGTcOvGgb7J
	bdHCs+C0kgJsC6fC4hBym9uITxb9icqH8WDHhFHsJW1uvC8wfmdog4TnYpxG2wu8
	kCKQzl4iEnR04tmOcdOjnpltYmTdLv1wWS3wiP7qkEhtE9cFg7wiMPvLqVhwejX9
	L0L6XGK3GHU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C876426F7;
	Sun,  3 Apr 2011 02:40:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CFEB326F6; Sun,  3 Apr 2011
 02:40:49 -0400 (EDT)
In-Reply-To: <7vtyefg8fi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 02 Apr 2011 23:23:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 52059016-5DBD-11E0-BF81-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170679>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I would have expected that the patch relative to jc/diff-irreversible-delete
>> topic would consist only of changes to diff.c:emit_rewrite_diff(), docs
>> and tests.
>
> Here is an "in other words" follow-up.  Your tests looked reasonable (and
> pass with this patch on top of what has been queued in 'pu').

And this is the documentation part, based on your version but somewhat
rewritten.  Your version said "cannot be applied with -R", but at the
mechanical application level, the format is deliberately designed to make
`patch` and `git apply` to fail, and I think that should be mentioned
together with the reason why such an option exists (i.e. for human eyeball
consumption).

I'll squash these two to what is queued in 'pu'.  We may want to polish it
again after 1.7.5 but I think it is in much better shape now.

Thanks.

 Documentation/diff-options.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c93124b..30a00d3 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -259,6 +259,19 @@ endif::git-log[]
 	projects, so use it with caution.  Giving more than one
 	`-C` option has the same effect.
 
+-D::
+--irreversible-delete::
+	Omit the preimage for deletes, i.e. print only the header but not
+	the diff between the preimage and `/dev/null`. The resulting patch
+	is not meant to be applied with `patch` nor `git apply`; this is
+	solely for people who want to just concentrate on reviewing the
+	text after the change. In addition, the output obviously lack
+	enough information to apply such a patch in reverse, even manually,
+	hence the name of the option.
++
+When used together with `-B`, omit also the preimage in the deletion part
+of a delete/create pair.
+
 -l<num>::
 	The `-M` and `-C` options require O(n^2) processing time where n
 	is the number of potential rename/copy targets.  This
