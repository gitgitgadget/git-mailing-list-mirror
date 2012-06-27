From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: problem with file named with dash character
Date: Wed, 27 Jun 2012 13:33:57 -0700
Message-ID: <7vbok48pfu.fsf@alter.siamese.dyndns.org>
References: <52ae7682-3e9a-4b52-bec1-08ba3aadffc0@office.digitalus.nl>
 <80a7ce17-3ee7-4f09-b984-b6685e163b87@office.digitalus.nl>
 <7vk3ys8v96.fsf@alter.siamese.dyndns.org>
 <20120627195205.GA11700@sigill.intra.peff.net>
 <7vfw9g8pqn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Lyubomirov <daniel@digitalus.bg>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 22:34:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sjyw9-0000nq-PP
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 22:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755634Ab2F0UeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 16:34:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57446 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547Ab2F0Ud7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 16:33:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65821934F;
	Wed, 27 Jun 2012 16:33:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rHCSziwvES/T+XnfRhLu0bJZRzc=; b=dt/zsz
	RS0xLdtmSn9xnOUdM5q06wt0w5pT+ukUxB4GAyWGWgJonr+jAk68dWe0RNp/SkHu
	1ep3RXDVV6LZhKXFpj5Qy8c03TMLZ03fEc72Z3A1kYRWJKLtawBJlXi5UC3Y9aA1
	IiPS/fulKr6gxfdo/+1PreaZ99jvLlIp+wDp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uCBIIE5nRMNA59BcGcYZ3pNB5XzsQgYd
	2rt7VfZSK2kR+nFHvhD0JIxAaeU2YzxoBUacgBK2jFA2Gzry7Glv3zJoFS+nHHW/
	ozvL0po63MqL3EiGUmWG0oJfkJffYBcA8lcl8JbtZnYdRgXqKrJUHnsHT3boYc9H
	yytwrfs5Pkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C05E934E;
	Wed, 27 Jun 2012 16:33:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A764C934D; Wed, 27 Jun 2012
 16:33:58 -0400 (EDT)
In-Reply-To: <7vfw9g8pqn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Jun 2012 13:27:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6C46422A-C097-11E1-BBEE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200743>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> but that code path should be fixed properly (with a use_stdin flag in
>> the filespec).
>
> Yes, just as I said; I am finding more and more issues with the
> no-index hack that I have been fixing a bit by bit since I send the
> message you responded to.

It is not ready yet, but here are a few patches WIP.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 27 Jun 2012 11:51:15 -0700
Subject: [PATCH 1/?] diff-index.c: do not pretend paths are pathspecs

"git diff --no-index" takes exactly two paths, not pathspecs, and
has its own way queue_diff() to populate the diff_queue.  Do not
call diff_tree_setup_paths(), pretending as it takes pathspecs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff-no-index.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/diff-no-index.c b/diff-no-index.c
index f0b0010..ca875da 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -175,6 +175,7 @@ void diff_no_index(struct rev_info *revs,
 	int i;
 	int no_index = 0;
 	unsigned options = 0;
+	const char *paths[2];
 
 	/* Were we asked to do --no-index explicitly? */
 	for (i = 1; i < argc; i++) {
@@ -233,8 +234,6 @@ void diff_no_index(struct rev_info *revs,
 
 	if (prefix) {
 		int len = strlen(prefix);
-		const char *paths[3];
-		memset(paths, 0, sizeof(paths));
 
 		for (i = 0; i < 2; i++) {
 			const char *p = argv[argc - 2 + i];
@@ -247,10 +246,10 @@ void diff_no_index(struct rev_info *revs,
 			     : p);
 			paths[i] = p;
 		}
-		diff_tree_setup_paths(paths, &revs->diffopt);
+	} else {
+		for (i = 0; i < 2; i++)
+			paths[i] = argv[argc - 2 + i];
 	}
-	else
-		diff_tree_setup_paths(argv + argc - 2, &revs->diffopt);
 	revs->diffopt.skip_stat_unmatch = 1;
 	if (!revs->diffopt.output_format)
 		revs->diffopt.output_format = DIFF_FORMAT_PATCH;
@@ -262,8 +261,7 @@ void diff_no_index(struct rev_info *revs,
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
 
-	if (queue_diff(&revs->diffopt, revs->diffopt.pathspec.raw[0],
-		       revs->diffopt.pathspec.raw[1]))
+	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
 		exit(1);
 	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
 	diffcore_std(&revs->diffopt);
-- 
1.7.11.1.184.g3ee8f69
