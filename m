From: Caleb Cushing <xenoterracide@gmail.com>
Subject: Re: [PATCH] mergetool merge/skip/abort
Date: Wed, 21 Jan 2009 11:17:52 -0500
Message-ID: <81bfc67a0901210817r49971c09kea9dc8ee5ae21572@mail.gmail.com>
References: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 17:19:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPfnT-0002k5-Fp
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 17:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752056AbZAUQRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 11:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbZAUQRz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 11:17:55 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:40813 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbZAUQRy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 11:17:54 -0500
Received: by fk-out-0910.google.com with SMTP id f33so262715fkf.5
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 08:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=qyMxcNkIjThSAp5SUE3vvDmvn29vRBwxPNN7CpWd1Us=;
        b=W6/PyLZsh5EC2u+g4oPkgAociRqnGdUh2BzkPgTC7dhOUwr5tx5R1X7bPnXG+rLkV/
         skrJyEB+n2srkMvUsVeFAOMUNPm4VCV0A21Es5xteRfoKVLJzKgZxh90OZmJ+HC9YBCl
         dMPhJudccHLV7eRvtSuZGNH3L8M2O/e1vYlQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=hLevsCrc95UGHmF2ARWztz95H/pdML5c4KmruhwHav0uNTmj7H0cywUhUGMX0rAPAh
         OIgg1KfAvhsoKGaQlHOO2KXJLsx7pnbAG9F8caf8E9o3NjkAZQJ8cAccTtesF04EKPDB
         VXoyPZcoR4TVznHG7/mTImbtDTmwlc86d6/i8=
Received: by 10.223.109.198 with SMTP id k6mr1823413fap.46.1232554672706; Wed, 
	21 Jan 2009 08:17:52 -0800 (PST)
In-Reply-To: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106624>

just a typo fix in the patch

>From 29c2873861a3aec8304529735307385e9e5c248a Mon Sep 17 00:00:00 2001
From: Caleb Cushing <xenoterracide@gmail.com>
Date: Tue, 20 Jan 2009 11:33:30 -0500
Subject: [PATCH] mergetool merge/skip/abort
 add functionality to skip merging a file or abort from the merge

---
 git-mergetool.sh |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 00e1337..ae94300 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -177,11 +177,27 @@ merge_file () {
     describe_file "$local_mode" "local" "$LOCAL"
     describe_file "$remote_mode" "remote" "$REMOTE"
     if "$prompt" = true; then
-       printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
-       read ans
-    fi
+               while true; do
+               printf "Use (m)erge file or (s)kip file, or (a)bort? (%s): " \
+               "$merge_tool"
+               read ans
+               case "$ans" in
+                       [mM]*)
+                       break
+                       ;;
+                       [sS]*)
+                       cleanup_temp_files
+                       return 0
+                       ;;
+                       [aA]*)
+                       cleanup_temp_files
+                       exit 0
+                       ;;
+               esac
+               done
+       fi

-    case "$merge_tool" in
+       case "$merge_tool" in
        kdiff3)
            if base_present ; then
                ("$merge_tool_path" --auto --L1 "$MERGED (Base)" --L2
"$MERGED (Local)" --L3 "$MERGED (Remote)" \
--
1.6.1

-- 
Caleb Cushing

http://xenoterracide.blogspot.com
