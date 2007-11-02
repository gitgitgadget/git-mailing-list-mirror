From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3] gitweb: Improve reading of repo config
Date: Sat,  3 Nov 2007 00:41:17 +0100
Message-ID: <1194046880-29941-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 00:39:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io66z-000709-C8
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 00:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbXKBXi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 19:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755426AbXKBXiz
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 19:38:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:24335 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405AbXKBXit (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 19:38:49 -0400
Received: by ug-out-1314.google.com with SMTP id z38so694638ugc
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 16:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=jDji8uMLoIPKDGkgYHfRMP9PPqCsdUpHQP9Zsu7gMUw=;
        b=P/AToHwEjGVx0yxtRSDpf9HPufLKg58gPsMkyb1yUMECcREJiQ5fJ6iLGJyjTMpoDAZ8IRRIyOInE37OOZ+2XxKaHUz43wVD4tkIAFYZ6+opDMCLz08/2Z8DFJ89h6YH6ip7a+vEQL1e6LixoaqCKB49+jd+Jj/hsFehDGXRC+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=d6UBobAKeTLkTDOEeh0elV4Ba9sjgJR2O0LqnkYu/oRGGEa+io/UPndLlnY5c7JxPoLeJUEtT0sLaDJww7U+W9vawUQ20m7RM7MzkfCJI2t2nNd6guKxdbnSmlI7mRr0Wn+tewSCpHxQDDaDKK3mUawCK9a2pFkkZCfFXfs2ygU=
Received: by 10.67.15.15 with SMTP id s15mr2414752ugi.1194046727951;
        Fri, 02 Nov 2007 16:38:47 -0700 (PDT)
Received: from roke.D-201 ( [83.8.198.10])
        by mx.google.com with ESMTPS id j2sm3409484ugf.2007.11.02.16.38.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Nov 2007 16:38:45 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lA2NfLIV029956;
	Sat, 3 Nov 2007 00:41:22 +0100
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id lA2NfK8G029955;
	Sat, 3 Nov 2007 00:41:21 +0100
X-Mailer: git-send-email 1.5.3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63192>

This series of patches introduces single-call reading of
gitweb-related part of repository configuration in gitweb. Instead of
calling git-config once for each config variable we check, read all
variables at once for first request of repo config variable.

First patch adds test to check if our changes do not break gitweb too
badly, second one introduces mentioned above "eager" repo config
reading, and third makes use of the fact that adding new configuration
variables to check is not that costly now.

Table of contents:
==================
 [PATCH 1/3] gitweb: Add tests for overriding gitweb config with repo config
 [PATCH 2/3] gitweb: Read repo config using 'git config -z -l'
 [PATCH 3/3] gitweb: Use config file for repository description and URLs

Diffstat:
=========
 gitweb/gitweb.perl |   82 +++++++++++++++++++++----------------------------
 1 files changed, 33 insertions(+), 47 deletions(-)

-- 
Jakub Narebski, Poland
git version 1.5.3.5
