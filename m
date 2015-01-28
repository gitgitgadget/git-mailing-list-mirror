From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Score in diff-format
Date: Wed, 28 Jan 2015 13:17:19 -0800
Message-ID: <xmqqk306fvvk.fsf@gitster.dls.corp.google.com>
References: <20150128062309.GA29506@glandium.org>
	<54C8F306.1000001@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 29 02:12:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGdf7-0002rB-Bf
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 02:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbbA2BMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 20:12:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751752AbbA2BM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:12:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DA90F345A2;
	Wed, 28 Jan 2015 16:17:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nwo0VqwEiNE3oRk6qnQ1fmV+Iq8=; b=S7fPVL
	ny7SKquPh39WZtsZGZgZqKHSCVo0LKaehOw2Pxq2zIkn0Oin7/P28BMb8YSqGF1P
	725OgeA6Qm6Lm5m+ihCdpSNUIZYOJZU/bGlSBMKdG5vu6dYBjWMWSkP+ay3K+gfQ
	cjiRjj5kT3CebN/+iO2PdIW0GJctmw+J9t+ME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t5wSXhJ01qODiAra7MRdQEWP6j7pspZs
	EBuhUaImYtm4N1sHzcylfjfizcixiSh8XRDWeWuRdpKEQD+T/l3FyX7UU6Awuf7F
	pPx3DybRQCSCuiSzfQXsRocCPhjNYd91nHHkvvZUZsIa6/11VYtPGxx45dtYZ0lF
	1D9bGUoxcgg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D2136345A0;
	Wed, 28 Jan 2015 16:17:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5456F3459F;
	Wed, 28 Jan 2015 16:17:20 -0500 (EST)
In-Reply-To: <54C8F306.1000001@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 28 Jan 2015 15:32:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B59DF1E-A733-11E4-8107-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263127>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I'd say it depends on the definition of "so". The documentation is
> correct if you read "so" as "*always* followed by a score". I guess you
> read it as "followed by a score".

I read it so as well ;-)

> Percentages with M are not mentioned in diff-format, but they are a
> consequence of "-B" processing. Maybe we could mention that?

-- >8 --
Subject: diff-format doc: a score can follow M for rewrite

b6d8f309 (diff-raw format update take #2., 2005-05-23) started
documenting the diff format, and it said

 ...
 (8) sha1 for "dst"; 0{40} if creation, unmerged or "look at work tree".
 (9) status, followed by similarlity index number only for C and R.
 (10) a tab or a NUL when '-z' option is used.
 ...

because C and R _were_ the only ones that came with a number back
then.  This was corrected by ddafa7e9 (diff-helper: Fix R/C score
parsing under -z flag., 2005-05-29) and we started saying "score"
instead of "similarlity index" (because we can have other kind of
score there), and stopped saying "only for C and R" (because Git is
an ever evolving system).  Later f345b0a0 ([PATCH] Add -B flag to
diff-* brothers., 2005-05-30) introduced a new concept,
"dissimilarity" score and it did not have to fix any documentation.

The current text that says only C and R can have scores came
independently from a5a323f3 (Add reference for status letters in
documentation., 2008-11-02) and it was wrong from the day one.

Noticed-by: Mike Hommey
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/diff-format.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index 15c7e79..e6cfc9b 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -66,7 +66,8 @@ be committed)
 
 Status letters C and R are always followed by a score (denoting the
 percentage of similarity between the source and target of the move or
-copy), and are the only ones to be so.
+copy).  M may show how completely the modification rewrites the file
+with a score (denoting the percentage of dissimilarity).
 
 <sha1> is shown as all 0's if a file is new on the filesystem
 and it is out of sync with the index.
