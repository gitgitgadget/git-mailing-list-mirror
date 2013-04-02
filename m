From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] peel_onion(): teach $foo^{object} peeler
Date: Tue, 02 Apr 2013 09:56:46 -0700
Message-ID: <7v6204g9bl.fsf@alter.siamese.dyndns.org>
References: <51543FDB.9010109@alum.mit.edu>
 <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com>
 <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net>
 <7vli97v558.fsf@alter.siamese.dyndns.org> <51565F96.1020203@alum.mit.edu>
 <7vk3opr0ke.fsf@alter.siamese.dyndns.org> <51567844.7030503@alum.mit.edu>
 <7vboa1qtnb.fsf@alter.siamese.dyndns.org>
 <7vhajtpdtc.fsf@alter.siamese.dyndns.org>
 <7vy5d3nqik.fsf_-_@alter.siamese.dyndns.org> <515A94C7.3000406@alum.mit.edu>
 <7vfvz9gclo.fsf@alter.siamese.dyndns.org> <515B083A.5050808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:57:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN4WM-0003O3-A4
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760852Ab3DBQ4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:56:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760189Ab3DBQ4s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:56:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3672112088;
	Tue,  2 Apr 2013 16:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iKbF0IcoxeM6Pt/sHXsU0tqlL0w=; b=vEA6v3
	u3Y2ePMRMzRC/hPxrPjedf/IZ6My60bQpgf7emOD4d01rhNm+WVBeINUkfDeZux3
	oX8j1R9bjJ/+CYmwzOnv7qzVXk072xDLJDH9xwrkUNpUVI0fz7zzQXswALHxyWJD
	//HVu8DtRb/KBB08uAH666icuiOZoXzMsKm8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j/PnJpZy8sXQOXAaEaok1eWS/Dp+tuKq
	3sTuUwNTnKC6AQGwYBlfYh2xCKik0TJaJTgC2a0ur1SERQjbFV3fMPenX8RGWGgZ
	VRHlZwwLrC2U0ToKV8wR2HwfjRpeL2P56zx4UtTqPjW2l4puSEatNfx0RaLm2bP2
	0+RXlLDtV0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CFD412087;
	Tue,  2 Apr 2013 16:56:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89EFF12086; Tue,  2 Apr
 2013 16:56:47 +0000 (UTC)
In-Reply-To: <515B083A.5050808@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 02 Apr 2013 18:32:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4E5F44FA-9BB6-11E2-A7FD-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219799>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/02/2013 05:45 PM, Junio C Hamano wrote:
>
>> Also, v1.8.2^{tag} would be give the tag itself, while master^{tag}
>> would not report the commit "master" but would error out, which
>> would be useless.  You are better off doing `git cat-file -t foo`
>> and seeing if it is a tag object at that point.
>
> All correct, of course.  But the user would never use "master^{tag}"
> unless he wants a tag and nothing else, so erroring out would be exactly
> the thing he wants in that case.  This is no different than the
> "^{commit}" part of "master^{tree}^{commit}", which correctly errors out
> because a commit cannot be inferred from a tree.

Correct; I was only saying adding it is not something that solves a
problem that cannot be solved with the current system (i.e. no added
value from feature point-of-view).  I would not object to a patch to
allow "git rev-parse v1.8.2^{tag}" for completeness.

We may want to rethink if we can lose the hardcoded lengths like 6,
3, 4, 4 from here, but I didn't bother ;-).


 sha1_name.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 85b6e75..47f39a8 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -639,16 +639,18 @@ static int peel_onion(const char *name, int len, unsigned char *sha1)
 		return -1;
 
 	sp++; /* beginning of type name, or closing brace for empty */
-	if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
+	if (!strncmp(tag_type, sp, 3) && sp[3] == '}')
+		expected_type = OBJ_TAG;
+	else if (!strncmp(commit_type, sp, 6) && sp[6] == '}')
 		expected_type = OBJ_COMMIT;
 	else if (!strncmp(tree_type, sp, 4) && sp[4] == '}')
 		expected_type = OBJ_TREE;
 	else if (!strncmp(blob_type, sp, 4) && sp[4] == '}')
 		expected_type = OBJ_BLOB;
 	else if (!prefixcmp(sp, "object}"))
-		expected_type = OBJ_ANY;
+		expected_type = OBJ_ANY; /* ok as long as it exists */
 	else if (sp[0] == '}')
-		expected_type = OBJ_NONE;
+		expected_type = OBJ_NONE; /* unwrap until we get a non-tag */
 	else if (sp[0] == '/')
 		expected_type = OBJ_COMMIT;
 	else
