From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] fetch-pack: mention server version with verbose output
Date: Mon, 13 Aug 2012 12:07:35 -0700
Message-ID: <7v7gt2ehl4.fsf_-_@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
 <20120810211509.GB888@sigill.intra.peff.net>
 <7v393uif9g.fsf@alter.siamese.dyndns.org>
 <7vboieehrf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 13 21:07:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0zzR-0002K5-EY
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 21:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852Ab2HMTHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 15:07:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44566 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752083Ab2HMTHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 15:07:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 302E88A4F;
	Mon, 13 Aug 2012 15:07:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o5Wz8I4/fMk5LPSsmtNkjFishd4=; b=AhKab6
	1YO/Vx0CeVLBhNQpErn0HjCKB/K0w0ryba1SpGmehaI2iz4BhBqCmIKSJTjo/3Et
	KEY9oMOe99gOFK+9PW/owkw6dmJnfsODDZiIAwPqbC6mZY2NMmTuIKvJfFHAnMr9
	M9vXD6Sj36TrRoKSlshJEpNT0HxsrWfENdWvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fCDhqARYhyHt6q9y9o1xjGSK9s0Lpe8N
	bc12ueEi9FJpnyeVxL8UUfME9W3g23jvRnVuoLsvXSC9BM/RTtayFK1HAi+jq4+8
	UvYSjHJvhKOAY4hBkSberr2lLotTWLD+4iurLZpIIquWStuQwCewWK58To5Zdzw1
	q4gvCrM4G2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F0468A4E;
	Mon, 13 Aug 2012 15:07:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E0738A4C; Mon, 13 Aug 2012
 15:07:37 -0400 (EDT)
In-Reply-To: <7vboieehrf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 13 Aug 2012 12:03:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 254658E4-E57A-11E1-A907-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203354>

Fetch-pack's verbose mode is more of a debugging mode (and in fact
takes two "-v" arguments to trigger via the porcelain layer). Let's
mention the server version as another possible item of interest.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this is your 4 adjusted for the previous one, releaving the
   caller from having to figure out where the capability string
   ends.

 builtin/fetch-pack.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index fdec7f6..1633aa3 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -787,6 +787,8 @@ static struct ref *do_fetch_pack(int fd[2],
 {
 	struct ref *ref = copy_ref_list(orig_ref);
 	unsigned char sha1[20];
+	const char *agent_feature = NULL;
+	int agent_len;
 
 	sort_ref_list(&ref, ref_compare_name);
 
@@ -829,8 +831,15 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
-	if (server_supports("agent"))
+
+	if ((agent_feature = server_feature("agent", &agent_len)) != NULL &&
+	    5 < agent_len && agent_feature[5] == '=') {
 		agent_supported = 1;
+		if (args.verbose) {
+			fprintf(stderr, "Server version is %.*s\n",
+				agent_len - 6, agent_feature + 6);
+		}
+	}
 
 	if (everything_local(&ref, nr_match, match)) {
 		packet_flush(fd[1]);
-- 
1.7.12.rc2.85.g1de7134
