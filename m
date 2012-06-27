From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 13:35:15 -0700
Message-ID: <7v4npw8pdo.fsf@alter.siamese.dyndns.org>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
 <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
 <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
 <20120627195205.GA11700@sigill.intra.peff.net>
 <7vfw9g8pqn.fsf@alter.siamese.dyndns.org>
 <7vbok48pfu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Lyubomirov <daniel@digitalus.bg>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 22:35:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjyxO-0002dr-PO
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 22:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155Ab2F0UfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 16:35:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57980 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab2F0UfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 16:35:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EACC938F;
	Wed, 27 Jun 2012 16:35:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e1Rc1Gu+XHEqACWH/h5T7Fd4Azc=; b=msItEf
	RHeP5NtdcuDUDIaEHC82Va1+U4zhJFvPZwo+7RGJ8tNLU9MKZ0OhdQzKQ5yS/C4/
	I5Dwq8qmlH7NeF4yrFZPj8XtlKKMkbLJRboleYDSiDxNBypL7VGqzbR4984K60xU
	qpPvihwiuFHDTFT91/9MydjpepJITAil7ofZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z0dqZhomqSnNL1oRCK92kl92AcTkLNKN
	TXVS5m8a7KpbnsaWklnRwrqYcapCBD3UzaYtBqsFTB19SXuiqIQPnZKa+FqV9zOY
	vI6usVwobc1iQBP4foqzB63ua7AtdGJ4gKYk9TaBzRarAg5D0THENutzocZ5+B73
	RcLN142j/PU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 060C5938E;
	Wed, 27 Jun 2012 16:35:17 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E372938D; Wed, 27 Jun 2012
 16:35:16 -0400 (EDT)
In-Reply-To: <7vbok48pfu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Jun 2012 13:33:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9AA042D8-C097-11E1-8104-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200744>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> but that code path should be fixed properly (with a use_stdin flag in
>>> the filespec).
>>
>> Yes, just as I said; I am finding more and more issues with the
>> no-index hack that I have been fixing a bit by bit since I send the
>> message you responded to.
>
> It is not ready yet, but here are a few patches WIP.

And this is the second clean-up

-- >8 --
Subject: [PATCH 2/?] diff-index.c: unify handling of command line paths

Regardless of where in the directory hierarchy you are, "-" on the
command line means the standard input.  The old code knew too much
about how the low level machinery uses paths to read from the
working tree and did not bother to have the same check for "-" when
the command is run from the top-level.

Unify the codepaths for subdirectory case and toplevel case into one
and make it clearer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-no-index.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index ca875da..a5c1e3e 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -172,7 +172,7 @@ void diff_no_index(struct rev_info *revs,
 		   int argc, const char **argv,
 		   int nongit, const char *prefix)
 {
-	int i;
+	int i, prefixlen;
 	int no_index = 0;
 	unsigned options = 0;
 	const char *paths[2];
@@ -232,23 +232,18 @@ void diff_no_index(struct rev_info *revs,
 	if (!DIFF_OPT_TST(&revs->diffopt, EXIT_WITH_STATUS))
 		setup_pager();
 
-	if (prefix) {
-		int len = strlen(prefix);
-
-		for (i = 0; i < 2; i++) {
-			const char *p = argv[argc - 2 + i];
+	prefixlen = prefix ? strlen(prefix) : 0;
+	for (i = 0; i < 2; i++) {
+		const char *p = argv[argc - 2 + i];
+		if (!strcmp(p, "-"))
 			/*
-			 * stdin should be spelled as '-'; if you have
-			 * path that is '-', spell it as ./-.
+			 * stdin should be spelled as "-"; if you have
+			 * path that is "-", spell it as "./-".
 			 */
-			p = (strcmp(p, "-")
-			     ? xstrdup(prefix_filename(prefix, len, p))
-			     : p);
-			paths[i] = p;
-		}
-	} else {
-		for (i = 0; i < 2; i++)
-			paths[i] = argv[argc - 2 + i];
+			p = p;
+		else if (prefixlen)
+			p = xstrdup(prefix_filename(prefix, prefixlen, p));
+		paths[i] = p;
 	}
 	revs->diffopt.skip_stat_unmatch = 1;
 	if (!revs->diffopt.output_format)
-- 
1.7.11.1.184.g3ee8f69
