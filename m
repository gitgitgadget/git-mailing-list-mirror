From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Emit helpful status for accidental "git stash" save
Date: Sat, 22 Dec 2007 09:58:09 -0800
Message-ID: <7vabo2y5la.fsf@gitster.siamese.dyndns.org>
References: <7vmys2ya0l.fsf@gitster.siamese.dyndns.org>
	<1198344685-24156-1-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 18:58:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J68cX-0001mB-FE
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 18:58:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbXLVR6W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Dec 2007 12:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbXLVR6W
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 12:58:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbXLVR6W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Dec 2007 12:58:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B545D68F0;
	Sat, 22 Dec 2007 12:58:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 291A968E5;
	Sat, 22 Dec 2007 12:58:16 -0500 (EST)
In-Reply-To: <1198344685-24156-1-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Sat, 22 Dec 2007 18:31:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69150>

Wincent Colaiuta <win@wincent.com> writes:

> El 22/12/2007, a las 17:22, Junio C Hamano escribi=C3=83=C2=B3:
>
>> I like that "To restore them..." insn, and I like that this is
>> much less invasive than anything we have seen during the
>> discussion.  But can we do this only for an accidental "git
>> stash" not for a deliberate "git stash save"?
>
> Something like this then?

Sure, even like this.

 git-stash.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index f16fd9c..ade300c 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -99,7 +99,7 @@ save_stash () {
=20
 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
 		die "Cannot save the current status"
-	printf >&2 'Saved "%s"\n' "$stash_msg"
+	printf >&2 'Saved working directory and index state "%s"\n' "$stash_m=
sg"
 }
=20
 have_stash () {
@@ -228,7 +228,9 @@ create)
 *)
 	if test $# -eq 0
 	then
-		save_stash && git-reset --hard
+		save_stash &&=20
+		echo >&2 '(To restore them type "git stash apply")' &&
+		git-reset --hard
 	else
 		usage
 	fi
