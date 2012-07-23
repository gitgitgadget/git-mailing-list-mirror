From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 1/4] Use variables for the lists of tools that support merging
 / diffing
Date: Mon, 23 Jul 2012 20:32:10 +0200
Message-ID: <500D98AA.2030902@gmail.com>
References: <500CF8CE.90906@gmail.com> <500CF9D2.30102@gmail.com> <500CFAB4.4050905@gmail.com> <7vvchemnmn.fsf@alter.siamese.dyndns.org> <500D984D.4070909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Jul 23 20:32:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StNQb-0003oZ-C4
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 20:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab2GWScQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 14:32:16 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50010 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754187Ab2GWScQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 14:32:16 -0400
Received: by wgbdr13 with SMTP id dr13so6109200wgb.1
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Anp5Em/NJnbSzHhhzb+Ycl9AGIuvlCHrgIHCxNrQZFs=;
        b=izYnwTk5LKuUjRMx14fqv+Md9Txwd4hDWf+SczO8BQlMFvQSUi5zLkHN4PskqdgEDO
         G4xCWavjDzAi2DbMv0SbpkgyXJm5NtgWy2ertSVwRMIHAP1AKS0jVJvN8f7Rofz0YYvw
         LPgsl22IoMgVagmQ3NO300Ke190z96ip415GqKLZpYf4+6eXKr2U8413g2CKmID9wyMj
         8t35JglFZWtL5TELdKBAIa9pa4cjXvNBs3bjR+4a/jmULOvhugHKU2KltJMMg4wngr4s
         e+yHS0lgi87rRMj/+ye+d3nlK3NYA+vqFmQWh9u2SPu0dRpkhdHQCEURscCVn34Lfujh
         9wxg==
Received: by 10.217.1.195 with SMTP id n45mr3760571wes.179.1343068334666;
        Mon, 23 Jul 2012 11:32:14 -0700 (PDT)
Received: from [192.168.178.22] (p5DDB0653.dip0.t-ipconnect.de. [93.219.6.83])
        by mx.google.com with ESMTPS id cu1sm18153931wib.6.2012.07.23.11.32.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 11:32:14 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <500D984D.4070909@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201952>

Also, add a few comments that clarify the meaning of these variables and
sort the list of tools alphabetically.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 contrib/completion/git-completion.bash | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5be9dee..4a76120 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1325,17 +1325,24 @@ _git_diff ()
 	__git_complete_revlist_file
 }
 
-__git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bc3
+# Tools that support both merging and diffing.
+__git_diffmerge_tools="araxis bc3 diffuse ecmerge emerge gvimdiff
+			kdiff3 meld opendiff p4merge tkdiff vimdiff xxdiff
 "
 
+# Tools that support diffing.
+__git_difftools="$__git_diffmerge_tools kcompare"
+
+# Tools that support merging.
+__git_mergetools="$__git_diffmerge_tools tortoisemerge"
+
 _git_difftool ()
 {
 	__git_has_doubledash && return
 
 	case "$cur" in
 	--tool=*)
-		__gitcomp "$__git_mergetools_common kompare" "" "${cur##--tool=}"
+		__gitcomp "$__git_difftools" "" "${cur##--tool=}"
 		return
 		;;
 	--*)
@@ -1623,7 +1630,7 @@ _git_mergetool ()
 {
 	case "$cur" in
 	--tool=*)
-		__gitcomp "$__git_mergetools_common tortoisemerge" "" "${cur##--tool=}"
+		__gitcomp "$__git_mergetools" "" "${cur##--tool=}"
 		return
 		;;
 	--*)
-- 
1.7.11.msysgit.2
