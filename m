From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] remote prune: print the list of pruned branches
Date: Thu, 12 Jun 2008 00:00:41 -0700
Message-ID: <7v63sf9lye.fsf@gitster.siamese.dyndns.org>
References: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
 <1213109495-6974-1-git-send-email-dkr+ml.git@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Thu Jun 12 09:01:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6gok-000396-3Z
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 09:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbYFLHA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 03:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbYFLHA7
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 03:00:59 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35767 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbYFLHA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 03:00:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 02C8113DE;
	Thu, 12 Jun 2008 03:00:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 07C2013DD; Thu, 12 Jun 2008 03:00:49 -0400 (EDT)
In-Reply-To: <1213109495-6974-1-git-send-email-dkr+ml.git@free.fr> (Olivier
 Marin's message of "Tue, 10 Jun 2008 16:51:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4E66C120-384D-11DD-B071-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84726>

Olivier Marin <dkr+ml.git@free.fr> writes:

> diff --git a/builtin-remote.c b/builtin-remote.c
> index 745a4ee..851bdde 100644
> --- a/builtin-remote.c
> +++ b/builtin-remote.c
> ...  
> +		printf("Pruning %s\n", *argv);
> +		if (states.stale.nr)
> +			printf("From: %s\n", states.remote->url[0]);

Thanks.  I've queued the series (with minor fixups and rewording) to
'next' already, hoping that we can merge this fix to 'master' before
1.5.6.

But I am very tempted to also apply the following on top.  Thoughts?

-- >8 --
[PATCH] "remote prune": be quiet when there is nothing to prune

The previous commit made it always say "Pruning $remote" but reported the
URL only when there is something to prune.  Make it consistent by not
saying anything at all when there is nothing to prune.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-remote.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 4b00cf9..145dd85 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -560,12 +560,13 @@ static int prune(int argc, const char **argv)
 
 		get_remote_ref_states(*argv, &states, 1);
 
-		printf("Pruning %s\n", *argv);
-		if (states.stale.nr)
+		if (states.stale.nr) {
+			printf("Pruning %s\n", *argv);
 			printf("URL: %s\n",
 			       states.remote->url_nr
 			       ? states.remote->url[0]
 			       : "(no URL)");
+		}
 
 		for (i = 0; i < states.stale.nr; i++) {
 			const char *refname = states.stale.items[i].util;
-- 
1.5.6.rc2.26.g8c37
