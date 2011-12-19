From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* How to generate pull-request with info of signed tag
Date: Mon, 19 Dec 2011 12:06:55 -0800
Message-ID: <7vk45smilc.fsf@alter.siamese.dyndns.org>
References: <874nx1korf.fsf@linux.vnet.ibm.com>
 <7vbor8jw0h.fsf@alter.siamese.dyndns.org> <871us3l45o.fsf@linux.vnet.ibm.com>
 <7viplfdlpb.fsf@alter.siamese.dyndns.org> <87iplch79e.fsf@linux.vnet.ibm.com>
 <7vobv4mj4r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 19 21:07:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcjUF-0006bX-Pl
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 21:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752908Ab1LSUHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 15:07:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab1LSUG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 15:06:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C69CA7DC4;
	Mon, 19 Dec 2011 15:06:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k+iWgDBtGtc8xRBXSwRMvYl0/sI=; b=nwsJCY
	SecuFcjE0u1LQ0xmZN8CH5N0kMCIeIIhra0ID1RrCT72zDKBMJoh6NzZsvA0h8em
	JCL1S90Prxg08N/+Asv/LheqcB/VcDHgbA2agK8GZ2/jMVyEIo1PXXqAhNjPXRtb
	EVcbUUjuYhbo1MG3JjcUAnxQqNVzgfeXahKsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vgJngXba6SRMrBC8svaJeNYIPJ50K6EB
	99aGGcOtQP/LJFBze9sRLZ5FLgfGz0quYa1/YeaaOMqTQCPD7t73hoaaR4lwMdrI
	bwlX/lMCIBJ6LV8/Zkvyy6Ql6c+CDXcw9lnFgznK93Z0cRIHaHTJC4vGZebR605K
	ywFLKIS9B/U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDD4F7DC3;
	Mon, 19 Dec 2011 15:06:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EF0E7DC2; Mon, 19 Dec 2011
 15:06:57 -0500 (EST)
In-Reply-To: <7vobv4mj4r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 19 Dec 2011 11:55:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00EDAC8A-2A7D-11E1-AF56-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187467>

Junio C Hamano <gitster@pobox.com> writes:

> Come to think of it, the last patch I sent out on request pull was very
> wrong....

And this should fix it.

-- >8 --
Subject: [PATCH] request-pull: do not emit "tag" before the tagname

The whole point of the recent update to allow "git pull $url $tagname" is
so that the integrator does not have to store the (signed) tag that is
used to convey authenticity to be recorded in the resulting merge in the
local repository's tag namespace.  Asking for a merge be made with "git
pull $url tag $tagname" defeats it.

Note that the request can become ambiguous if the requestor has a branch
with the same name as the tag, but that is not a new problem limited to
pulling. I wouldn't mind if somebody wants to add disambiguation to the
find_matching_ref logic in the script as a separate patch, though.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-request-pull.sh     |    4 +---
 t/t5150-request-pull.sh |    2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index 7b5c777..d7ba117 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -63,10 +63,8 @@ die "fatal: No commits in common between $base and $head"
 find_matching_ref='
 	sub abbr {
 		my $ref = shift;
-		if ($ref =~ s|refs/heads/||) {
+		if ($ref =~ s|refs/heads/|| || $ref =~ s|refs/tags/||) {
 			return $ref;
-		} elsif ($ref =~ s|refs/tags/||) {
-			return "tag $ref";
 		} else {
 			return $ref;
 		}
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index aec842f..da25bc2 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -180,7 +180,7 @@ test_expect_success 'request names an appropriate branch' '
 		read branch
 	} <digest &&
 	{
-		test "$branch" = tag--full ||
+		test "$branch" = full ||
 		test "$branch" = master ||
 		test "$branch" = for-upstream
 	}
-- 
1.7.8.370.gb3269
