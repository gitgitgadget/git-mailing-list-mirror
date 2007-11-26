From: Pascal Obry <pascal.obry@wanadoo.fr>
Subject: [PATCH] Use --no-color option on git log commands.
Date: Mon, 26 Nov 2007 23:04:28 +0100
Organization: Home
Message-ID: <474B42EC.1000408@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 26 23:04:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwm4S-0002rd-OT
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 23:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762AbXKZWEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 17:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755381AbXKZWEe
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 17:04:34 -0500
Received: from smtp28.orange.fr ([80.12.242.100]:41103 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753560AbXKZWEd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 17:04:33 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2807.orange.fr (SMTP Server) with ESMTP id B47AA80000B0
	for <git@vger.kernel.org>; Mon, 26 Nov 2007 23:04:31 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-61-188.w82-124.abo.wanadoo.fr [82.124.127.188])
	by mwinf2807.orange.fr (SMTP Server) with ESMTP id 80DD580000AE
	for <git@vger.kernel.org>; Mon, 26 Nov 2007 23:04:31 +0100 (CET)
X-ME-UUID: 20071126220431527.80DD580000AE@mwinf2807.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66140>


When colors are activated on the repository the git log output
will contain control characters to set/reset the colors. This
makes list_stash() fails as the sed regular expression does not
match the color control characters. Also use --no-color when
computing the head on create_stash() procedure.
---
 git-stash.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 534eb16..cde9767 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -37,7 +37,7 @@ create_stash () {
        # state of the base commit
        if b_commit=$(git rev-parse --verify HEAD)
        then
-               head=$(git log --abbrev-commit --pretty=oneline -n 1 HEAD)
+               head=$(git log --no-color --abbrev-commit
--pretty=oneline -n 1 HEAD)
        else
                die "You do not have the initial commit yet"
        fi
@@ -108,7 +108,7 @@ have_stash () {

 list_stash () {
        have_stash || return 0
-       git log --pretty=oneline -g "$@" $ref_stash |
+       git log --no-color --pretty=oneline -g "$@" $ref_stash |
        sed -n -e 's/^[.0-9a-f]* refs\///p'
 }

--
1.5.3.6.959.g1ab5

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
