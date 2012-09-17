From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [FYI/PATCH 4/5] Git::SVN::_new: use accessor to write path field
Date: Mon, 17 Sep 2012 02:12:34 -0700
Message-ID: <20120917091234.GE358@elie.Belkin>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
 <1343419252-9447-2-git-send-email-schwern@pobox.com>
 <20120917090435.GA358@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 11:12:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDXNn-0006aR-2g
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 11:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab2IQJMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 05:12:39 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:61274 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755342Ab2IQJMi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 05:12:38 -0400
Received: by pbbrr13 with SMTP id rr13so8706509pbb.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LGG5dS0S0dKNeswPXyH1lJYkQ0SdUQSh8V+WsRgE27Y=;
        b=ElZ9u36ia8MaZpZOSISvScPNmr44u/uSIYLdbN/9O2dKwzWMiXb2U+JoqrLxySziBx
         bohy4Msc9sqcPI3gjmBGEK09YIVy4jTFXcf0xBVl2s5ZnDGp9hqk2hNx5hpfVcuQgYzQ
         Rk3LDSOV3Ztad7cQ2VdyDGjsSZpP5CFpOWk3WIFJ09h2nV0fgxscN2qX009HU+xe38ck
         PrSwT86oo+RWZ9sA/zB5oOe3NELmcrsjsMg4LySNPJibREUjoY7K4h/ztYJvVDpOlqg2
         0/tJQNKG7Tpuxj5N/Qk8vHYHn7G5NyVlKNEfqf4PCH0vQ9nccakHKELsjjcGKj8zk6/X
         qdjQ==
Received: by 10.66.73.9 with SMTP id h9mr19071294pav.76.1347873158221;
        Mon, 17 Sep 2012 02:12:38 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id sr3sm6630078pbc.44.2012.09.17.02.12.36
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 02:12:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120917090435.GA358@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205669>

From: Michael G. Schwern <schwern@pobox.com>
Date: Fri, 27 Jul 2012 13:00:48 -0700

If some day the setter is taught to canonicalize paths, make sure the
path gets canonicalized at construction time, too.

[jn: split from a larger patch]

Signed-off-by: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 perl/Git/SVN.pm |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 826a7fa6..3aa20109 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -2280,10 +2280,12 @@ sub _new {
 
 	$_[3] = $path = '' unless (defined $path);
 	mkpath([$dir]);
-	bless {
+	my $obj = bless {
 		ref_id => $ref_id, dir => $dir, index => "$dir/index",
-	        path => $path, config => "$ENV{GIT_DIR}/svn/config",
+	        config => "$ENV{GIT_DIR}/svn/config",
 	        map_root => "$dir/.rev_map", repo_id => $repo_id }, $class;
+	$obj->path($path);
+	return $obj;
 }
 
 sub path {
-- 
1.7.10.4
