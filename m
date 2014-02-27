From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2] branch: change install_branch_config() to use skip_prefix()
Date: Thu, 27 Feb 2014 19:35:29 +0400
Message-ID: <530F5B41.1050900@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 27 16:43:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ36w-00024y-5Y
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 16:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbaB0Pmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 10:42:54 -0500
Received: from forward10.mail.yandex.net ([77.88.61.49]:52923 "EHLO
	forward10.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbaB0Pmx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 10:42:53 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2014 10:42:53 EST
Received: from smtp9.mail.yandex.net (smtp9.mail.yandex.net [77.88.61.35])
	by forward10.mail.yandex.net (Yandex) with ESMTP id 7C25A1020208
	for <git@vger.kernel.org>; Thu, 27 Feb 2014 19:35:30 +0400 (MSK)
Received: from smtp9.mail.yandex.net (localhost [127.0.0.1])
	by smtp9.mail.yandex.net (Yandex) with ESMTP id 5BED215200F5
	for <git@vger.kernel.org>; Thu, 27 Feb 2014 19:35:30 +0400 (MSK)
Received: from 212.192.143.160 (212.192.143.160 [212.192.143.160])
	by smtp9.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id BLmnu1Fi2X-ZTG8CVBP;
	Thu, 27 Feb 2014 19:35:30 +0400
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client certificate not present)
X-Yandex-Uniq: 7b31b6f3-9fc5-4ad9-bdca-f74dc0c91030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393515330;
	bh=tatnkI+qukKZuKfCvpnjAG8/9iR4+5uEXU/50itbZvg=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 Content-Type:Content-Transfer-Encoding;
	b=YHVrFJpssy7go9RjpMqtoWoOX/R6JD06BQZDvzsZKl38phRNU1gORYdniW/dkoryT
	 CwlFIgW/SL85k7LurhDJeUaVMkIdXnUI604dMEtJxE77fEiZSYCsWUopDIN2EP4OWz
	 kwejWiOrmFi7iTIXZnLLmO0FJZ23ymxYfeg4FwtU=
Authentication-Results: smtp9.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242829>

Change install_branch_config() to use skip_prefix()
for getting the short name of the remote branch.

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 branch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..9382e02 100644
--- a/branch.c
+++ b/branch.c
@@ -49,8 +49,8 @@ static int should_setup_rebase(const char *origin)
 
 void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
 {
-	const char *shortname = remote + 11;
-	int remote_is_branch = starts_with(remote, "refs/heads/");
+	const char *shortname = skip_prefix(remote, "refs/heads/");
+	int remote_is_branch = shortname != NULL;
 	struct strbuf key = STRBUF_INIT;
 	int rebasing = should_setup_rebase(origin);
 
-- 
1.8.3.2
