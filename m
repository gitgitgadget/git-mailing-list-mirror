From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] gitweb: make logo optional
Date: Mon, 3 Jan 2011 23:05:55 -0600
Message-ID: <20110104050555.GC8280@burratino>
References: <20110104050206.GA8280@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 04 06:06:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZz65-0001RK-TM
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 06:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab1ADFGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 00:06:08 -0500
Received: from mail-yi0-f66.google.com ([209.85.218.66]:63340 "EHLO
	mail-yi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab1ADFGH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 00:06:07 -0500
Received: by yic24 with SMTP id 24so1881059yic.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 21:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vC+8tgxJSC/V7/tLRsammdMQtnwR9W+fg69RPS3Yvjc=;
        b=ldy4D2kjMrt/DI228aXOthQCijox9y5W2L/06wD8If55JB7aG8p2iISHeIhPVOGRmq
         f9TwOmxeB4TZpg9bmtt7PdE8rqXDdyXc/N9OBfUfUZ5GEMOwZby7nli0QK5k2lYCKdqh
         1e7UNA1x42Ro4IVBBSlwc0qMftA4WYt6C1rXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nkkdhYC9iGIs2Dp2z94UCG1UPJzAb++CvrbSf4FHrA7AwEFcfupseu1q2Ad/xc2b+L
         qitt07O63IItOIi0TnN7UI39E9JzMRLdYsKIJGAtli/dqiOvJ3yVDPhzEN4CH02gBbJU
         GbnjswoYb6zgWQ67lUcFIohPXlDDdZTUsx6h4=
Received: by 10.151.50.19 with SMTP id c19mr20019062ybk.96.1294117566789;
        Mon, 03 Jan 2011 21:06:06 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.sbcglobal.net [69.209.72.219])
        by mx.google.com with ESMTPS id r6sm13699985yba.23.2011.01.03.21.06.04
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 21:06:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110104050206.GA8280@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164477>

Date: Fri, 3 Sep 2010 19:45:09 -0500

Some sites may not want to have a logo at all.  In particular, git
instaweb can benefit from this.

While at it, use $cgi->img to simplify this code.  (CGI.pm learned
most HTML4 tags by version 2.79, so this should be portable to perl
5.8, though I haven't tested.)

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Eric liked an earlier version of this patch that did not use
$cgi->img.

 gitweb/gitweb.perl |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c65af1a..064697c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3601,10 +3601,15 @@ EOF
 		insert_file($site_header);
 	}
 
-	print "<div class=\"page_header\">\n" .
-	      $cgi->a({-href => esc_url($logo_url),
-	               -title => $logo_label},
-	              qq(<img src=").esc_url($logo).qq(" width="72" height="27" alt="git" class="logo"/>));
+	print "<div class=\"page_header\">\n";
+	if (defined $logo) {
+		print $cgi->a({-href => esc_url($logo_url),
+		               -title => $logo_label},
+		              $cgi->img({-src => esc_url($logo),
+		                         -width => 72, -height => 27,
+		                         -alt => "git",
+		                         -class => "logo"}));
+	}
 	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
 	if (defined $project) {
 		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
-- 
1.7.4.rc0
