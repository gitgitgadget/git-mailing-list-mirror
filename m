From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hooks--update: allow deleting a tag through git push <remote> :<tag>
Date: Wed, 07 Nov 2007 16:54:42 -0800
Message-ID: <7v640d8skt.fsf@gitster.siamese.dyndns.org>
References: <20071107103450.29849.qmail@c27a4ce40673ff.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 01:55:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipvfm-0005Ve-Ii
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 01:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759391AbXKHAyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 19:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759291AbXKHAyu
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 19:54:50 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36991 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759037AbXKHAyt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 19:54:49 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4EA332EF;
	Wed,  7 Nov 2007 19:55:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CCC43935BF;
	Wed,  7 Nov 2007 19:55:06 -0500 (EST)
In-Reply-To: <20071107103450.29849.qmail@c27a4ce40673ff.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Wed, 7 Nov 2007 10:34:50 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63918>

Gerrit Pape <pape@smarden.org> writes:

> The update hook interpretes deleting a tag, no matter if annotated or not,
> through git push <remote> :<tag> as unannotated tag, and declines it by
> default:
> ...
> With this patch deleting a tag is allowed unconditionally, just as
> deleting a branch.
>
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
>  templates/hooks--update |    9 ++++++---
>  1 files changed, 6 insertions(+), 3 deletions(-)

Since you are allowing deletion for anything, wouldn't this be
much simpler, I wonder...

---

 templates/hooks--update |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/templates/hooks--update b/templates/hooks--update
index d8c7626..e12904a 100644
--- a/templates/hooks--update
+++ b/templates/hooks--update
@@ -41,9 +41,9 @@ if [ -z "$projectdesc" -o "$projectdesc" = "Unnamed repository; edit this file t
 fi
 
 # --- Check types
-# if $newrev is 0000...0000, it's a commit to delete a branch
+# if $newrev is 0000...0000, it's a commit to delete a ref.
 if [ "$newrev" = "0000000000000000000000000000000000000000" ]; then
-	newrev_type=commit
+	exit 0 ;# allow anything to be deleted
 else
 	newrev_type=$(git-cat-file -t $newrev)
 fi
