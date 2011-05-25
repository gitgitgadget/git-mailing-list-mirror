From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merge made by recursive?
Date: Wed, 25 May 2011 13:47:34 -0700
Message-ID: <7vzkma1p95.fsf@alter.siamese.dyndns.org>
References: <loom.20110525T192418-887@post.gmane.org>
 <7vvcwy37de.fsf@alter.siamese.dyndns.org>
 <20110525195032.GC27260@sigill.intra.peff.net>
 <7vei3m3571.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Ligocki <sligocki@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 22:48:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPL01-0002Qx-4K
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 22:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500Ab1EYUrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 16:47:46 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47726 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932362Ab1EYUro (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 16:47:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 43921544F;
	Wed, 25 May 2011 16:49:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sXUHpQoPrcUnoegPNWfUdPD0h4E=; b=mwGkGQ
	BRCsDfPoAVGD0yV7MFeZQOAfPy+6t/R6UEp78w9ziMOmDJ7P53ZMGC6zEnfVXIqH
	rRAE2eqaNoTbGFexCszGxr/AhxC3OKANdx+w2LGbT3o22rVZV1v3tPRQSu1T6b5R
	as5iNGKE/L4zGV/8qk9LLrLliqGVI1avLJ6Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y/0KGknqFLL0CTWoMjTtCHoXY5r+dew2
	lXxqXvTFVLYV7jOzK0BOgFZ9Fg4mXxazE+v/qZsAQDwgojdNtuPFpuTBF31+we2b
	39J4FmqvSZIS6Cno3E2Pxjz2cqgUNSU15OeqIsKqdtTiQNdamz6Fo5wPm3ieQ5Lc
	alkfzsd4W9s=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 101F3544E;
	Wed, 25 May 2011 16:49:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B9581544D; Wed, 25 May 2011
 16:49:43 -0400 (EDT)
In-Reply-To: <7vei3m3571.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 25 May 2011 13:17:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 874328E8-8710-11E0-A872-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174462>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Also, most of the rest of the merge output has been gettext-ized, but
>> not this message. If we are going to declare it not parseable, should we
>> also be internationalizing it?
>
> Heh, great minds think alike. I was wondering about that while I took a
> brief walk after sending it out.

I am reluctant to do this (including the rewording of the end-user facing
message) until we decide what to do with the reflog. Right now, I think no
tool looks at the reflog, but contaminating the reflog with translatable
messages mean that we will never be able to support "3 merges ago" just
like we support "the previous branch".

Either we split the messages into two, one translatable and given to the
end user and the other untranslatable and sent to the reflog, or find a
place in reflog entry where we can hide machine readable and stable
representation of what happened and store both the end-user facing message
and the machine readable one separately. In the longer term I would prefer
the latter.

-- >8 --
Subject: [PATCH] merge: mark the final "Merge made by..." message for l10n

The final "Merge made by ... strategy" message is an end-user facing
message and can be localized.  And mark the test that depends on the exact
wording with test_i18ncmp.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge.c               |    2 +-
 t/t7602-merge-octopus-many.sh |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 8bc453d..4083b9b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -902,7 +902,7 @@ static int finish_automerge(struct commit_list *common,
 	strbuf_addch(&merge_msg, '\n');
 	run_prepare_commit_msg();
 	commit_tree(merge_msg.buf, result_tree, parents, result_commit, NULL);
-	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
+	strbuf_addf(&buf, _("Merge made by the '%s' strategy."), wt_strategy);
 	finish(result_commit, buf.buf);
 	strbuf_release(&buf);
 	drop_save();
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 61f36ba..3f893de 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -66,7 +66,7 @@ EOF
 test_expect_success 'merge output uses pretty names' '
 	git reset --hard c1 &&
 	git merge c2 c3 c4 >actual &&
-	test_cmp actual expected
+	test_i18ncmp actual expected
 '
 
 cat >expected <<\EOF
@@ -80,7 +80,7 @@ EOF
 
 test_expect_success 'merge up-to-date output uses pretty names' '
 	git merge c4 c5 >actual &&
-	test_cmp actual expected
+	test_i18ncmp actual expected
 '
 
 cat >expected <<\EOF
@@ -97,7 +97,7 @@ EOF
 test_expect_success 'merge fast-forward output uses pretty names' '
 	git reset --hard c0 &&
 	git merge c1 c2 >actual &&
-	test_cmp actual expected
+	test_i18ncmp actual expected
 '
 
 test_done
-- 
1.7.5.2.483.gc61ca
