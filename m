From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use 'fast-forward' all over the place
Date: Sun, 25 Oct 2009 00:15:05 -0700
Message-ID: <7vtyxoymfa.fsf@alter.siamese.dyndns.org>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
 <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
 <7v1vks2l8q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 08:15:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1xKY-0002hg-D4
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 08:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbZJYHPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 03:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbZJYHPQ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 03:15:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986AbZJYHPP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 03:15:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2715F85209;
	Sun, 25 Oct 2009 03:15:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ax1Q/xudZNwLQ2RYHdF/MatXQCc=; b=dwTl7d
	BVMxv6EyV9VLquaNsJedh0G5MRrIuAAU6raEm+scV5rM0AsbqCWk6p+tsyRFEkUl
	ia4N+e/QCTlOEHaqQAF9U2IWWLmBuFPnrEam3YiQ7ZVRzg4wNivxHMAZTkECUOA5
	5qtUxoJQUlHKQOe5g3WEGOJuQ4+ugwZUKoQ38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GQwryPln+Pl/dAr/ukjQu7ITttdv0dpg
	p14eizR2nJ8wGpemctyVlq+U1ehM9KQW1RfSUQzn4aOaKA1DkGfJeiQH4YPyLGvn
	cvozTzkQ2PxH2OrGzbC+3wMotCNAy/2Q/HBcb6EUmfIv0NIAX8O1qGDsxXlESqhL
	zhMo6NTae18=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E6DED85205;
	Sun, 25 Oct 2009 03:15:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5A7FD85204; Sun, 25 Oct 2009
 03:15:07 -0400 (EDT)
In-Reply-To: <7v1vks2l8q.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 24 Oct 2009 20\:41\:41 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 231A9D66-C136-11DE-B260-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131189>

I'll queue your patch with the following interdiff for now.

 * user-manual.txt: do not change emphasis (typography) in this patch---if
   it needs to be changed, that should be a separate patch.

 * builtin-fetch.c: an instance of "non fast-forward" was left
   unconverted; fix it.

 * contrib/hooks/post-receive-email: likewise.

   By the way, in Documentation/git-init.txt there also is another "non
   fast-forward"; since it is not a fix-up to this patch, I left it as-is.
   We may want to change it as well while we are at it.

 * git-gui: this is a straight revert of your patch, so that Shawn can
   apply an undated version of this patch to his tree first, and then I
   can pull the result from him.

   $ git grep -i -n -e 'fast forward' -- git-gui/

   will show what need to be changed.  This is a key string of "mc", so
   msgid in *.po files and git-gui.pot file need to consistently change,
   even though the translated strings in *.po files may stay as before.

If you spot misconversions in here (or other "fast forward" that need to be
converted but I missed), please holler.

Thanks.

---

 Documentation/user-manual.txt    |    2 +-
 builtin-fetch.c                  |    2 +-
 contrib/hooks/post-receive-email |    2 +-
 git-gui/lib/branch_create.tcl    |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 42d92fd..269ec47 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2115,7 +2115,7 @@ $ git checkout release && git pull
 
 Important note!  If you have any local changes in these branches, then
 this merge will create a commit object in the history (with no local
-changes git will simply do a fast-forward merge).  Many people dislike
+changes git will simply do a "fast-forward" merge).  Many people dislike
 the "noise" that this creates in the Linux history, so you should avoid
 doing this capriciously in the "release" branch, as these noisy commits
 will become part of the permanent history when you ask Linus to pull
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 89cedc8..6303aa0 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -287,7 +287,7 @@ static int update_local_ref(struct ref *ref,
 			r ? "unable to update local ref" : "forced update");
 		return r;
 	} else {
-		sprintf(display, "! %-*s %-*s -> %s  (non fast-forward)",
+		sprintf(display, "! %-*s %-*s -> %s  (non-fast-forward)",
 			SUMMARY_WIDTH, "[rejected]", REFCOL_WIDTH, remote,
 			pretty_ref);
 		return 1;
diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 3b075ad..58a35c8 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -316,7 +316,7 @@ generate_update_branch_email()
 
 	# List all of the revisions that were removed by this update, in a
 	# fast-forward update, this list will be empty, because rev-list O
-	# ^N is empty.  For a non fast-forward, O ^N is the list of removed
+	# ^N is empty.  For a non-fast-forward, O ^N is the list of removed
 	# revisions
 	fast_forward=""
 	rev=""
diff --git a/git-gui/lib/branch_create.tcl b/git-gui/lib/branch_create.tcl
index f1235c7..3817771 100644
--- a/git-gui/lib/branch_create.tcl
+++ b/git-gui/lib/branch_create.tcl
@@ -77,7 +77,7 @@ constructor dialog {} {
 		-variable @opt_merge
 	pack $w.options.merge.no -side left
 	radiobutton $w.options.merge.ff \
-		-text [mc "Fast-forward Only"] \
+		-text [mc "Fast Forward Only"] \
 		-value ff \
 		-variable @opt_merge
 	pack $w.options.merge.ff -side left
