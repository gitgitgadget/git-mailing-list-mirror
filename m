From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 04/11] commit.c: use ALLOC_GROW() in register_commit_graft()
Date: Mon, 03 Mar 2014 11:21:20 +0400
Message-ID: <53142D70.30704@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:22:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNCN-0001He-0j
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753737AbaCCHV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:21:58 -0500
Received: from forward8l.mail.yandex.net ([84.201.143.141]:35918 "EHLO
	forward8l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbaCCHV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:21:56 -0500
Received: from smtp11.mail.yandex.net (smtp11.mail.yandex.net [95.108.130.67])
	by forward8l.mail.yandex.net (Yandex) with ESMTP id DB9041A40EFE
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:21:55 +0400 (MSK)
Received: from smtp11.mail.yandex.net (localhost [127.0.0.1])
	by smtp11.mail.yandex.net (Yandex) with ESMTP id A31107E00C3
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:21:55 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp11.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 5kH4LZaqZW-LtmGJIW9;
	Mon,  3 Mar 2014 11:21:55 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 5ef04b80-384d-4f27-a542-b68a4fb8d410
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831315;
	bh=t9G8Z4+F/9/BRrRdsFG43p0bzrlybgafgt/OLPGNr3E=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=hE/3tG64K/UH9DGKhbJFQAsIjpifOXSp4B6SPl+sF+KXrF25dJWtWx40I9wliGinI
	 OeXi+nbGweWXl8Btm+SCfusJ+OwdPvCmObAF4nBrjUFlFSCgCW7u1ynCL/457D2csL
	 kwxttfZehkG4iC9Ju/WxEIydhJS/+7v52moipLPE=
Authentication-Results: smtp11.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53142CB9.80100@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243183>

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
