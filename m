From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH v7 1/9] gitweb: Go to DONE_REQUEST rather than DONE_GITWEB
	in die_error
Date: Thu, 23 Dec 2010 00:55:00 +0100
Message-ID: <20101222235459.7998.43333.stgit@localhost.localdomain>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 23 00:55:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVYWw-0006sg-59
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 00:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478Ab0LVXzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 18:55:33 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52803 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100Ab0LVXzc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 18:55:32 -0500
Received: by mail-fx0-f46.google.com with SMTP id 20so6638578fxm.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 15:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=O11Crqc+gNBu2+vMhWQjhEtk5iMImXTHGfFE5L8rbH4=;
        b=N39iJI8YAHi0VoSuJXwJksIvX0uoeZJVHSyiDruDcqpYwkF3gf9Eo/IKC9SS07fB+b
         Fos6wlTRToWS4PK0I/ng898mfj01NecNrr3HSPwkC/lMGCqJ6m/hTGSvzYtQJPit7b7H
         azm0AWqVQJ8RFhuRMaH/YcCGlHZHpooX2E3qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=WmcNATo47YeslCEN9uc1hd3xKzjt7C8TShDF5Ul10ZgW1XveN3MJK4L+jrAZht8yFp
         zQIwVo2usMcXk6KZJv33SufHDCN1nR0GBjTPMnIjbpXXZIEW1I5vcSahkn7QUfKJr3NQ
         S2nQum+WSFXvXjlKJXUfj2FMH7EoHGMIQISk8=
Received: by 10.223.103.6 with SMTP id i6mr637784fao.84.1293062131987;
        Wed, 22 Dec 2010 15:55:31 -0800 (PST)
Received: from localhost.localdomain (abvw91.neoplus.adsl.tpnet.pl [83.8.220.91])
        by mx.google.com with ESMTPS id y1sm1854062fak.15.2010.12.22.15.55.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Dec 2010 15:55:30 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBMNt08w008090;
	Thu, 23 Dec 2010 00:55:10 +0100
In-Reply-To: <20101222234843.7998.87068.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164102>



End the request after die_error finishes, rather than exiting gitweb
instance (perhaps wrapped like in ModPerl::Registry or gitweb.psgi
case).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4779618..724287b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1169,6 +1169,7 @@ sub run {
 
 		run_request();
 
+	DONE_REQUEST:
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
 		$first_request = 0;
@@ -3767,7 +3768,7 @@ EOF
 	print "</div>\n";
 
 	git_footer_html();
-	goto DONE_GITWEB
+	goto DONE_REQUEST
 		unless ($opts{'-error_handler'});
 }
 
