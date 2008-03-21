From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Permit refspec source side to parse as a sha1
Date: Thu, 20 Mar 2008 21:50:42 -0700
Message-ID: <7vabksu1ct.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org>
 <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 05:51:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcZE8-0001KS-6v
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 05:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbYCUEuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 00:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752997AbYCUEuz
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 00:50:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752963AbYCUEuy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 00:50:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A4F0D25B4;
	Fri, 21 Mar 2008 00:50:53 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EFBA925B1; Fri, 21 Mar 2008 00:50:49 -0400 (EDT)
In-Reply-To: <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 20 Mar 2008 21:10:59 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77711>

Junio C Hamano <gitster@pobox.com> writes:

> I really think we cannot afford piling hacks on top of hacks to hide the
> broken interface forever.  We have two different things to validate, and
> the callers all know what they have when calling us to validate.  We
> should not have a single loose validation that only catches "it cannot be
> either fetch nor push refspec" breakage.
> ...
> But at least I think something like this patch would lead us in the right
> direction.

On top of the one I sent out, with this patch, you can:

	$ git push other ':/remote show:refs/heads/new'

to send the commit you would review with "git show ':/remote show'".

---
 builtin-send-pack.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 930e0fb..bb9c33a 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -537,7 +537,7 @@ static void verify_remote_names(int nr_heads, const char **heads)
 	int i;
 
 	for (i = 0; i < nr_heads; i++) {
-		const char *remote = strchr(heads[i], ':');
+		const char *remote = strrchr(heads[i], ':');
 
 		remote = remote ? (remote + 1) : heads[i];
 		switch (check_ref_format(remote)) {
