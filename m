From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] get_tree_entry: map blank requested entry to tree root
Date: Tue, 09 Jan 2007 17:04:19 -0800
Message-ID: <7v64bfheuk.fsf@assigned-by-dhcp.cox.net>
References: <20070109161147.GA9313@coredump.intra.peff.net>
	<7vk5zviwxa.fsf@assigned-by-dhcp.cox.net>
	<20070110004633.GA14345@coredump.intra.peff.net>
	<7vac0rhf6g.fsf@assigned-by-dhcp.cox.net>
	<20070110005750.GA18242@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 02:04:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Rt9-0001ik-81
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 02:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbXAJBEV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 20:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932612AbXAJBEV
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 20:04:21 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:59453 "EHLO
	fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932611AbXAJBEU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 20:04:20 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110010419.XJQ3976.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 20:04:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9D3V1W0011kojtg0000000; Tue, 09 Jan 2007 20:03:29 -0500
To: Jeff King <peff@peff.net>
In-Reply-To: <20070110005750.GA18242@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 9 Jan 2007 19:57:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36455>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 09, 2007 at 04:57:11PM -0800, Junio C Hamano wrote:
>
>> I've noticed this while looking at your patch and fixed it in my
>> tree already.
>
> Thanks, I will stop looking, then. :)

-- >8 --
[PATCH] builtin-archive: do not free a tree held by the object layer.

Found by running "git archive --format=tar HEAD" in Documentation/
directory.

It's surprising that nobody has noticed this from the beginning...

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-archive.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 391cf43..32737d3 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -137,7 +137,6 @@ void parse_treeish_arg(const char **argv, struct archiver_args *ar_args,
 		if (err || !S_ISDIR(mode))
 			die("current working directory is untracked");
 
-		free(tree);
 		tree = parse_tree_indirect(tree_sha1);
 	}
 	ar_args->tree = tree;
