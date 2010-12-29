From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/4] git-instaweb: Static files are under "static/" in gitweb_conf
Date: Wed, 29 Dec 2010 17:48:14 +0100
Message-ID: <201012291748.14484.jnareb@gmail.com>
References: <201012291743.41213.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tadeusz Sosnierz <tadzikes@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 29 17:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXzEY-0004pD-C2
	for gcvg-git-2@lo.gmane.org; Wed, 29 Dec 2010 17:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab0L2Quh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Dec 2010 11:50:37 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57019 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753403Ab0L2Que (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Dec 2010 11:50:34 -0500
Received: by mail-bw0-f46.google.com with SMTP id 15so11085534bwz.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=jG/Zj/3FvdScLkWNL6p3cq+q8xewzf6BxKX5FJ/cIWM=;
        b=mxylxq/0zlCPmdBUQcTiOJr+oltRdTRhppBmgxNxnkHqF8yJUhLM2guxlg61r7tPpZ
         nFuIbf65i6coCdJCX/WSQGyUv0Lrl/JiE8IK7w1Fufhk61+LUnhK/C6rkqVJSS5zsikA
         N7NRr/O4g7Upb+2DGmCJdQAPmCULpJQs3+BgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mrze8vkRWjVqAnOkcFC6MYoNr+sU97wkm/r7lNjliFrdDaP6jxyAM6PDbiqf2EAAhJ
         b4CpmvNZr4JDrQhi7Z25XOq2Ll5CCGgSroCbxBY8j2td/Hn75zsuwpErFVLfZLc3Cs4c
         Uv1ko60UxTcDwEffb2gw/6d3XTXw2g8m6+TOk=
Received: by 10.204.98.65 with SMTP id p1mr12304239bkn.198.1293641433362;
        Wed, 29 Dec 2010 08:50:33 -0800 (PST)
Received: from [192.168.1.13] (abvs18.neoplus.adsl.tpnet.pl [83.8.216.18])
        by mx.google.com with ESMTPS id x38sm7505600bkj.13.2010.12.29.08.50.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Dec 2010 08:50:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201012291743.41213.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164317>

The variables used to compose links for gitweb static files,
i.e. @stylesheets / $stylesheet, $logo, etc. are configurable via
GITWEB_CSS, GITWEB_LOGO, etc. gitweb build configuration variables.
The installation directory of those static files is currently always
set to $(gitwebdir)/static.  Thus git-instaweb could rely on the place
where those files are installed, but not on $logo, $favicon
etc. variables.

Set @stylesheets, $logo, $favicon and $javascript to their default
values in gitweb config file for git-instaweb (in gitweb_conf
function), so that web servers invoked by git-instaweb (for example
Plack::Middleware::Static component for 'plackup' web server) can
correctly serve links to those static files.

We assume here that git-instaweb uses modern gitweb with names of
gitweb config variables as mentioned above.

Note that we had to take care that possible optional minimizations of
stylesheet and of javascript is correctly taken into account.


This is continuation of fixup for issue noticed by Tadeusz So=C5=9Bnier=
z
with --httpd=3Dplackup and gitweb stylesheet (CSS).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The subject (commit description) is not the best, but that is what I
was able to come up with.

This doesn't matter for default configuration and setup, but it allows
me to use my custom gitweb build configuration without any changes in
result.

 git-instaweb.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index bb57d81..da569f2 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -581,6 +581,11 @@ our \$projectroot =3D "$(dirname "$fqgitdir")";
 our \$git_temp =3D "$fqgitdir/gitweb/tmp";
 our \$projects_list =3D \$projectroot;
=20
+our @stylesheets =3D ("static/".basename(\$stylesheets[0]));
+our \$logo =3D "static/git-logo.png";
+our \$favicon =3D "static/git-favicon.png";
+our \$javascript =3D "static/".basename(\$javascript);
+
 \$feature{'remote_heads'}{'default'} =3D [1];
 EOF
 }
--=20
1.7.3
