From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 09/10] difftool: use run_mergetool from git-mergetool-lib
Date: Wed,  1 Apr 2009 05:55:13 -0700
Message-ID: <1238590514-41893-10-git-send-email-davvid@gmail.com>
References: <1238590514-41893-1-git-send-email-davvid@gmail.com>
 <1238590514-41893-2-git-send-email-davvid@gmail.com>
 <1238590514-41893-3-git-send-email-davvid@gmail.com>
 <1238590514-41893-4-git-send-email-davvid@gmail.com>
 <1238590514-41893-5-git-send-email-davvid@gmail.com>
 <1238590514-41893-6-git-send-email-davvid@gmail.com>
 <1238590514-41893-7-git-send-email-davvid@gmail.com>
 <1238590514-41893-8-git-send-email-davvid@gmail.com>
 <1238590514-41893-9-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com, charles@hashpling.org
X-From: git-owner@vger.kernel.org Wed Apr 01 14:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp01k-0004A8-TH
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764731AbZDAM4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764734AbZDAMz7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:55:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.225]:13767 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764706AbZDAMzq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:55:46 -0400
Received: by rv-out-0506.google.com with SMTP id f9so29191rvb.1
        for <git@vger.kernel.org>; Wed, 01 Apr 2009 05:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5FmFISG5KyTiSj+vrx9vlMbReKfMPkcBOBEyOy641lY=;
        b=kAc9pfv+7jqEGIDKMbqss53W+X/PoxkswxEoeNerlynSl7o7Mdgk0jhC4koMfEJv7j
         11UeqLdLCFFm40kE7e810CKvqtOQ7eajWdJZwtTV42rroIxMLLZq5UEUDfPjSdYKlSbb
         l3CJt7yH7UJKpDtb4JKMVzGzmM+iXPtWPFhF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CJSXH2K3MZGALwVTbu9Hni5QJYVHJlwcF7m9SykayHTaENNxCPuHS85cU16U0snvRF
         DMJMDnmsoI9O1SJu53NH6qNNqETCRZWEDooyr0Q/zDZhAa9kkHGTvHW5HexxRCw7jFFN
         4JpzuQAc/Iv8a7UdBcXu6WoZgmj9kSNEQK3lk=
Received: by 10.114.102.20 with SMTP id z20mr5228254wab.53.1238590544781;
        Wed, 01 Apr 2009 05:55:44 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l38sm7149481waf.33.2009.04.01.05.55.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 01 Apr 2009 05:55:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.423.g442d
In-Reply-To: <1238590514-41893-9-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115382>

This refactors git-mergetool-helper to use run_mergetool.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool-helper.sh |   62 +-----------------------------------------------
 1 files changed, 1 insertions(+), 61 deletions(-)

diff --git a/git-difftool-helper.sh b/git-difftool-helper.sh
index 6cc5ab5..2dfc870 100755
--- a/git-difftool-helper.sh
+++ b/git-difftool-helper.sh
@@ -43,67 +43,7 @@ launch_merge_tool () {
 	fi
 
 	# Run the appropriate merge tool command
-	case "$merge_tool" in
-	kdiff3)
-		basename=$(basename "$MERGED")
-		"$merge_tool_path" --auto \
-			--L1 "$basename (A)" \
-			--L2 "$basename (B)" \
-			-o "$MERGED" "$LOCAL" "$REMOTE" \
-			> /dev/null 2>&1
-		;;
-
-	kompare)
-		"$merge_tool_path" "$LOCAL" "$REMOTE"
-		;;
-
-	tkdiff)
-		"$merge_tool_path" -o "$MERGED" "$LOCAL" "$REMOTE"
-		;;
-
-	meld)
-		"$merge_tool_path" "$LOCAL" "$REMOTE"
-		;;
-
-	vimdiff)
-		"$merge_tool_path" -c "wincmd l" "$LOCAL" "$REMOTE"
-		;;
-
-	gvimdiff)
-		"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$REMOTE"
-		;;
-
-	xxdiff)
-		"$merge_tool_path" \
-			-X \
-			-R 'Accel.SaveAsMerged: "Ctrl-S"' \
-			-R 'Accel.Search: "Ctrl+F"' \
-			-R 'Accel.SearchForward: "Ctrl-G"' \
-			--merged-file "$MERGED" \
-			"$LOCAL" "$REMOTE"
-		;;
-
-	opendiff)
-		"$merge_tool_path" "$LOCAL" "$REMOTE" \
-			-merge "$MERGED" | cat
-		;;
-
-	ecmerge)
-		"$merge_tool_path" "$LOCAL" "$REMOTE" \
-			--default --mode=merge2 --to="$MERGED"
-		;;
-
-	emerge)
-		"$merge_tool_path" -f emerge-files-command \
-			"$LOCAL" "$REMOTE" "$(basename "$MERGED")"
-		;;
-
-	*)
-		if test -n "$merge_tool_cmd"; then
-			( eval $merge_tool_cmd )
-		fi
-		;;
-	esac
+	run_mergetool "$merge_tool";
 }
 
 # Allow GIT_DIFF_TOOL and GIT_MERGE_TOOL to provide default values
-- 
1.6.1.3
