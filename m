From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 6/6] Add git-rewrite-commits
Date: Fri, 13 Jul 2007 10:01:00 +0200
Message-ID: <20070713080100.GN1528MdfPADPa@greensroom.kotnet.org>
References: <11842671631744-git-send-email-skimo@liacs.nl>
 <11842671631635-git-send-email-skimo@liacs.nl>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 10:01:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9G5N-0003sw-26
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 10:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759824AbXGMIBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 04:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759514AbXGMIBE
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 04:01:04 -0400
Received: from psmtp03.wxs.nl ([195.121.247.12]:47682 "EHLO psmtp03.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759207AbXGMIBC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 04:01:02 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JL3000EGY9OHZ@psmtp03.wxs.nl> for git@vger.kernel.org; Fri,
 13 Jul 2007 10:01:00 +0200 (MEST)
Received: (qmail 20437 invoked by uid 500); Fri, 13 Jul 2007 08:01:00 +0000
In-reply-to: <11842671631635-git-send-email-skimo@liacs.nl>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52370>

On Thu, Jul 12, 2007 at 09:06:03PM +0200, skimo@liacs.nl wrote:
> +static int rewrite_parents(struct commit *commit, int path_pruning)
> +{
> +	int n;
> +	struct commit_list *list, *parents, **prev;
> +	unsigned char sha1[20];
> +
> +	for (n = 0, prev = &commit->parents; *prev; ++n) {
> +		list = *prev;
> +
> +		rewrite_parents(list->item, path_pruning);
> +		if (!is_pruned(list->item, path_pruning)) {
> +			prev = &list->next;
> +			continue;
> +		}

Oops... that should be the other way around...

diff --git a/builtin-rewrite-commits.c b/builtin-rewrite-commits.c
index d95a16c..4cd17ae 100644
--- a/builtin-rewrite-commits.c
+++ b/builtin-rewrite-commits.c
@@ -279,11 +279,11 @@ static int rewrite_parents(struct commit *commit, int path_pruning)
 	for (n = 0, prev = &commit->parents; *prev; ++n) {
 		list = *prev;
 
-		rewrite_parents(list->item, path_pruning);
 		if (!is_pruned(list->item, path_pruning)) {
 			prev = &list->next;
 			continue;
 		}
+		rewrite_parents(list->item, path_pruning);
 
 		hashcpy(sha1, list->item->object.sha1);
 		get_rewritten_sha1(sha1);

I'll include it in my next version.

skimo
