From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Tue, 24 Feb 2009 22:08:50 -0800
Message-ID: <7vk57fdp59.fsf@gitster.siamese.dyndns.org>
References: <1235227723-11471-1-git-send-email-git@storm-olsen.com>
 <7v8wnzr3k9.fsf@gitster.siamese.dyndns.org> <49A05958.7050703@trolltech.com>
 <20090223154237.GH22848@spearce.org> <49A2C8D1.3080104@trolltech.com>
 <20090223161657.GL22848@spearce.org>
 <7vab8cpqgl.fsf@gitster.siamese.dyndns.org> <49A40372.2060600@tedpavlic.com>
 <49A40858.6010108@trolltech.com> <49A414B8.8010906@tedpavlic.com>
 <7vljrvixa3.fsf@gitster.siamese.dyndns.org>
 <49A44EC6.3070800@storm-olsen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Pavlic <ted@tedpavlic.com>,
	Marius Storm-Olsen <marius@trolltech.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marius Storm-Olsen <git@storm-olsen.com>,
	git <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@storm-olsen.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 07:10:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcCyZ-0005Vt-Cz
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 07:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbZBYGJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 01:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbZBYGJE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 01:09:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbZBYGJC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 01:09:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A5B61EB2;
	Thu, 26 Feb 2009 01:08:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 88D7D1EB0; Thu,
 26 Feb 2009 01:08:51 -0500 (EST)
In-Reply-To: <49A44EC6.3070800@storm-olsen.com> (Marius Storm-Olsen's message
 of "Tue, 24 Feb 2009 20:47:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F4A7C74C-03CB-11DE-9076-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111372>

Marius Storm-Olsen <marius@storm-olsen.com> writes:

> Junio, unfortunately you applied the incorrect version.
>
> It was v3 (Message-Id:
> <1235244057-16912-1-git-send-email-git@storm-olsen.com>) which was the
> correct one, since it's the one that avoids the "GIT_DIR!" in a bare
> repo. :-/

Sorry, I only was looking at the thread that had Shawn's Ack.
Is this interdiff as a fix-up Ok?

-- >8 --

Subject: [PATCH] Fixup: Add bare repository indicator for __git_ps1

Signed-off-by: Marius Storm-Olsen <git@storm-olsen.com>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a61d852..dd393cd 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -117,9 +117,14 @@ __git_ps1 ()
 
 		local w
 		local i
+		local c
 
 		if [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
-			b="GIT_DIR!"
+			if [ "true" = "$(git config --bool core.bare 2>/dev/null)" ]; then
+				c="BARE:"
+			else
+				b="GIT_DIR!"
+			fi
 		elif [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then
 			if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
 				if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
@@ -135,12 +140,6 @@ __git_ps1 ()
 			fi
 		fi
 
-		local c
-
-		if [ "true" = "$(git config --bool core.bare 2>/dev/null)" ]; then
-			c="BARE:"
-		fi
-
 		if [ -n "$b" ]; then
 			if [ -n "${1-}" ]; then
 				printf "$1" "$c${b##refs/heads/}$w$i$r"
-- 
1.6.2.rc1.113.ga620b
