From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 14:34:06 -0800
Message-ID: <7vpqq65xcx.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
 <7vr5am7p30.fsf@alter.siamese.dyndns.org>
 <7vei6m7muw.fsf@alter.siamese.dyndns.org>
 <7v39n27llq.fsf@alter.siamese.dyndns.org>
 <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
 <7vy64u65ta.fsf@alter.siamese.dyndns.org>
 <loom.20110304T210337-216@post.gmane.org>
 <7vtyfi606a.fsf@alter.siamese.dyndns.org> <4D7165A3.5080308@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Miseler <alexander@miseler.de>, git@vger.kernel.org
To: Colin Guthrie <gmane@colin.guthr.ie>
X-From: git-owner@vger.kernel.org Fri Mar 04 23:34:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvdZp-0005Cj-9U
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 23:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760227Ab1CDWeT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 17:34:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277Ab1CDWeS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 17:34:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D84D04890;
	Fri,  4 Mar 2011 17:35:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j7MfJzMNqXCd/8RuT9P5gdLE3ZQ=; b=SPZyhU
	cD0DjCzqTeImAcVgF+20HLArVniE1lnaYHqfaSsIYhUoWJMGjzeBHD041M9t4BUI
	SVgb8cwtncHsYpfQsyDBhE8MUqLBWOcAnHXZFWT6MyZjYdECOqrpGoP7EdRq34+q
	3IxB9F9rwFmhepWP6AxisKlgGFAlY5oBF3aE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oOJvPUF9YG6UkdIBUAA5c3zWbD7dTcg4
	Bph4xVrLP6ugtXx6qU9krZTAdjsb9f9Lkrp34eI122UOMU1ZlCwW7hM66MtBKqV5
	Rq33Y+uw9NichS9y6wb63TnAqwqIY7J1lMivWletbDyqPdV57T7/yY2amqepdre8
	izsU654OVDM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 961B3488F;
	Fri,  4 Mar 2011 17:35:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4C996488B; Fri,  4 Mar 2011
 17:35:30 -0500 (EST)
In-Reply-To: <4D7165A3.5080308@colin.guthr.ie> (Colin Guthrie's message of
 "Fri\, 04 Mar 2011 22\:20\:19 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B8431B70-46AF-11E0-993E-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168471>

Colin Guthrie <gmane@colin.guthr.ie> writes:

> 'Twas brillig, and Junio C Hamano at 04/03/11 21:33 did gyre and gimble:
>> In short, Linus and I both know what you are talking about, and we may
>> revisit that issue later, but the thing is that it would not be very
>> pleasant, and not something that can be done in one sitting during a
>> single discussion thread on the list.
>
> As a simple option to avoid that, how about just printing out (by
> default) the line offsets if hunks don't apply 100% cleanly? This would
> at least alert you to the fact that some fixups were needed.

Yeah, that is what GNU patch does, and would be a small improvement that
might be in a right direction.

While we are at it, here is an alternate patch that does not lose the
ability to cope with the case where the target version has functions moved
around without introducing new ambiguous patch application sites.  Instead
of keeping the "last position was here -- we won't look beyond that", we
mark the lines that were brought into the target by the patch application
so far, and reject preimage matches against these lines.

A full solution for detecting a potential ambiguity and warning it would
be based on this version instead.  It would involve letting find_pos() not
stop at the first hit near the intended target, and marking the hunk that
can apply at more than one location.

A yet even more reliable alternative solution _might_ be to first scan the
original without applying any hunks just to find the possible sites to be
patched, warn ambiguities and decide & commit to these patch application
sites, and then apply the hunks.  If we did so, we wouldn't need this
patch nor the previous one.

But that would be a larger change, and would require a good test vector,
perhaps a large quilt series, to make sure it does not introduce
regression.


 builtin/apply.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 14951da..04f56f8 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -204,6 +204,7 @@ struct line {
 	unsigned hash : 24;
 	unsigned flag : 8;
 #define LINE_COMMON     1
+#define LINE_PATCHED	2
 };
 
 /*
@@ -2085,7 +2086,8 @@ static int match_fragment(struct image *img,
 
 	/* Quick hash check */
 	for (i = 0; i < preimage_limit; i++)
-		if (preimage->line[i].hash != img->line[try_lno + i].hash)
+		if ((img->line[try_lno + i].flag & LINE_PATCHED) ||
+		    (preimage->line[i].hash != img->line[try_lno + i].hash))
 			return 0;
 
 	if (preimage_limit == preimage->nr) {
@@ -2428,6 +2430,9 @@ static void update_image(struct image *img,
 	memcpy(img->line + applied_pos,
 	       postimage->line,
 	       postimage->nr * sizeof(*img->line));
+	for (i = 0; i < postimage->nr; i++)
+		img->line[applied_pos + i].flag |= LINE_PATCHED;
+
 	img->nr = nr;
 }
 
