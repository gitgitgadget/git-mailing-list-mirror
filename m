From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk fails to parse git log output in 1.5.3
Date: Sun, 02 Sep 2007 16:16:05 -0700
Message-ID: <7vzm04odze.fsf@gitster.siamese.dyndns.org>
References: <20070902223128.GA19198@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 01:16:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRygA-0003As-7o
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 01:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbXIBXQL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 19:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbXIBXQK
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 19:16:10 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42474 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbXIBXQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 19:16:09 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 19E5612CD51;
	Sun,  2 Sep 2007 19:16:29 -0400 (EDT)
In-Reply-To: <20070902223128.GA19198@falcon.digizenstudio.com> (Jing Xue's
	message of "Sun, 2 Sep 2007 18:31:28 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57401>

Jing Xue <jingxue@digizenstudio.com> writes:

> gitk shows an error "Can't parse git log output: {\x1b[33commit..." at
> startup and quits.
>
> Obviously it's because my git-log outputs in color mode. But the same
> happens (and git-log still outputs in colors) after I set color.pager=false. 
>
> What am I missing?

This will quickly turn into an FAQ.

Please see:

	http://thread.gmane.org/gmane.comp.version-control.git/57204

for details and a possible future plans.  Making "diff.color =
true" to always color was a mistake, and if you have such a
configuration, it would break any script that reads from "git
log".  In the meantime, do not do "diff.color = true" (or
"color.diff = true") in your configuration; say "auto" instead
of "true", and/or apply this patch.

---

 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 300fdce..9c21eff 100755
--- a/gitk
+++ b/gitk
@@ -93,6 +93,7 @@ proc start_rev_list {view} {
     }
     if {[catch {
 	set fd [open [concat | git log -z --pretty=raw $order --parents \
+			 --no-color \
 			 --boundary $viewargs($view) "--" $viewfiles($view)] r]
     } err]} {
 	error_popup "Error executing git rev-list: $err"
