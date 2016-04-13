From: David Holmer <odinguru@gmail.com>
Subject: [PATCH] gitk: Fix how remote branch names with / are drawn
Date: Tue, 12 Apr 2016 21:59:03 -0400
Message-ID: <1460512743-27100-1-git-send-email-odinguru@gmail.com>
Cc: David Holmer <odinguru@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 04:00:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqA6Y-0007lV-4n
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 04:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102AbcDMCA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 22:00:26 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35653 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964861AbcDMCAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 22:00:25 -0400
Received: by mail-qg0-f43.google.com with SMTP id f105so32329796qge.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 19:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zB5UF4083pnWMfLaiFeJOZwSpaG3gOKZgVU+7guQh+M=;
        b=BUQxxtX/iWVvG5jMs6GrxzCA0inz9KGqIuvW4JCHELyVkdmgd+kYQjxecvTCqr2ZxI
         +2KuByz/AaqpTeTtkN4orjDCILaFfwDbqS/KcnMBMyVe8RWH/fYzvkf7AjNEeJukA2p3
         DlnLB6LRuWstm3kcuTqTRzKFqlh6KDQJWo2nC2SYDqv2UjLUekmrloNN2I3yNwmN/c3t
         yh2PMx25bNwvTGtXmjqKMTw1rZ7LDDNRXpkoYqdqj78y8lYWP0ot/z2RBr4diN836VdZ
         LAcCX1YxPnpiCYHGoboLR23A8ljBCzPmCNSK8QRjdFDqUTFH62W+X7qD6bLJlPJ1H93t
         rIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zB5UF4083pnWMfLaiFeJOZwSpaG3gOKZgVU+7guQh+M=;
        b=d96yv7Z53M4a4x3DneFtk/SmpbBsQIpgk7SL0S640loSpwvUz24N/Jc2PKRojCphNi
         qnn4eIdsfTLq8Ba9EyULL1GC36CrWo3I4OO7T4fVNr1DE1KGQJDodmpsqQO3kwXUHjlY
         34Pgtq0TbAZI+29qeF4x2+nspiDJV4GpKITmZA8KaWS2mcgdGUZHKdQXbL9fAh/mh9tG
         w/09jifaH84dXUzJQLjuqct8fysaKRlitXv6Ol6e/WQlm5nX8XXiwXTFMbjg/uN3d8gn
         Ht8o2aWXslDf/T+vctG9EaNeuLYUCw/yjI46QhFwF976iLVUzpxN/WoX3x1SCA6dX1SN
         NcDw==
X-Gm-Message-State: AOPr4FUnIrwp9MDGdaGsY+8dFowxEqND2o5XJIrXNtkuXrJpMas5+9fgZE0vzpPmmB7ZQw==
X-Received: by 10.140.235.22 with SMTP id g22mr8359840qhc.43.1460512824209;
        Tue, 12 Apr 2016 19:00:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-74-71-211-86.nyc.res.rr.com. [74.71.211.86])
        by smtp.gmail.com with ESMTPSA id b74sm14898162qge.22.2016.04.12.19.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Apr 2016 19:00:23 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291366>

Consider this example branch:

remotes/origin/master

gitk displays this branch with different background colors for each part:
"remotes/origin" in orange and "master" in green. The idea is to make it
visually easy to read the branch name separately from the remote name.

However this fails when given this example branch:

remotes/origin/foo/bar

gitk displays this branch with "remotes/origin/foo" in orange and "bar" in
green. This makes it hard to read the branch name "foo/bar". This is due
to an inappropriately greedy regexp. This patch provides a fix so the same
branch will now be displayed with "remotes/origin" in orange and "foo/bar"
in green.

Signed-off-by: David Holmer <odinguru@gmail.com>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 805a1c7..ca2392b 100755
--- a/gitk
+++ b/gitk
@@ -6640,7 +6640,7 @@ proc drawtags {id x xt y1} {
 	    set xl [expr {$xl - $delta/2}]
 	    $canv create polygon $x $yt $xr $yt $xr $yb $x $yb \
 		-width 1 -outline black -fill $col -tags tag.$id
-	    if {[regexp {^(remotes/.*/|remotes/)} $tag match remoteprefix]} {
+	    if {[regexp {^(remotes/[^/]*/|remotes/)} $tag match remoteprefix]} {
 	        set rwid [font measure mainfont $remoteprefix]
 		set xi [expr {$x + 1}]
 		set yti [expr {$yt + 1}]
-- 
1.9.1
