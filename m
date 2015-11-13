From: Rob Mayoff <mayoff@dqd.com>
Subject: [PATCH] contrib/subtree: unwrap tag refs
Date: Thu, 12 Nov 2015 22:15:44 -0600
Message-ID: <1447388144-23806-1-git-send-email-git@rob.dqd.com>
Cc: Rob Mayoff <mayoff@dqd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 05:15:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zx5mH-0007RV-Qy
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 05:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbbKMEPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2015 23:15:53 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36662 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754220AbbKMEPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2015 23:15:52 -0500
Received: by oiww189 with SMTP id w189so43788755oiw.3
        for <git@vger.kernel.org>; Thu, 12 Nov 2015 20:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dqd_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=abAEYLZKFIaRUltd9v99MRo6oe9lxgWqKG3ALMkIZAs=;
        b=rek7VdKqFRV8aeva066EU29KoRt4b5Zd+wEuydN09heyC2+n1f9it5/EM8Ls+BlRcq
         fCM7NmsHuFxi82/vkAj2f7gbs6PBrmZ05bL48F0YkUBna+JI+tycunORde/8tcN1p8zA
         8xiK9/j4WDh8zWjTyT8Ud69oOvVvbPc1nEye3jbIn3Bjb5fZfkDTnKTSiNBtMXpX2xqm
         xdHRMV3tgpH//wtzLREjXRDZkjC22j2rKFBKquilUOskKBi/u6H+HWHxpgzZkxiCNtEs
         1N5zblGljH/+KDYQHXyxzd2UDsE45tKaw/FgWiBVo77+IvjfX2XnQZoelI4pQJRlB/ce
         7wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=abAEYLZKFIaRUltd9v99MRo6oe9lxgWqKG3ALMkIZAs=;
        b=WbIMFwU5ieaqCRNYm8stx3ajVNdKkTXXZapL82exMCFJdbcOYd3mky3tg7/FdKVTq7
         oEqXSWfJqPJnSbylnxyQ5TEU4qV14009ViJX8E3eqeyzrNpn3HAd/SmF2XYU4bpzsn9j
         NsYm9wueg6VlBzhEa9HCdo5M0v4GIzAk9hYReBVe5YTrMWWuzMb/iH/ZaSCfs7QDVKGB
         VCIG3m/C3r3G/BP4pT01KJnjRQvKnIHfaxaaesTVMzfarPWs2fXQqN8UEcxWHcF7kNuJ
         bLuX0jcXmgGwziZ9VfKb7lDm5cqIp8VhoVcV1ZwXmn92E+2Ky4ggG0e8ECWYx3WIMoIe
         QWtA==
X-Gm-Message-State: ALoCoQkfThF1Lf++2pBwXN580LgqgpkmDgplelAvz0x2/oR/e//RUh/g2i8+euVc2h68wBurmP4u
X-Received: by 10.202.2.18 with SMTP id 18mr11118748oic.59.1447388151260;
        Thu, 12 Nov 2015 20:15:51 -0800 (PST)
Received: from can.local.com (65-36-82-75.dyn.grandenetworks.net. [65.36.82.75])
        by smtp.gmail.com with ESMTPSA id t84sm5265077oie.1.2015.11.12.20.15.50
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Nov 2015 20:15:50 -0800 (PST)
X-Google-Original-From: Rob Mayoff <git@rob.dqd.com>
X-Mailer: git-send-email 2.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281232>

From: Rob Mayoff <mayoff@dqd.com>

If a subtree was added using a tag ref, the tag ref is stored in
the subtree commit message instead of the underlying commit's ref.
To split or push subsequent changes to the subtree, the subtree
command needs to unwrap the tag ref.  This patch makes it do so.

The problem was described in a message to the mailing list from
Junio C Hamano dated 29 Apr 2014, with the subject "Re: git subtree
issue in more recent versions". The archived message can be found
at <http://comments.gmane.org/gmane.comp.version-control.git/247503>.

Signed-off-by: Rob Mayoff <mayoff@dqd.com>
---
 contrib/subtree/git-subtree.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 9f06571..b051600 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -245,7 +245,10 @@ find_latest_squash()
 		case "$a" in
 			START) sq="$b" ;;
 			git-subtree-mainline:) main="$b" ;;
-			git-subtree-split:) sub="$b" ;;
+			git-subtree-split:)
+				sub="$b"
+				sub="$(git rev-parse "$b^0")" || die "could not rev-parse split hash $b from commit $sq"
+				;;
 			END)
 				if [ -n "$sub" ]; then
 					if [ -n "$main" ]; then
@@ -278,7 +281,10 @@ find_existing_splits()
 		case "$a" in
 			START) sq="$b" ;;
 			git-subtree-mainline:) main="$b" ;;
-			git-subtree-split:) sub="$b" ;;
+			git-subtree-split:)
+				sub="$b"
+				sub="$(git rev-parse "$b^0")" || die "could not rev-parse split hash $b from commit $sq"
+				;;
 			END)
 				debug "  Main is: '$main'"
 				if [ -z "$main" -a -n "$sub" ]; then
-- 
2.4.3
