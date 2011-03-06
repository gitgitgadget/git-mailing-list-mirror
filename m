From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Sun, 06 Mar 2011 14:15:39 -0800
Message-ID: <7vlj0r520k.fsf@alter.siamese.dyndns.org>
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
Cc: Alexander Miseler <alexander@miseler.de>, git@vger.kernel.org
To: Colin Guthrie <gmane@colin.guthr.ie>
X-From: git-owner@vger.kernel.org Sun Mar 06 23:16:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwMF1-0001nU-7o
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 23:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab1CFWPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 17:15:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab1CFWPt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 17:15:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AEEBF40C8;
	Sun,  6 Mar 2011 17:17:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Cws/EnK9KfQpObjsUo2unzGicVY=; b=RTuSi43jsMAsrrtMW4asRJ1
	CdyTnC9geIdwN3x+MR50vsYHo8DhKraEbHAX2Y1NNkoUbKmvmd/bk7pW8ojMeQpF
	I0tA2Vu89gpCJIeNQlaj2I63n7Q7gyHZQb2IPRg+VjH0kpwDuYlikwJwHQlL9xNa
	UEEOsFEcKG5P8Z8zh3IE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=eaIkb2XKkSYx80psZNPe0m9xZE7pZoJwO4tMuyebx2J2V6jh8
	7IITbOcjGZrUzNgB5cflLab1JXImX8i/W5Pyl5eNW8q9gCvl//RhGzALhKkmnjJ5
	nAXR51RUynu5M8XC5CE0QRckzwvziiNW7q4upCgMYQQ4dYng6SczzO2CR0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7CEA340C7;
	Sun,  6 Mar 2011 17:17:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0DFE740C5; Sun,  6 Mar 2011
 17:17:06 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7B96A02A-483F-11E0-8A99-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168543>

Colin Guthrie <gmane@colin.guthr.ie> writes:

> 'Twas brillig, and Junio C Hamano at 04/03/11 22:42 did gyre and gimble:
>> ... and a patch to do so would look like this.  "git apply -v" and (GNU)
>> "patch -p1" seems to report exactly the same numbers for the problematic
>> patch and the initial state that started this discussion.
>> ... 
>
> Personally I wouldn't bother making offset absolute... (equiv of
> abs(offset)) as knowing it applied earlier or later could be useful...
> the direction is lost here and I don't really see why that's nicer for
> the user. But maybe that's just my opinion?

I don't have a strong opinion on this either way; I would just imitate
what GNU patch would do, which would probably be to show the offset as-is,
except that it flips the sign if it is being run in reverse with -R
option.

A bigger question I would actually care _more_ about is if this should be
on by default without -v.  We usually do not allow fuzz by default for
safety, and we do warn loudly when -C reduces the context and we actually
need to use it to match the preimage.

In any case, here is an update to match what GNU patch seems to do more
closely.

-- >8 --
Subject: [PATCH] apply -v: show offset count when patch did not apply exactly

When the line number the patch intended to touch does not match
the line in the version being patched, GNU patch reports that
it applied the hunk at a different line number, with how big an
offset.

Teach "git apply" to do the same under --verbose option.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 14951da..a231c0c 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2432,7 +2432,8 @@ static void update_image(struct image *img,
 }
 
 static int apply_one_fragment(struct image *img, struct fragment *frag,
-			      int inaccurate_eof, unsigned ws_rule)
+			      int inaccurate_eof, unsigned ws_rule,
+			      int nth_fragment)
 {
 	int match_beginning, match_end;
 	const char *patch = frag->patch;
@@ -2638,6 +2639,15 @@ static int apply_one_fragment(struct image *img, struct fragment *frag,
 				apply = 0;
 		}
 
+		if (apply_verbosely && applied_pos != pos) {
+			int offset = applied_pos - pos;
+			if (apply_in_reverse)
+				offset = 0 - offset;
+			fprintf(stderr,
+				"Hunk #%d succeeded at %d (offset %d lines).\n",
+				nth_fragment, applied_pos + 1, offset);
+		}
+
 		/*
 		 * Warn if it was necessary to reduce the number
 		 * of context lines.
@@ -2785,12 +2795,14 @@ static int apply_fragments(struct image *img, struct patch *patch)
 	const char *name = patch->old_name ? patch->old_name : patch->new_name;
 	unsigned ws_rule = patch->ws_rule;
 	unsigned inaccurate_eof = patch->inaccurate_eof;
+	int nth = 0;
 
 	if (patch->is_binary)
 		return apply_binary(img, patch);
 
 	while (frag) {
-		if (apply_one_fragment(img, frag, inaccurate_eof, ws_rule)) {
+		nth++;
+		if (apply_one_fragment(img, frag, inaccurate_eof, ws_rule, nth)) {
 			error("patch failed: %s:%ld", name, frag->oldpos);
 			if (!apply_with_reject)
 				return -1;
-- 
1.7.4.1.299.ga459d
