From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] attr.c: use strchrnul() to scan for one line
Date: Sun, 15 May 2016 15:28:10 -0700
Message-ID: <xmqqr3d33qit.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 00:28:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b24WI-0004VY-2w
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 00:28:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbcEOW2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 18:28:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55357 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751798AbcEOW2N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 18:28:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F88D19806;
	Sun, 15 May 2016 18:28:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=c
	21gKez2/FnifwRnxxnB0iEwncg=; b=RiePFhVUm5HgJv45dS7UwaabJwz7FbTBJ
	t2B0L/Coy+P/uj6DgHmJo54JTCIULAL7W1tSTIUF2McWOMRdNHoRsqynhGAGUFi4
	778NdNM7/KuUNJhNBdbtF/hjtT9M9uYoS7HHpLP4zppeXpdkl4LHfwvZj5JKDf4j
	/3aZ+u9NIo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=g5I
	kixnhvrxCaUD0vIiakBUCvHSiH51jrNFkKipad5q7hcxXwi0+aF+ZyokavLDx41X
	5e8NNif38ofXSY2ZqNYdALQVuvv4BiCeHYg8cGi8Gts1skYQPZmIN9xVjJTXnM6E
	sjKuQgAGv05hO8DC3S55FS/ahdYlGRtPSwltNOis=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7757719805;
	Sun, 15 May 2016 18:28:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2CEB19802;
	Sun, 15 May 2016 18:28:11 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4EE1C016-1AEC-11E6-A6C6-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294690>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/attr.c b/attr.c
index a19946a..a7f2c3f 100644
--- a/attr.c
+++ b/attr.c
@@ -407,8 +407,8 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 	for (sp = buf; *sp; ) {
 		char *ep;
 		int more;
-		for (ep = sp; *ep && *ep != '\n'; ep++)
-			;
+
+		ep = strchrnul(sp, '\n');
 		more = (*ep == '\n');
 		*ep = '\0';
 		handle_attr_line(res, sp, path, ++lineno, macro_ok);
-- 
2.8.2-748-gfb85f76
