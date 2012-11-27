From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/5] diff --shortstat: do not count "unmerged" entries
Date: Tue, 27 Nov 2012 14:21:30 -0800
Message-ID: <7vsj7ulmad.fsf@alter.siamese.dyndns.org>
References: <1354051310-29093-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 27 23:21:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdTXJ-0008KC-8F
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 23:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604Ab2K0WVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 17:21:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754509Ab2K0WVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 17:21:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3D11A5AC;
	Tue, 27 Nov 2012 17:21:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4GYNvnleXmFzzBfM68ZV6FgFSUQ=; b=M2tTqY
	o+vxj1Hj3YJnie/ybvha6qVSjzRfBPJaXpXtEBk3uHlvtcz5xfFBe2Hmvpoxq6DY
	+N6ozEoYmAg/oSfKsx081NS3kfXQxPIvWUvqLVYe/intN0XFrj1d3nPToqQMeAlu
	aK2OGR3bL6oRYErbpIErufh2w2V+nZ2PGhbBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ipe3mPHkLF8EMaEioBkrvIP0EalpCDTy
	df9cktBf+vAZJAPgjkzZ7tD4zhvCGffyRVEnB3FYR/C49f3FERdAncv4RhGIoL27
	RLGry74/f/0dtKUPD6zvQ5m0Trh/DI/5MNGHRqbjVQVpkRxT3XZDhkOJwlGMCKjG
	WvCIXigQcYk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C09BEA5AA;
	Tue, 27 Nov 2012 17:21:32 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2D6D0A5A8; Tue, 27 Nov 2012
 17:21:32 -0500 (EST)
In-Reply-To: <1354051310-29093-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Tue, 27 Nov 2012 13:21:45 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC0F8DB2-38E0-11E2-80D4-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210611>

Fix the same issue as the previous one for "git diff --stat";
unmerged entries was doubly-counted.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 26ede82..374b235 100644
--- a/diff.c
+++ b/diff.c
@@ -1701,9 +1701,8 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 		int added = data->files[i]->added;
 		int deleted= data->files[i]->deleted;
 
-		if (data->files[i]->is_unmerged)
-			continue;
-		if (!data->files[i]->is_interesting && (added + deleted == 0)) {
+		if (data->files[i]->is_unmerged ||
+		    (!data->files[i]->is_interesting && (added + deleted == 0))) {
 			total_files--;
 		} else if (!data->files[i]->is_binary) { /* don't count bytes */
 			adds += added;
-- 
1.8.0.1.337.gd2c5e06
