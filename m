From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] commit.c: use strchrnul() to scan for one line
Date: Sun, 15 May 2016 15:23:15 -0700
Message-ID: <xmqq37pj55bg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 00:23:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b24Rc-0000AL-J3
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 00:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751870AbcEOWXT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 18:23:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751798AbcEOWXS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 18:23:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 761261978E;
	Sun, 15 May 2016 18:23:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	Bf8nH2fis86PFSHVfKoClOJpuI=; b=GuiNCPJqlObBaW4mOFpa07ouUxd1Rjbrd
	1W0dghLbKdjhbRUHNrvhckVHyygS5mDmDZb58BJoHc0DGZZ+634Aek13hUMn4Tw0
	ywE805pvGNH8deCCZ1UTKpX1BMDDm0McdTmpAvw4hz6C8Wx24g1BI+QVRFZR0zSX
	4URgQ6yQnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Nt8
	Xf5iQ6GgRsR+AZbL2KjdRqioq9HuD7+uXvAzxFQJWTk4qNmSeIet4c/RyyYEvduk
	R6/vlXCgJ3Wj6rJ6FkAtjb+NNEiLKIPPeZUSLIgo8Jjoek3ixyQTG4SZVdw1f8kZ
	+WfpadiiKsqK8l7e1uqS8fm+hghf5Xbetb/zpw2k=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E5101978D;
	Sun, 15 May 2016 18:23:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D1D1E1978C;
	Sun, 15 May 2016 18:23:16 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9F01CBD2-1AEB-11E6-B60A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294689>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/commit.c b/commit.c
index 3f4f371..1f9ee8a 100644
--- a/commit.c
+++ b/commit.c
@@ -415,8 +415,7 @@ int find_commit_subject(const char *commit_buffer, const char **subject)
 		p++;
 	if (*p) {
 		p += 2;
-		for (eol = p; *eol && *eol != '\n'; eol++)
-			; /* do nothing */
+		eol = strchrnul(p, '\n');
 	} else
 		eol = p;
 
-- 
2.8.2-748-gfb85f76
