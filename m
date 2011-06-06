From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 3/3] submodule add: clean up duplicated code
Date: Mon, 06 Jun 2011 21:58:43 +0200
Message-ID: <4DED3173.20804@web.de>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de> <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de> <7vipskb0br.fsf@alter.siamese.dyndns.org> <4DED30E0.6090608@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:58:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTfwo-0004OS-5Z
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 21:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab1FFT6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 15:58:45 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:34237 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753289Ab1FFT6p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 15:58:45 -0400
Received: from smtp07.web.de  ( [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 2E61D1918F185;
	Mon,  6 Jun 2011 21:58:44 +0200 (CEST)
Received: from [93.240.124.249] (helo=[192.168.178.43])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QTfwi-000588-00; Mon, 06 Jun 2011 21:58:44 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DED30E0.6090608@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18fYcEV0zBHShJ72z2QZJl1b7yL545IEWdvfiBV
	96VZMsdijAkV1vXneWG50iJRYOp8+GHikyRDQkHR6MpuhCBXoJ
	dkmKb0PWM6+rz8Aq4ffA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175157>

In cmd_add() the switch statement used to resolve a relative url was
present twice. Remove the second one and use the realrepo variable set
by the first one (lines 194 ff.) instead.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-submodule.sh |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 3fbc21e..2a727e1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -238,15 +238,7 @@ cmd_add()
 			die "'$path' already exists and is not a valid git repo"
 		fi

-		case "$repo" in
-		./*|../*)
-			url=$(resolve_relative_url "$repo") || exit
-		    ;;
-		*)
-			url="$repo"
-			;;
-		esac
-		git config submodule."$path".url "$url"
+		git config submodule."$path".url "$realrepo"
 	else

 		module_clone "$path" "$realrepo" "$reference" || exit
-- 
1.7.6.rc0.3.g28a66
