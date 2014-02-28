From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 04/11] commit.c: change register_commit_graft() to use
 ALLOC_GROW()
Date: Fri, 28 Feb 2014 13:42:43 +0400
Message-ID: <53105A13.9070704@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:43:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJJye-0004Qf-5F
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:43:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbaB1Jn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:43:26 -0500
Received: from forward2l.mail.yandex.net ([84.201.143.145]:48785 "EHLO
	forward2l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbaB1JnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:43:22 -0500
Received: from smtp14.mail.yandex.net (smtp14.mail.yandex.net [95.108.131.192])
	by forward2l.mail.yandex.net (Yandex) with ESMTP id 3D85C1AC0F45
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:43:20 +0400 (MSK)
Received: from smtp14.mail.yandex.net (localhost [127.0.0.1])
	by smtp14.mail.yandex.net (Yandex) with ESMTP id F105A1B6136A
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:43:19 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp14.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QWpQqtY5UA-hJ2OZl7Z;
	Fri, 28 Feb 2014 13:43:19 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: f1e4f370-e072-4794-bd37-2422a9680d42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393580599;
	bh=t9G8Z4+F/9/BRrRdsFG43p0bzrlybgafgt/OLPGNr3E=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=lQjx5l/Yg86OUvHb06r+WWeIpIlOOoOEmd4F1lfo38dTvNLNybCvXFVHGmy0cmSUQ
	 U6gKAEN0ASOShs9iMknvrPXFCHIROnJs72owTif01Xzc1pJEqvySgbcJxV/U/fWDR+
	 hh3f5wwcUukWZkE2SncVVSwvxqdpLKZveOq1Dah8=
Authentication-Results: smtp14.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242923>

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 commit.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..e004314 100644
--- a/commit.c
+++ b/commit.c
@@ -147,12 +147,8 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 		return 1;
 	}
 	pos = -pos - 1;
-	if (commit_graft_alloc <= ++commit_graft_nr) {
-		commit_graft_alloc = alloc_nr(commit_graft_alloc);
-		commit_graft = xrealloc(commit_graft,
-					sizeof(*commit_graft) *
-					commit_graft_alloc);
-	}
+	ALLOC_GROW(commit_graft, commit_graft_nr + 1, commit_graft_alloc);
+	commit_graft_nr++;
 	if (pos < commit_graft_nr)
 		memmove(commit_graft + pos + 1,
 			commit_graft + pos,
-- 
1.8.5.3
