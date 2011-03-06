From: Junio C Hamano <junio@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Sun, 06 Mar 2011 14:15:27 -0800
Message-ID: <7vsjuz520w.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
 <7vr5am7p30.fsf@alter.siamese.dyndns.org>
 <7vei6m7muw.fsf@alter.siamese.dyndns.org>
 <7v39n27llq.fsf@alter.siamese.dyndns.org>
 <AANLkTim=jpJmBZmtAVX2V8Ui44AwpTbevJtSR2Xk=wLX@mail.gmail.com>
 <7vy64u65ta.fsf@alter.siamese.dyndns.org>
 <loom.20110304T210337-216@post.gmane.org>
 <7vtyfi606a.fsf@alter.siamese.dyndns.org> <4D7165A3.5080308@colin.guthr.ie>
 <7vlj0u5wyw.fsf@alter.siamese.dyndns.org> <4D7223A9.6080105@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Colin Guthrie <gmane@colin.guthr.ie>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
	<avarab@gmail.com>, Alexander Miseler <alexander@miseler.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 23:23:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwMM2-0005H2-N1
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 23:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab1CFWWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 17:22:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab1CFWWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 17:22:55 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Mar 2011 17:22:54 EST
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BEC2540C4;
	Sun,  6 Mar 2011 17:17:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Di1p8Ehw4r/FpQG5sKmYnSpPyY=; b=sbQRmw
	IKeaU2KXQXFcHfhD5yEbMsN8vSO4MTYVGzZoFxKVebuQMDXiYEiOEKSfeDDgMtUw
	G3bVJW71stl5JLIiCt107mzcMSLBd9EWZ8HQnDVB5ecGQULG5FHg804xzelauApy
	wPAM083PYbVM1ry0TAEwJTlCFGHjP3cl88hrU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dFGbJhFAGIAzZ3rRiK3bdrbgwHkCmJXp
	Cv6h8Gdb/HvmqDn5f/nbIwxP/smcJBm1Cubmjprco0GrouifGoTso974aX5z93sS
	eMm7OV4euP+FUOFpHksoUhwmboN/7eu93DSnZOfx/EZN2fL1geEk16S7AzoYaLZ1
	Z/NYqrtguUI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 460A040C3;
	Sun,  6 Mar 2011 17:17:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B2EE740C2; Sun,  6 Mar 2011
 17:16:54 -0500 (EST)
In-Reply-To: Junio C. Hamano's message of "\(unknown date\)"
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 757CDCF4-483F-11E0-A202-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168544>

Junio C Hamano <gitster@pobox.com> writes:

> In any case, here is an update to match what GNU patch seems to do more
> closely.
> ...

This is an unrelated tangent, but in a separate thread there was a
discussion on "%d noun(s)" in a recent weatherbaloon patch, and use of
ngettext(3) was suggested to solve this portably to languages other than
Germanic and Romanic family.

So here is my exercise for preparing the new code for upcoming i18n.
Does it look sane?

Do we want a new wrapper similar to _() that would easily make this into a
noop under NO_GETTEXT in the proposed i18n infrastructure?

 builtin/apply.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index a231c0c..f084250 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2644,7 +2644,10 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 			if (apply_in_reverse)
 				offset = 0 - offset;
 			fprintf(stderr,
+				ngettext(
+				"Hunk #%d succeeded at %d (offset %d line).\n",
 				"Hunk #%d succeeded at %d (offset %d lines).\n",
+				(offset < 0 ? (0 - offset) : offset)),
 				nth_fragment, applied_pos + 1, offset);
 		}
 
