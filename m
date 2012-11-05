From: Phil Pennock <phil@apcera.com>
Subject: [PATCH] gitweb: make remote_heads config setting work.
Date: Mon, 5 Nov 2012 18:50:47 -0500
Message-ID: <20121105235047.GA78156@redoubt.spodhuis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 06 00:51:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVWRh-0001UJ-0N
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 00:51:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab2KEXu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 18:50:56 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:50787 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177Ab2KEXuz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 18:50:55 -0500
Received: by mail-wg0-f42.google.com with SMTP id fm10so2200916wgb.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 15:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=apcera.com; s=google;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition;
        bh=sbNEP8dDN7NTbQbPL+NDYbRWQxSFD/d6d+dkXOP2GXc=;
        b=GsYl2UiKWyVTaDJm0dr5FzX8sOKFpsVv2Ya+rLfBtDt80hHGfJbBUwZ3MTji6iHEcR
         YzuBESx5psLnJIdKHs9nyMvTSA7VS+uMMR/uYTvCNKqW1D04sxPtnv3c0ju1mNW/SEYx
         BmCZYMQBMCBAbPjy2ofdogavmn541ifrJRBDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:x-gm-message-state;
        bh=sbNEP8dDN7NTbQbPL+NDYbRWQxSFD/d6d+dkXOP2GXc=;
        b=YoYZCbSgmS1koxRRV1KatL3E6WxgcPU7ePHZnZpzYBnfjcSjue47i+FDKlybIxJ7Dl
         /WBCl1uWn/uT8Ydo/con9RWYucALJWoibTwzEedbmmcgYwxYSvTWTCR1G5mEDSYb980c
         D9MRq0dnLBKCV09ggdUqtdV8cnJipc6QrxlA1EM9zBF21uOsge47G0ouA0hPRPWO+DDv
         7rA7FzHq57Vef3zKL19drHeyoUB5hYN1BVmt8B9+vNBMV5F+6aX2/g+WM/YnWtVLFAPp
         jdS0ujJygdpUOV3pYQzuxCCkPAG3sd0b1azf0kjmOgi7DqzrZWajQJxp+GQMgRhi31+H
         DEYA==
Received: by 10.216.197.155 with SMTP id t27mr3729356wen.216.1352159453484;
        Mon, 05 Nov 2012 15:50:53 -0800 (PST)
Received: from redoubt.spodhuis.org (causeway.spodhuis.org. [2a02:898:0:30::31:1])
        by mx.google.com with ESMTPS id ey2sm13953434wib.9.2012.11.05.15.50.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 15:50:53 -0800 (PST)
Content-Disposition: inline
X-Gm-Message-State: ALoCoQlTrVMwgzISAIHQSJUVEjTvdTZag6Hm/iWzBMj7iqbuIEF9v8Aevr34dDU/wd8jRCiTiLOa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209093>

Git configuration items can not contain underscores in their name; the
'remote_heads' feature can not be enabled on a per-repository basis with
that name.

This changes the git-config option to be `gitweb.remoteheads` but does
not change the gitweb.conf option, to avoid backwards compatibility
issues.  We strip underscores from keys before looking through
git-config output for them.

Signed-off-by: Phil Pennock <phil@apcera.com>"
---
 gitweb/gitweb.perl |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 10ed9e5..f2144c8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -541,7 +541,7 @@ our %feature = (
 	# $feature{'remote_heads'}{'default'} = [1];
 	# To have project specific config enable override in $GITWEB_CONFIG
 	# $feature{'remote_heads'}{'override'} = 1;
-	# and in project config gitweb.remote_heads = 0|1;
+	# and in project config gitweb.remoteheads = 0|1;
 	'remote_heads' => {
 		'sub' => sub { feature_bool('remote_heads', @_) },
 		'override' => 0,
@@ -2702,6 +2702,7 @@ sub git_get_project_config {
 		$key = lc($key);
 	}
 	$key =~ s/^gitweb\.//;
+	$key =~ s/_//g;
 	return if ($key =~ m/\W/);
 
 	# type sanity check
-- 
1.7.10.3
