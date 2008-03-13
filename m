From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] git fetch: Take '-n' to mean '--no-tags'
Date: Thu, 13 Mar 2008 08:13:15 +0100
Message-ID: <47D8D40B.60409@op5.se>
References: <20080312105102.GE14040@wo.int.altlinux.org> <47D7EE27.50407@op5.se> <alpine.LSU.1.00.0803121703010.1656@racer.site> <47D7FF8E.5040700@op5.se> <alpine.LSU.1.00.0803121710460.1656@racer.site> <47D8CEA6.5040301@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Dmitry V. Levin" <ldv@altlinux.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 08:14:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZhdf-0002X4-4N
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 08:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751945AbYCMHNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 03:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbYCMHNU
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 03:13:20 -0400
Received: from mail.op5.se ([193.201.96.20]:46796 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbYCMHNS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 03:13:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2B76F1F080CF;
	Thu, 13 Mar 2008 08:14:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SAo3KQ+38Jri; Thu, 13 Mar 2008 08:14:22 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 5313F1F0803C;
	Thu, 13 Mar 2008 08:14:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <47D8CEA6.5040301@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77041>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Prior to commit 83201998730ac5f0b95ac832f3b727da26ab0129, we
understood '-n' as a short option to mean "don't fetch tags
from the remote". This patch reinstates behaviour similar,
but not identical to the pre commit 832019987 times.

Back then, -n always overrode --tags, so if both --tags and -n
was given on command-line, no tags were fetched regardless of
argument ordering. Now we use a "last entry wins" strategy,
so '-n --tags' means "fetch tags".
Since it's patently absurd to say both --tags and --no-tags
this shouldn't matter in practice.

Spotted-by: Artem Zolochevskiy <azol@altlinux.org>
Reported-by: Dmitry V. Levin <ldv@altlinux.org>
Tested-by: Andreas Ericsson <ae@op5.se>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

Andreas Ericsson wrote:
> Johannes Schindelin wrote:
>>
>> Maybe like this (completely untested, that will be your task tomorrow):
>>
> 
> Looks like how I thought it should be. Test passed fine, both real and
> automated. Proper patch incoming in a minute.
> 

And here it is.

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 55f611e..b2b9935 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -40,6 +40,8 @@ static struct option builtin_fetch_options[] = {
 		    "force overwrite of local branch"),
 	OPT_SET_INT('t', "tags", &tags,
 		    "fetch all tags and associated objects", TAGS_SET),
+	OPT_SET_INT('n', NULL, &tags,
+		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
 	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
 		    "allow updating of HEAD ref"),
-- 
1.5.4.4.532.ga6828.dirty

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
